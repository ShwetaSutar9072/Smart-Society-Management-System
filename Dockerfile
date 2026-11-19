# ---- Build the WAR ----
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -q dependency:go-offline
COPY src ./src
RUN mvn -q clean package -DskipTests

# ---- Run on Tomcat 10.1 (Jakarta EE 10) ----
FROM tomcat:10.1-jdk21-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/smartsocietymca-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Required at runtime (set them in your host, e.g. Render/Railway dashboard):
#   DB_URL, DB_USERNAME, DB_PASSWORD
EXPOSE 8080
CMD ["catalina.sh", "run"]
