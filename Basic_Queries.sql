-- Count total files
SELECT COUNT(*) FROM FileIteration;

-- Count released files
SELECT COUNT(*) 
FROM FileIteration
WHERE LifeCycleStateName = 'Released';
