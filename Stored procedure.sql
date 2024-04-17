CREATE TYPE [dbo].[LopHocPhanSectionType]
   AS TABLE (
    [IdLHPSection] [int] NOT NULL,
    [MaGVGiangDay] [varchar](15) NOT NULL,
    [IdNHP] [int] NOT NULL,
    [NhomTo] [tinyint] NOT NULL DEFAULT 255, -- 255: Phân nhóm, 0: Không phân tổ, 1: Phân tổ 1, 2: Phân tổ 2, ...
    [Ngay_BD] [date] NOT NULL,
    [Ngay_KT] [date] NOT NULL,
    [MucDich] [char](2) NOT NULL CHECK (MucDich IN ('LT', 'TH', 'TN', 'U')), -- LT: Lý thuyết, TH: Thực hành, TN: Thí nghiệm, U: Unknown
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE()
)
GO

CREATE PROCEDURE [dbo].[InsertNhomHocPhanAndLopHocPhanSections]
    @MaMH VARCHAR(15),
    @MaLopSV VARCHAR(15),
    @MaQLKhoiTao VARCHAR(15),
    @Nhom TINYINT,
    @LopHocPhanSections [dbo].[LopHocPhanSectionType] READONLY
AS
    BEGIN
        SET NOCOUNT ON;

        BEGIN TRY
            -- Insert into NhomHocPhan
            INSERT INTO [NhomHocPhan] (MaMH, MaLopSV, MaQLKhoiTao, Nhom)
            VALUES (@MaMH, @MaLopSV, @MaQLKhoiTao, @Nhom);

            -- Get the inserted IdNHP
            DECLARE @IdNHP INT;
            SET @IdNHP = SCOPE_IDENTITY();

            -- Insert into LopHocPhanSection for each row in the table parameter
            INSERT INTO [LopHocPhanSection] (IdNHP, MaGVGiangDay, NhomTo, Ngay_BD, Ngay_KT, MucDich)
            SELECT @IdNHP, MaGVGiangDay, NhomTo, Ngay_BD, Ngay_KT, MucDich
            FROM @LopHocPhanSections;
            
        END TRY
        BEGIN CATCH
            -- Rollback the transaction if an error occurs
            IF @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;
            
            -- Throw the error
            THROW;
        END CATCH;
    END
GO

CREATE PROCEDURE [dbo].[UpdateNhomHocPhanAndLopHocPhanSections]
    @IdNHP INT,
    @MaMH VARCHAR(15),
    @MaLopSV VARCHAR(15),
    @MaQLKhoiTao VARCHAR(15),
    @Nhom TINYINT,
    @LopHocPhanSections [dbo].[LopHocPhanSectionType] READONLY
AS
    BEGIN
        SET NOCOUNT ON;

        BEGIN TRY
            -- Update NhomHocPhan
            UPDATE NHP
            SET NHP.MaMH = @MaMH,
                NHP.MaLopSV = @MaLopSV,
                NHP.MaQLKhoiTao = @MaQLKhoiTao,
                NHP.Nhom = @Nhom
            FROM [dbo].[NhomHocPhan] NHP
            WHERE NHP.IdNHP = @IdNHP;

            -- Update LopHocPhanSection for each row in the table parameter
            MERGE INTO [dbo].[LopHocPhanSection] AS target
            USING @LopHocPhanSections AS source
            ON (target.IdLHPSection = source.IdLHPSection AND target.IdNHP = @IdNHP) -- Join condition
            WHEN MATCHED THEN
                UPDATE SET target.NhomTo = source.NhomTo,
                        target.Ngay_BD = source.Ngay_BD,
                        target.Ngay_KT = source.Ngay_KT,
                        target.MucDich = source.MucDich
            WHEN NOT MATCHED THEN
                INSERT (IdNHP, MaGVGiangDay, NhomTo, Ngay_BD, Ngay_KT, MucDich)
                VALUES (@IdNHP, source.MaGVGiangDay, source.NhomTo, source.Ngay_BD, source.Ngay_KT, source.MucDich);

        END TRY

        BEGIN CATCH
            IF @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;
                
            -- You can handle the error here as needed
            RAISERROR('An error occurred while updating the NhomHocPhan and LopHocPhanSections.', 16, 1);
        END CATCH;
    END
GO