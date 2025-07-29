# Use official Node.js LTS image
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Install dependencies first (for caching)
COPY package*.json ./
RUN npm install --only=production

# Copy application source
COPY . .

# Expose the port
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
