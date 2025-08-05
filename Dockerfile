# Minimal Dockerfile for payment-gateway-api (Java Spring Boot)
FROM maven:3.8-openjdk-17 AS builder

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app

COPY --from=builder /app/target/payment-gateway-api-*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]