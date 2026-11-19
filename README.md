# Smart Society (JSP / Tomcat 10.1 / MySQL)

## Run
1. Create the database and import `ss_backup/dump.sql` (TiDB: `ss_backup/dump_tidb.sql`).
   Optional: run `ss_backup/migration.sql` (lets the admin password be hashed).
2. Set environment variables: `DB_URL`, `DB_USERNAME`, `DB_PASSWORD`
   e.g. `DB_URL=jdbc:mysql://localhost:3306/ss?useSSL=false&serverTimezone=UTC`
3. `mvn clean package`, deploy `target/smartsocietymca-1.0-SNAPSHOT.war` to Tomcat 10.1 (Java 17+), or `docker build`.

Existing plain-text passwords still work; each is converted to a PBKDF2 hash the first time that user logs in.

## Layout
- `WEB-INF/jspf/` shared pieces: `init` (imports), `guard` (login check), `header` (navbar), `footer`.
- Every page sets `role` = public | resident | admin, then includes those files.
- `src/main/java/.../Db, Web, Passwords, Catalog` helpers.
