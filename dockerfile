FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y wget

# Download and install OpenJDK
RUN wget https://download.java.net/java/GA/jdk17/0d1cfde4252546c693194d0d489f9b7c/35/GPL/openjdk-17_linux-x64_bin.tar.gz \
    && tar -xvf openjdk-17_linux-x64_bin.tar.gz -C /opt \
    && rm openjdk-17_linux-x64_bin.tar.gz

# Set environment variables
ENV JAVA_HOME=/opt/jdk-17
ENV PATH=$JAVA_HOME/bin:$PATH

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["node", "index.js"]
