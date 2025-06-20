-- ===================================================================
-- INSERTS PARA O BANCO DE DADOS DA OFICINA
-- ===================================================================

-- 1. Pessoas (Clientes, Funcionários e Empresas)
PRINT 'Inserindo Pessoas...'
INSERT INTO Pessoas (nome, telefone, email) VALUES
('Caio Dos Santos Lopes', '(48) 99111-1111', 'caio@email.com'),          -- ID 1
('Calebe Arlan Souza da Silva', '(48) 99222-2222', 'calebe@email.com'),      -- ID 2
('Gustavo Gonçalves dos Santos', '(48) 99333-3333', 'gustavo@email.com'),   -- ID 3 (Funcionário)
('Lucas Pizoni Flores', '(48) 99333-3334', 'lucas@email.com'),           -- ID 4
('Matheus Araújo de Melo', '(48) 99333-3335', 'matheus@email.com'),       -- ID 5
('Empresa X Logistica', '(48) 99444-4444', 'contato@empresax.com'),      -- ID 6 (Jurídico)
('Fernanda Lima', '(48) 99555-5555', 'fernanda.lima@email.com'),         -- ID 7
('Ricardo Oliveira', '(48) 99666-6666', 'ricardo.oliveira@email.com'),    -- ID 8
('Oficina Parceira Ltda', '(48) 99777-7777', 'parceira@oficina.com'),    -- ID 9 (Jurídico)
('Ana Costa', '(48) 99888-8888', 'ana.costa@email.com'),                -- ID 10 (Funcionário)
('Mariana Almeida', '(48) 98765-4321', 'mariana.a@email.com'),             -- ID 11
('Bruno Carvalho', '(48) 91234-5678', 'bruno.c@email.com'),               -- ID 12
('Transportadora Veloz Ltda', '(48) 3433-8899', 'contato@tveloz.com'),    -- ID 13 (Jurídico)
('Rafael Ferreira', '(48) 99887-7665', 'rafael.f@email.com'),              -- ID 14
('Juliana Ribeiro', '(48) 98877-6655', 'juliana.r@email.com'),             -- ID 15
('Carlos Eduardo Mendes', '(48) 98456-1234', 'cadu.mendes@email.com'),       -- ID 16 (Funcionário)
('Beatriz Costa', '(48) 99122-3344', 'beatriz.costa@email.com'),          -- ID 17
('Comercial de Peças S.A.', '(48) 3462-1020', 'compras@comercialpecas.com'),-- ID 18 (Jurídico)
('Vinicius Moraes', '(48) 99654-9876', 'vinicius.m@email.com'),            -- ID 19
('Laura Martins', '(48) 98811-2233', 'laura.m@email.com'),                 -- ID 20
('Thiago Nunes', '(48) 99159-8745', 'thiago.nunes@email.com'),            -- ID 21 (Funcionário)
('Construtora Rocha Forte', '(48) 3437-5060', 'adm@rochaforte.com');        -- ID 22 (Jurídico)
GO

-- 2. Especialização de Pessoas (Clientes e Funcionários)
PRINT 'Inserindo Clientes e Funcionários...'
-- Clientes Físicos
INSERT INTO Cliente_Fisico (id_usuario, cpf) VALUES
(1, '12345678901'),
(2, '98765432102'),
(4, '23456789013'),
(5, '34567890124'),
(7, '45678901235'),
(8, '56789012346'),
(11, '67890123457'),
(12, '78901234568'),
(14, '89012345679'),
(15, '90123456780'),
(17, '01234567891'),
(19, '12345678903'),
(20, '23456789014');

-- Clientes Jurídicos
INSERT INTO Cliente_Juridico (id_usuario, cnpj) VALUES
(6, '12345678000195'),
(9, '98765432000188'),
(13, '87654321000177'),
(18, '76543210000166'),
(22, '65432109000155');

