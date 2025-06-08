-- 1. Pessoas
INSERT INTO Pessoas (nome, telefone, email) VALUES
('Caio Dos Santos Lopes', '(48) 99111-1111', 'caio@email.com'), 
('Calebe', '(48) 99222-2222', 'calebe@email.com'), 
('Gustavo', '(48) 99333-3333', 'gustavo@email.com'), 
('Lucas', '(48) 99333-3333', 'lucas@email.com'), 
('Matheus', '(48) 99333-3333', 'matheus@email.com'), 
('Empresa X', '(48) 99444-4444', 'empresax@email.com');

-- 2. Cliente_Fisico
INSERT INTO Cliente_Fisico (id_usuario, cpf) VALUES
(1, '12345678900'),
(2, '98765432100'),
(4, '23456789013'),
(5, '34567890100'); 

-- 2. Cliente_Juridico
INSERT INTO Cliente_Juridico (id_usuario, cnpj) VALUES
(6, '12345678000195');

-- 3. Funcionarios
INSERT INTO Funcionarios (id_usuario, funcao, data_admissao, ativo, salario) VALUES
(3, 'Mecânico', '2022-01-10', 1, 3500.00);

-- 4. Enderecos
INSERT INTO Enderecos (id_usuario, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1, 'Rua A', '100', 'Casa', 'Centro', 'Criciúma', 'SC', '88800-000'),
(2, 'Rua B', '200', 'Ap 101', 'Pinheirinho', 'Criciúma', 'SC', '88800-001'),
(3, 'Rua C', '300', NULL, 'Próspera', 'Criciúma', 'SC', '88800-002'),
(4, 'Rua D', '400', NULL, 'São Luiz', 'Criciúma', 'SC', '88800-003'),
(5, 'Av. Industrial', '500', 'Galpão 2', 'Zona Industrial', 'Criciúma', 'SC', '88800-004'),
(6, 'Rua E', '600', 'Casa 2', 'Santa Luzia', 'Criciúma', 'SC', '88800-005');

-- 5. Veiculos
INSERT INTO Veiculos (id_cliente, placa, modelo, marca, ano_fabricacao, chassi, quilometragem, status) VALUES
(1, 'ABC1D23', 'Uno', 'Fiat', 2010, '9BWZZZ377VT004251', 120000, 'em manutenção'),
(2, 'XYZ9K87', 'Civic', 'Honda', 2015, '8AGZZZ377VT004999', 80000, 'aguardando'),
(4, 'DEF2G45', 'Gol', 'Volkswagen', 2012, '9BGZZZ377VT005111', 100000, 'aguardando'),
(5, 'HIJ3L67', 'Ka', 'Ford', 2018, '9FGZZZ377VT005222', 60000, 'em manutenção');

-- 6. Servicos
INSERT INTO Servicos (nome, descricao, preco_padrao, tempo_estimado) VALUES
('Troca de óleo', 'Substituição do óleo do motor', 150.00, 30),
('Alinhamento', 'Alinhamento das rodas', 120.00, 45);

-- 7. Pecas_Estoque
INSERT INTO Pecas_Estoque (nome, descricao, quantidade_estoque, preco_unitario) VALUES
('Filtro de óleo', 'Filtro para motor 1.0', 50, 30.00),
('Pneu Aro 14', 'Pneu 175/65R14', 20, 250.00);

-- 8. Ordens_de_Servico
INSERT INTO Ordens_de_Servico (id_veiculo, id_cliente, data_entrada, data_saida, titulo, descricao, status) VALUES
(1, 1, '2025-06-01 08:00:00', NULL, 'Revisão básica', 'Troca de óleo e revisão geral', 'em andamento'),
(2, 2, '2025-06-03 09:00:00', NULL, 'Alinhamento e balanceamento', 'Verificar direção puxando para o lado', 'aberta');

-- 9. Funcionarios_OS
INSERT INTO Funcionarios_OS (id_ordem_servico, id_funcionario, funcao_na_ordem, tempo_trabalhado, observacoes) VALUES
(1, 3, 'Responsável Técnico', 60, 'Cliente aguardando liberação'),
(2, 3, 'Auxiliar', 45, 'Necessita alinhamento fino');

-- 10. Itens_Servico_OS
INSERT INTO Itens_Servico_OS (id_ordem_servico, id_servico, quantidade, preco_realizado) VALUES
(1, 1, 1, 145.00),
(2, 2, 1, 110.00);

-- 11. Pecas_OS
INSERT INTO Pecas_OS (id_ordem_servico, id_peca, quantidade, preco_unitario) VALUES
(1, 1, 1, 28.00),
(2, 2, 2, 240.00);
