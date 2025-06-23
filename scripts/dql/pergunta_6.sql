-- 6- Quais são as peças mais requisitadas de forma decescente nos últimos 30 dias e 90 dias, 
-- quantas vezes foram utilizadas, e o valor total gerado com essas peças?

SELECT 
    pe.nome AS nome_peca,
    COUNT(pos.id) AS vezes_utilizada,
    SUM(pos.quantidade) AS quantidade_total,
    SUM(pos.quantidade * pos.preco_unitario) AS valor_total_gerado,
    'Últimos 30 dias' AS periodo
FROM Pecas_OS pos
JOIN Pecas_Estoque pe ON pe.id = pos.id_peca
JOIN Ordens_de_Servico os ON os.id = pos.id_ordem_servico
WHERE os.data_entrada >= DATEADD(DAY, -30, GETDATE())
GROUP BY pe.nome

UNION ALL

SELECT 
    pe.nome AS nome_peca,
    COUNT(pos.id) AS vezes_utilizada,
    SUM(pos.quantidade) AS quantidade_total,
    SUM(pos.quantidade * pos.preco_unitario) AS valor_total_gerado,
    'Últimos 90 dias' AS periodo
FROM Pecas_OS pos
JOIN Pecas_Estoque pe ON pe.id = pos.id_peca
JOIN Ordens_de_Servico os ON os.id = pos.id_ordem_servico
WHERE os.data_entrada >= DATEADD(DAY, -90, GETDATE())
GROUP BY pe.nome

ORDER BY periodo, quantidade_total DESC;
