package com.mycompany.smartsocietymca;

import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

/**
 * PBKDF2 password hashing.
 * Stored format: p1$<base64 salt>$<base64 hash>  (about 72 chars, fits varchar(100)).
 * Old rows that still contain a plain-text password are accepted once and should be
 * upgraded with {@link #needsUpgrade(String)} right after a successful login.
 */
public final class Passwords {

    private static final String PREFIX = "p1$";
    private static final int ITERATIONS = 120_000;
    private static final SecureRandom RANDOM = new SecureRandom();

    private Passwords() { }

    public static String hash(String password) {
        byte[] salt = new byte[16];
        RANDOM.nextBytes(salt);
        return PREFIX + Base64.getEncoder().encodeToString(salt) + "$"
                + Base64.getEncoder().encodeToString(derive(password, salt));
    }

    public static boolean verify(String password, String stored) {
        if (password == null || stored == null) {
            return false;
        }
        if (!stored.startsWith(PREFIX)) {
            // legacy plain-text row
            return MessageDigest.isEqual(password.getBytes(), stored.getBytes());
        }
        String[] parts = stored.split("\\$");
        if (parts.length != 3) {
            return false;
        }
        byte[] salt = Base64.getDecoder().decode(parts[1]);
        byte[] expected = Base64.getDecoder().decode(parts[2]);
        return MessageDigest.isEqual(expected, derive(password, salt));
    }

    public static boolean needsUpgrade(String stored) {
        return stored != null && !stored.startsWith(PREFIX);
    }

    private static byte[] derive(String password, byte[] salt) {
        try {
            PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, ITERATIONS, 256);
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(spec).getEncoded();
        } catch (GeneralSecurityException e) {
            throw new IllegalStateException(e);
        }
    }
}
