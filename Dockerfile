# Full-Stack Application Dockerfile
# Build Date: 2025-09-03
# Version: 1.1.0 - FIXED BUILD PROCESS

# Use Node.js 20 Alpine as base image
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy root package files
COPY package*.json ./

# Install root dependencies
RUN npm install

# Copy backend and frontend package files
COPY backend/package*.json ./backend/
COPY frontend/package*.json ./frontend/

# Install backend and frontend dependencies
RUN npm run install:all

# Copy source code
COPY . .

# Build backend first (in its own directory)
WORKDIR /app/backend
RUN npm run build

# Build frontend (in its own directory)
WORKDIR /app/frontend
RUN npm run build

# Production stage
FROM node:20-alpine AS production

# Set working directory
WORKDIR /app

# Copy built applications
COPY --from=builder /app/backend/dist ./backend/dist
COPY --from=builder /app/backend/uploads ./backend/uploads
COPY --from=builder /app/frontend/build ./frontend/build

# Copy package files for production dependencies
COPY backend/package*.json ./backend/
COPY frontend/package*.json ./frontend/

# Install only production dependencies
RUN cd backend && npm install --omit=dev --no-audit --no-fund
RUN cd frontend && npm install --omit=dev --no-audit --no-fund

# Create uploads directory
RUN mkdir -p backend/uploads

# Expose ports
EXPOSE 3001 3000

# Start the backend (you can modify this to start both if needed)
CMD ["cd", "backend", "&&", "npm", "run", "start:prod"]
