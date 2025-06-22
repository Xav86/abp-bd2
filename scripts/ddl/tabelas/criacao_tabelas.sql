CREATE TABLE [Pessoas] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nome] varchar(100) NOT NULL,
  [telefone] varchar(20) NOT NULL,
  [email] varchar(100) NOT NULL
)
GO

CREATE TABLE [Enderecos] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [id_pessoa] int NOT NULL,
  [logradouro] varchar(100) NOT NULL,
  [numero] varchar(10) NOT NULL,
  [complemento] varchar(50) NOT NULL,
  [bairro] varchar(50) NOT NULL,
  [cidade] varchar(50) NOT NULL,
  [estado] varchar(2) NOT NULL,
  [cep] varchar(10) NOT NULL
)
GO

CREATE TABLE [Clientes_Fisicos] (
  [id_pessoa] int PRIMARY KEY NOT NULL,
  [cpf] char(11) UNIQUE NOT NULL
)
GO

CREATE TABLE [Clientes_Juridicos] (
  [id_pessoa] int PRIMARY KEY NOT NULL,
  [cnpj] char(14) UNIQUE NOT NULL
)
GO

CREATE TABLE [Funcionarios] (
  [id_pessoa] int PRIMARY KEY NOT NULL,
  [funcao] varchar(50) NOT NULL,
  [data_admissao] date NOT NULL,
  [ativo] bit NOT NULL,
  [salario] numeric(14,2) NOT NULL
)
GO

CREATE TABLE [Veiculos] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [placa] varchar(10) UNIQUE NOT NULL,
  [modelo] varchar(50) NOT NULL,
  [marca] varchar(50) NOT NULL,
  [ano_fabricacao] char(4) NOT NULL,
  [chassi] char(17) NOT NULL,
  [quilometragem] smallint NOT NULL
)
GO

CREATE TABLE [Servicos] (
  [id] smallint PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nome] varchar(100) NOT NULL,
  [descricao] varchar(max) NOT NULL,
  [preco_padrao] numeric(14,2) NOT NULL
)
GO

CREATE TABLE [Ordens_de_Servico] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [id_veiculo] int NOT NULL,
  [id_cliente] int NOT NULL,
  [data_entrada] date NOT NULL,
  [data_saida] date,
  [data_meta] date NOT NULL,
  [titulo] varchar(100) NOT NULL,
  [descricao] varchar(500) NOT NULL,
  [status] tinyint NOT NULL
)
GO

CREATE TABLE [Funcionarios_OS] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [id_ordem_servico] int NOT NULL,
  [id_funcionario] int NOT NULL,
  [funcao_na_ordem] varchar(50) NOT NULL,
  [tempo_trabalhado] smallint NOT NULL,
  [observacoes] varchar(500) NOT NULL
)
GO

CREATE TABLE [Itens_Servico_OS] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [id_ordem_servico] int NOT NULL,
  [id_servico] smallint NOT NULL,
  [quantidade] smallint NOT NULL,
  [preco_realizado] numeric(14,2) NOT NULL
)
GO

CREATE TABLE [Pecas_Estoque] (
  [id] smallint PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nome] varchar(100) NOT NULL,
  [descricao] varchar(max) NOT NULL,
  [quantidade_estoque] int NOT NULL,
  [preco_unitario] numeric(14,2) NOT NULL
)
GO

CREATE TABLE [Pecas_OS] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [id_ordem_servico] int NOT NULL,
  [id_peca] smallint NOT NULL,
  [quantidade] int NOT NULL,
  [preco_unitario] numeric(14,2) NOT NULL
)
GO

CREATE TABLE [Historico_Ordens] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [id_pessoa] int NOT NULL,
  [id_ordem_servico] int NOT NULL,
  [campo_alterado] varchar(100),
  [valor_anterior] varchar(max) NOT NULL,
  [valor_novo] varchar(max) NOT NULL,
  [hora_alteracao] time NOT NULL,
  [data_alteracao] date NOT NULL DEFAULT (GETDATE()),
  [observacoes] varchar(max) NOT NULL
)
GO

CREATE TABLE [Status] (
  [id] tinyint PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [descricao] varchar(50) NOT NULL
)
GO

ALTER TABLE [Enderecos] ADD FOREIGN KEY ([id_pessoa]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Clientes_Fisicos] ADD FOREIGN KEY ([id_pessoa]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Clientes_Juridicos] ADD FOREIGN KEY ([id_pessoa]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Funcionarios] ADD FOREIGN KEY ([id_pessoa]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Ordens_de_Servico] ADD FOREIGN KEY ([id_veiculo]) REFERENCES [Veiculos] ([id])
GO

ALTER TABLE [Ordens_de_Servico] ADD FOREIGN KEY ([id_cliente]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Ordens_de_Servico] ADD FOREIGN KEY ([status]) REFERENCES [Status] ([id])
GO

ALTER TABLE [Funcionarios_OS] ADD FOREIGN KEY ([id_ordem_servico]) REFERENCES [Ordens_de_Servico] ([id])
GO

ALTER TABLE [Funcionarios_OS] ADD FOREIGN KEY ([id_funcionario]) REFERENCES [Funcionarios] ([id_pessoa])
GO

ALTER TABLE [Itens_Servico_OS] ADD FOREIGN KEY ([id_ordem_servico]) REFERENCES [Ordens_de_Servico] ([id])
GO

ALTER TABLE [Itens_Servico_OS] ADD FOREIGN KEY ([id_servico]) REFERENCES [Servicos] ([id])
GO

ALTER TABLE [Pecas_OS] ADD FOREIGN KEY ([id_ordem_servico]) REFERENCES [Ordens_de_Servico] ([id])
GO

ALTER TABLE [Pecas_OS] ADD FOREIGN KEY ([id_peca]) REFERENCES [Pecas_Estoque] ([id])
GO

ALTER TABLE [Historico_Ordens] ADD FOREIGN KEY ([id_pessoa]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Historico_Ordens] ADD FOREIGN KEY ([id_ordem_servico]) REFERENCES [Ordens_de_Servico] ([id])
GO
