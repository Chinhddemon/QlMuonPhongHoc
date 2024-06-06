GO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_OverrideOnAttributes]
    @TableName VARCHAR(128),
    @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF
    @TriggerActionOn CHAR(3) = 'U' -- I: INSERT, U: UPDATE, D: DELETE
AS
    BEGIN TRY

        DECLARE @HeadName VARCHAR(MAX)
        DECLARE @TailName VARCHAR(MAX)
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @InsertedJoinOn VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra tham số đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger

        -- Đặt tên cho trigger
        SET @HeadName = 'OverrideOnAttributes_'
        SET @TailName = ''
        IF @TriggerType = 'I' SET @TailName = '_UsingInsteadOf'

        -- Thiết lập hành động của trigger
        IF CHARINDEX('I', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'INSERT'
        IF CHARINDEX('U', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'UPDATE'
        IF CHARINDEX('D', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'DELETE'
        IF CHARINDEX('A', @TriggerType) > 0 SET @ActionCommand = 'AFTER ' + @ActionCommand
        ELSE IF CHARINDEX('I', @TriggerType) > 0 SET @ActionCommand = 'INSTEAD OF ' + @ActionCommand

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + @TableName + '.' + ColumnName + ' = ' + OverrideValue
        FROM #TableSetup t
        WHERE TableName = @TableName

        -- Thiết lập điều kiện join
        SELECT @InsertedJoinOn = COALESCE(@InsertedJoinOn + ' AND
                ', '') + @TableName + '.' + COLUMN_NAME + ' = i.' + COLUMN_NAME
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
            AND TABLE_NAME = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)
        IF @InsertedJoinOn IS NULL RAISERROR ('@InsertedJoinOn is NULL', 16, 1)

        -- MARK: Tạo trigger
        SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
        ON [dbo].[' + @TableName + ']
        ' + @ActionCommand + '
        AS
        BEGIN
            SET NOCOUNT ON

            UPDATE ' + @TableName + '
            SET ' + @Columns + '
            FROM [dbo].[' + @TableName + ']
            INNER JOIN inserted i 
                ON ' + @InsertedJoinOn + '
        END'

        EXEC (@SQL)

        PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_OverrideOnAttributesAt_OtherTables]
    @TableName VARCHAR(128),
    @TableRefName VARCHAR(128),
    @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF
    @TriggerActionOn CHAR(3) = 'IUD' -- I: INSERT, U: UPDATE, D: DELETE
AS
    BEGIN TRY
        DECLARE @HeadName VARCHAR(MAX)
        DECLARE @TailName VARCHAR(MAX)
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @TableRefJoinOn VARCHAR(MAX)
        DECLARE @InsertedJoinOn VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra dữ liệu đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
                AND TableRefName = @TableRefName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' or table ' + @TableRefName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END
        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableRefName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableRefName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger
        -- Đặt tên cho trigger
        SET @HeadName = 'OverrideOnAttributesAtOtherTables_'
        SET @TailName = ''

        -- Thiết lập hành động của trigger
        IF CHARINDEX('I', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'INSERT'
        IF CHARINDEX('U', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'UPDATE'
        IF CHARINDEX('D', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'DELETE'
        IF CHARINDEX('A', @TriggerType) > 0 SET @ActionCommand = 'AFTER ' + @ActionCommand
        ELSE IF CHARINDEX('I', @TriggerType) > 0 SET @ActionCommand = 'INSTEAD OF ' + @ActionCommand

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + @TableRefName + '.' + ColumnRefName + ' = ' + OverrideValue
        FROM #TableSetup
        WHERE TableName = @TableName
            AND TableRefName = @TableRefName

        -- Thiết lập điều kiện join
        SELECT @TableRefJoinOn = COALESCE(@TableRefJoinOn + ' AND
                ', '
                ') + 
            CASE 
                WHEN p.TABLE_NAME = @TableName THEN @TableRefName + '.' + f.COLUMN_NAME + ' = ' + @TableName + '.' + p.COLUMN_NAME
                ELSE @TableRefName + '.' + p.COLUMN_NAME + ' = ' + @TableName + '.' + f.COLUMN_NAME
            END
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE p
        INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS c ON c.UNIQUE_CONSTRAINT_NAME = p.CONSTRAINT_NAME
        INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE f ON c.CONSTRAINT_NAME = f.CONSTRAINT_NAME
        WHERE (p.TABLE_NAME = @TableName AND f.TABLE_NAME = @TableRefName)
            OR (p.TABLE_NAME = @TableRefName AND f.TABLE_NAME = @TableName)

        SELECT @InsertedJoinOn = COALESCE(@InsertedJoinOn + ' AND
                ', '
                ') + @TableName + '.' + COLUMN_NAME + ' = i.' + COLUMN_NAME
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
            AND TABLE_NAME = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)
        IF @TableRefJoinOn IS NULL RAISERROR ('@TableRefJoinOn is NULL', 16, 1)
        IF @InsertedJoinOn IS NULL RAISERROR ('@InsertedJoinOn is NULL', 16, 1)

        -- MARK: Tạo trigger
        SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
        ON [dbo].[' + @TableName + ']
        ' + @ActionCommand + '
        AS
        BEGIN
            SET NOCOUNT ON

            UPDATE ' + @TableRefName + '
            SET ' + @Columns + '
            FROM [dbo].[' + @TableRefName + ']
            INNER JOIN ' + @TableName + ' ON ' + @TableRefJoinOn + '
            INNER JOIN inserted i ON ' + @InsertedJoinOn + '
        END'

        EXEC (@SQL)

        PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_BlockOnAttributes]
    @TableName VARCHAR(128),
    @HeadName VARCHAR(128) = 'BlockOnAttributes_',
    @TailName VARCHAR(128) = '',
    -- @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF -- Not used
    @TriggerActionOn CHAR(3) = 'I' -- I: INSERT, U: UPDATE, D: DELETE
AS
    BEGIN TRY
        DECLARE @TriggerType CHAR(1) = 'A'
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra dữ liệu đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger

        -- Thiết lập hành động của trigger
        IF CHARINDEX('I', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'INSERT'
        IF CHARINDEX('U', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'UPDATE'
        IF CHARINDEX('D', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'DELETE'
        IF CHARINDEX('A', @TriggerType) > 0 SET @ActionCommand = 'AFTER ' + @ActionCommand
        ELSE IF CHARINDEX('I', @TriggerType) > 0 SET @ActionCommand = 'INSTEAD OF ' + @ActionCommand

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + 'inserted.' + ColumnName + ' IS NOT NULL'
        FROM #TableSetup
        WHERE TableName = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)

        -- MARK: Tạo trigger
        SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
        ON [dbo].[' + @TableName + ']
        ' + @ActionCommand + '
        AS
        BEGIN
            SET NOCOUNT ON

            IF EXISTS (
                SELECT 1
                FROM inserted
                WHERE ' + @Columns + '
            )
            BEGIN
                RAISERROR(''Can not insert data because _DeletedAt is not null'', 16, 1)
            END
        END'

        EXEC (@SQL)

        PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_PretendDelete]
    @TableName VARCHAR(128)
    -- @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF -- Not used
    -- @TriggerActionOn CHAR(3) = 'D' -- I: INSERT, U: UPDATE, D: DELETE -- Not used
AS
    BEGIN TRY
        DECLARE @HeadName VARCHAR(MAX)
        DECLARE @TailName VARCHAR(MAX)
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @DeletedJoinOn VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra dữ liệu đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger
        -- Đặt tên cho trigger
        SET @HeadName = 'PretendDelete_'
        SET @TailName = ''

        -- Thiết lập hành động của trigger
        SET @ActionCommand = 'INSTEAD OF DELETE'

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + @TableName + '._DeleteAt = GETDATE()'
        FROM #TableSetup
        WHERE TableName = @TableName

        -- Thiết lập điều kiện join
        SELECT @DeletedJoinOn = COALESCE(@DeletedJoinOn + ' AND
                ', '') + @TableName + '.' + COLUMN_NAME + ' = d.' + COLUMN_NAME
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
            AND TABLE_NAME = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)
        IF @DeletedJoinOn IS NULL RAISERROR ('@DeletedJoinOn is NULL', 16, 1)

        -- MARK: Tạo trigger
        SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
        ON [dbo].[' + @TableName + ']
        ' + @ActionCommand + '
        AS
        BEGIN
            SET NOCOUNT ON

            UPDATE ' + @TableName + '
            SET ' + @Columns + '
            FROM [dbo].[' + @TableName + ']
            INNER JOIN deleted d 
                ON ' + @DeletedJoinOn + '
        END'

        EXEC (@SQL)

        PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_PretendDeleteAt_OtherTables]
    @TableName VARCHAR(128),
    @TableRefedName VARCHAR(128)
    -- @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF -- Not used
    -- @TriggerActionOn CHAR(3) = 'D' -- I: INSERT, U: UPDATE, D: DELETE -- Not used
AS
    BEGIN TRY
        DECLARE @HeadName VARCHAR(MAX)
        DECLARE @TailName VARCHAR(MAX)
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @TableRefJoinOn VARCHAR(MAX)
        DECLARE @DeletedJoinOn VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @SQL_REPLACEMENT NVARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra dữ liệu đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
                AND TableRefedName = @TableRefedName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' or table ' + @TableRefedName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END
        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableRefedName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableRefedName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger
        -- Đặt tên cho trigger
        SET @HeadName = 'PretendDeleteAtOtherTables_'
        SET @TailName = ''

        -- Thiết lập hành động của trigger
        SET @ActionCommand = 'INSTEAD OF DELETE'

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + @TableRefedName + '._DeleteAt = GETDATE()'
        FROM #TableSetup
        WHERE TableName = @TableName
            AND TableRefedName = @TableRefedName

        -- Thiết lập điều kiện join
        SELECT @TableRefJoinOn = COALESCE(@TableRefJoinOn + ' AND ', '') + 
            CASE 
                WHEN p.TABLE_NAME = @TableName THEN @TableRefedName + '.' + f.COLUMN_NAME + ' = ' + @TableName + '.' + p.COLUMN_NAME
                ELSE @TableRefedName + '.' + p.COLUMN_NAME + ' = ' + @TableName + '.' + f.COLUMN_NAME
            END
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE p
        INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS c ON c.UNIQUE_CONSTRAINT_NAME = p.CONSTRAINT_NAME
        INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE f ON c.CONSTRAINT_NAME = f.CONSTRAINT_NAME
        WHERE (p.TABLE_NAME = @TableName AND f.TABLE_NAME = @TableRefedName)
            OR (p.TABLE_NAME = @TableRefedName AND f.TABLE_NAME = @TableName)

        SELECT @DeletedJoinOn = COALESCE(@DeletedJoinOn + ' AND ', '') + @TableName + '.' + COLUMN_NAME + ' = d.' + COLUMN_NAME
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
            AND TABLE_NAME = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)
        IF @TableRefJoinOn IS NULL RAISERROR ('@TableRefJoinOn is NULL', 16, 1)
        IF @DeletedJoinOn IS NULL RAISERROR ('@DeletedJoinOn is NULL', 16, 1)

        -- MARK: Tạo trigger
        
        SELECT @SQL_REPLACEMENT = OBJECT_DEFINITION(OBJECT_ID('PretendDelete_' + @TableName))
        IF @SQL_REPLACEMENT IS NOT NULL
        BEGIN
            SET @SQL_REPLACEMENT = REPLACE(@SQL_REPLACEMENT, 'CREATE', 'ALTER')
            SET @SQL_REPLACEMENT = REPLACE(@SQL_REPLACEMENT, 'SET NOCOUNT ON',
            'SET NOCOUNT ON

            DELETE FROM ' + @TableRefedName + '
            FROM [dbo].[' + @TableRefedName + ']
            INNER JOIN ' + @TableName + '
                ON ' + @TableRefJoinOn + '
            INNER JOIN deleted d 
                ON ' + @DeletedJoinOn)

            EXEC (@SQL_REPLACEMENT)

            PRINT 'Trigger PretendDelete_' + @TableName + ' has been updated from content of ' + @HeadName + @TableName + @TailName
        END
        ELSE
        BEGIN
            SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
            ON [dbo].[' + @TableName + ']
            ' + @ActionCommand + '
            AS
            BEGIN
                SET NOCOUNT ON

                UPDATE ' + @TableRefedName + '
                SET ' + @Columns + '
                FROM [dbo].[' + @TableRefedName + ']
                INNER JOIN ' + @TableName + '
                    ON ' + @TableRefJoinOn + '
                INNER JOIN deleted d 
                    ON ' + @DeletedJoinOn + '
            END'

            EXEC (@SQL)

            PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
        END

        
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[DropIfExists]
    @selectType VARCHAR(2), -- NULL if not specified object type
    @tableName VARCHAR(128),
    @headName VARCHAR(128),
    @tailName VARCHAR(128) = '',
    @schemaName VARCHAR(128) = 'dbo'
AS
    BEGIN TRY
        DECLARE @DescribeAction VARCHAR(MAX)
        DECLARE @ActionDone VARCHAR(MAX)
        DECLARE @ObjectName VARCHAR(MAX) = @headName + @tableName + @tailName
        DECLARE @ObjectType VARCHAR(MAX) = 'Object '
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        SET NOCOUNT ON

        CREATE TABLE #ObjectDrop (objectName VARCHAR(128), objectType VARCHAR(128))
        INSERT INTO #ObjectDrop (objectName, objectType)
        SELECT name, type
        FROM sys.objects
        WHERE SCHEMA_NAME(schema_id) = @schemaName
            AND name = @ObjectName

        SET NOCOUNT OFF

        IF @selectType IS NOT NULL
        BEGIN
            SET @ObjectType = 
                CASE @selectType
                    WHEN 'P' THEN 'Procedure '
                    WHEN 'V' THEN 'View '
                    WHEN 'U' THEN 'Table '
                    WHEN 'FN' THEN 'Function '
                    WHEN 'IF' THEN 'Function '
                    WHEN 'TF' THEN 'Function '
                    WHEN 'TR' THEN 'Trigger '
                    WHEN 'C' THEN 'Constraint '
                    WHEN 'S' THEN 'Sequence '
                    WHEN 'K' THEN 'Key '
                    WHEN 'I' THEN 'Index '
                    WHEN 'D' THEN 'Default '
                    WHEN 'X' THEN 'XML Schema Collection '
                    WHEN 'UQ' THEN 'Unique Constraint '
                    WHEN 'PK' THEN 'Primary Key Constraint '
                    WHEN 'F' THEN 'Foreign Key Constraint '
                    ELSE NULL
                END
            IF @ObjectType IS NULL 
                RAISERROR('@selectType is not valid', 16, 1)
        END

        IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('P')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'P'
        )
        BEGIN
            SET @SQL = 'DROP PROCEDURE '
            SET @ObjectType = 'Procedure '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('V')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'V'
        )
        BEGIN
            SET @SQL = 'DROP VIEW '
            SET @ObjectType = 'View '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('U')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'U'
        )
        BEGIN
            SET @SQL = 'DROP TABLE '
            SET @ObjectType = 'Table '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('FN', 'IF', 'TF')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'FN' OR @selectType = 'IF' OR @selectType = 'TF'
        )
        BEGIN
            SET @SQL = 'DROP FUNCTION '
            SET @ObjectType = 'Function '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('TR')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'TR'
        )
        BEGIN
            SET @SQL = 'DROP TRIGGER '
            SET @ObjectType = 'Trigger '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('C')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'C'
        )
        BEGIN
            SET @SQL = 'DROP CONSTRAINT '
            SET @ObjectType = 'Constraint '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('S')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'S'
        )
        BEGIN
            SET @SQL = 'DROP SEQUENCE '
            SET @ObjectType = 'Sequence '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('K')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'K'
        )
        BEGIN
            SET @SQL = 'DROP KEY '
            SET @ObjectType = 'Key '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('I')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'I'
        )
        BEGIN
            SET @SQL = 'DROP INDEX '
            SET @ObjectType = 'Index '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('D')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'D'
        )
        BEGIN
            SET @SQL = 'DROP DEFAULT '
            SET @ObjectType = 'Default '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('X')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'X'
        )
        BEGIN
            SET @SQL = 'DROP XML SCHEMA COLLECTION '
            SET @ObjectType = 'XML Schema Collection '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('UQ')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'UQ'
        )
        BEGIN
            SET @SQL = 'DROP UNIQUE CONSTRAINT '
            SET @ObjectType = 'Unique Constraint '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('PK')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'PK'
        )
        BEGIN
            SET @SQL = 'DROP PRIMARY KEY CONSTRAINT '
            SET @ObjectType = 'Primary Key Constraint '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('F')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'F'
        )
        BEGIN
            SET @SQL = 'DROP FOREIGN KEY CONSTRAINT '
            SET @ObjectType = 'Foreign Key Constraint '
        END

        DROP TABLE #ObjectDrop

        SET @DescribeAction = ' has been '
        SET @ActionDone = 'dropped'

        SET @SQL = @SQL + @schemaName + '.' + @ObjectName

        EXEC(@SQL)
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when dropping object: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_OverrideOnAttributes]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), ColumnName VARCHAR(128), OverrideValue VARCHAR(128))
        INSERT INTO #TableSetup
        SELECT TABLE_NAME, COLUMN_NAME, 'GETDATE()'
        FROM INFORMATION_SCHEMA.COLUMNS TABLE_NAME
        WHERE COLUMN_NAME = '_LastUpdateAt'

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableName VARCHAR(128)
        DECLARE @HeadName VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableName
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadName = 'OverrideOnAttributes_'
            EXEC [dbo].[DropIfExists] 'TR', @TableName, @HeadName
            EXEC [dbo].[GENERATE_TRIGGER_OverrideOnAttributes] @TableName, 'A', 'U'
            FETCH NEXT FROM CURSOR_TABLE INTO @TableName
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_OverrideOnAttributesAtOtherTables]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), TableRefName VARCHAR(128), ColumnRefName VARCHAR(128), OverrideValue VARCHAR(128))
        INSERT INTO #TableSetup (TableName, TableRefName, ColumnRefName, OverrideValue) VALUES
            ('GiangVien', 'TaiKhoan', '_LastUpdateAt', 'GETDATE()'),
            ('SinhVien', 'TaiKhoan', '_LastUpdateAt', 'GETDATE()'),
            ('QuanLy', 'TaiKhoan', '_LastUpdateAt', 'GETDATE()'),
            ('NhomToHocPhan', 'NhomHocPhan', '_LastUpdateAt', 'GETDATE()'),
            ('MuonPhongHoc', 'LichMuonPhong', '_LastUpdateAt', 'GETDATE()')

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName, TableRefName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableName VARCHAR(128)
        DECLARE @TableRefName VARCHAR(128)
        DECLARE @HeadName VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableName, @TableRefName
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadName = 'OverrideOnAttributesAtOtherTables_'
            EXEC [dbo].[DropIfExists] 'TR', @TableName, @HeadName
            EXEC [dbo].[GENERATE_TRIGGER_OverrideOnAttributesAt_OtherTables] @TableName, @TableRefName, 'A' ,'IUD'
            FETCH NEXT FROM CURSOR_TABLE INTO @TableName, @TableRefName
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_BlockOnAttributes]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), ColumnName VARCHAR(128))
        INSERT INTO #TableSetup
        SELECT TABLE_NAME, COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE COLUMN_NAME = '_DeleteAt'

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableNameInput VARCHAR(128)
        DECLARE @HeadNameInput VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableNameInput
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadNameInput = 'PrevertInsertOnAttributes_'
            EXEC [dbo].[DropIfExists] 'TR', @TableNameInput, @HeadNameInput
            EXEC [dbo].[GENERATE_TRIGGER_BlockOnAttributes] 
                @TableName = @TableNameInput, 
                @HeadName = @HeadNameInput, 
                @TriggerActionOn = 'I'
            FETCH NEXT FROM CURSOR_TABLE INTO @TableNameInput
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_PretendDelete]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), ColumnName VARCHAR(128))
        INSERT INTO #TableSetup
        SELECT TABLE_NAME, COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE COLUMN_NAME = '_DeleteAt'

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableName VARCHAR(128)
        DECLARE @HeadName VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableName
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadName = 'PretendDelete_'
            EXEC [dbo].[DropIfExists] 'TR', @TableName, @HeadName
            EXEC [dbo].[GENERATE_TRIGGER_PretendDelete] @TableName
            FETCH NEXT FROM CURSOR_TABLE INTO @TableName
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_PretendDeleteAt_OtherTables]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), TableRefedName VARCHAR(128))
        INSERT INTO #TableSetup (TableName, TableRefedName) VALUES
            ('NhomHocPhan', 'NhomToHocPhan'),
            ('NhomToHocPhan', 'LichMuonPhong')

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName, TableRefedName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableName VARCHAR(128)
        DECLARE @TableRefedName VARCHAR(128)
        DECLARE @HeadName VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableName, @TableRefedName
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadName = 'PretendDeleteAtOtherTables_'
            EXEC [dbo].[DropIfExists] 'TR', @TableName, @HeadName
            EXEC [dbo].[GENERATE_TRIGGER_PretendDeleteAt_OtherTables] @TableName, @TableRefedName
            FETCH NEXT FROM CURSOR_TABLE INTO @TableName, @TableRefedName
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

EXEC [dbo].[GeneratePackage_Trigger_OverrideOnAttributes]
EXEC [dbo].[GeneratePackage_Trigger_OverrideOnAttributesAtOtherTables]
EXEC [dbo].[GeneratePackage_Trigger_BlockOnAttributes]
EXEC [dbo].[GeneratePackage_Trigger_PretendDelete]
EXEC [dbo].[GeneratePackage_Trigger_PretendDeleteAt_OtherTables]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_OverrideOnAttributes]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_OverrideOnAttributesAtOtherTables]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_BlockOnAttributes]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_PretendDelete]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_PretendDeleteAt_OtherTables]
DROP PROCEDURE [dbo].[DropIfExists]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_OverrideOnAttributes]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_OverrideOnAttributesAt_OtherTables]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_BlockOnAttributes]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_PretendDelete]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_PretendDeleteAt_OtherTables]
GO
