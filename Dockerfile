# Gunakan base image Java
FROM openjdk:11-jre-slim

# Salin aplikasi JAR ke dalam container
COPY target/hello-world-app.jar /app/hello-world-app.jar

# Expose port yang digunakan oleh aplikasi
EXPOSE 8080

# Command untuk menjalankan aplikasi
CMD ["java", "-jar", "/app/hello-world-app.jar"]
