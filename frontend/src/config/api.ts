// API Configuration for different environments

const getApiBaseUrl = (): string => {
  // Check if we're in production (Railway)
  if (process.env.NODE_ENV === 'production') {
    // Use Railway environment variable
    return process.env.REACT_APP_API_URL || 'https://ai-competition-2025-production.up.railway.app/api';
  }
  
  // Development fallback
  return process.env.REACT_APP_API_URL || 'http://localhost:3001/api';
};

export const API_BASE_URL = getApiBaseUrl();

console.log('🔗 API Base URL:', API_BASE_URL);