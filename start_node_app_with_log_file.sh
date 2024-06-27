#!/bin/bash
#EXERCISE 8: Bash Script - Node App with Log Directory

# Set log directory location for the application (absolute path)
LOG_DIRECTORY="/Users/tariq/Desktop/workspace/devops-task-tech-with-nana/node_app/package"

# Check if the directory already exists
if [ -d "$LOG_DIRECTORY" ]; then
    echo "Created log directory: $LOG_DIRECTORY"
else
    # If the directory doesn't exist, create it
    mkdir -p "$LOG_DIRECTORY"
    if [ $? -eq 0 ]; then
        echo "Created log directory: $LOG_DIRECTORY"
    else
        echo "Failed to create log directory: $LOG_DIRECTORY"
        exit 1
    fi
fi

echo ""
echo "################"


# Fetch NodeJS project archive from s3 bucket
echo "Downloading NodeJS project archive..."
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz

# Extract the project archive to ./package folder
tar zxvf ./bootcamp-node-envvars-project-1.0.0.tgz

# Set all needed environment variables
export APP_ENV=development
export DB_USER=myUser
export DB_PWD=myPassword

# Check if all required environment variables are set
if [ -z "$APP_ENV" ] || [ -z "$DB_PWD" ] || [ -z "$DB_USER" ]; then
    echo "One or more required environment variables are not set. Exiting."
    exit 1
fi

echo ""
echo "############################"
echo "Successfully set the following environment variables:"
echo "APP_ENV - $APP_ENV"
echo "DB_USER - $DB_USER"
echo "DB_PWD - $DB_PWD"
echo "############################"
echo ""

# Change to package directory
cd package

# Install application dependencies
echo "Installing application dependencies..."
npm install
npm install dotenv
npm install express@4.19.2

# Function to start Node.js application
start_node_app() {
    echo "Starting the nodejs application..."
    node server.js &
    sleep 2 # Wait for 2 seconds to ensure the process starts
    ps aux | grep node | grep -v grep
    echo ""
    echo "NodeJS is running on port 3000:"

    APP_PID=$!
    sleep 5
    if ps -p $APP_PID > /dev/null
    then
     echo "Application has started successfully."
     echo "Process ID: $APP_PID"
     PORT=3000
    if lsof -i :$PORT
    then
     echo "Application is listening on port $PORT"
    else
     echo "Application is not listening on port $PORT"
    fi
   else
    echo "Application failed to start."
  fi

}

start_node_app

# Check if Node.js is running on port 3000, handle EADDRINUSE error
if lsof -nP -iTCP:3000 -sTCP:LISTEN >/dev/null; then
    echo "Node.js application started successfully."
else
    echo "Port 3000 is not in use or application failed to start."
fi

# Perform npm audit to check for vulnerabilities
echo ""
echo "Performing npm audit..."
npm audit

# Display any high severity vulnerabilities
echo ""
echo "############################"
echo "High severity vulnerabilities:"
npm audit --json | jq '.metadata.vulnerabilities.high'
echo "############################"