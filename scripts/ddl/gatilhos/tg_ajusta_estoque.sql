
DROP TRIGGER IF EXISTS tg_ajusta_estoque
GO

CREATE TRIGGER tg_ajusta_estoque
ON Pecas_OS
AFTER INSERT, DELETE
AS
BEGIN
    
    DECLARE @id_peca SMALLINT;
    DECLARE @quantidade INT;

    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        SELECT @id_peca = id_peca, @quantidade = quantidade FROM inserted;
        UPDATE Pecas_Estoque
        SET quantidade_estoque = quantidade_estoque - @quantidade
        WHERE id = @id_peca;
    END

    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        SELECT @id_peca = id_peca, @quantidade = quantidade FROM deleted;
        UPDATE Pecas_Estoque
        SET quantidade_estoque = quantidade_estoque + @quantidade
        WHERE id = @id_peca;
    END
END;
GO