DROP PROCEDURE IF EXISTS pr_atualiza_os
GO

CREATE PROCEDURE pr_atualiza_os
    (@id_pessoa INT,
    @id_ordem_servico INT,
    @observacoes VARCHAR(MAX),
	@status_id INT = NULL,
    @funcao_na_ordem VARCHAR(50),
    @tempo_trabalhado INT = NULL)
AS
BEGIN

    IF NOT EXISTS (SELECT 1 FROM Ordens_de_Servico WHERE id = @id_ordem_servico)
    BEGIN
        THROW 50000, 'Ordem de serviço não encontrada.',1;
    END

    IF @status_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Status WHERE id = @status_id)
    BEGIN
        THROW 50001, 'Status inválido.',1;
    END
    
    IF @id_pessoa IS NULL OR NOT EXISTS (SELECT 1 FROM Funcionarios WHERE id_pessoa = @id_pessoa)
    BEGIN
        THROW 50005, 'Usuário não encontrado.',1;
    END

    INSERT INTO Funcionarios_OS (id_ordem_servico, id_funcionario, funcao_na_ordem, tempo_trabalhado, observacoes)
    VALUES (
        @id_ordem_servico,
        @id_pessoa,
        @funcao_na_ordem,
        @tempo_trabalhado,
        @observacoes
    );
   
	IF @status_id IS NULL
	BEGIN
		SELECT TOP 1 @status_id = status
		FROM Ordens_de_Servico
		WHERE id = @id_ordem_servico ;
	END

    INSERT INTO Historico_Ordens (
        id_pessoa,
        id_ordem_servico,
        hora_alteracao,
        data_alteracao,
        observacoes
    )
    VALUES (
        @id_pessoa,
        @id_ordem_servico,
        CONVERT(TIME, GETDATE()), 
        CONVERT(DATE, GETDATE()), 
        @observacoes

    );

    UPDATE Ordens_de_Servico
    SET status = @status_id
    WHERE id = @id_ordem_servico;

    IF @status_id = 5
    BEGIN
        UPDATE Ordens_de_Servico
        SET data_saida = CONVERT(DATE, GETDATE())
        WHERE id = @id_ordem_servico;
    END

    PRINT 'Registro inserido na tabela Historico_Ordens com sucesso.'
END
GO
