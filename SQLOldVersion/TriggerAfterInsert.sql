--MARK: Insert trigger after Insert data
GO

CREATE TRIGGER [dbo].[BlockDeletedFromAttributes_LopHocPhanSection]
ON [dbo].[LopHocPhanSection]
AFTER UPDATE, DELETE
AS
	BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
			SELECT 1
    FROM deleted AS d
        INNER JOIN [dbo].[LopHocPhanSection] AS lhp ON d.IdLHPSection = lhp.IdLHPSection
    WHERE lhp.Ngay_BD <= GETDATE() AND lhp.Ngay_KT >= GETDATE()
		)
		BEGIN
        RAISERROR ('Cannot update or delete LopHocPhanSection when Ngay_BD and Ngay_KT are between current date', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO
