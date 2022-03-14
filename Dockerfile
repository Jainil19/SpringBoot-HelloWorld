# syntax=docker/dockerfile:1

FROM openjdk:16-alpine3.13
RUN addgroup app && adduser -S -G app app
USER app

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN dos2unix mvnw
RUN ./mvnw dependency:go-offline

COPY src ./src
EXPOSE 8080
CMD ["./mvnw", "spring-boot:run"]