/* Quais os 5 clientes que mais geraram receita no último semestre,
 considerando apenas ordens finalizadas, o total gasto por cada um? */
 
WITH ReceitaPorOS_CTE AS (
    SELECT
        os.id,
        os.id_cliente,
        (ISNULL(Servicos.Total_Servicos, 0) + ISNULL(Pecas.Total_Pecas, 0)) AS Total_Receita_OS
    FROM
        Ordens_de_Servico os
    LEFT JOIN (
        SELECT id_ordem_servico, SUM(preco_realizado) AS Total_Servicos
        FROM Itens_Servico_OS
        GROUP BY id_ordem_servico
    ) AS Servicos ON os.id = Servicos.id_ordem_servico
    LEFT JOIN (
        SELECT id_ordem_servico, SUM(quantidade * preco_unitario) AS Total_Pecas
        FROM Pecas_OS
        GROUP BY id_ordem_servico
    ) AS Pecas ON os.id = Pecas.id_ordem_servico
    WHERE
        os.status = 5
        AND os.data_saida >= DATEADD(MONTH, -6, GETDATE())
),
TotalPorCliente_CTE AS (
    SELECT
        r.id_cliente,
        SUM(r.Total_Receita_OS) AS Total_Gasto_Cliente
    FROM
        ReceitaPorOS_CTE r
    GROUP BY
        r.id_cliente
)

-- Consulta final 
SELECT TOP 5
    p.nome AS 'Cliente',
    cte.Total_Gasto_Cliente AS 'Total_Gasto'
FROM
    TotalPorCliente_CTE cte
JOIN
    Pessoas p ON cte.id_cliente = p.id
ORDER BY
    Total_Gasto_Cliente DESC;
GO