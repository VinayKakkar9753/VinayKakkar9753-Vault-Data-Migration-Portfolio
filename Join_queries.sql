-- Files per folder
SELECT fo.FolderName, COUNT(*) 
FROM FileIteration fi
JOIN Folder fo ON fi.FolderId = fo.FolderId
GROUP BY fo.FolderName;
