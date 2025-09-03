# Use Node.js 20 Alpine as base image - Railway Optimized
FROM node:20-alpine

# Build arguments for cache invalidation
ARG BUILD_DATE=2025-09-03
ARG VERSION=1.0.0

# Add labels for better cache management
LABEL build-date=$BUILD_DATE
LABEL version=$VERSION
LABEL description="AI Competition Frontend - React App"

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --omit=dev --no-audit --no-fund --prefer-offline=false

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Use nginx to serve the built app
FROM nginx:alpine

# Copy built app to nginx
COPY --from=0 /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
