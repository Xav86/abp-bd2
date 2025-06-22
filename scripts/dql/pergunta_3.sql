--3- Qual foi o faturamento total gerado entre Janeiro/2023 e Dezembro/2025 por ordens de serviço finalizadas, e qual foi o serviço mais ofertado nesse período e seu preço médio praticado?

-- ordens finalizadas entre 2023 até 2025
-- resumo: selecionando os ids das ordens de serviço que estão concluidas (não nulas) dentro de 1 de janeiro de 2023 até 31 de dezembro de 2025
WITH OrdensFiltradas AS (
  SELECT id
  FROM Ordens_de_Servico
  WHERE data_saida IS NOT NULL
    AND data_saida BETWEEN '2023-01-01' AND '2025-12-31'
),

-- faturamento com serviços
-- resumo: somando o preço realizado na tabela de itens_servico_os que esteja dentro dos ids que estão naquele periodo
FaturamentoServicos AS (
  SELECT SUM(preco_realizado) AS total_servicos
  FROM Itens_Servico_OS
  WHERE id_ordem_servico IN (SELECT id FROM OrdensFiltradas)
),

-- faturamento com peças
-- resumo: somando o preço vezes a quantidade de todas as peças que estão dentro do periodo
FaturamentoPecas AS (
  SELECT SUM(preco_unitario * quantidade) AS total_pecas
  FROM Pecas_OS
  WHERE id_ordem_servico IN (SELECT id FROM OrdensFiltradas)
),

-- serviço mais vendido na data com média de preço
-- selecionando o primeiro item trazendo o nome e vezes ofertadas e uma média do preço dos itens junto de serviços que estão naquele periodo de tempo, ordenados pelo nome e vezes ofertado
ServicoMaisOfertado AS (
  SELECT TOP 1
    s.nome,
    COUNT(*) AS vezes_ofertado,
    AVG(iso.preco_realizado) AS preco_medio
  FROM Itens_Servico_OS iso
  JOIN Servicos s ON s.id = iso.id_servico
  WHERE iso.id_ordem_servico IN (SELECT id FROM OrdensFiltradas)
  GROUP BY s.nome
  ORDER BY vezes_ofertado DESC
)

-- resultado final
-- trazendo em uma unica consulta a soma dos preços e chamando isso de faturamento, trazendo nome, vezes ofertado e preço médio trazendo tudo em todas as ctes
SELECT
  FORMAT(fs.total_servicos + fp.total_pecas, 'N2', 'pt-BR') AS faturamento_total,
  smo.nome AS servico_mais_ofertado,
  smo.vezes_ofertado,
  FORMAT(smo.preco_medio, 'N2', 'pt-BR') AS preco_medio
FROM FaturamentoServicos fs
CROSS JOIN FaturamentoPecas fp
CROSS JOIN ServicoMaisOfertado smo;