-- Funcionários
INSERT INTO Funcionarios (id_usuario, funcao, data_admissao, ativo, salario) VALUES
(3, 'Mecanico Chefe', '2022-01-10', 1, 4200.00),
(10, 'Recepcionista', '2023-05-15', 1, 2800.00),
(16, 'Mecanico', '2023-03-20', 1, 3500.00),
(21, 'Eletricista', '2024-01-15', 1, 3750.00);
GO

-- 3. Enderecos
PRINT 'Inserindo Endereços...'
INSERT INTO Enderecos (id_usuario, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1, 'Rua A', '100', 'Casa', 'Centro', 'Criciuma', 'SC', '88800-000'),
(2, 'Rua B', '200', 'Ap 101', 'Pinheirinho', 'Criciuma', 'SC', '88800-001'),
(3, 'Rua C', '300', '', 'Prospera', 'Criciuma', 'SC', '88800-002'),
(4, 'Rua D', '400', '', 'Sao Luiz', 'Criciuma', 'SC', '88800-003'),
(5, 'Av. Industrial', '500', 'Galpao 2', 'Zona Industrial', 'Criciuma', 'SC', '88800-004'),
(6, 'Rua E', '600', 'Sede', 'Santa Luzia', 'Criciuma', 'SC', '88800-005'),
(7, 'Av. Brasil', '700', 'Ap 302', 'Centro', 'Icara', 'SC', '88820-000'),
(8, 'Rua das Palmeiras', '800', 'Casa', 'Comerciario', 'Criciuma', 'SC', '88800-006'),
(9, 'Rua F', '900', 'Sala 10', 'Michel', 'Criciuma', 'SC', '88800-007'),
(10, 'Rua G', '1000', 'Ap 10', 'Vila Rica', 'Criciuma', 'SC', '88800-008'),
(11, 'Rua das Gaivotas', '123', 'Casa', 'Centro', 'Tubarão', 'SC', '88701-000'),
(12, 'Av. Marcolino Martins Cabral', '2000', '', 'Vila Moema', 'Tubarão', 'SC', '88705-001'),
(13, 'Rodovia BR-101', 'km 340', 'Galpão 5', 'Distrito Industrial', 'Capivari de Baixo', 'SC', '88745-000'),
(14, 'Rua Itália', '455', 'Ap 202', 'Centro', 'Urussanga', 'SC', '88840-000'),
(15, 'Rua das Flores', '50', 'Casa', 'Rio Maina', 'Criciúma', 'SC', '88800-110'),
(16, 'Av. Centenário', '3400', 'Ap 504', 'Centro', 'Criciúma', 'SC', '88802-000'),
(17, 'Rua Laguna', '789', '', 'Centro', 'Jaguaruna', 'SC', '88715-000'),
(18, 'Rua do Comércio', '1500', 'Prédio A', 'Comerciário', 'Criciúma', 'SC', '88800-006'),
(19, 'Rua Holanda', '210', 'Casa', 'Nações', 'Criciúma', 'SC', '88800-200'),
(20, 'Rua da Praia', '90', '', 'Morro dos Conventos', 'Araranguá', 'SC', '88900-000'),
(21, 'Rua Joinville', '333', 'Ap 101', 'Michel', 'Criciúma', 'SC', '88800-007'),
(22, 'Av. Getúlio Vargas', '850', 'Sala 3', 'Centro', 'Içara', 'SC', '88820-000');
GO

