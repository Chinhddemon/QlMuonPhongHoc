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
            INNER JOIN [dbo].[NhomToHocPhan] AS nthp ON d.idNhomToHocPhan = nthp.idNhomToHocPhan
        WHERE nthp.startDate <= GETDATE() AND nthp.endDate >= GETDATE()
            )
            BEGIN
            RAISERROR ('Cannot update or delete NhomToHocPhan when startDate and endDate are between current date', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO
