-- Explanation: This script will drop all the stored procedures in the database.
DECLARE @procedureName NVARCHAR(MAX)
DECLARE procedureCursor CURSOR FOR
    SELECT [name]
    FROM sys.procedures
OPEN procedureCursor
FETCH NEXT FROM procedureCursor INTO @procedureName
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC ('DROP PROCEDURE ' + @procedureName)
    FETCH NEXT FROM procedureCursor INTO @procedureName
END
CLOSE procedureCursor
DEALLOCATE procedureCursor
-- End of the script

-- Explanation: This script will drop all the views in the database.
DECLARE @viewName NVARCHAR(MAX)
DECLARE viewCursor CURSOR FOR
    SELECT [name]
    FROM sys.views
OPEN viewCursor
FETCH NEXT FROM viewCursor INTO @viewName
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC ('DROP VIEW ' + @viewName)
    FETCH NEXT FROM viewCursor INTO @viewName
END
CLOSE viewCursor
DEALLOCATE viewCursor
-- End of the script

-- Explanation: This script will drop all the triggers in the database.
DECLARE @TriggerName NVARCHAR(128)
DECLARE cursorTrigger CURSOR FOR
SELECT name FROM sys.triggers

OPEN cursorTrigger

FETCH NEXT FROM cursorTrigger INTO @TriggerName
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC ('DROP TRIGGER ' + @TriggerName)
    FETCH NEXT FROM cursorTrigger INTO @TriggerName
END

CLOSE cursorTrigger
DEALLOCATE cursorTrigger
-- End of the script