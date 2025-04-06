# ---- Build Stage ----
    FROM maven:3.9.4-eclipse-temurin-17 AS build

    WORKDIR /app
    
    # Copy pom.xml and download dependencies first (cache efficient)
    COPY pom.xml .
    RUN mvn dependency:go-offline
    
    # Copy the rest of the source code
    COPY src ./src
    
    # Package the app (with dependencies)
    RUN mvn clean package -DskipTests
    
    # ---- Runtime Stage ----
    FROM eclipse-temurin:17
    
    WORKDIR /app
    
    # Copy only the final fat JAR from the build stage
    COPY --from=build /app/target/the-best-todo-app-jar-with-dependencies.jar todo-app.jar
    
    # Run the app
    ENTRYPOINT ["java", "-jar", "todo-app.jar"]
    