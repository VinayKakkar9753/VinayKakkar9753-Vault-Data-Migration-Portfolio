-- ============================================
-- BASIC SQL QUERIES - VAULT DATA ANALYSIS
-- Author: Vinay Kakkar
-- Purpose: Data validation and analysis
-- ============================================

-- 1. Count total number of files
SELECT COUNT(*) AS TotalFiles
FROM FileIteration;


-- 2. Count number of released files
SELECT COUNT(*) AS ReleasedFiles
FROM FileIteration
WHERE LifeCycleStateName = 'Released';


-- 3. Count files by lifecycle state
SELECT LifeCycleStateName, COUNT(*) AS FileCount
FROM FileIteration
GROUP BY LifeCycleStateName
ORDER BY FileCount DESC;


-- 4. Count files by folder
SELECT fo.FolderName, COUNT(*) AS FileCount
FROM FileIteration fi
JOIN Folder fo ON fi.FolderId = fo.FolderId
GROUP BY fo.FolderName
ORDER BY FileCount DESC;


-- 5. Find records with NULL lifecycle (data quality check)
SELECT *
FROM FileIteration
WHERE LifeCycleStateName IS NULL;
