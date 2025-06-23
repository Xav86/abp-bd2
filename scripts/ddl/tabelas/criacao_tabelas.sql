CREATE TABLE [Pessoas] (
  [id] int NOT NULL IDENTITY(1, 1),
  [nome] varchar(100) NOT NULL,
  [telefone] varchar(20) NOT NULL,
  [email] varchar(100) NOT NULL,
  CONSTRAINT pk_pessoas PRIMARY KEY (id)
)
GO

CREATE TABLE [Enderecos] (
  [id] int NOT NULL IDENTITY(1, 1),
  [id_pessoa] int NOT NULL,
  [logradouro] varchar(100) NOT NULL,
  [numero] varchar(10) NOT NULL,
  [complemento] varchar(50) NOT NULL,
  [bairro] varchar(50) NOT NULL,
  [cidade] varchar(50) NOT NULL,
  [estado] varchar(2) NOT NULL,
  [cep] varchar(10) NOT NULL,
  CONSTRAINT pk_enderecos PRIMARY KEY (id)
)
GO

CREATE TABLE [Clientes_Fisicos] (
  [id_pessoa] int NOT NULL,
  [cpf] char(11) NOT NULL,
  CONSTRAINT uq_clientes_fisicos__cpf UNIQUE (cpf),
  CONSTRAINT pk_clientes_fisicos PRIMARY KEY (id_pessoa)
)
GO

CREATE TABLE [Clientes_Juridicos] (
  [id_pessoa] int NOT NULL,
  [cnpj] char(14) NOT NULL,
  CONSTRAINT uq_clientes_juridicos__cnpj UNIQUE (cnpj),
  CONSTRAINT pk_clientes_juridicos PRIMARY KEY (id_pessoa)
)
GO

CREATE TABLE [Funcionarios] (
  [id_pessoa] int NOT NULL,
  [funcao] varchar(50) NOT NULL,
  [data_admissao] date NOT NULL,
  [ativo] bit NOT NULL,
  [salario] numeric(14,2) NOT NULL
  CONSTRAINT pk_funcionarios PRIMARY KEY (id_pessoa)
)
GO

CREATE TABLE [Veiculos] (
  [id] int NOT NULL IDENTITY(1, 1),
  [placa] varchar(10) NOT NULL,
  [modelo] varchar(50) NOT NULL,
  [marca] varchar(50) NOT NULL,
  [ano_fabricacao] char(4) NOT NULL,
  [chassi] char(17) NOT NULL,
  [quilometragem] int NOT NULL,
  CONSTRAINT uq_veiculos__placa UNIQUE (placa),
  CONSTRAINT pk_veiculos PRIMARY KEY (id)
)
GO

CREATE TABLE [Servicos] (
  [id] smallint NOT NULL IDENTITY(1, 1),
  [nome] varchar(100) NOT NULL,
  [descricao] varchar(max) NOT NULL,
  [preco_padrao] numeric(14,2) NOT NULL,
  CONSTRAINT pk_servicos PRIMARY KEY (id)
)
GO

CREATE TABLE [Status] (
  [id] tinyint NOT NULL IDENTITY(1, 1),
  [descricao] varchar(50) NOT NULL
  CONSTRAINT pk_status PRIMARY KEY (id)
)
GO

CREATE TABLE [Ordens_de_Servico] (
  [id] int NOT NULL IDENTITY(1, 1),
  [id_veiculo] int NOT NULL,
  [id_cliente] int NOT NULL,
  [data_entrada] date NOT NULL,
  [data_saida] date,
  [data_meta] date NOT NULL,
  [titulo] varchar(100) NOT NULL,
  [descricao] varchar(500) NOT NULL,
  [status] tinyint NOT NULL,
  CONSTRAINT pk_ordens_de_servico PRIMARY KEY (id)
)
GO

CREATE TABLE [Funcionarios_OS] (
  [id] int NOT NULL IDENTITY(1, 1),
  [id_ordem_servico] int NOT NULL,
  [id_funcionario] int NOT NULL,
  [funcao_na_ordem] varchar(50) NOT NULL,
  [tempo_trabalhado] smallint NOT NULL,
  [observacoes] varchar(500) NOT NULL,
  CONSTRAINT pk_funcionarios_os PRIMARY KEY (id)
)
GO

CREATE TABLE [Itens_Servico_OS] (
  [id] int NOT NULL IDENTITY(1, 1),
  [id_ordem_servico] int NOT NULL,
  [id_servico] smallint NOT NULL,
  [preco_realizado] numeric(14,2) NOT NULL,
  CONSTRAINT pk_itens_servicos_os PRIMARY KEY (id)
)
GO

