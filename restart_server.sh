#!/bin/bash

# Restart Server Script
# This script stops any running Node.js server processes and starts a new one

echo "Stopping any running Node.js server processes..."

# Find and kill any running Node.js server processes
pkill -f "node server.js" || echo "No server process found"

# Wait a moment for processes to terminate
sleep 2

echo "Starting server..."

# Start the server with the specified port
PORT=8080 node server.js &

echo "Server started on port 8080"