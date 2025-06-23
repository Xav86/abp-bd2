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

----------Inserts para a pergunta
-- Ordens de serviço finalizadas (status = 5) no 1º trimestre de 2025
INSERT INTO Ordens_de_Servico (id_veiculo, id_cliente, data_entrada, data_saida, data_meta, titulo, descricao, status) VALUES
(1, 5, '2025-01-05', '2025-01-10', '2025-01-15', 'Revisão', 'Troca de óleo e inspeção geral', 5),
(2, 5, '2025-02-03', '2025-02-05', '2025-02-07', 'Alinhamento', 'Alinhamento e balanceamento', 5),
(1, 5, '2025-03-10', '2025-03-12', '2025-03-15', 'Inspeção elétrica', 'Checagem completa do sistema elétrico', 5);

-- Funcionários que participaram dessas ordens com tempo_trabalhado > 30
INSERT INTO Funcionarios_OS (id_ordem_servico, id_funcionario, funcao_na_ordem, tempo_trabalhado, observacoes) VALUES
(16, 3, 'Mecânico Chefe', 90, 'Responsável pelo serviço'),
(16, 21, 'Eletricista', 45, 'Apoio técnico'),
(17, 16, 'Mecânico', 120, 'Trabalho pesado'),
(17, 10, 'Auxiliar', 60, 'Ajudou em diversas tarefas'),
(18, 16, 'Mecânico', 80, 'Inspeção geral'),
(18, 21, 'Eletricista', 70, 'Diagnóstico e conserto elétrico');

