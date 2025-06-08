
/* Ajustar "Tabela" para a tabela que vai receber a trigger */
DROP TRIGGER trg_update_[tabela];

CREATE OR ALTER TRIGGER trg_update_[tabela]
ON tabela
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @antes NVARCHAR(MAX), @depois NVARCHAR(MAX), @log NVARCHAR(MAX);

    SELECT @antes = (
        SELECT * FROM DELETED FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );

    SELECT @depois = (
        SELECT * FROM INSERTED FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );

    SET @log = CONCAT('UPDATE em tabela: {"antes": ', @antes, ', "depois": ', @depois, '}');

    INSERT INTO Historico (log, data_hora)
    VALUES (@log, GETDATE());
END;
