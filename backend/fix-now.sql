USE ai_crm;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `table_extractions`;
DROP TABLE IF EXISTS `ocr_results`;
DROP TABLE IF EXISTS `file_metadata`;
DROP TABLE IF EXISTS `parsed_files`;
SET FOREIGN_KEY_CHECKS = 1;

-- Show remaining tables (should be empty or only system tables)
SHOW TABLES;
