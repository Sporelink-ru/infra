FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /src
COPY connector/pom.xml .
RUN mvn dependency:go-offline
COPY connector/src ./src
RUN mvn clean package -Dmaven.test.skip=true

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /src/target/connector-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]