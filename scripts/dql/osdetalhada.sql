-- Consulta para um relatório detalhado das Ordens de Serviço
SELECT
    os.id AS 'ID_Ordem',
    s_atual.descricao AS 'Status_Atual',
    os.titulo AS 'Titulo_OS',
    FORMAT(os.data_entrada, 'dd/MM/yyyy HH:mm') AS 'Data_Entrada',
    p_cliente.nome AS 'Cliente',
    v.placa AS 'Placa_Veiculo',
    CONCAT(v.marca, ' ', v.modelo) AS 'Veiculo',

    -- Concatena todos os serviços da OS em uma única string
    (
        SELECT STRING_AGG(CONCAT(s.nome, ' (R$ ', FORMAT(iso.preco_realizado, 'N2', 'pt-BR'), ')'), CHAR(13)+CHAR(10))
        FROM Itens_Servico_OS iso
        JOIN Servicos s ON iso.id_servico = s.id
        WHERE iso.id_ordem_servico = os.id
    ) AS 'Servicos_Realizados',

    -- Concatena todas as peças da OS em uma única string
    (
        SELECT STRING_AGG(CONCAT(pe.nome, ' (', pos.quantidade, 'x R$ ', FORMAT(pos.preco_unitario, 'N2', 'pt-BR'), ')'), CHAR(13)+CHAR(10))
        FROM Pecas_OS pos
        JOIN Pecas_Estoque pe ON pos.id_peca = pe.id
        WHERE pos.id_ordem_servico = os.id
    ) AS 'Pecas_Utilizadas',

    -- Concatena os funcionários que trabalharam na OS
    (
        -- CORREÇÃO: A sintaxe 'STRING_AGG(DISTINCT ...)' não é suportada.
        -- A lógica foi ajustada para primeiro obter os nomes distintos e depois agregar.
        SELECT STRING_AGG(T.nome, ', ')
        FROM (
            SELECT DISTINCT p_func.nome
            FROM Funcionarios_OS fos
            JOIN Funcionarios f ON fos.id_funcionario = f.id_pessoa
            JOIN Pessoas p_func ON f.id_pessoa = p_func.id
            WHERE fos.id_ordem_servico = os.id
        ) AS T
    ) AS 'Funcionarios_Envolvidos',

    -- Concatena o histórico de alterações da OS
    (
        SELECT
            STRING_AGG(
                CONCAT(
                    -- CORREÇÃO: Removida a barra invertida inválida no formato da hora.
                    '[', FORMAT(ho.data_alteracao, 'dd/MM/yy'), ' ', FORMAT(ho.hora_alteracao, 'hh:mm'), '] ',
                    p_hist.nome, ': ',
                    ho.observacoes
                ),
                CHAR(13)+CHAR(10)
            ) WITHIN GROUP (ORDER BY ho.data_alteracao ASC, ho.hora_alteracao ASC)
        FROM
            Historico_Ordens ho
        JOIN
            Pessoas p_hist ON ho.id_pessoa = p_hist.id
        WHERE
            ho.id_ordem_servico = os.id
    ) AS 'Historico_Completo',

    -- Calcula o valor total da OS
    FORMAT(
        ISNULL((SELECT SUM(iso.preco_realizado) FROM Itens_Servico_OS iso WHERE iso.id_ordem_servico = os.id), 0) +
        ISNULL((SELECT SUM(pos.quantidade * pos.preco_unitario) FROM Pecas_OS pos WHERE pos.id_ordem_servico = os.id), 0)
    , 'C', 'pt-BR') AS 'Valor_Total'
FROM
    Ordens_de_Servico os
JOIN
    Pessoas p_cliente ON os.id_cliente = p_cliente.id
JOIN
    Veiculos v ON os.id_veiculo = v.id
JOIN
    Status s_atual ON os.status = s_atual.id
ORDER BY
    os.id DESC; -- Adicionado para ordenar o resultado
GO
