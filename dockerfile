# Use an official SUSE Linux as a parent image
FROM opensuse/leap:latest

# Install OpenJDK
RUN zypper refresh && \
    zypper install -y java-17-openjdk && \
    zypper clean -a

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