-- 4. Veiculos
-- CORREÇÃO: Removida a coluna 'id_cliente' e 'status' que não existem na tabela Veiculos.
PRINT 'Inserindo Veículos...'
INSERT INTO Veiculos (placa, modelo, marca, ano_fabricacao, chassi, quilometragem) VALUES
('ABC1D23', 'Uno', 'Fiat', '2010', '9BWZZZ377VT004251', 125000),      -- ID 1
('XYZ9K87', 'Civic', 'Honda', '2015', '8AGZZZ377VT004999', 83000),       -- ID 2
('DEF2G45', 'Gol', 'Volkswagen', '2012', '9BGZZZ377VT005111', 102000),    -- ID 3
('HIJ3L67', 'Ka', 'Ford', '2018', '9FGZZZ377VT005222', 65000),         -- ID 4
('KLM4N89', 'Strada', 'Fiat', '2022', '7CHZZZ377VT005333', 45000),      -- ID 5
('OPQ5P12', 'HB20', 'Hyundai', '2019', '6BDZZZ377VT005444', 72000),     -- ID 6
('RST6Q34', 'Onix', 'Chevrolet', '2020', '5CEZZZ377VT005555', 58000),    -- ID 7
('UVW7R56', 'Corolla', 'Toyota', '2021', '4DFZZZ377VT005666', 31000),    -- ID 8
('WXY8S78', 'Toro', 'Fiat', '2021', '3EGZZZ377VT005777', 90000),       -- ID 9
('ZAB9T90', 'Kwid', 'Renault', '2019', '2FHZZZ377VT005888', 75000),      -- ID 10
('MNO5P67', 'Creta', 'Hyundai', '2021', '7BDZZZ377VT006111', 48000),     -- ID 11
('PQR6Q78', 'Compass', 'Jeep', '2019', '6CEZZZ377VT006222', 78000),     -- ID 12
('STU7R89', 'Iveco Daily', 'Iveco', '2018', '5DFZZZ377VT006333', 180000),   -- ID 13
('VWX8S90', 'Polo', 'Volkswagen', '2020', '4EGZZZ377VT006444', 62000),     -- ID 14
('YZA9T01', 'Fit', 'Honda', '2017', '3FHZZZ377VT006555', 95000),       -- ID 15
('BCD0U12', 'Argo', 'Fiat', '2022', '2GIZZZ377VT006666', 35000);       -- ID 16
GO

-- 5. Catalogo de Servicos
PRINT 'Inserindo Catálogo de Serviços...'
INSERT INTO Servicos (nome, descricao, preco_padrao, tempo_estimado) VALUES
('Troca de oleo e filtro', 'Substituicao do oleo do motor e filtro de oleo.', 180.00, 30),
('Alinhamento 3D', 'Alinhamento computadorizado das quatro rodas.', 120.00, 45),
('Balanceamento de rodas', 'Balanceamento de cada roda para evitar vibracoes.', 80.00, 40),
('Troca de pastilhas de freio', 'Substituicao das pastilhas de freio dianteiras.', 250.00, 60),
('Revisao completa (basica)', 'Verificacao de 30 itens, incluindo fluidos, filtros e velas.', 450.00, 180),
('Diagnostico com scanner', 'Leitura da injecao eletronica com scanner automotivo.', 100.00, 20),
('Limpeza de bicos injetores', 'Limpeza e equalizacao dos bicos da injecao eletronica.', 200.00, 90),
('Troca da correia dentada', 'Substituicao da correia dentada e tensionador.', 600.00, 240),
('Reparo no ar condicionado', 'Diagnostico e recarga de gas do sistema de A/C.', 350.00, 120),
('Higienizacao do ar condicionado', 'Limpeza do sistema e troca do filtro de cabine.', 150.00, 50);
GO

-- 6. Pecas em Estoque
PRINT 'Inserindo Peças no Estoque...'
INSERT INTO Pecas_Estoque (nome, descricao, quantidade_estoque, preco_unitario) VALUES
('Filtro de oleo motor 1.0', 'Filtro de oleo para motores Fiat/GM 1.0', 50, 30.00),
('Pneu Aro 14 (175/65R14)', 'Pneu da marca X para carros compactos', 40, 320.00),
('Oleo de Motor 5W30 Sintetico', 'Litro de oleo sintetico 5W30', 100, 55.00),
('Pastilha de Freio Dianteira (Gol G5)', 'Par de pastilhas de freio para VW Gol G5/G6', 20, 90.00),
('Filtro de Ar do Motor (Onix)', 'Filtro de ar para Chevrolet Onix/Prisma', 35, 45.00),
('Correia Dentada (motor Fire)', 'Correia para motores Fiat Fire 1.0/1.4', 15, 120.00),
('Vela de Ignicao (3 eletrodos)', 'Vela de ignicao universal para motores flex', 80, 25.00),
('Filtro de Cabine / Ar Condicionado', 'Filtro anti-polen universal', 60, 35.00),
('Amortecedor Dianteiro (Par)', 'Amortecedores para linha compacta GM', 10, 450.00),
('Lampada H4 Super Branca', 'Par de lampadas para farol', 30, 50.00);
GO

