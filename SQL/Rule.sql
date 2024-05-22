-- Last synced with database: not yet

GO
-- MARK: Logical DataType
CREATE RULE [dbo].[CK_Ascending] AS
	@Start <= @End
GO

CREATE RULE [dbo].[CK_IsPositive] AS
	@Count > 0
GO

CREATE RULE [dbo].[CK_InRange] AS
	@Start <= @Range AND @Range <= @End
GO

CREATE RULE [dbo].[CK_InRangeOrNull] AS
	@Range IS NULL OR @Start <= @Range AND @Range <= @End
GO

-- MARK: Common Situation

CREATE RULE [dbo].[CK_AgeOverYears] AS
	DATEDIFF(YEAR, @DateOfBirth, GETDATE()) >= @Years
GO

CREATE RULE [dbo].[CK_Gender] AS
	@Gender IN (0, 1, 9) -- 0: Nam, 1: Nữ, 9: Không ghi nhận
GO

CREATE RULE [dbo].[CK_NameUTF8] AS
	@NameUTF8 NOT LIKE '[^a-zA-ZÀ-ÿ ]'
GO

CREATE RULE [dbo].[CK_Email] AS
	@Email LIKE '%@%.%' AND @Email NOT LIKE '[^a-zA-Z0-9.@]'
GO

CREATE RULE [dbo].[CK_Username] AS
	LEN(@Username) >= 8 AND @Username NOT LIKE '%[^a-zA-Z0-9]%'
GO

CREATE RULE [dbo].[CK_Status] AS
	@Status IN ('A', 'U', 'M') -- A: Available, U: Unavailable, M: Maintenance
GO

-- MARK: Specific Situation

CREATE RULE [dbo].[CK_PhoneNumberInVietNam] AS
	@PhoneNumber LIKE '0%' AND @PhoneNumber NOT LIKE '[^0-9]'
GO

CREATE RULE [dbo].[CK_PhoneNumber] AS -- Not check yet
	@PhoneNumber LIKE '+[0-9]{1,3}-[0-9]{9,11}'
GO

CREATE RULE [dbo].[CK_LopSV_Khoa] AS
	@Khoa NOT LIKE '%[^a-zA-ZÀ-ÿ0-9 ]%'
GO

CREATE RULE [dbo].[CK_LopSV_HeDaoTao] AS
	@HeDaoTao IN ('CQ', 'TX')
GO
