/* Indice geral */
CREATE NONCLUSTERED INDEX idx_ordens_por_data_entrada_saida
ON Ordens_de_Servico (status,data_entrada, data_saida)
INCLUDE (id, id_veiculo, id_cliente, titulo, descricao);
GO

CREATE NONCLUSTERED INDEX idx_pecas_os_por_ordem_servico
ON Pecas_OS (id_ordem_servico,id_peca)
INCLUDE (preco_unitario, quantidade);
GO

CREATE NONCLUSTERED INDEX idx_historico_ordens_por_ordem_servico
ON Historico_Ordens (hora_alteracao, data_alteracao)
INCLUDE (id_pessoa, id_ordem_servico, observacoes);
GO

CREATE NONCLUSTERED INDEX idx_itens_servico_os_por_ordem_servico
ON Itens_Servico_OS (id_ordem_servico, id_servico)
INCLUDE (preco_realizado);
GO

/* Indice para pergunta 3 */
CREATE NONCLUSTERED INDEX idx_ordens_data_saida
ON Ordens_de_Servico(data_saida)
INCLUDE (id);

/* Indices para a pergunta 1 */
CREATE NONCLUSTERED INDEX idx_ordens_status_data_entrada
ON Ordens_de_Servico ([status], data_entrada)
INCLUDE (id);

CREATE NONCLUSTERED INDEX idx_funcionarios_os_ordem_tempo_func
ON Funcionarios_OS (id_ordem_servico, tempo_trabalhado)
INCLUDE (id_funcionario);
