# Use official OpenJDK 21 image
FROM eclipse-temurin:21-jdk

# Copy obfuscated jar
COPY target/java-web-poc-1.0.0-obfuscated.jar /app/webapp.jar

# Expose port
EXPOSE 8081

# Run the jar
ENTRYPOINT ["java","-jar","/app/webapp.jar"]

