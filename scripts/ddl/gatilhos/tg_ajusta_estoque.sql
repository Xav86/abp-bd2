DROP TRIGGER IF EXISTS tg_ajusta_estoque;
GO

CREATE TRIGGER tg_ajusta_estoque
ON Pecas_OS
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    declare @quantidade_estoque int;
    declare @quantidade_peca int;

    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN

        SELECT @quantidade_estoque = quantidade_estoque
        FROM Pecas_Estoque
        WHERE id = (SELECT TOP 1 id_peca FROM inserted); 

        SELECT @quantidade_peca = SUM(quantidade)
        FROM inserted
        WHERE id_peca = (SELECT TOP 1 id_peca FROM inserted); 
        
        IF @quantidade_estoque < @quantidade_peca
        BEGIN
            THROW 50002, 'Estoque insuficiente para a peça.', 1;
        END

        UPDATE pe
        SET 
            pe.quantidade_estoque = pe.quantidade_estoque - i.total_quantidade
        FROM 
            Pecas_Estoque pe
        JOIN 
            (SELECT id_peca, SUM(quantidade) AS total_quantidade 
             FROM inserted 
             GROUP BY id_peca) AS i 
        ON pe.id = i.id_peca;
    END

    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        UPDATE pe
        SET 
            pe.quantidade_estoque = pe.quantidade_estoque + d.total_quantidade
        FROM 
            Pecas_Estoque pe
        JOIN 
            (SELECT id_peca, SUM(quantidade) AS total_quantidade 
             FROM deleted 
             GROUP BY id_peca) AS d 
        ON pe.id = d.id_peca;
    END
END;
GO
