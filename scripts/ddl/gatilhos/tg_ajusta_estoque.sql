DROP TRIGGER IF EXISTS tg_ajusta_estoque;
GO

CREATE TRIGGER tg_ajusta_estoque
ON Pecas_OS
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
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
