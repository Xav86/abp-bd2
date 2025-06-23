 -- 1: Quais são os 2 funcionários que mais participaram de ordens de serviço no primeiro trimestre de 2025,
 -- considerando apenas os serviços concluídos e com tempo trabalhado acima de 30 minutos?

WITH cte1 AS (
    SELECT id 
    FROM ordens_de_servico
    WHERE [status] = 5 
    AND DATEPART(YEAR, data_entrada) = 2025
    AND DATEPART(QUARTER, data_entrada) = 1
),
cte2 AS (
    SELECT id_funcionario, COUNT(id_funcionario) AS participacao
    FROM funcionarios_os
    WHERE tempo_trabalhado > 30
    AND id_ordem_servico IN (
        SELECT id FROM cte1
    )
    GROUP BY id_funcionario
),
-- Se fosse um ranking para mostrar até o segundo colocado não precisaria do TOP
cte3 AS (
    SELECT TOP 2 id_funcionario, participacao, 
    DENSE_RANK() OVER (ORDER BY participacao DESC) AS rank
    FROM cte2
)

SELECT * FROM funcionarios
WHERE id_pessoa IN (
    SELECT id_funcionario FROM cte3
)
