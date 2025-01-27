# Use Maven 3.9.5 with OpenJDK 17 to build the application
FROM maven:3.9.5-openjdk-17 as builder
 
# Set the working directory inside the container
WORKDIR /app
 
# Copy the pom.xml and the source code
COPY pom.xml .
COPY src ./src
 
# Build the Maven project (skip tests to speed up the build)
RUN mvn clean package -DskipTests
 
# Use OpenJDK 17 base image for the final stage
FROM openjdk:17-jre-slim
 
# Set the working directory in the final image
WORKDIR /app
 
# Copy the JAR file from the builder image
COPY --from=builder /app/target/myapp-1.0-SNAPSHOT.jar myapp.jar
 
# Expose the port the app will run on
EXPOSE 8080
 
# Command to run the application
ENTRYPOINT ["java", "-jar", "myapp.jar"]
