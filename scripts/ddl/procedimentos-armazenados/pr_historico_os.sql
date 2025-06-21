DROP PROCEDURE IF EXISTS pr_atualiza_os
GO

CREATE PROCEDURE pr_atualiza_os
    (@id_usuario INT,
    @id_ordem_servico INT,
    @observacoes VARCHAR(MAX),
	@status_id INT = NULL,
    @id_servico INT = NULL,
    @id_peca INT = NULL,
    @quantidade INT = NULL)
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
    
    IF @id_servico IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Servicos WHERE id = @id_servico)
    BEGIN
        THROW 50002, 'Serviço não encontrado.',1;
    END

    IF @id_peca IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Pecas_Estoque WHERE id = @id_peca)
    BEGIN
        THROW 50003, 'Peça não encontrada.',1;
    END

    IF @id_peca IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Pecas_Estoque WHERE id = @id_peca AND quantidade_estoque >= @quantidade)
    BEGIN
        THROW 50004, 'Quantidade de peças insuficiente no estoque.',1;
    END

    IF @id_servico IS NOT NULL
    BEGIN
        INSERT INTO Itens_Servico_OS (id_ordem_servico, id_servico, preco_realizado)
        VALUES (@id_ordem_servico, @id_servico, (SELECT preco_padrao FROM Servicos WHERE id = @id_servico));
    END

    IF @id_peca IS NOT NULL
    BEGIN
        INSERT INTO Pecas_OS (id_ordem_servico, id_peca, quantidade, preco_unitario)
        VALUES (@id_ordem_servico, @id_peca, @quantidade, (SELECT preco_unitario FROM Pecas_Estoque WHERE id = @id_peca));
    END

	IF @status_id IS NULL
	BEGIN
		SELECT TOP 1 @status_id = status_id 
		FROM Historico_Ordens 
		WHERE id_ordem_servico = @id_ordem_servico 
		ORDER BY data_alteracao DESC, hora_alteracao DESC;
	END

    INSERT INTO Historico_Ordens (
        id_usuario,
        id_ordem_servico,
        hora_alteracao,
        data_alteracao,
        observacoes,
		status_id
    )
    VALUES (
        @id_usuario,
        @id_ordem_servico,
        CONVERT(TIME, GETDATE()), 
        CONVERT(DATE, GETDATE()), 
        @observacoes,
        @status_id
    );

    PRINT 'Registro inserido na tabela Historico_Ordens com sucesso.'
END
GO

EXEC pr_atualiza_os
    @id_usuario = 1,
    @id_ordem_servico = 1,
    @observacoes = 'Atualização de status e inclusão de serviços e peças.',
    @status_id = 2,
    @id_servico = 3,
    @id_peca = 5,
    @quantidade = 2;
    
EXEC pr_atualiza_os
    @id_usuario = 1,
    @id_ordem_servico = 1,
    @observacoes = 'Devolvendo uma peça ao estoque.',
    @status_id = 2,
    @id_servico = 3,
    @id_peca = 5,
    @quantidade = 1;


EXEC pr_atualiza_os
    @id_usuario = 2,
    @id_ordem_servico = 2,
    @observacoes = 'Mudança de status para em andamento.',
    @status_id = 3,
    @id_servico = 4,
    @id_peca = 6,
    @quantidade = 1;

EXEC pr_atualiza_os
    @id_usuario = 3,
    @id_ordem_servico = 3,
    @observacoes = 'Serviço adicional incluído.',
    @status_id = 4,
    @id_servico = 2,
    @id_peca = NULL,
    @quantidade = NULL;

EXEC pr_atualiza_os
    @id_usuario = 4,
    @id_ordem_servico = 4,
    @observacoes = 'Peça substituída.',
    @status_id = 5,
    @id_servico = NULL,
    @id_peca = 7,
    @quantidade = 3;

EXEC pr_atualiza_os
    @id_usuario = 5,
    @id_ordem_servico = 5,
    @observacoes = 'Apenas atualização de status.',
    @status_id = 1,
    @id_servico = NULL,
    @id_peca = NULL,
    @quantidade = NULL;

EXEC pr_atualiza_os
    @id_usuario = 6,
    @id_ordem_servico = 6,
    @observacoes = 'Incluindo serviço e peça.',
    @status_id = 2,
    @id_servico = 5,
    @id_peca = 8,
    @quantidade = 4;

EXEC pr_atualiza_os
    @id_usuario = 7,
    @id_ordem_servico = 7,
    @observacoes = 'Atualização geral.',
    @status_id = 3,
    @id_servico = NULL,
    @id_peca = NULL,
    @quantidade = NULL;

EXEC pr_atualiza_os
    @id_usuario = 8,
    @id_ordem_servico = 8,
    @observacoes = 'Serviço extra adicionado.',
    @status_id = 4,
    @id_servico = 6,
    @id_peca = NULL,
    @quantidade = NULL;

EXEC pr_atualiza_os
    @id_usuario = 9,
    @id_ordem_servico = 9,
    @observacoes = 'Peça adicional incluída.',
    @status_id = 5,
    @id_servico = NULL,
    @id_peca = 9,
    @quantidade = 2;

EXEC pr_atualiza_os
    @id_usuario = 10,
    @id_ordem_servico = 10,
    @observacoes = 'Atualização completa.',
    @status_id = 2,
    @id_servico = 7,
    @id_peca = 10,
    @quantidade = 1;

PRINT 'Execução dos comandos de histórico finalizada.';