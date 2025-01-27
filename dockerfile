# Use an official Maven image to build the application
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml file and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the application code
COPY src ./src

# Package the application
RUN mvn package

# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jre-slim

# Set the working directory
WORKDIR /app

# Copy the packaged application from the build stage
COPY --from=build /app/target/your-app.jar /app/your-app.jar

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "/app/your-app.jar"]
