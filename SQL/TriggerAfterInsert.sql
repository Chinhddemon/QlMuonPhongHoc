--MARK: Insert trigger after Insert data
GO

CREATE TRIGGER [dbo].[BlockDeletedFromAttributes_NhomToHocPhan]
ON [dbo].[NhomToHocPhan]
AFTER UPDATE, DELETE
AS
	BEGIN
        SET NOCOUNT ON;

        IF EXISTS (
                SELECT 1
        FROM deleted AS d
            INNER JOIN [dbo].[NhomToHocPhan] AS lhp ON d.idNhomToHocPhan = lhp.idNhomToHocPhan
        WHERE lhp.startAt <= GETDATE() AND lhp.endAt >= GETDATE()
            )
            BEGIN
            RAISERROR ('Cannot update or delete NhomToHocPhan when startAt and endAt are between current date', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO
