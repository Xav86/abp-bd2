--2- Quais os serviços mais vendidos no último trimestre (por quantidade), o funcionário que mais realizou cada tipo de serviço, e o valor total obtido por cada serviço com base no preço realizado

WITH UltimoTrimestre AS (
    SELECT *
    FROM Ordens_de_Servico
    WHERE data_entrada >= DATEADD(QUARTER, -1, GETDATE())
),
QuantidadeServicos AS (
   SELECT 
        s.id AS id_servico,
        s.nome AS nome_servico,
        COUNT(*) AS quantidade_vendida,
        SUM(iso.preco_realizado) AS valor_total
    FROM Itens_Servico_OS iso
    INNER JOIN UltimoTrimestre os ON os.id = iso.id_ordem_servico
    INNER JOIN Servicos s ON s.id = iso.id_servico
    GROUP BY s.id, s.nome
),
FuncionarioServico AS (
    SELECT 
        s.id AS id_servico,
        f.id_pessoa,
        p.nome AS nome_funcionario,
        COUNT(*) AS quantidade_realizada,
        RANK() OVER (PARTITION BY s.id ORDER BY COUNT(*) DESC) AS ranking
    FROM Itens_Servico_OS iso
    INNER JOIN Servicos s ON s.id = iso.id_servico
    INNER JOIN Ordens_de_Servico os ON os.id = iso.id_ordem_servico
    INNER JOIN Funcionarios_OS fos ON fos.id_ordem_servico = os.id
    INNER JOIN Funcionarios f ON f.id_pessoa = fos.id_funcionario
    INNER JOIN Pessoas p ON p.id = f.id_pessoa
    WHERE os.data_entrada >= DATEADD(QUARTER, -1, GETDATE())
    GROUP BY s.id, f.id_pessoa, p.nome
)
SELECT 
    qs.nome_servico,
    qs.quantidade_vendida,
    fs.nome_funcionario,
    qs.valor_total
FROM QuantidadeServicos qs
LEFT JOIN FuncionarioServico fs ON fs.id_servico = qs.id_servico AND fs.ranking = 1
ORDER BY qs.quantidade_vendida DESC;