CREATE TABLE [Pessoas] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nome] varchar(100),
  [telefone] varchar(20),
  [email] varchar(100)
)
GO

CREATE TABLE [Enderecos] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_usuario] int,
  [logradouro] varchar(100),
  [numero] varchar(10),
  [complemento] varchar(50),
  [bairro] varchar(50),
  [cidade] varchar(50),
  [estado] varchar(2),
  [cep] varchar(10)
)
GO

CREATE TABLE [Cliente_Fisico] (
  [id_usuario] int PRIMARY KEY,
  [cpf] char(11) UNIQUE
)
GO

CREATE TABLE [Cliente_Juridico] (
  [id_usuario] int PRIMARY KEY,
  [cnpj] char(14) UNIQUE
)
GO

CREATE TABLE [Funcionarios] (
  [id_usuario] int PRIMARY KEY,
  [funcao] varchar(50),
  [data_admissao] date,
  [ativo] bit,
  [salario] numeric(14,2)
)
GO

CREATE TABLE [Veiculos] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_cliente] int,
  [placa] varchar(10) UNIQUE,
  [modelo] varchar(50),
  [marca] varchar(50),
  [ano_fabricacao] int,
  [chassi] varchar(30),
  [quilometragem] int,
  [status] varchar(20)
)
GO

CREATE TABLE [Servicos] (
  [id] smallint PRIMARY KEY IDENTITY(1, 1),
  [nome] varchar(100),
  [descricao] varchar(max),
  [preco_padrao] numeric(14,2),
  [tempo_estimado] int
)
GO

CREATE TABLE [Ordens_de_Servico] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_veiculo] int,
  [id_cliente] int,
  [data_entrada] datetime,
  [data_saida] datetime,
  [titulo] varchar(100),
  [descricao] text,
  [status] varchar(20)
)
GO

CREATE TABLE [Funcionarios_OS] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_ordem_servico] int,
  [id_funcionario] int,
  [funcao_na_ordem] varchar(50),
  [tempo_trabalhado] int,
  [observacoes] text
)
GO

CREATE TABLE [Itens_Servico_OS] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_ordem_servico] int,
  [id_servico] smallint,
  [quantidade] int,
  [preco_realizado] numeric(14,2)
)
GO

CREATE TABLE [Pecas_Estoque] (
  [id] smallint PRIMARY KEY IDENTITY(1, 1),
  [nome] varchar(100),
  [descricao] text,
  [quantidade_estoque] int,
  [preco_unitario] numeric(14,2)
)
GO

CREATE TABLE [Pecas_OS] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_ordem_servico] int,
  [id_peca] smallint,
  [quantidade] int,
  [preco_unitario] numeric(14,2)
)
GO

CREATE TABLE [Historico_Ordens] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_usuario] int,
  [id_ordem_servico] int,
  [campo_alterado] varchar(100),
  [valor_anterior] varchar(max),
  [valor_novo] varchar(max),
  [data_alteracao] datetime DEFAULT (GETDATE()),
  [observacoes] text
)
GO

ALTER TABLE [Enderecos] ADD FOREIGN KEY ([id_usuario]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Cliente_Fisico] ADD FOREIGN KEY ([id_usuario]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Cliente_Juridico] ADD FOREIGN KEY ([id_usuario]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Funcionarios] ADD FOREIGN KEY ([id_usuario]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Veiculos] ADD FOREIGN KEY ([id_cliente]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Ordens_de_Servico] ADD FOREIGN KEY ([id_veiculo]) REFERENCES [Veiculos] ([id])
GO

ALTER TABLE [Ordens_de_Servico] ADD FOREIGN KEY ([id_cliente]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Funcionarios_OS] ADD FOREIGN KEY ([id_ordem_servico]) REFERENCES [Ordens_de_Servico] ([id])
GO

ALTER TABLE [Funcionarios_OS] ADD FOREIGN KEY ([id_funcionario]) REFERENCES [Funcionarios] ([id_usuario])
GO

ALTER TABLE [Itens_Servico_OS] ADD FOREIGN KEY ([id_ordem_servico]) REFERENCES [Ordens_de_Servico] ([id])
GO

ALTER TABLE [Itens_Servico_OS] ADD FOREIGN KEY ([id_servico]) REFERENCES [Servicos] ([id])
GO

ALTER TABLE [Pecas_OS] ADD FOREIGN KEY ([id_ordem_servico]) REFERENCES [Ordens_de_Servico] ([id])
GO

ALTER TABLE [Pecas_OS] ADD FOREIGN KEY ([id_peca]) REFERENCES [Pecas_Estoque] ([id])
GO

ALTER TABLE [Historico_Ordens] ADD FOREIGN KEY ([id_usuario]) REFERENCES [Pessoas] ([id])
GO

ALTER TABLE [Historico_Ordens] ADD FOREIGN KEY ([id_ordem_servico]) REFERENCES [Ordens_de_Servico] ([id])
GO
