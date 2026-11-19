package com.mycompany.smartsocietymca;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Set;

/**
 * Central place for database access.
 *
 * Connection settings come from environment variables (or JVM system
 * properties with the same names):
 *   DB_URL       e.g. jdbc:mysql://localhost:3306/ss?useSSL=false&serverTimezone=UTC
 *   DB_USERNAME
 *   DB_PASSWORD
 *
 * Always use it with try-with-resources so connections are never leaked:
 *   try (Connection con = Db.get()) { ... }
 */
public final class Db {

    private static final Set<String> ID_TABLES = Set.of(
            "addevent", "addservices", "bookingevent", "commoncharges", "paycharges",
            "subscription", "subscription2", "subscription3", "subscription4");
    private static final Set<String> ID_COLUMNS = Set.of(
            "eventid", "srno", "bid", "payid", "payno");

    /** The logged-in resident's profile (loaded from the registration table). */
    public record Resident(int srno, String name, String mobile, String address, String email) { }

    private Db() { }

    /** Returns the profile for a username, or null if there is no such resident. */
    public static Resident findResident(Connection con, String username) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(
                "SELECT srno, resi_name, mob_no, address, email_id FROM registration WHERE username = ?")) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next()
                        ? new Resident(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5))
                        : null;
            }
        }
    }

    private static String setting(String name, String fallback) {
        String v = System.getenv(name);
        if (v == null || v.isBlank()) {
            v = System.getProperty(name);
        }
        return (v == null || v.isBlank()) ? fallback : v;
    }

    public static Connection get() throws SQLException {
        String url = setting("DB_URL", null);
        if (url == null) {
            throw new SQLException("DB_URL environment variable is not set. "
                    + "Set DB_URL, DB_USERNAME and DB_PASSWORD before starting the server.");
        }
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL driver not found on the classpath", e);
        }
        return DriverManager.getConnection(url, setting("DB_USERNAME", ""), setting("DB_PASSWORD", ""));
    }

    /**
     * Next primary key for tables that do not use AUTO_INCREMENT.
     * Uses MAX()+1 (not COUNT()+1, which produces duplicate keys after a delete).
     * Table and column names are checked against a whitelist.
     * Callers should still retry on a duplicate-key error (see {@link #isDuplicate}).
     */
    public static int nextId(Connection con, String table, String column) throws SQLException {
        if (!ID_TABLES.contains(table) || !ID_COLUMNS.contains(column)) {
            throw new IllegalArgumentException("Table/column not allowed: " + table + "." + column);
        }
        try (PreparedStatement ps = con.prepareStatement(
                "SELECT COALESCE(MAX(" + column + "), 0) + 1 FROM " + table);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 1;
        }
    }

    public static boolean isDuplicate(SQLException e) {
        return e.getErrorCode() == 1062 || "23000".equals(e.getSQLState());
    }
}
