# Use Node.js 20 Alpine as base image - V2.0
FROM node:20-alpine

# Build argument to force cache invalidation
ARG BUILD_DATE=2025-09-03
ARG VERSION=2.0.0

# Add labels for better cache management
LABEL build-date=$BUILD_DATE
LABEL version=$VERSION
LABEL description="AI Competition Backend with OCR Support"

# Set working directory
WORKDIR /app

# Install system dependencies for Tesseract OCR
RUN apk add --no-cache \
    tesseract \
    tesseract-data-eng \
    poppler-utils \
    && rm -rf /var/cache/apk/*

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --omit=dev --no-audit --no-fund --prefer-offline=false

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Create uploads directory
RUN mkdir -p uploads

# Set permissions
RUN chmod 755 uploads

# Expose port
EXPOSE 3001

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3001/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) })" || exit 1

# Start the application
CMD ["npm", "run", "start:prod"]
