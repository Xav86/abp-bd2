/* CREATE TABLE [Ordens_de_Servico] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [id_veiculo] int NOT NULL,
  [id_cliente] int NOT NULL,
  [data_entrada] date NOT NULL,
  [data_saida] date,
  [data_meta] date NOT NULL,
  [titulo] varchar(100) NOT NULL,
  [descricao] varchar(max) NOT NULL,
  [status_id] tinyint NOT NULL,
)
GO */

CREATE NONCLUSTERED INDEX idx_ordem_servico_status_includes
ON Ordens_de_Servico (id)
INCLUDE (id_veiculo,id_cliente,status_id,data_entrada,data_saida);
GO