-- 7. Status de Ordens de Serviço
-- Adicionando os status possíveis para as Ordens de Serviço
PRINT 'Inserindo Status de Ordens de Serviço...'
INSERT INTO Status (descricao) VALUES
('Na Fila'),
('Aguardando Aprovacao'),
('Em Manutencao'),
('Aguardando Peca'),
('Finalizada'),
('Cancelada');

-- 8. Ordens de Servico
PRINT 'Inserindo Ordens de Serviço...'
INSERT INTO Ordens_de_Servico (id_veiculo, id_cliente, data_entrada, data_saida, data_meta, titulo, descricao, status_id) VALUES
(1, 1, '2024-06-10 08:00:00', '2024-06-10 12:00:00', '2024-06-10', 'Revisao basica Uno', 'Troca de oleo e revisao geral.', 5),
(2, 2, '2024-06-11 09:15:00', '2024-06-11 11:00:00', '2024-06-11', 'Alinhamento e balanceamento Civic', 'Verificar direcao puxando para o lado.', 5),
(3, 4, '2024-06-12 14:00:00', NULL, '2024-06-13', 'Freios fazendo barulho Gol', 'Cliente reclama de ruido ao frear.', 2),
(4, 5, '2024-06-13 10:00:00', NULL, '2024-06-14', 'Motor falhando Ka', 'Realizar diagnostico via scanner.', 3),
(5, 6, '2024-06-14 08:30:00', NULL, '2024-06-17', 'Revisao de 40.000km Strada', 'Executar revisao conforme manual.', 3),
(6, 7, '2024-06-17 11:00:00', NULL, '2024-06-18', 'Ar condicionado nao gela HB20', 'Verificar sistema e possivel vazamento.', 4),
(7, 8, '2024-06-18 09:00:00', NULL, '2024-06-18', 'Orcamento troca de correia Onix', 'Apenas orcamento, nao executar.', 1),
(8, 2, '2024-06-19 10:30:00', NULL, '2024-06-20', 'Troca de pneus Corolla', 'Substituir os 4 pneus, alinhar e balancear.', 1),
(9, 6, '2024-06-20 15:00:00', NULL, '2024-06-21', 'Luz da injecao acesa Toro', 'Passar scanner e identificar falha.', 3),
(10, 9, '2024-06-21 16:00:00', NULL, '2024-06-22', 'Orcamento amortecedores Kwid', 'Cliente solicitou orcamento para troca dos 4 amortecedores.', 2),
(11, 11, '2024-06-22 09:00:00', NULL, '2024-06-24', 'Revisão 50.000km Creta', 'Fazer revisão completa conforme manual do proprietário.', 3),
(12, 12, '2024-06-24 10:30:00', NULL, '2024-06-25', 'Sistema de ar condicionado', 'Ar condicionado parou de gelar e faz barulho.', 4),
(13, 13, '2024-06-25 08:00:00', NULL, '2024-06-26', 'Troca de embreagem Iveco', 'Embreagem patinando em subidas com carga.', 3),
(14, 14, '2024-06-25 11:00:00', '2024-06-25 17:00:00', '2024-06-25', 'Troca correia dentada Polo', 'Cliente solicitou troca preventiva da correia.', 5),
(15, 15, '2024-06-26 14:00:00', NULL, '2024-06-27', 'Barulho na suspensão Fit', 'Verificar barulho na parte dianteira ao passar em buracos.', 1);
GO

