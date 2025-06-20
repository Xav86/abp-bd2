-- ===================================================================
-- CONSULTA DETALHADA DE ORDENS DE SERVIÇO
-- Une informações de Clientes, Veículos, Serviços, Peças e Funcionários
-- ===================================================================

SELECT
    os.id AS 'ID_Ordem',
    dbo.fn_getStatusDescricao(os.status_id) as 'Status',
    os.titulo AS 'Titulo_OS',
    FORMAT(os.data_entrada, 'dd/MM/yyyy HH:mm') AS 'Data_Entrada',
    p_cliente.nome AS 'Cliente',
    v.placa AS 'Placa_Veiculo',
    CONCAT(v.marca, ' ', v.modelo) AS 'Veiculo',

    -- Concatena todos os serviços da OS em uma única string
    (
        SELECT STRING_AGG(CONCAT(s.nome, ' (', iso.quantidade, 'x R$ ', FORMAT(iso.preco_realizado, 'N2'), ')'), CHAR(13)+CHAR(10)) -- CHAR(13)+CHAR(10) é uma quebra de linha
        FROM Itens_Servico_OS iso
        JOIN Servicos s ON iso.id_servico = s.id
        WHERE iso.id_ordem_servico = os.id
    ) AS 'Servicos_Realizados',

    -- Concatena todas as peças da OS em uma única string
    (
        SELECT STRING_AGG(CONCAT(pe.nome, ' (', pos.quantidade, 'x R$ ', FORMAT(pos.preco_unitario, 'N2'), ')'), CHAR(13)+CHAR(10))
        FROM Pecas_OS pos
        JOIN Pecas_Estoque pe ON pos.id_peca = pe.id
        WHERE pos.id_ordem_servico = os.id
    ) AS 'Pecas_Utilizadas',

    -- Concatena todos os funcionários da OS em uma única string
     (
        SELECT STRING_AGG(p_func.nome, ', ')
        FROM Funcionarios_OS fos
        JOIN Funcionarios f ON fos.id_funcionario = f.id_usuario
        JOIN Pessoas p_func ON f.id_usuario = p_func.id
        WHERE fos.id_ordem_servico = os.id
    ) AS 'Mecanicos_Responsaveis',

    -- Calcula o valor total da OS somando serviços e peças
    FORMAT(
        ISNULL((SELECT SUM(iso.quantidade * iso.preco_realizado) FROM Itens_Servico_OS iso WHERE iso.id_ordem_servico = os.id), 0) +
        ISNULL((SELECT SUM(pos.quantidade * pos.preco_unitario) FROM Pecas_OS pos WHERE pos.id_ordem_servico = os.id), 0)
    , 'C', 'pt-BR') AS 'Valor_Total'
FROM
    Ordens_de_Servico os
JOIN
    Pessoas p_cliente ON os.id_cliente = p_cliente.id
JOIN
    Veiculos v ON os.id_veiculo = v.id
ORDER BY
    os.id DESC;
GO
