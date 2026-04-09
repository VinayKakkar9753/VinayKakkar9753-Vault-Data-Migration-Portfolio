-- =====================================
-- Vault 2026 Migration Sanity Report (Single Summary Table)
-- Database: VAULT
-- Author: Vinay Kakkar
-- =====================================

USE [VAULT];
GO

-- Create a summary table with all key metrics
WITH
-- Total files
TotalFiles AS (
    SELECT COUNT(*) AS Value FROM FileMaster
),
-- Total revisions
TotalRevisions AS (
    SELECT COUNT(*) AS Value FROM FileIteration
),
-- Latest revision per file
LatestRevisionFiles AS (
    SELECT COUNT(fi.FileIterationId) AS Value
    FROM FileMaster fm
    JOIN FileIteration fi 
        ON fm.TipFileBaseName = fi.FileName
),
-- Files checked out
FilesCheckedOut AS (
    SELECT COUNT(*) AS Value
    FROM FileMaster
    WHERE CheckedOut = 1
),
-- Files checked in
FilesCheckedIn AS (
    SELECT COUNT(*) AS Value
    FROM FileMaster
    WHERE CheckedOut = 0
),
-- Files checked in during migration window
FilesCheckedInDuringMigration AS (
    SELECT COUNT(*) AS Value
    FROM FileIteration
    WHERE CheckinDate BETWEEN '2026-01-01' AND '2026-04-01'
),
-- Files per folder (total)
FilesPerFolder AS (
    SELECT COUNT(*) AS Value FROM FileMaster
),
-- Files per lifecycle state (total)
FilesPerLifecycle AS (
    SELECT COUNT(*) AS Value FROM FileIteration
),
-- Files per category (total)
FilesPerCategory AS (
    SELECT COUNT(*) AS Value
    FROM FileMaster fm
    JOIN Entity e ON fm.FileMasterID = e.EntityID
    JOIN CategoryOnEntity coe ON e.EntityID = coe.EntityId
    JOIN CategoryDef cd ON coe.CategoryDefId = cd.CategoryDefId
)

-- Combine all metrics in one result set
SELECT 'Total Files' AS Metric, Value FROM TotalFiles
UNION ALL
SELECT 'Total Revisions', Value FROM TotalRevisions
UNION ALL
SELECT 'Latest Revision per File', Value FROM LatestRevisionFiles
UNION ALL
SELECT 'Files Checked Out', Value FROM FilesCheckedOut
UNION ALL
SELECT 'Files Checked In', Value FROM FilesCheckedIn
UNION ALL
SELECT 'Files Checked In During Migration', Value FROM FilesCheckedInDuringMigration
UNION ALL
SELECT 'Files Per Folder (Total)', Value FROM FilesPerFolder
UNION ALL
SELECT 'Files Per Lifecycle State (Total)', Value FROM FilesPerLifecycle
UNION ALL
SELECT 'Files Per Category (Total)', Value FROM FilesPerCategory
