-- AI CRM Database Setup Script
-- Run this script to set up the database for the AI CRM File Processing System

-- Create database
CREATE DATABASE IF NOT EXISTS ai_crm;
USE ai_crm;

-- Note: The parsed_files table will be automatically created by TypeORM
-- when you start the backend server with synchronize: true

-- The table structure will be:
-- CREATE TABLE parsed_files (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     filename VARCHAR(255) NOT NULL,
--     fileType VARCHAR(50) NOT NULL,
--     originalName VARCHAR(100) NOT NULL,
--     fileSize BIGINT NOT NULL,
--     parsedContent LONGTEXT NOT NULL,
--     extractedText TEXT NULL,
--     createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
-- );

-- Create a user (optional, you can use root)
-- CREATE USER 'ai_crm_user'@'localhost' IDENTIFIED BY 'your_secure_password';
-- GRANT ALL PRIVILEGES ON ai_crm.* TO 'ai_crm_user'@'localhost';
-- FLUSH PRIVILEGES;

SELECT 'Database ai_crm created successfully!' as message;

