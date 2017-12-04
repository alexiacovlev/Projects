CREATE PROCEDURE [dbo].[sp_ax_getAutoNumberInfo] 
@Name VARCHAR(50)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

UPDATE AX_AutoNumber
SET AX_AutoNumber.CurrentNumber= AX_AutoNumber.CurrentNumber + 1
WHERE AX_AutoNumber.Name = @Name

-- use SET NOCOUNT ON on start
SELECT * FROM AX_AutoNumber
WHERE AX_AutoNumber.Name = @Name
END