/* Quais os 5 clientes que mais geraram receita no último semestre,
 considerando apenas ordens finalizadas, o total gasto por cada um? */

SELECT TOP 5
    Pessoas_cliente.nome AS 'Cliente',
    SUM(
        ISNULL((SELECT SUM(iso.preco_realizado) FROM Itens_Servico_OS iso WHERE iso.id_ordem_servico = os.id), 0) +
        ISNULL((SELECT SUM(pos.quantidade * pos.preco_unitario) FROM Pecas_OS pos WHERE pos.id_ordem_servico = os.id), 0)
    ) AS 'Total_Gasto'
FROM
    Ordens_de_Servico os
JOIN
    Pessoas Pessoas_cliente ON os.id_cliente = Pessoas_cliente.id
WHERE
    os.status = 5 AND
    os.data_saida >= DATEADD(MONTH, -6, GETDATE())
GROUP BY
    Pessoas_cliente.nome 
ORDER BY
    SUM(
        ISNULL((SELECT SUM(iso.preco_realizado) FROM Itens_Servico_OS iso WHERE iso.id_ordem_servico = os.id), 0) +
        ISNULL((SELECT SUM(pos.quantidade * pos.preco_unitario) FROM Pecas_OS pos WHERE pos.id_ordem_servico = os.id), 0)
    ) DESC;
GO