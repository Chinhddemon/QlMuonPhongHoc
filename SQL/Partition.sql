-- MARK: Depecated
-- GO

-- -- Delete all partition scheme
-- DECLARE @SQL NVARCHAR(MAX) = N''
-- SELECT @SQL = @SQL + N'DROP PARTITION SCHEME ' + QUOTENAME(name) + N';' + CHAR(13) + CHAR(10)
-- FROM sys.partition_schemes
-- WHERE name LIKE 'PS_%'
-- EXEC sp_executesql @SQL

-- GO

-- -- Delete all partition function
-- DECLARE @SQL NVARCHAR(MAX) = N''
-- SELECT @SQL = @SQL + N'DROP PARTITION FUNCTION ' + QUOTENAME(name) + N';' + CHAR(13) + CHAR(10)
-- FROM sys.partition_functions
-- WHERE name LIKE 'PF_%'
-- EXEC sp_executesql @SQL

-- GO

-- CREATE PARTITION FUNCTION [PF_CleanOnCharA] 
--     (CHAR(1)) 
-- AS 
--     RANGE LEFT FOR VALUES ('A')

-- CREATE PARTITION SCHEME [PS_CleanOnCharA]
-- AS PARTITION [PF_CleanOnCharA]
-- TO (
--     [PRIMARY], -- Nhóm tập tin cho partition chứa giá trị 'A'
--     [SECONDARY] -- Nhóm tập tin cho partition chứa giá trị không phải 'A'
-- )

-- CREATE PARTITION FUNCTION [PF_CleanOnDelete] 
--   (DATETIME) 
-- AS 
--     RANGE LEFT FOR VALUES (NULL)

-- CREATE PARTITION SCHEME [PS_CleanOnNull] 
-- AS PARTITION [PF_CleanOnDelete]
-- TO (
--     [PRIMARY], -- Nhóm tập tin cho partition chứa giá trị NULL
--     [SECONDARY] -- Nhóm tập tin cho partition chứa giá trị không phải NULL
-- )