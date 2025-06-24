-- Índices Gerais
CREATE NONCLUSTERED INDEX idx_ordens_geral
ON Ordens_de_Servico (id_veiculo, id_cliente, data_entrada, data_saida)
INCLUDE (id, status, titulo, descricao);
GO

CREATE NONCLUSTERED INDEX idx_pecas_os_por_ordem_servico
ON Pecas_OS (id_ordem_servico, id_peca)
INCLUDE (preco_unitario, quantidade);
GO

CREATE NONCLUSTERED INDEX idx_historico_ordens_por_alteracao
ON Historico_Ordens (id_ordem_servico,hora_alteracao, data_alteracao)
INCLUDE (id_pessoa, observacoes);
GO

CREATE NONCLUSTERED INDEX idx_itens_servico_os_por_ordem_servico
ON Itens_Servico_OS (id_ordem_servico, id_servico)
INCLUDE (preco_realizado);
GO

CREATE NONCLUSTERED INDEX idx_ordens_data_saida_para_faturamento
ON Ordens_de_Servico(data_saida)
INCLUDE (id);
GO

CREATE NONCLUSTERED INDEX idx_ordens_status_data_entrada_para_func
ON Ordens_de_Servico ([status], data_entrada)
INCLUDE (id);
GO

CREATE NONCLUSTERED INDEX idx_funcionarios_os_ordem_tempo_func
ON Funcionarios_OS (id_ordem_servico, tempo_trabalhado)
INCLUDE (id_funcionario);
GO

CREATE NONCLUSTERED INDEX idx_itens_servico_os_id_servico
ON Itens_Servico_OS (id_servico)
INCLUDE (id_ordem_servico, preco_realizado);
GO

CREATE NONCLUSTERED INDEX idx_funcionarios_os_id_funcionario
ON Funcionarios_OS (id_funcionario)
INCLUDE (id_ordem_servico, tempo_trabalhado);
GO

CREATE NONCLUSTERED INDEX idx_ordens_datas_atraso
ON Ordens_de_Servico (data_meta, data_saida)
INCLUDE (id);
GO

CREATE NONCLUSTERED INDEX idx_pecas_os_id_peca
ON Pecas_OS (id_peca, id_ordem_servico)
INCLUDE (quantidade, preco_unitario);
GO

