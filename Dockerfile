
# Multi-stage build for Java Spring Boot application
# Stage 1: Build stage
FROM gradle:8.5-jdk21 AS build

# Set working directory
WORKDIR /app

# Copy Gradle wrapper and build files
COPY gradle/ gradle/
COPY gradlew gradlew.bat build.gradle settings.gradle ./

# Give execution permission to gradlew and download dependencies
RUN chmod +x ./gradlew && ./gradlew dependencies --no-daemon

# Copy source code
COPY src/ src/

# Build the application
RUN ./gradlew build --no-daemon -x test

# Stage 2: Runtime stage
FROM eclipse-temurin:21-jre AS runtime

# Install necessary packages for better container operation
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create app directory and user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser
WORKDIR /app

# Create data directory for H2 database
RUN mkdir -p /app/data && chown -R appuser:appuser /app

# Copy the built jar from build stage
COPY --from=build /app/build/libs/*-SNAPSHOT.jar app.jar

# Change ownership to appuser
RUN chown appuser:appuser app.jar

# Switch to non-root user
USER appuser

# Expose port (Spring Boot default is 8080)
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

# Set JVM options for container environment
ENV JAVA_OPTS="-Xmx512m -Xms256m -XX:+UseContainerSupport -XX:MaxRAMPercentage=75 -Duser.timezone=Asia/Seoul"
# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]