-- 9. Itens de Servico por OS
PRINT 'Relacionando Serviços às Ordens de Serviço...'
INSERT INTO Itens_Servico_OS (id_ordem_servico, id_servico, quantidade, preco_realizado) VALUES
(1, 1, 1, 175.00), -- OS 1: Troca de oleo
(2, 2, 1, 120.00), -- OS 2: Alinhamento
(2, 3, 1, 80.00),  -- OS 2: Balanceamento
(3, 4, 1, 240.00), -- OS 3: Troca de pastilhas
(4, 6, 1, 100.00), -- OS 4: Diagnostico
(5, 5, 1, 450.00), -- OS 5: Revisao completa
(6, 9, 1, 350.00), -- OS 6: Reparo Ar Cond.
(7, 8, 1, 600.00), -- OS 7: Orcamento Correia
(8, 2, 1, 120.00), -- OS 8: Alinhamento
(8, 3, 4, 80.00),  -- OS 8: Balanceamento
(9, 6, 1, 100.00), -- OS 9: Diagnostico
(11, 5, 1, 450.00), -- OS 11: Revisão completa
(12, 9, 1, 350.00), -- OS 12: Reparo no ar condicionado
(13, 1, 1, 800.00), -- OS 13: Custo customizado para troca de embreagem
(14, 8, 1, 620.00), -- OS 14: Troca da correia dentada
(15, 2, 1, 120.00); -- OS 15: Alinhamento para checagem da suspensão
GO

-- 10. Pecas utilizadas por OS
PRINT 'Relacionando Peças às Ordens de Serviço...'
INSERT INTO Pecas_OS (id_ordem_servico, id_peca, quantidade, preco_unitario) VALUES
(1, 1, 1, 30.00),  -- OS 1: Filtro de oleo
(1, 3, 4, 55.00),  -- OS 1: 4L de oleo
(3, 4, 1, 90.00),  -- OS 3: Par de pastilhas
(5, 1, 1, 30.00),  -- OS 5: Filtro de oleo
(5, 5, 1, 45.00),  -- OS 5: Filtro de ar
(5, 7, 4, 25.00),  -- OS 5: 4 velas
(8, 2, 4, 310.00), -- OS 8: 4 Pneus
(11, 3, 5, 55.00), -- OS 11: 5L de oleo
(11, 5, 1, 45.00), -- OS 11: Filtro de ar
(11, 8, 1, 35.00), -- OS 11: Filtro de cabine
(14, 6, 1, 150.00);-- OS 14: Correia dentada (preço pode variar por modelo)
GO


-- 11. Funcionarios alocados por OS
PRINT 'Relacionando Funcionários às Ordens de Serviço...'
INSERT INTO Funcionarios_OS (id_ordem_servico, id_funcionario, funcao_na_ordem, tempo_trabalhado, observacoes) VALUES
(1, 3, 'Mecanico Responsavel', 40, 'Finalizado com sucesso.'),
(2, 3, 'Mecanico Responsavel', 50, 'Alinhamento corrigido.'),
(3, 3, 'Mecanico', 0, 'Aguardando aprovacao do cliente para trocar discos tambem.'),
(4, 3, 'Mecanico', 20, 'Falha no sensor de rotacao. Peca solicitada.'),
(5, 3, 'Mecanico Chefe', 180, 'Revisao OK.'),
(6, 3, 'Mecanico', 60, 'Vazamento na mangueira de alta pressao. Peca nao disponivel no estoque.'),
(8, 3, 'Borracheiro', 90, 'Pneus substituidos.'),
(9, 10, 'Recepcionista', 10, 'Abertura da OS e primeiro contato.'),
(9, 3, 'Mecanico', 25, 'Diagnostico realizado, falha no bico injetor 3.'),
(11, 16, 'Mecanico', 120, 'Iniciada a revisão, aguardando velas chegarem.'),
(12, 21, 'Eletricista', 90, 'Diagnóstico feito. Compressor do A/C com defeito. Peça encomendada.'),
(13, 3, 'Mecanico Chefe', 180, 'Desmontagem do câmbio em andamento.'),
(14, 16, 'Mecanico', 240, 'Troca da correia e tensor finalizada com sucesso.'),
(15, 10, 'Recepcionista', 5, 'Abertura da OS.');
GO


PRINT 'SCRIPT DE CRIAÇÃO E POPULAÇÃO FINALIZADO COM SUCESSO!'
