# Multi-stage Dockerfile for building and running the tempathome_server Spring Boot app
# Stage 1: build with Gradle using the project Gradle wrapper
FROM gradle:8.5-jdk17 AS build
WORKDIR /home/gradle/project
# Copy only Gradle wrapper and gradle files first to leverage Docker layer cache
COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle settings.gradle .
# Copy source
COPY src src
# Ensure wrapper is executable
RUN chmod +x gradlew || true
# Build the application (including tests). If you want to skip tests, add -x test
RUN ./gradlew clean bootJar --no-daemon

# Stage 2: runtime image with a minimal JRE
FROM eclipse-temurin:17-jre-alpine
# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
# Copy jar from the build stage
COPY --from=build /home/gradle/project/build/libs/*.jar app.jar
# Expose default Spring Boot port
EXPOSE 8080
# Use non-root user
USER appuser
# JVM options can be passed via JAVA_OPTS env var
ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar /app/app.jar"]

