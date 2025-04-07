# ---- Build Stage ----
    FROM maven:3.9.4-eclipse-temurin-17 AS build

       # Set the working directory inside the container
    WORKDIR /app
    
    # Change to the directory containing pom.xml
    WORKDIR /app/The-Best-Todo-App-master
    
    # Copy the pom.xml file and download dependencies
    COPY pom.xml .
    RUN mvn dependency:go-offline
    
    # Copy the rest of the source code
    COPY The-Best-Todo-App-master/src ./src
    
    # Package the app (with dependencies)
    RUN mvn clean package -DskipTests
    
    # ---- Runtime Stage ----
    FROM eclipse-temurin:17
    
    WORKDIR /app
    
    # Copy only the final fat JAR from the build stage
    COPY --from=build /app/target/the-best-todo-app-jar-with-dependencies.jar todo-app.jar
    
    # Run the app
    ENTRYPOINT ["java", "-jar", "todo-app.jar"]
    