CREATE TABLE [Pecas_Estoque] (
  [id] smallint NOT NULL IDENTITY(1, 1),
  [nome] varchar(100) NOT NULL,
  [descricao] varchar(max) NOT NULL,
  [quantidade_estoque] int NOT NULL,
  [preco_unitario] numeric(14,2) NOT NULL,
  CONSTRAINT pk_pecas_estoque PRIMARY KEY (id)
)
GO

CREATE TABLE [Pecas_OS] (
  [id] int NOT NULL IDENTITY(1, 1),
  [id_ordem_servico] int NOT NULL,
  [id_peca] smallint NOT NULL,
  [quantidade] int NOT NULL,
  [preco_unitario] numeric(14,2) NOT NULL,
  CONSTRAINT pk_pecas_os PRIMARY KEY (id)
)
GO

CREATE TABLE [Historico_Ordens] (
  [id] int NOT NULL IDENTITY(1, 1),
  [id_pessoa] int NOT NULL,
  [id_ordem_servico] int NOT NULL,
  [hora_alteracao] time NOT NULL,
  [data_alteracao] date NOT NULL,
  [observacoes] varchar(max) NOT NULL,
  CONSTRAINT pk_historico_ordens PRIMARY KEY (id)
)
GO

ALTER TABLE Enderecos
ADD CONSTRAINT fk_pessoas__enderecos 
FOREIGN KEY (id_pessoa) 
REFERENCES Pessoas (id)
GO

ALTER TABLE Clientes_Fisicos
ADD CONSTRAINT fk_pessoas__clientes_fisicos 
FOREIGN KEY (id_pessoa) 
REFERENCES Pessoas (id)
GO

ALTER TABLE Clientes_Juridicos
ADD CONSTRAINT fk_pessoas__clientes_juridicos 
FOREIGN KEY (id_pessoa) 
REFERENCES Pessoas (id)
GO

ALTER TABLE Funcionarios
ADD CONSTRAINT fk_pessoas__funcionarios 
FOREIGN KEY (id_pessoa) 
REFERENCES Pessoas (id)
GO

ALTER TABLE Ordens_de_Servico
ADD CONSTRAINT fk_pessoas__ordens_de_servico 
FOREIGN KEY (id_cliente) 
REFERENCES Pessoas (id)
GO

ALTER TABLE Ordens_de_Servico
ADD CONSTRAINT fk_veiculos__ordens_de_servico 
FOREIGN KEY (id_veiculo) 
REFERENCES Veiculos (id)
GO

ALTER TABLE Ordens_de_Servico
ADD CONSTRAINT fk_status__ordens_de_servico 
FOREIGN KEY (status) 
REFERENCES [Status] (id)
GO

ALTER TABLE Funcionarios_OS
ADD CONSTRAINT fk_ordens_de_servico__funcionario_os 
FOREIGN KEY (id_ordem_servico) 
REFERENCES Ordens_de_Servico (id)

ALTER TABLE Funcionarios_OS
ADD CONSTRAINT fk_funcionarios__funcionarios_os 
FOREIGN KEY (id_funcionario) 
REFERENCES Funcionarios (id_pessoa);
GO

ALTER TABLE Itens_Servico_OS
ADD CONSTRAINT fk_ordens_de_servico__itens_servico_os 
FOREIGN KEY (id_ordem_servico) 
REFERENCES Ordens_de_Servico (id);

ALTER TABLE Itens_Servico_OS
ADD CONSTRAINT fk_servicos__itens_servico_os 
FOREIGN KEY (id_servico) 
REFERENCES Servicos (id);
GO

ALTER TABLE Pecas_OS
ADD CONSTRAINT fk_ordens_de_servico__pecas_os 
FOREIGN KEY (id_ordem_servico) 
REFERENCES Ordens_de_Servico (id);
GO

ALTER TABLE Pecas_OS
ADD CONSTRAINT fk_pecas_estoque__pecas_os 
FOREIGN KEY (id_peca) 
REFERENCES Pecas_Estoque (id);
GO

ALTER TABLE Historico_Ordens
ADD CONSTRAINT fk_pessoas__historico_ordens 
FOREIGN KEY (id_pessoa) 
REFERENCES Pessoas (id);
GO

ALTER TABLE Historico_Ordens
ADD CONSTRAINT fk_ordens_de_servico__historico_ordens 
FOREIGN KEY (id_ordem_servico) 
REFERENCES Ordens_de_Servico (id);

ALTER TABLE Historico_Ordens
ADD CONSTRAINT df_historico_ordens 
DEFAULT GETDATE() 
FOR data_alteracao;
GO
