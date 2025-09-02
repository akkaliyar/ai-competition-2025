-- AI CRM Enhanced Database Setup Script
-- Comprehensive database setup for the enhanced AI CRM File Processing System

-- Create database with UTF8MB4 support for emojis and special characters
CREATE DATABASE IF NOT EXISTS ai_crm 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE ai_crm;

-- Enable timezone support
SET time_zone = '+00:00';

-- Create main parsed_files table
CREATE TABLE IF NOT EXISTS `parsed_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `originalName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileType` enum('image','pdf','excel') COLLATE utf8mb4_unicode_ci NOT NULL,
  `mimeType` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileSize` bigint NOT NULL,
  `fileHash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filePath` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnailPath` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processingStatus` enum('pending','processing','completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `processingStartedAt` timestamp NULL DEFAULT NULL,
  `processingCompletedAt` timestamp NULL DEFAULT NULL,
  `processingDurationMs` int DEFAULT NULL,
  `extractedText` longtext COLLATE utf8mb4_unicode_ci,
  `ocrData` longtext COLLATE utf8mb4_unicode_ci,
  `ocrMetadata` json DEFAULT NULL,
  `parsedContent` longtext COLLATE utf8mb4_unicode_ci,
  `contentMetadata` json DEFAULT NULL,
  `characterCount` int DEFAULT NULL,
  `wordCount` int DEFAULT NULL,
  `lineCount` int DEFAULT NULL,
  `averageConfidence` float DEFAULT NULL,
  `errorMessage` text COLLATE utf8mb4_unicode_ci,
  `errorStack` text COLLATE utf8mb4_unicode_ci,
  `retryCount` int NOT NULL DEFAULT '0',
  `imageMetadata` json DEFAULT NULL,
  `pdfMetadata` json DEFAULT NULL,
  `excelMetadata` json DEFAULT NULL,
  `detectedLanguage` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hasStructuredData` tinyint NOT NULL DEFAULT '0',
  `tableCount` int DEFAULT NULL,
  `userAgent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploadedFromIp` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sessionId` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `lastAccessedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_parsed_files_fileType_processingStatus` (`fileType`,`processingStatus`),
  KEY `IDX_parsed_files_createdAt` (`createdAt`),
  KEY `IDX_parsed_files_processingStatus` (`processingStatus`),
  KEY `IDX_parsed_files_fileHash` (`fileHash`),
  FULLTEXT KEY `FT_parsed_files_extractedText` (`extractedText`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create OCR results table
CREATE TABLE IF NOT EXISTS `ocr_results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parsedFileId` int NOT NULL,
  `ocrEngine` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ocrVersion` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pageNumber` int NOT NULL DEFAULT '1',
  `regionId` int DEFAULT NULL,
  `rawText` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `wordLevelData` json DEFAULT NULL,
  `lineLevelData` json DEFAULT NULL,
  `paragraphLevelData` json DEFAULT NULL,
  `blockLevelData` json DEFAULT NULL,
  `overallConfidence` float DEFAULT NULL,
  `averageWordConfidence` float DEFAULT NULL,
  `averageLineConfidence` float DEFAULT NULL,
  `lowConfidenceWordCount` int DEFAULT NULL,
  `confidenceThreshold` float DEFAULT NULL,
  `processingTimeMs` int NOT NULL,
  `processingOptions` json DEFAULT NULL,
  `imagePreprocessing` json DEFAULT NULL,
  `characterCount` int NOT NULL,
  `wordCount` int NOT NULL,
  `lineCount` int NOT NULL,
  `sentenceCount` int DEFAULT NULL,
  `paragraphCount` int DEFAULT NULL,
  `hasNumericData` tinyint NOT NULL DEFAULT '0',
  `hasTabularData` tinyint NOT NULL DEFAULT '0',
  `hasFormData` tinyint NOT NULL DEFAULT '0',
  `detectedTables` json DEFAULT NULL,
  `detectedFields` json DEFAULT NULL,
  `imageQuality` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `textOrientation` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hasNoise` tinyint NOT NULL DEFAULT '0',
  `hasBlur` tinyint NOT NULL DEFAULT '0',
  `skewAngle` float DEFAULT NULL,
  `warnings` text COLLATE utf8mb4_unicode_ci,
  `errors` text COLLATE utf8mb4_unicode_ci,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `IDX_ocr_results_parsedFileId` (`parsedFileId`),
  CONSTRAINT `FK_ocr_results_parsedFileId` FOREIGN KEY (`parsedFileId`) REFERENCES `parsed_files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create file metadata table
CREATE TABLE IF NOT EXISTS `file_metadata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parsedFileId` int NOT NULL,
  `imageWidth` int DEFAULT NULL,
  `imageHeight` int DEFAULT NULL,
  `imageDpi` int DEFAULT NULL,
  `imageColorSpace` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageBitDepth` int DEFAULT NULL,
  `imageFormat` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageCompression` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageExifData` json DEFAULT NULL,
  `cameraModel` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageDateTaken` timestamp NULL DEFAULT NULL,
  `imageGpsData` json DEFAULT NULL,
  `pdfPageCount` int DEFAULT NULL,
  `pdfVersion` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdfTitle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdfAuthor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdfSubject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdfCreator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdfProducer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdfCreationDate` timestamp NULL DEFAULT NULL,
  `pdfModificationDate` timestamp NULL DEFAULT NULL,
  `pdfIsEncrypted` tinyint NOT NULL DEFAULT '0',
  `pdfHasImages` tinyint NOT NULL DEFAULT '0',
  `pdfHasForms` tinyint NOT NULL DEFAULT '0',
  `pdfPageSizes` json DEFAULT NULL,
  `pdfFonts` json DEFAULT NULL,
  `pdfBookmarks` json DEFAULT NULL,
  `excelSheetCount` int DEFAULT NULL,
  `excelSheetNames` json DEFAULT NULL,
  `excelTitle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excelAuthor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excelCompany` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excelApplication` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excelCreationDate` timestamp NULL DEFAULT NULL,
  `excelModificationDate` timestamp NULL DEFAULT NULL,
  `excelTotalCells` int DEFAULT NULL,
  `excelUsedCells` int DEFAULT NULL,
  `excelSheetStatistics` json DEFAULT NULL,
  `excelHasFormulas` tinyint NOT NULL DEFAULT '0',
  `excelHasCharts` tinyint NOT NULL DEFAULT '0',
  `excelHasMacros` tinyint NOT NULL DEFAULT '0',
  `excelDataTypes` json DEFAULT NULL,
  `fileExtension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fileMd5Hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fileSha256Hash` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fileEncoding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fileLineEndings` int DEFAULT NULL,
  `fileHasBom` tinyint NOT NULL DEFAULT '0',
  `detectedLanguages` json DEFAULT NULL,
  `textComplexity` float DEFAULT NULL,
  `keywordDensity` json DEFAULT NULL,
  `entityExtraction` json DEFAULT NULL,
  `sentimentAnalysis` json DEFAULT NULL,
  `processingServer` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processingNodeVersion` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processingLibraryVersions` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processingConfiguration` json DEFAULT NULL,
  `customMetadata` json DEFAULT NULL,
  `tags` json DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `REL_file_metadata_parsedFileId` (`parsedFileId`),
  CONSTRAINT `FK_file_metadata_parsedFileId` FOREIGN KEY (`parsedFileId`) REFERENCES `parsed_files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create table extractions table
CREATE TABLE IF NOT EXISTS `table_extractions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parsedFileId` int NOT NULL,
  `tableIndex` int NOT NULL,
  `tableName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pageNumber` int DEFAULT NULL,
  `rowCount` int NOT NULL,
  `columnCount` int NOT NULL,
  `headers` json NOT NULL,
  `tableData` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `cellTypes` json DEFAULT NULL,
  `cellStyles` json DEFAULT NULL,
  `boundingBox` json DEFAULT NULL,
  `tableConfidence` float DEFAULT NULL,
  `emptyRows` int DEFAULT NULL,
  `emptyCells` int DEFAULT NULL,
  `dataCompleteness` float DEFAULT NULL,
  `hasHeaderRow` tinyint NOT NULL DEFAULT '0',
  `hasFooterRow` tinyint NOT NULL DEFAULT '0',
  `hasNumericData` tinyint NOT NULL DEFAULT '0',
  `hasDateData` tinyint NOT NULL DEFAULT '0',
  `columnStatistics` json DEFAULT NULL,
  `dataPatterns` json DEFAULT NULL,
  `duplicateRows` json DEFAULT NULL,
  `outliers` json DEFAULT NULL,
  `extractionMethod` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processingTimeMs` int DEFAULT NULL,
  `extractionOptions` json DEFAULT NULL,
  `validationErrors` json DEFAULT NULL,
  `dataWarnings` json DEFAULT NULL,
  `overallQuality` float DEFAULT NULL,
  `excelSheetName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excelRange` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excelFormulas` json DEFAULT NULL,
  `hasExcelCharts` tinyint NOT NULL DEFAULT '0',
  `excelFormatting` json DEFAULT NULL,
  `pdfTextBlocks` json DEFAULT NULL,
  `pdfTableDetectionScore` float DEFAULT NULL,
  `pdfLayoutAnalysis` json DEFAULT NULL,
  `ocrTableRegions` json DEFAULT NULL,
  `ocrAverageConfidence` float DEFAULT NULL,
  `cellBoundingBoxes` json DEFAULT NULL,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `IDX_table_extractions_parsedFileId` (`parsedFileId`),
  CONSTRAINT `FK_table_extractions_parsedFileId` FOREIGN KEY (`parsedFileId`) REFERENCES `parsed_files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create views for easier data access
CREATE OR REPLACE VIEW `v_file_summary` AS
SELECT 
    pf.id,
    pf.originalName,
    pf.fileType,
    pf.fileSize,
    pf.processingStatus,
    pf.processingDurationMs,
    pf.characterCount,
    pf.wordCount,
    pf.hasStructuredData,
    pf.tableCount,
    pf.createdAt,
    COALESCE(fm.pdfPageCount, 1) as pageCount,
    CASE 
        WHEN pf.fileType = 'excel' THEN fm.excelSheetCount
        ELSE NULL 
    END as sheetCount
FROM parsed_files pf
LEFT JOIN file_metadata fm ON pf.id = fm.parsedFileId;

-- Create performance monitoring view
CREATE OR REPLACE VIEW `v_processing_stats` AS
SELECT 
    DATE(createdAt) as date,
    fileType,
    COUNT(*) as total_files,
    COUNT(CASE WHEN processingStatus = 'completed' THEN 1 END) as completed_files,
    COUNT(CASE WHEN processingStatus = 'failed' THEN 1 END) as failed_files,
    AVG(processingDurationMs) as avg_processing_time_ms,
    AVG(fileSize) as avg_file_size,
    SUM(fileSize) as total_size_processed
FROM parsed_files
GROUP BY DATE(createdAt), fileType
ORDER BY date DESC, fileType;

SELECT 'Enhanced AI CRM database setup completed successfully!' as message;

