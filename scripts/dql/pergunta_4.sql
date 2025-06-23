-- ========================================================
-- 4- Quantas ordens de serviço previstas para entrega atrasaram nos últimos 3 meses, 
-- qual o funcionário técnico principal envolvido e qual foi o tempo médio de atraso em dias?
-- ========================================================

WITH OrdensAtrasadas AS (
    SELECT 
        os.id AS id_ordem,
        os.data_meta,
        os.data_saida,
        DATEDIFF(DAY, os.data_meta, os.data_saida) AS dias_atraso
    FROM Ordens_de_Servico os
    WHERE 
        os.data_saida IS NOT NULL
        AND os.data_saida > os.data_meta
        AND DATEDIFF(DAY, os.data_meta, os.data_saida) >= 90
),
FuncionarioPrincipal AS (
    SELECT 
        fo.id_ordem_servico,
        fo.id_funcionario,
        ROW_NUMBER() OVER (
            PARTITION BY fo.id_ordem_servico 
            ORDER BY fo.tempo_trabalhado DESC
        ) AS rn
    FROM Funcionarios_OS fo
),
FuncionarioComNome AS (
    SELECT 
        fa.id_ordem_servico,
        p.nome AS nome_funcionario
    FROM FuncionarioPrincipal fa
    JOIN Pessoas p ON p.id = fa.id_funcionario
    WHERE fa.rn = 1
)
SELECT 
    COUNT(oa.id_ordem) AS total_ordens_atrasadas,
    fc.nome_funcionario,
    AVG(CAST(oa.dias_atraso AS FLOAT)) AS tempo_medio_atraso_dias
FROM OrdensAtrasadas oa
JOIN FuncionarioComNome fc ON fc.id_ordem_servico = oa.id_ordem
GROUP BY fc.nome_funcionario
ORDER BY total_ordens_atrasadas DESC;