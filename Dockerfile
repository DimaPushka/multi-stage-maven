FROM maven:3-eclipse-temurin-17-alpine as builder
RUN mkdir -p /app/source
COPY . /app/source
COPY pom.xml .
WORKDIR /app/source
RUN mvn clean package -DskipTests


FROM openjdk:17-alpine as runtime
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]