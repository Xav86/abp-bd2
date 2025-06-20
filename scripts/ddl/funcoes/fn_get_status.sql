CREATE FUNCTION dbo.fn_getStatusDescricao (@statusId int)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @descricao VARCHAR(50)

    SELECT @descricao = descricao
    FROM Status
    WHERE id = TRY_CAST(@statusId AS SMALLINT)

    RETURN @descricao
END
GO
