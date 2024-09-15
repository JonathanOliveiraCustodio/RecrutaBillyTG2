USE master
--DROP DATABASE RecrutaBillyTG2
CREATE DATABASE RecrutaBillyTG2
GO
USE RecrutaBillyTG2 
GO
CREATE TABLE fornecedor(
codigo			INT				NOT NULL IDENTITY(1,1),
nome			VARCHAR(70)		NOT NULL,
telefone		CHAR(12)		NOT NULL,
email			VARCHAR(100)	NOT NULL, 
empresa			VARCHAR(50)		NOT NULL,
CEP		        CHAR(09)	    NOT NULL,
logradouro      VARCHAR(150)	NOT NULL, 
numero          VARCHAR (20)	NOT NULL,
bairro          VARCHAR(150)	NOT NULL,
complemento     VARCHAR(100)	NULL,
cidade          VARCHAR(100)	NOT NULL,
UF              CHAR(02)	    NOT NULL,
PRIMARY KEY (codigo)
)
GO
CREATE TABLE equipamento(
codigo				INT				NOT NULL IDENTITY (1,1),
nome				VARCHAR(100)	NOT NULL,
descricao			VARCHAR(100)	NOT NULL,
fabricante			VARCHAR(50)		NOT NULL,
dataAquisicao		DATE			NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE insumo(
codigo			INT	        	NOT NULL IDENTITY (1,1),
nome			VARCHAR(100)    NOT NULL,
precoCompra		DECIMAL(10,2)	NOT NULL,
precoVenda     DECIMAL(10,2)	NOT NULL,
quantidade		DECIMAL(10,2)	NOT NULL,
unidade	     	VARCHAR(15)     NOT NULL,
fornecedor		INT				NOT NULL,
dataCompra      DATE            NOT NULL   
PRIMARY KEY (codigo)
FOREIGN KEY (fornecedor) REFERENCES fornecedor (codigo)
)
GO
CREATE TABLE funcionario(
CPF					CHAR(11)		NOT NULL,
nome				VARCHAR(100)    NOT NULL,
nivelAcesso			VARCHAR(30)     NOT NULL,
senha				VARCHAR(30)		NOT NULL,
email				VARCHAR(100)	NOT NULL,
dataNascimento      DATE			NOT NULL,
telefone		    CHAR(12)		NOT NULL,
cargo               VARCHAR(30)     NOT NULL,
horario             VARCHAR(30)     NOT NULL,
salario				DECIMAL (10,1)  NOT NULL,
dataAdmissao        DATE			NOT NULL,
dataDesligamento    DATE            NULL,
observacao          VARCHAR(200)    NULL,
PRIMARY KEY (CPF)
)
GO
CREATE TABLE produto(
codigo		   INT	         	NOT NULL IDENTITY (1,1),
nome		   VARCHAR(50)      NOT NULL,
categoria      VARCHAR(30)      NOT NULL,
descricao      VARCHAR(100)     NOT NULL,
valorUnitario  DECIMAL (10,2)   NOT NULL,
status		   VARCHAR(30)		NOT NULL,
quantidade	   INT				NOT NULL,
refEstoque     VARCHAR(50)      NOT NULL 
PRIMARY KEY (codigo)
)
GO
CREATE TABLE insumosProduto(
codigoProduto    INT   NOT NULL,  
codigoInsumo     INT   NOT NULL,
quantidade       INT   NOT NULL
PRIMARY KEY (codigoProduto,codigoInsumo)
FOREIGN KEY (codigoProduto) REFERENCES produto (codigo),
FOREIGN KEY (codigoInsumo) REFERENCES insumo (codigo)
)
GO
CREATE TABLE cliente(
codigo			INT				NOT NULL IDENTITY (1,1),
nome			VARCHAR(100)	NOT NULL,
telefone		CHAR(11)		NOT NULL,
email			VARCHAR(100)	NOT NULL,
tipo			VARCHAR(10)	    NOT NULL,
documento		CHAR(14)	    NOT NULL,
CEP		        CHAR(09)	    NOT NULL,
logradouro      VARCHAR(150)	NOT NULL, 
bairro          VARCHAR(150)	NOT NULL,
localidade      VARCHAR(100)	NOT NULL,
UF              CHAR(02)	    NOT NULL,
complemento     VARCHAR(100)	NULL,
numero          VARCHAR (20)	NOT NULL,
dataNascimento  DATE	NOT NULL
PRIMARY KEY (codigo)
)
GO 
CREATE TABLE pedido(
codigo	          INT		     		NOT NULL IDENTITY (1,1),
nome	          VARCHAR(100)		    NOT NULL,
descricao         VARCHAR(200)		    NOT NULL,
cliente           INT  		  	        NOT NULL,
valorTotal		  DECIMAL(10,2)		    NULL,
estado			  VARCHAR(100)		    NOT NULL,
dataPedido		  DATE					NULL,
tipoPagamento     VARCHAR(30)		    NOT NULL,
observacao        VARCHAR(200)		    NULL,
statusPagamento   VARCHAR(30)		    NOT NULL, 
dataPagamento     DATE					NULL
PRIMARY KEY (codigo)
FOREIGN KEY (cliente) REFERENCES cliente (codigo)
)
GO
CREATE TABLE produtosPedido(
codigoPedido    INT				NOT NULL,
codigoProduto   INT				NOT NULL,
quantidade		INT				NOT NULL
FOREIGN KEY (codigoPedido) REFERENCES pedido (codigo),
FOREIGN KEY (codigoProduto) REFERENCES produto (codigo)
)
GO
CREATE TABLE despesa(
codigo			INT				NOT NULL		IDENTITY,
nome			VARCHAR(200)	NOT NULL,
tipo			VARCHAR(50)		NOT NULL,
pagamento		VARCHAR(50)		NOT NULL,
dataInicio		DATE			NOT NULL,
dataVencimento	DATE			NULL,
valor			DECIMAL(12,2)	NOT NULL,
estado			VARCHAR(50)		NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE manutencoesEquipamento(
codigoManutencao    INT IDENTITY(1,1)   NOT NULL,
codigoEquipamento   INT			    	NOT NULL,
dataManutencao		DATE				NOT NULL,
descricaoManutencao VARCHAR(100)	    NOT NULL
PRIMARY KEY (codigoManutencao,codigoEquipamento)
FOREIGN KEY (codigoEquipamento) REFERENCES equipamento (codigo),
)
GO
CREATE TABLE orcamento (
codigo					INT             NOT NULL IDENTITY(1,1),
nome					VARCHAR(100)    NOT NULL,
descricao				VARCHAR(200)    NOT NULL,
cliente			        INT             NOT NULL,
valorTotal				DECIMAL(10,2)   NULL,
formaPagamento			VARCHAR(25)     NOT NULL,
status					VARCHAR(50)     NOT NULL,
observacao				VARCHAR(200)    NULL,
dataOrcamento			DATE            NOT NULL,
PRIMARY KEY (codigo),
FOREIGN KEY (cliente) REFERENCES cliente (codigo)
)
GO
CREATE TABLE endereco(
codigo              INT IDENTITY(1,1)   NOT NULL,
CPF                 CHAR(11)		    NOT NULL,
CEP				    CHAR(09)	        NOT NULL,
logradouro          VARCHAR(150)	    NOT NULL, 
bairro              VARCHAR(150)	    NOT NULL,
localidade          VARCHAR(100)	    NOT NULL,
UF                  CHAR(02)	        NOT NULL,
complemento         VARCHAR(100)	    NULL,
numero              VARCHAR (20)	    NOT NULL,
tipoEndereco		VARCHAR(30)		    NOT NULL
PRIMARY KEY (codigo,CPF)
FOREIGN KEY (CPF) REFERENCES funcionario (CPF),
)
GO
CREATE TABLE configuracoes(
qtdMaximaOrcamento                INT		    NULL,
qtdMinimaProdutoEstoque           INT		    NULL,
qtdMediaPedidoAndamento           INT		    NULL,
qtdMediaPedidosRecebidos          INT           NULL,
qtdMediaPedidosDespachados        INT           NULL,
qtdMediaProducaoProdutos          INT           NULL,
)
GO
-- Insert Usuario de Teste
INSERT INTO funcionario (CPF, nome, nivelAcesso, senha, email, dataNascimento, telefone, cargo, horario, salario, dataAdmissao, dataDesligamento, observacao) VALUES
('25525320045', 'Administrador', 'admin', 'admin', 'admin', '2000-01-01', '12345678901', 'Gerente', '08:00 às 17:00', 5000.0, '2020-01-01', NULL, NULL),
('76368440015', 'Evandro', 'admin', '123456', 'teste@teste.com', '1985-05-20', '12345678902', 'Supervisor', '09:00 às 18:00', 4000.0, '2021-01-01', NULL, NULL),
('37848890007', 'John', 'Funcionário', '123456', 'john@john.com', '1990-08-15', '12345678903', 'Funcionário', '10:00 às 19:00', 3000.0, '2022-01-01', NULL, NULL);
GO
INSERT INTO cliente (nome, telefone, email, tipo, documento, CEP, logradouro, bairro, localidade, UF, complemento, numero, dataNascimento) VALUES
('Fabio de Lima', '11956432345', 'fdelima@email.com', 'CPF', '45230955074', '08120300', 'Rua Nogueira Viotti', 'Itaim Paulista', 'São Paulo', 'SP', NULL, '156B','1990-08-01'),
('Manoel Gonçalves Costa', '11983774561', 'manoelgoncosta@email.com', 'CPF', '14568711029', '09154900', 'Estrada de Ferro Santos Jundiaí', 'Vila Elclor', 'Santo André', 'SP', NULL, '45','1996-10-03'),
('Astolfo Melo de Cunha', '11984823716', 'astolfocunha@email.com', 'CNPJ', '70295892000180', '01531000', 'Rua da Glória', 'Liberdade', 'São Paulo', 'SP', NULL, '234','2000-05-03'),
('Gabriela Bittencourt', '11965428657', 'gabiit@email.com', 'CNPJ', '32596552000109', '01002000', 'Rua Boa Vista', 'Centro', 'São Paulo', 'SP', NULL, '90','1997-11-01'),
('Yasmin Ribeiro Faganello', '11912438547', 'yasribeiro@email.com', 'CPF', '61837422010', '04050001', 'Avenida Jabaquara', 'Mirandópolis', 'São Paulo', 'SP', NULL, '452A','1984-02-02'),
('Rafaela Ferrari', '11943758121', 'raferrari@email.com', 'CPF', '28348483004', '01310000', 'Avenida Paulista', 'Bela Vista', 'São Paulo', 'SP', 'Apt 202', '1500','1945-08-08'),
('Carlos Eduardo Mendes', '11976543210', 'carlosmendes@email.com', 'CPF', '32856987001', '04534011', 'Rua Bandeira Paulista', 'Itaim Bibi', 'São Paulo', 'SP', NULL, '123','1978-12-12'),
('Mariana Alves', '11987654321', 'marianaalves@email.com', 'CPF', '42396587002', '01323001', 'Rua Haddock Lobo', 'Cerqueira César', 'São Paulo', 'SP', NULL, '456','1985-03-15'),
('Fernando Pereira', '11998765432', 'fernandopereira@email.com', 'CPF', '53048792003', '01402001', 'Alameda Santos', 'Jardim Paulista', 'São Paulo', 'SP', NULL, '789','1992-07-23'),
('Ana Beatriz Rocha', '11909876543', 'anabrocha@email.com', 'CPF', '61934876004', '01310930', 'Rua Bela Cintra', 'Consolação', 'São Paulo', 'SP', NULL, '101','1980-01-05'),
('Pedro Henrique Costa', '11921098765', 'pedrohcosta@email.com', 'CPF', '79856723005', '05414020', 'Rua Teodoro Sampaio', 'Pinheiros', 'São Paulo', 'SP', NULL, '202','1975-05-25'),
('Lucas Silva', '11932109876', 'lucassilva@email.com', 'CPF', '98366168026', '05013020', 'Rua Caiubi', 'Perdizes', 'São Paulo', 'SP', NULL, '303','1988-10-10'),
('Joana Souza', '11943210987', 'joanasouza@email.com', 'CPF', '24228714021', '02012001', 'Rua Voluntários da Pátria', 'Santana', 'São Paulo', 'SP', NULL, '404','1995-11-11'),
('Thiago Santos', '11954321098', 'thiagosantos@email.com', 'CPF', '14532477000', '03015001', 'Rua Siqueira Bueno', 'Belenzinho', 'São Paulo', 'SP', NULL, '505','1983-09-09'),
('Laura Martins', '11965432109', 'lauramartins@email.com', 'CPF', '30269360069', '04013002', 'Avenida Indianópolis', 'Indianópolis', 'São Paulo', 'SP', NULL, '606','1990-04-04'),
('Bruno Oliveira', '11976543201', 'brunooliveira@email.com', 'CPF', '08971895071', '05015020', 'Rua Turiassu', 'Perdizes', 'São Paulo', 'SP', NULL, '707','1982-12-20'),
('Julia Rodrigues', '11987654320', 'juliarodrigues@email.com', 'CPF', '47648143070', '03012001', 'Rua Tobias Barreto', 'Belém', 'São Paulo', 'SP', NULL, '808','1987-07-17'),
('Marcelo Lima', '11998765421', 'marcelolima@email.com', 'CPF', '93240037041', '04012002', 'Avenida Jurema', 'Indianópolis', 'São Paulo', 'SP', NULL, '909','1991-03-03'),
('Patricia Andrade', '11909876542', 'patriciaandrade@email.com', 'CPF', '72410957072', '05017030', 'Rua Apinajés', 'Perdizes', 'São Paulo', 'SP', NULL, '1010','1979-08-18'),
('Felipe Costa', '11921098754', 'felipecosta@email.com', 'CPF', '50794757065', '03012002', 'Rua Tuiuti', 'Tatuapé', 'São Paulo', 'SP', NULL, '1111','1986-02-22'),
('Amanda Silva', '11932109865', 'amandasilva@email.com', 'CPF', '24872469011', '04012003', 'Avenida Moreira Guimarães', 'Moema', 'São Paulo', 'SP', NULL, '1212','1993-05-09');
GO
INSERT INTO fornecedor (nome, telefone, email, empresa, CEP, logradouro, numero, bairro, complemento, cidade, UF) VALUES
('Tech Solutions Ltda.','1234567890', 'contato@techsolutions.com', 'Tecnologia e Soluções', '12345-678', 'Rua das Inovações', '123', 'Centro', NULL, 'São Paulo', 'SP'),
('Eco Supply Co.', '2345678901', 'contato@ecosupply.com', 'Fornecimento Ecológico', '23456-789', 'Avenida Sustentável', '456', 'Jardim', NULL, 'Rio de Janeiro', 'RJ'),
('ArtisanCraft Inc.', '3456789012', 'contato@artisancraft.com', 'Arte e Design', '34567-890', 'Praça dos Artesãos', '789', 'Vila', NULL, 'Belo Horizonte', 'MG'),
('Gourmet Essentials', '4567890123', 'contato@gourmetessentials.com', 'Alimentos Gourmet', '45678-901', 'Travessa dos Sabores', '101', 'Centro', NULL, 'Curitiba', 'PR'),
('BioTech Innovations', '5678901234', 'contato@biotechinnovations.com', 'Inovações Biomédicas', '56789-012', 'Alameda da Ciência', '202', 'Zona Industrial', NULL, 'Porto Alegre', 'RS'),
('EduSmart Solutions', '6789012345', 'contato@edusmart.com', 'Soluções Educacionais', '67890-123', 'Avenida do Conhecimento', '303', 'Bairro Universitário', NULL, 'Brasília', 'DF'),
('Fashion Trends Inc.', '7890123456', 'contato@fashiontrends.com', 'Tendências de Moda', '78901-234', 'Rua da Moda', '404', 'Centro', NULL, 'Florianópolis', 'SC'),
('GreenGrow Gardens', '8901234567', 'contato@greengrowgardens.com', 'Jardins Sustentáveis', '89012-345', 'Estrada das Plantas', '505', 'Jardins', NULL, 'Salvador', 'BA'),
('TechNova Industries','9012345678', 'contato@technovaindustries.com', 'Indústria Tecnológica', '90123-456', 'Boulevard da Tecnologia', '606', 'Distrito Tecnológico', NULL, 'Campinas', 'SP'),
('Tranquil Retreats Ltd.', '0123456789', 'contato@tranquilretreats.com', 'Retiros Tranquilos', '01234-567', 'Rua da Serenidade', '707', 'Centro', NULL, 'Fortaleza', 'CE');
GO
INSERT INTO insumo (nome, precoCompra,precoVenda, quantidade,unidade, fornecedor,dataCompra) VALUES
('Solvente', 30.00,35.00, 500,'unidade', 1.5,'2024-05-05'),
('Verniz', 50.00,55.00, 100,'unidade', 2,'2024-04-07'),
('Papel Offset', 15.00,20.00, 1000,'unidade', 3,'2024-11-10'),
('Tinta Branca PU', 50.00,55.00, 50,'unidade', 4,'2024-02-01'),
('Tinta Preta PU', 40.00,45.00, 300,'ml', 5,'2024-09-03'),
('Molecula Verrmelha', 25.00,30.00, 400,'kg', 1,'2024-06-04'),
('Molecula Cinza', 120.00,150.00, 5.5,'kg', 8,'2024-06-03'),
('Filamento Azul', 42.50, 48.90,200,'kg', 7,'2023-12-12'),
('Poliester', 30.00, 35.00, 10,'ml', 8,'2024-07-15'),
('Tinta Metálica', 20.10,27.50, 20,'unidade', 6, '2024-07-10');
GO
INSERT INTO equipamento (nome, descricao, fabricante, dataAquisicao) VALUES 
('Impressora Offset', 'Impressora Offset de alta velocidade', 'HP', '2024-04-27'),
('Guilhotina', 'Guilhotina de corte automático', 'Guilhotinas S.A.', '2024-04-27'),
('Encadernadora', 'Encadernadora para acabamento de livros', 'Encadernações Ltda.', '2024-04-27'),
('Máquina de Corte e Vinco', 'Máquina para corte e vinco de papelão', 'Máquinas Inc.', '2024-04-27'),
('Plotter de Impressão', 'Plotter para impressão de grandes formatos', 'Plotter Solutions', '2024-04-27'),
('Dobradeira', 'Dobradeira de papel automática', 'Dobras & Cia.', '2024-04-27'),
('Laminadora', 'Laminadora para aplicação de filmes plásticos', 'Laminadoras S.A.', '2024-04-27'),
('Grampeadora Automática', 'Grampeadora automática para acabamento de revistas', 'Grampeadoras Ltda.', '2024-04-27'),
('Sistema de Impressão Digital', 'Impressora digital de alta resolução', 'Digital Print', '2024-04-27'),
('Fresadora CNC', 'Fresadora de controle numérico computadorizado para usinagem de peças', 'CNC Solutions', '2024-04-27');
GO
INSERT INTO produto (nome, categoria, descricao, valorUnitario,status, quantidade,refEstoque) VALUES
('Caneca Personalizada', 'Utensílio Doméstico', 'Caneca de cerâmica com personalização de foto ou texto.', 15.99,'Em Produção',2,'CX01'),
('Camiseta Personalizada', 'Vestuário', 'Camiseta de algodão com estampa personalizada.', 24.99,'Em Produção',10,'CX02'),
('Calendário de Parede Personalizado', 'Papelaria', 'Calendário de parede personalizado com fotos.', 12.99,'Não Aplicável',100,'CX05'),
('Caneta Personalizada', 'Papelaria', 'Caneta esferográfica com nome gravado.', 13.49,'Em Produção',100,'AR01'),
('Mouse Pad Personalizado', 'Acessório de Computador', 'Mouse pad com imagem personalizada.', 58.99,'Não Aplicável',5,'CX10'),
('Caderno Personalizado', 'Papelaria', 'Caderno com capa personalizada.', 19.99, 'Em Produção',15,'CX03'),
('Almofada Personalizada', 'Decoração', 'Almofada com foto personalizada.', 17.99, 'Em Produção',20,'CX02'),
('Chaveiro Personalizado', 'Acessório', 'Chaveiro com nome gravado.', 5.99,'Não Aplicável',2,'AR01'),
('Patach emborrados', 'Emborachados', 'Emborachados personalizado com nome e tipo sanguineo.', 10.00,'Não Aplicável',5,'AR01');
GO
INSERT INTO pedido (nome, descricao, cliente, valorTotal, estado, dataPedido, tipoPagamento, observacao, statusPagamento, dataPagamento)
VALUES
('Pedido 001', 'Descrição do Pedido 001', 1, 150.00, 'Em andamento', '2024-07-01', 'PIX', NULL, 'Pago', '2024-07-02'),
('Pedido 002', 'Descrição do Pedido 002', 2, 200.00, 'Recebido', '2024-07-02', 'Boleto', NULL, 'Pendente', NULL),
('Pedido 003', 'Descrição do Pedido 003', 3, 50.00, 'Pedido Finalizado', '2024-07-03', 'Dinheiro', NULL, 'Pago', '2024-07-03'),
('Pedido 004', 'Descrição do Pedido 004', 4, 300.00, 'Despachado', '2024-07-04', 'Cartão de Crédito', NULL, 'Pendente', NULL),
('Pedido 005', 'Descrição do Pedido 005', 5, 120.00, 'Em andamento', '2024-07-05', 'Transferência Bancária', NULL, 'Pago', '2024-07-06'),
('Pedido 006', 'Descrição do Pedido 006', 6, 180.00, 'Recebido', '2024-07-06', 'Mercado Pago', NULL, 'Pendente', NULL),
('Pedido 007', 'Descrição do Pedido 007', 1, 90.00, 'Pedido Finalizado', '2024-07-07', 'PIX', NULL, 'Pago', '2024-07-08'),
('Pedido 008', 'Descrição do Pedido 008', 2, 220.00, 'Despachado', '2024-07-08', 'Boleto', NULL, 'Pendente', NULL),
('Pedido 009', 'Descrição do Pedido 009', 3, 110.00, 'Em andamento', '2024-07-09', 'Cartão de Crédito', NULL, 'Pago', '2024-07-10'),
('Pedido 010', 'Descrição do Pedido 010', 4, 250.00, 'Recebido', '2024-07-10', 'Transferência Bancária', NULL, 'Pendente', NULL),
('Pedido 011', 'Descrição do Pedido 011', 5, 130.00, 'Pedido Finalizado', '2024-07-11', 'Mercado Pago', NULL, 'Pago', '2024-07-12'),
('Pedido 012', 'Descrição do Pedido 012', 6, 160.00, 'Despachado', '2024-07-12', 'PIX', NULL, 'Pendente', NULL),
('Pedido 013', 'Descrição do Pedido 013', 1, 200.00, 'Em andamento', '2024-07-13', 'Boleto', NULL, 'Pago', '2024-07-14'),
('Pedido 014', 'Descrição do Pedido 014', 2, 80.00, 'Recebido', '2024-07-14', 'Cartão de Crédito', NULL, 'Pendente', NULL),
('Pedido 015', 'Descrição do Pedido 015', 3, 220.00, 'Pedido Finalizado', '2024-07-15', 'Transferência Bancária', NULL, 'Pago', '2024-07-16'),
('Pedido 016', 'Descrição do Pedido 016', 4, 140.00, 'Despachado', '2024-07-16', 'Mercado Pago', NULL, 'Pendente', NULL),
('Pedido 017', 'Descrição do Pedido 017', 5, 170.00, 'Em andamento', '2024-07-17', 'PIX', NULL, 'Pago', '2024-07-18'),
('Pedido 018', 'Descrição do Pedido 018', 6, 190.00, 'Recebido', '2024-07-18', 'Boleto', NULL, 'Pendente', NULL),
('Pedido 019', 'Descrição do Pedido 019', 1, 210.00, 'Pedido Finalizado', '2024-07-19', 'Cartão de Crédito', NULL, 'Pago', '2024-07-20'),
('Pedido 020', 'Descrição do Pedido 020', 2, 230.00, 'Despachado', '2024-07-20', 'Transferência Bancária', NULL, 'Pendente', NULL);
GO
INSERT INTO manutencoesEquipamento (codigoEquipamento, dataManutencao, descricaoManutencao) VALUES
(1, '2023-01-15', 'Substituição de peças desgastadas'),
(2, '2023-02-20', 'Lubrificação completa'),
(3, '2023-03-10', 'Revisão geral do equipamento'),
(4, '2023-04-05', 'Troca de óleo'),
(5, '2023-05-25', 'Ajuste de calibragem'),
(6, '2023-06-30', 'Reparo no sistema elétrico'),
(7, '2023-07-15', 'Substituição de filtros'),
(8, '2023-08-20', 'Verificação de segurança'),
(9, '2023-09-10', 'Limpeza interna e externa'),
(10, '2023-10-05', 'Atualização de software'),
(1, '2023-11-25', 'Inspeção de rotina'),
(2, '2023-12-30', 'Reparação de falhas mecânicas'),
(3, '2024-01-15', 'Teste de performance'),
(4, '2024-02-20', 'Revisão de sistemas hidráulicos'),
(5, '2024-03-10', 'Substituição de correias'),
(6, '2024-04-05', 'Ajuste de alinhamento'),
(7, '2024-05-25', 'Teste de funcionamento'),
(8, '2024-06-30', 'Atualização de firmware'),
(9, '2024-07-15', 'Inspeção de cabos e conexões'),
(10, '2024-08-20', 'Reparo em componentes desgastados');
GO
INSERT INTO orcamento (nome, descricao, cliente, valorTotal,formaPagamento, status, observacao, dataOrcamento) VALUES
('Orçamento A', 'Descrição do orçamento A', 1, 1500.00, 'Mercado  Pago','Orçamento', 'Observação A', '2024-08-01'),
('Orçamento B', 'Descrição do orçamento B', 2, 2500.50,'PIX', 'Orçamento', 'Observação B', '2024-08-02'),
('Orçamento C', 'Descrição do orçamento C', 3, 3200.75,'Mercado  Pago', 'Orçamento', 'Observação C', '2024-08-03'),
('Orçamento D', 'Descrição do orçamento D', 4, 450.30,'PIX', 'Orçamento', 'Observação D', '2024-08-04'),
('Orçamento E', 'Descrição do orçamento E', 5, 5700.80,'Mercado  Pago', 'Orçamento', 'Observação E', '2024-08-05'),
('Orçamento F', 'Descrição do orçamento F', 6, 1200.40,'PIX', 'Orçamento', 'Observação F', '2024-08-06'),
('Orçamento G', 'Descrição do orçamento G', 7, 2300.90,'Mercado  Pago', 'Orçamento', 'Observação G', '2024-08-07'),
('Orçamento H', 'Descrição do orçamento H', 8, 750.00,'PIX', 'Orçamento', 'Observação H', '2024-08-08'),
('Orçamento I', 'Descrição do orçamento I', 9, 1340.10,'Boleto', 'Orçamento', 'Observação I', '2024-08-09'),
('Orçamento J', 'Descrição do orçamento J', 10, 250.20,'PIX', 'Orçamento', 'Observação J', '2024-08-10'),
('Orçamento K', 'Descrição do orçamento K', 11, 4900.30,'Boleto', 'Orçamento', 'Observação K', '2024-08-11'),
('Orçamento L', 'Descrição do orçamento L', 12, 3100.00,'PIX', 'Orçamento', 'Observação L', '2024-08-12'),
('Orçamento M', 'Descrição do orçamento M', 13, 870.70,'Boleto', 'Orçamento', 'Observação M', '2024-08-13'),
('Orçamento N', 'Descrição do orçamento N', 14, 670.80,'PIX', 'Aprovado', 'Observação N', '2024-08-14'),
('Orçamento O', 'Descrição do orçamento O', 15, 2950.20,'Boleto', 'Em aberto', 'Observação O', '2024-08-15'),
('Orçamento P', 'Descrição do orçamento P', 16, 1450.60,'PIX', 'Rejeitado', 'Observação P', '2024-08-16'),
('Orçamento Q', 'Descrição do orçamento Q', 17, 2000.00,'Boleto', 'Em aberto', 'Observação Q', '2024-08-17'),
('Orçamento R', 'Descrição do orçamento R', 18, 5000.50,'PIX', 'Aprovado', 'Observação R', '2024-08-18'),
('Orçamento S', 'Descrição do orçamento S', 19, 330.00,'Mercado  Pago', 'Em aberto', 'Observação S', '2024-08-19'),
('Orçamento T', 'Descrição do orçamento T', 20, 7700.90,'PIX', 'Rejeitado', 'Observação T', '2024-08-20')
GO
INSERT INTO endereco (CPF, CEP, logradouro, bairro, localidade, UF, complemento, numero, tipoEndereco) VALUES 
('25525320045','01001-000','Praça da Sé','Sé','São Paulo','SP','Centro','1','Residencial'),
('76368440015','20040-003','Avenida Rio Branco','Centro','Rio de Janeiro','RJ','Edifício ABC','100','Comercial')
GO
INSERT INTO configuracoes(qtdMaximaOrcamento,qtdMinimaProdutoEstoque,qtdMediaPedidoAndamento,qtdMediaPedidosRecebidos,qtdMediaPedidosDespachados,qtdMediaProducaoProdutos) VALUES 
(14,5,4,5,5,5)
GO
CREATE PROCEDURE sp_iud_fornecedor
    @acao CHAR(1),
    @codigo INT NULL,
    @nome VARCHAR(50),
    @telefone CHAR(12),
    @email VARCHAR(100),
    @empresa VARCHAR(50),
    @CEP CHAR(9),
    @logradouro VARCHAR(150),
    @numero VARCHAR(20),
    @bairro VARCHAR(150),
    @complemento VARCHAR(100),
    @cidade VARCHAR(100),
    @UF CHAR(2),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM fornecedor WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código já existe. Não é possível inserir o fornecedor.', 16, 1)
            RETURN
        END
        INSERT INTO fornecedor (nome, telefone, email, empresa, CEP, logradouro, numero, bairro, complemento, cidade, UF)
        VALUES  (@nome, @telefone, @email, @empresa, @CEP, @logradouro, @numero, @bairro, @complemento, @cidade, @UF)
        SET @saida = 'Fornecedor inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM fornecedor WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código não existe. Não é possível atualizar o fornecedor.', 16, 1)
            RETURN
        END

        UPDATE fornecedor
        SET nome = @nome, telefone = @telefone, email = @email, empresa = @empresa, CEP = @CEP, logradouro = @logradouro, numero = @numero, bairro = @bairro, complemento = @complemento, cidade = @cidade, UF = @UF
        WHERE codigo = @codigo
        SET @saida = 'Fornecedor alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM fornecedor WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código não existe. Não é possível excluir o fornecedor.', 16, 1)
            RETURN
        END

        DELETE FROM fornecedor WHERE codigo = @codigo
        SET @saida = 'Fornecedor excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO

CREATE PROCEDURE sp_iud_equipamento
    @acao CHAR(1),
    @codigo INT NULL,
    @nome VARCHAR(50),
    @descricao VARCHAR(100),
    @fabricante VARCHAR(50),
    @dataAquisicao DATE,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM equipamento WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código já existe. Não é possível inserir o equipamento.', 16, 1)
            RETURN
        END

        INSERT INTO equipamento (nome, descricao, fabricante, dataAquisicao)
        VALUES (@nome, @descricao, @fabricante, @dataAquisicao)
        SET @saida = 'Equipamento inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM equipamento WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código não existe. Não é possível atualizar o equipamento.', 16, 1)
            RETURN
        END

        UPDATE equipamento
        SET nome = @nome,
            descricao = @descricao,
            fabricante = @fabricante,
            dataAquisicao = @dataAquisicao
        WHERE codigo = @codigo
        SET @saida = 'Equipamento alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM equipamento WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código não existe. Não é possível excluir o equipamento.', 16, 1)
            RETURN
        END

        DELETE FROM equipamento
        WHERE codigo = @codigo
        SET @saida = 'Equipamento excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_insumo
    @acao CHAR(1),
    @codigo INT NULL,
    @nome VARCHAR(100),
    @precoCompra DECIMAL(10,2),
	@precoVenda DECIMAL(10,2),
    @quantidade DECIMAL(10,2),
	@unidade VARCHAR(15),
    @fornecedor INT,
	@dataCompra DATE,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM insumo WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código já existe. Não é possível inserir o insumo.', 16, 1)
            RETURN
        END
        INSERT INTO insumo (nome, precoCompra, precoVenda, quantidade, unidade, fornecedor,dataCompra)
        VALUES (@nome, @precoCompra,@precoVenda, @quantidade, @unidade, @fornecedor,GETDATE())
        SET @saida = 'Insumo inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM insumo WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código não existe. Não é possível atualizar o insumo.', 16, 1)
            RETURN
        END
        UPDATE insumo
        SET nome = @nome, precoCompra = @precoCompra, precoVenda= @precoVenda, quantidade = @quantidade, 
		unidade = @unidade, fornecedor = @fornecedor,dataCompra=@dataCompra
        WHERE codigo = @codigo
        SET @saida = 'Insumo alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM insumo WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código não existe. Não é possível excluir o insumo.', 16, 1)
            RETURN
        END
        DELETE FROM insumo WHERE codigo = @codigo
        SET @saida = 'Insumo excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_funcionario
    @acao CHAR(1),
    @CPF CHAR(11),
    @nome VARCHAR(100),
    @nivelAcesso VARCHAR(30),
    @senha VARCHAR(30),
    @email VARCHAR(100),
    @dataNascimento DATE,
    @telefone CHAR(12),
    @cargo VARCHAR(30),
    @horario VARCHAR(30),
    @salario DECIMAL(10,1),
    @dataAdmissao DATE,
    @dataDesligamento DATE NULL,
    @observacao VARCHAR(200) NULL,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM funcionario WHERE CPF = @CPF)
        BEGIN
            RAISERROR('CPF já existe. Não é possível inserir o funcionário.', 16, 1);
            RETURN;
        END

        INSERT INTO funcionario (CPF, nome, nivelAcesso, senha, email, dataNascimento, telefone, cargo, horario, salario, dataAdmissao, dataDesligamento, observacao)
        VALUES (@CPF, @nome, @nivelAcesso, @senha, @email, @dataNascimento, @telefone, @cargo, @horario, @salario, @dataAdmissao, @dataDesligamento, @observacao);

        SET @saida = 'Funcionário inserido com sucesso';
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM funcionario WHERE CPF = @CPF)
        BEGIN
            RAISERROR('CPF não existe. Não é possível atualizar o funcionário.', 16, 1);
            RETURN;
        END

        UPDATE funcionario
        SET nome = @nome, 
            nivelAcesso = @nivelAcesso, 
            senha = @senha, 
            email = @email,
            dataNascimento = @dataNascimento, 
            telefone = @telefone, 
            cargo = @cargo, 
            horario = @horario, 
            salario = @salario, 
            dataAdmissao = @dataAdmissao, 
            dataDesligamento = @dataDesligamento, 
            observacao = @observacao
        WHERE CPF = @CPF;

        SET @saida = 'Funcionário atualizado com sucesso';
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM funcionario WHERE CPF = @CPF)
        BEGIN
            RAISERROR('CPF não existe. Não é possível excluir o funcionário.', 16, 1);
            RETURN;
        END

        DELETE FROM funcionario WHERE CPF = @CPF;

        SET @saida = 'Funcionário excluído com sucesso';
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1);
        RETURN;
    END
END
GO
CREATE PROCEDURE sp_iud_produto
    @acao CHAR(1),
    @codigo INT NULL,
    @nome VARCHAR(50),
    @categoria VARCHAR(30),
    @descricao VARCHAR(100),
    @valorUnitario DECIMAL(10,2),
    @status VARCHAR(20),
    @quantidade INT, 
    @refEstoque VARCHAR(50),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    -- Verifica a ação a ser executada
    IF (@acao = 'I')
    BEGIN
        -- Verifica se o código já existe na tabela produto
        IF EXISTS (SELECT 1 FROM produto WHERE codigo = @codigo)
        BEGIN
            RAISERROR('Código já existe. Não é possível inserir o produto.', 16, 1);
            SET @saida = 'Código já existe. Não é possível inserir o produto.';
            RETURN;
        END
        
        -- Insere o novo produto
        INSERT INTO produto (nome, categoria, descricao, valorUnitario, status, quantidade, refEstoque)
        VALUES (@nome, @categoria, @descricao, @valorUnitario, @status, @quantidade, @refEstoque);
        SET @saida = 'Produto inserido com sucesso';
    END
    ELSE IF (@acao = 'U')
    BEGIN
        -- Atualiza o produto existente
        UPDATE produto
        SET nome = @nome, categoria = @categoria, descricao = @descricao, valorUnitario = @valorUnitario, status = @status, quantidade = @quantidade, refEstoque = @refEstoque
        WHERE codigo = @codigo;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('Produto não encontrado.', 16, 1);
            SET @saida = 'Produto não encontrado.';
            RETURN;
        END

        SET @saida = 'Produto alterado com sucesso';
    END
    ELSE IF (@acao = 'D')
    BEGIN
        -- Exclui o produto
        DELETE FROM produto WHERE codigo = @codigo;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('Produto não encontrado.', 16, 1);
            SET @saida = 'Produto não encontrado.';
            RETURN;
        END

        SET @saida = 'Produto excluído com sucesso';
    END
    ELSE
    BEGIN
        -- Ação inválida
        RAISERROR('Operação inválida', 16, 1);
        SET @saida = 'Operação inválida';
        RETURN;
    END
END
GO
CREATE PROCEDURE sp_iud_insumosProduto
    @acao CHAR(1),
    @codigoProduto INT,
    @codigoInsumo INT,
	@quantidade INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM insumosProduto WHERE codigoProduto = @codigoProduto AND codigoInsumo = @codigoInsumo)
        BEGIN
            RAISERROR('Relação produto-insumo já existe. Não é possível inserir.', 16, 1)
            RETURN
        END

        INSERT INTO insumosProduto (codigoProduto, codigoInsumo,quantidade)
        VALUES (@codigoProduto, @codigoInsumo,@quantidade)
        SET @saida = 'Relação produto-insumo inserida com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM insumosProduto WHERE codigoProduto = @codigoProduto AND codigoInsumo = @codigoInsumo)
        BEGIN
            RAISERROR('Relação produto-insumo não existe. Não é possível atualizar.', 16, 1)
            RETURN
        END

        -- Atualizar a relação não faz sentido nesse contexto, mas se necessário, adicione o código aqui
        SET @saida = 'Operação de atualização não suportada para relação produto-insumo'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM insumosProduto WHERE codigoProduto = @codigoProduto AND codigoInsumo = @codigoInsumo)
        BEGIN
            RAISERROR('Relação produto-insumo não existe. Não é possível excluir.', 16, 1)
            RETURN
        END

        DELETE FROM insumosProduto 
        WHERE codigoProduto = @codigoProduto AND codigoInsumo = @codigoInsumo
        SET @saida = 'Relação produto-insumo excluída com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END

GO
CREATE PROCEDURE sp_iud_cliente(
    @acao CHAR(1), 
    @codigocliente INT NULL, 
    @nome VARCHAR(100), 
    @telefone CHAR(12), 
    @email VARCHAR(100), 
    @tipo VARCHAR(10), 
    @documento CHAR(14), 
	@CEP       CHAR(09),
	@logradouro VARCHAR(150), 
	@bairro VARCHAR(150), 
	@localidade VARCHAR(100), 
	@UF CHAR(02), 
	@complemento VARCHAR(100), 
	@numero VARCHAR(20), 
	@dataNascimento DATE,
    @saida VARCHAR(200) OUTPUT
)
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM cliente WHERE codigo = @codigocliente)
        BEGIN
            RAISERROR('Código já existe. Não é possível inserir o cliente.', 16, 1)
            RETURN
        END

        INSERT INTO cliente (nome, telefone, email, tipo, documento,CEP,logradouro,bairro,localidade,UF,complemento,numero,dataNascimento)
        VALUES (@nome, @telefone, @email, @tipo, @documento,@CEP,@logradouro,@bairro,@localidade,@UF,@complemento,@numero,@dataNascimento)
        SET @saida = 'Cliente inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM cliente WHERE codigo = @codigocliente)
        BEGIN
            RAISERROR('Código não existe. Não é possível atualizar o cliente.', 16, 1)
            RETURN
        END

        UPDATE cliente
        SET nome = @nome,
            telefone = @telefone,
            email = @email,
            tipo = @tipo,
            documento = @documento,
			cep = @CEP,
			logradouro=@logradouro,
			bairro=@bairro,
			localidade=@localidade,
			UF=@UF,
			complemento=@complemento,
			numero=@numero,
			dataNascimento=@dataNascimento
        WHERE codigo = @codigocliente    
        SET @saida = 'Cliente atualizado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM cliente WHERE codigo = @codigocliente)
        BEGIN
            RAISERROR('Código não existe. Não é possível excluir o cliente.', 16, 1)
            RETURN
        END
        DELETE FROM cliente
        WHERE codigo = @codigocliente
        SET @saida = 'Cliente excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_pedido
    @acao CHAR(1), 
    @codigo INT = NULL, -- O parâmetro pode ser NULL se não for usado
    @nome VARCHAR(100),
    @descricao VARCHAR(200),
    @cliente INT,
    @valorTotal DECIMAL(10,2) = NULL,
    @estado VARCHAR(100),
    @tipoPagamento VARCHAR(30),
    @observacao VARCHAR(200) = NULL,
    @statusPagamento VARCHAR(30),
    @dataPagamento DATE = NULL,
    @saida VARCHAR(200) OUTPUT
AS
BEGIN
    IF (@acao = 'I') -- Inserir
    BEGIN
        INSERT INTO pedido (nome, descricao, cliente, valorTotal, estado, dataPedido, tipoPagamento, observacao, statusPagamento, dataPagamento) 
        VALUES (@nome, @descricao, @cliente, @valorTotal, @estado, GETDATE(), @tipoPagamento, @observacao, @statusPagamento, @dataPagamento)
        
        -- Retornar o valor do código gerado
        SET @codigo = SCOPE_IDENTITY()
        SET @saida = 'Pedido inserido com sucesso. Código gerado: ' + CAST(@codigo AS VARCHAR(10))
    END
    ELSE IF (@acao = 'U') -- Atualizar
    BEGIN
        UPDATE pedido
        SET nome = @nome,
            descricao = @descricao,
            cliente = @cliente,
            valorTotal = @valorTotal,
            estado = @estado,
            tipoPagamento = @tipoPagamento,
            observacao = @observacao,
            statusPagamento = @statusPagamento,
            dataPagamento = @dataPagamento
        WHERE codigo = @codigo
        
        -- Verificar se a atualização afetou alguma linha
        IF @@ROWCOUNT > 0
            SET @saida = 'Pedido atualizado com sucesso'
        ELSE
            SET @saida = 'Nenhum pedido encontrado para atualizar'
    END
    ELSE IF (@acao = 'D') -- Excluir
    BEGIN
        DELETE FROM pedido
        WHERE codigo = @codigo
        
        -- Verificar se a exclusão afetou alguma linha
        IF @@ROWCOUNT > 0
            SET @saida = 'Pedido excluído com sucesso'
        ELSE
            SET @saida = 'Nenhum pedido encontrado para excluir'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO

CREATE PROCEDURE sp_iud_produtos_pedido(
@acao CHAR(1), 
@codigopedido INT, 
@codigoproduto INT, 
@quantidade INT, 
@saida VARCHAR(200) OUTPUT)
AS
BEGIN
	IF(@acao = 'I')
	BEGIN
		INSERT INTO produtosPedido(codigoPedido, codigoProduto, quantidade) VALUES
		(@codigopedido, @codigoproduto, @quantidade)
		SET @saida = 'Produto adicionado ao Pedido'
	END
	ELSE
	IF(@acao = 'U')
	BEGIN
		UPDATE produtosPedido
		SET codigoProduto = @codigoproduto,
			quantidade = @quantidade
		WHERE codigoPedido = @codigopedido
		SET @saida = 'Produto alterado com sucesso'
	END
	ELSE
	IF(@acao = 'D')
	BEGIN
		DELETE produtosPedido
		WHERE codigoPedido = @codigopedido
		AND codigoProduto = @codigoproduto
		SET @saida = 'Produto removido do pedido'
	END
END
GO
-- Inicio Procedure de Login 
CREATE PROCEDURE sp_login_funcionario
    @Email NVARCHAR(100),
    @Senha NVARCHAR(30),
    @Resultado NVARCHAR(100) OUTPUT,
    @NivelAcesso NVARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @SenhaDb NVARCHAR(30)  
    -- Verifica se o usuário existe e obtém a senha armazenada
    SELECT @SenhaDb = senha, @NivelAcesso = nivelAcesso
    FROM funcionario
    WHERE email = @Email

    -- Verifica se o usuário existe e a senha está correta
    IF @SenhaDb IS NULL OR @SenhaDb != @Senha
    BEGIN
        SET @Resultado = 'Usuário ou senha incorretos'
        SET @NivelAcesso = NULL
    END
    ELSE
    BEGIN
        SET @Resultado = 'Login bem-sucedido'
    END
END
GO
-- Fim da Procedure
CREATE PROCEDURE sp_finalizar_pedido(
@codigopedido INT, 
@codigocliente INT, 
@saida VARCHAR(200) OUTPUT)
AS
BEGIN
	UPDATE pedido
	SET estado = 'Pedido Finalizado'
	WHERE codigo = @codigopedido
	AND cliente = @codigocliente
	SET @saida = 'Pedido finalizado com sucesso'
END
GO
-- Inicio Procedure para alterar senha
CREATE PROCEDURE sp_alterar_senha
    @Email NVARCHAR(100),
    @CPF NVARCHAR(11),
    @NovaSenha NVARCHAR(30),
    @Resultado NVARCHAR(100) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM usuario WHERE email = @Email AND cpf = @CPF)
    BEGIN
        UPDATE usuario
        SET senha = @NovaSenha
        WHERE email = @Email AND cpf = @CPF    
        SET @Resultado = 'Senha alterada com sucesso'
    END
    ELSE
    BEGIN
        SET @Resultado = 'Email ou CPF incorretos'
    END
END
GO

CREATE PROCEDURE sp_iud_manutencoesEquipamento
    @acao CHAR(1), 
    @codigoManutencao INT ,
	@codigoEquipamento INT = NULL,
    @descricaoManutencao VARCHAR(100) = NULL,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO manutencoesEquipamento (codigoEquipamento, dataManutencao, descricaoManutencao)
        VALUES (@codigoEquipamento, GETDATE(), @descricaoManutencao)
        SET @saida = 'Manutenção de equipamento inserida com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM manutencoesEquipamento WHERE codigoEquipamento = @codigoEquipamento AND codigoManutencao = @codigoManutencao)
        BEGIN
            RAISERROR('Manutenção de equipamento não existe. Não é possível atualizar.', 16, 1)
            RETURN
        END

        UPDATE manutencoesEquipamento
        SET descricaoManutencao = @descricaoManutencao
        WHERE codigoEquipamento = @codigoEquipamento AND codigoManutencao = @codigoManutencao

        SET @saida = 'Manutenção de equipamento atualizada com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM manutencoesEquipamento WHERE codigoEquipamento = @codigoEquipamento AND codigoManutencao = @codigoManutencao)
        BEGIN
            RAISERROR('Manutenção de equipamento não existe. Não é possível excluir.', 16, 1)
            RETURN
        END

        DELETE FROM manutencoesEquipamento 
        WHERE codigoEquipamento = @codigoEquipamento AND codigoManutencao = @codigoManutencao

        SET @saida = 'Manutenção de equipamento excluída com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END;
GO
-- Inicio procedure IUD Despesa
CREATE PROCEDURE sp_iud_despesa(@acao CHAR(1), @codigo INT, @nome VARCHAR(200), @data DATE, @dataVencimento DATE, @valor DECIMAL(12,2), @tipo VARCHAR(50), @pagamento VARCHAR(50), @estado VARCHAR(50), @saida VARCHAR(200) OUTPUT)
AS
BEGIN
	IF(UPPER(@acao) = 'I')
	BEGIN
		INSERT INTO despesa (nome, dataInicio, dataVencimento, valor, tipo, pagamento, estado) VALUES
		(@nome, @data, @dataVencimento, @valor, @tipo, @pagamento, @estado)
		SET @saida = 'Despesa inserida com sucesso.'
	END
	ELSE
	IF(UPPER(@acao) = 'U')
	BEGIN
		UPDATE despesa
		SET nome = @nome,
			dataInicio = @data,
			dataVencimento = @dataVencimento,
			valor = @valor,
			tipo = @tipo,
			pagamento = @pagamento,
			estado = @estado
		WHERE codigo = @codigo
		SET @saida = 'Despesa alterada com sucesso.'
	END
	ELSE
	IF(UPPER(@acao) = 'D')
	BEGIN
		DELETE despesa
		WHERE codigo = @codigo
		SET @saida = 'Despesa excluida com sucesso.'
	END
	ELSE
	BEGIN
		RAISERROR('Operação inválida', 16, 1)
		RETURN
	END
END
-- Fim da procedure
GO
CREATE PROCEDURE sp_iud_orcamento
    @acao CHAR(1),
    @codigo INT = NULL, -- O parâmetro pode ser NULL se não for usado
    @nome VARCHAR(100),
    @descricao VARCHAR(200),
    @cliente INT,
    @valorTotal DECIMAL(10,2),
	@formaPagamento VARCHAR(25),
	@dataOrcamento DATE = NULL,
    @status VARCHAR(50),
    @observacao VARCHAR(200),
    @saida VARCHAR(200) OUTPUT
AS
BEGIN
   IF (@acao = 'I') -- Inserir
BEGIN
    -- Verifica se o código do cliente já existe na tabela cliente
    IF EXISTS (SELECT 1 FROM orcamento WHERE codigo = @codigo)
    BEGIN
        -- Se o código existir, retorna um erro e sai da procedure
        RAISERROR('Código de Orçamento já existe. Não é possível inserir o orçamento.', 16, 1)
        RETURN
    END   
    -- Inserir o orçamento na tabela orcamento
    INSERT INTO orcamento (nome, descricao, cliente, valorTotal, formaPagamento, status, observacao, dataOrcamento)
    VALUES (@nome, @descricao, @cliente, @valorTotal, @formaPagamento, 'Orçamento', @observacao, GETDATE())
    
    -- Retornar o valor do código gerado
    SET @codigo = SCOPE_IDENTITY()
    SET @saida = 'Orçamento inserido com sucesso. Código gerado: ' + CAST(@codigo AS VARCHAR(10))
END
    ELSE IF (@acao = 'U') -- Atualizar
    BEGIN
        UPDATE orcamento
        SET nome = @nome,
            descricao = @descricao,
            cliente = @cliente,
            valorTotal = @valorTotal,
			formaPagamento = @formaPagamento,
			dataOrcamento = @dataOrcamento,
            status = @status,
            observacao = @observacao
        WHERE codigo = @codigo

        -- Verificar se a atualização afetou alguma linha
        IF @@ROWCOUNT > 0
            SET @saida = 'Orçamento atualizado com sucesso'
        ELSE
            SET @saida = 'Nenhum orçamento encontrado para atualizar'
    END
    ELSE IF (@acao = 'D') -- Excluir
    BEGIN
        DELETE FROM orcamento
        WHERE codigo = @codigo
        
        -- Verificar se a exclusão afetou alguma linha
        IF @@ROWCOUNT > 0
            SET @saida = 'Orçamento excluído com sucesso'
        ELSE
            SET @saida = 'Nenhum orçamento encontrado para excluir'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_orcamento_pedido
    @codigo INT, 
    @saida VARCHAR(200) OUTPUT 
AS
BEGIN
    -- Verifica se o orçamento já foi convertido em pedido
    IF EXISTS (SELECT 1 FROM orcamento WHERE codigo = @codigo AND status = 'Pedido')
    BEGIN
        -- Se o status já for 'Pedido', retorna uma mensagem informando que já foi convertido
        SET @saida = 'Este orçamento já foi convertido em pedido. Não é possível converter novamente.'
        RETURN
    END
    
    -- Atualiza o status do orçamento para 'Pedido'
    UPDATE orcamento
    SET status = 'Pedido'
    WHERE codigo = @codigo;
    
    -- Verifica se a atualização afetou alguma linha
    IF @@ROWCOUNT > 0
    BEGIN
        -- Inserir o pedido na tabela pedido, excluindo a coluna de identidade 'codigo'
        INSERT INTO pedido (nome, descricao, cliente, valorTotal, estado, dataPedido, tipoPagamento, observacao, statusPagamento, dataPagamento)
        SELECT nome, descricao, cliente, valorTotal, 'Recebido', GETDATE(), formaPagamento, observacao, 'Pendente', NULL
        FROM orcamento
        WHERE codigo = @codigo;
        
        SET @saida = 'Orçamento convertido em pedido com sucesso.';
    END
    ELSE
    BEGIN
        SET @saida = 'Nenhum orçamento encontrado com o código especificado para atualizar.';
    END
END
GO
CREATE PROCEDURE sp_iud_endereco
    @acao CHAR(1),
    @codigo INT NULL,
    @CPF CHAR(11),
    @CEP CHAR(9),
    @logradouro VARCHAR(150),
    @bairro VARCHAR(150),
    @localidade VARCHAR(100),
    @UF CHAR(2),
    @complemento VARCHAR(100) NULL,
    @numero VARCHAR(20),
    @tipoEndereco VARCHAR(30),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM endereco WHERE codigo = @codigo AND CPF = @CPF)
        BEGIN
            RAISERROR('Endereço já existe. Não é possível inserir.', 16, 1)
            RETURN
        END
        INSERT INTO endereco (CPF, CEP, logradouro, bairro, localidade, UF, complemento, numero, tipoEndereco)
        VALUES (@CPF, @CEP, @logradouro, @bairro, @localidade, @UF, @complemento, @numero, @tipoEndereco)
        SET @saida = 'Endereço inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM endereco WHERE codigo = @codigo AND CPF = @CPF)
        BEGIN
            RAISERROR('Endereço não existe. Não é possível atualizar.', 16, 1)
            RETURN
        END

        UPDATE endereco
        SET CEP = @CEP, logradouro = @logradouro, bairro = @bairro, localidade = @localidade, UF = @UF, complemento = @complemento, numero = @numero, tipoEndereco = @tipoEndereco
        WHERE codigo = @codigo AND CPF = @CPF
        SET @saida = 'Endereço alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM endereco WHERE codigo = @codigo AND CPF = @CPF)
        BEGIN
            RAISERROR('Endereço não existe. Não é possível excluir.', 16, 1)
            RETURN
        END

        DELETE FROM endereco WHERE codigo = @codigo AND CPF = @CPF
        SET @saida = 'Endereço excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_u_configuracoes
    @qtdMaximaOrcamento INT,
    @qtdMinimaProdutoEstoque INT,
	@qtdMediaPedidoAndamento INT,
	@qtdMediaPedidosRecebidos INT,
	@qtdMediaPedidosDespachados INT,
	@qtdMediaProducaoProdutos INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM configuracoes)
    BEGIN
        RAISERROR('Configuração não existe. Não é possível atualizar.', 16, 1)
        RETURN
    END

    UPDATE configuracoes
    SET qtdMaximaOrcamento = @qtdMaximaOrcamento, qtdMinimaProdutoEstoque = @qtdMinimaProdutoEstoque,
	qtdMediaPedidoAndamento = @qtdMediaPedidoAndamento, qtdMediaPedidosRecebidos = @qtdMediaPedidosRecebidos,
	qtdMediaPedidosDespachados = @qtdMediaPedidosDespachados, qtdMediaProducaoProdutos = @qtdMediaProducaoProdutos
    SET @saida = 'Configuração alterada com sucesso'
END
GO
CREATE FUNCTION fn_insumo_funcionario()
RETURNS TABLE
AS
RETURN
(
    SELECT 
    i.codigo AS codigoInsumo,
    f.codigo AS codigoFornecedor,
    f.nome AS nomeFornecedor,
    i.nome AS nomeInsumo,
	i.precoCompra AS precoCompraInsumo,
	i.precoVenda AS precoVendaInsumo,
    i.dataCompra AS dataCompraInsumo,
    i.quantidade AS quantidadeInsumo,
	i.unidade AS unidadeInsumo
FROM insumo i
INNER JOIN fornecedor f ON i.fornecedor = f.codigo
);
GO
CREATE FUNCTION fn_equipamento()
RETURNS TABLE
AS
RETURN
(
 SELECT codigo, nome, descricao, fabricante, dataAquisicao FROM equipamento
);
GO
CREATE FUNCTION fn_consultar_equipamento(@codigoEquipamento INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        codigo,
        nome,
        descricao,
        fabricante,
        dataAquisicao
    FROM 
        equipamento
    WHERE
        codigo = @codigoEquipamento
);
GO
CREATE FUNCTION fn_consultar_endereco (
    @codigo INT,
    @CPF CHAR(11)
)
RETURNS TABLE
AS
RETURN
(
    SELECT e.codigo, e.CPF, e.CEP, e.logradouro, e.bairro, e.localidade, e.UF, 
           e.complemento, e.numero, e.tipoEndereco, f.nome AS nomeFuncionario
    FROM endereco e
    INNER JOIN funcionario f ON e.CPF = f.CPF
    WHERE e.codigo = @codigo AND e.CPF = @CPF
);
GO
CREATE FUNCTION fn_consultar_produto(@codigoProduto INT)
RETURNS TABLE
AS
RETURN
    SELECT 
        codigo,
        nome,
		categoria,
		descricao,
        valorUnitario,
		status,
		quantidade,
		refEstoque
    FROM 
        produto
    WHERE
        codigo = @codigoProduto;
GO
CREATE FUNCTION fn_listar_insumos_produto (@codigoProduto INT)
RETURNS TABLE
AS
RETURN
(
    SELECT p.nome AS nomeProduto, i.nome AS nomeInsumo, i.unidade AS unidadeInsumo, p.codigo AS codigoProduto, 
	i.codigo AS codigoInsumo, pi.quantidade 
    FROM produto p 
    INNER JOIN insumosProduto pi ON p.codigo = pi.codigoProduto 
    INNER JOIN insumo i ON pi.codigoInsumo = i.codigo 
    WHERE p.codigo = @codigoProduto
);
GO
CREATE FUNCTION fn_listar_manutencoes_equipamento (@codigoEquipamento INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
	eq.codigo AS codigoEquipamento,
	eq.nome AS nomeEquipamento, 
	mp.codigoManutencao,
    mp.dataManutencao, 
	mp.descricaoManutencao 
    FROM equipamento eq 
    INNER JOIN manutencoesEquipamento mp ON eq.codigo = mp.codigoEquipamento
    WHERE eq.codigo = @codigoEquipamento
);
GO
CREATE VIEW v_pedidos
AS
SELECT 
p.codigo,
p.nome AS nomePedido, 
p.descricao,
p.cliente AS codigoCliente, 
p.valorTotal, 
p.estado, 
p.dataPedido,
p.tipoPagamento,
p.observacao,
p.statusPagamento,
p.dataPagamento,

c.nome AS nomeCliente, 
c.CEP,
c.logradouro,
c.numero,
c.UF,
c.localidade,
c.bairro,
c.complemento,
c.telefone
FROM pedido p, cliente c
WHERE p.cliente = c.codigo
GO
CREATE VIEW v_pedido_produto
AS
SELECT pp.codigoPedido AS codigo_pedido, p.codigo AS codigo_produto, p.nome AS nome_produto, p.categoria AS categoria_produto, p.descricao AS descricao_produto, p.valorUnitario AS valor_unitario, pp.quantidade
FROM produtosPedido pp, produto p
WHERE p.codigo = pp.codigoProduto
GO
CREATE VIEW v_produto AS
SELECT 
    codigo, 
    nome, 
    categoria, 
    descricao, 
    valorUnitario, 
    status, 
    quantidade, 
    refEstoque 
FROM 
    produto;
GO
CREATE VIEW v_funcionario AS
SELECT 
    CPF,
    nome,
    nivelAcesso,
    senha,
    email,
	dataNascimento,
	telefone,
	cargo,
	horario,
	salario,
	dataAdmissao,
	dataDesligamento,
	observacao
FROM 
    funcionario;
GO
CREATE VIEW vw_endereco_funcionario AS
SELECT 
    e.codigo,
    e.CPF,
    f.nome AS nomeFuncionario,
    e.CEP,
    e.logradouro,
    e.bairro,
    e.localidade,
    e.UF,
    e.complemento,
    e.numero,
    e.tipoEndereco
FROM 
    endereco e
JOIN 
    funcionario f ON e.CPF = f.CPF;
GO
CREATE FUNCTION fn_listar_funcionario_cpf(@CPF CHAR(11))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        CPF,
        nome,
        nivelAcesso,
        senha,
        email,
		telefone,
		dataNascimento,
		cargo,
		horario,
		salario,
		dataAdmissao,
		dataDesligamento,
		observacao
    FROM 
        funcionario
    WHERE 
        CPF = @CPF
);
GO

CREATE TRIGGER t_valortotal ON produtosPedido
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @soma DECIMAL(10,2)
	DECLARE @codigopedido INT
	DECLARE @codigoproduto INT

	IF NOT EXISTS(SELECT * FROM DELETED)
	BEGIN
		SELECT @codigopedido = codigoPedido, @codigoproduto = codigoProduto FROM INSERTED
	END
	ELSE
	BEGIN
		SELECT @codigopedido = codigoPedido, @codigoproduto = codigoProduto FROM DELETED
	END

	SELECT @soma = SUM(pr.valorUnitario * pp.quantidade)
	FROM produtosPedido pp, pedido pe, produto pr
	WHERE pp.codigoPedido = @codigopedido
	AND pe.codigo = pp.codigoPedido
	AND pp.codigoProduto = pr.codigo

	UPDATE pedido
	SET valorTotal = @soma
	WHERE codigo = @codigopedido
END
GO
CREATE TRIGGER t_estadofinal ON produtosPedido
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @codigopedido INT
	DECLARE @estado VARCHAR(100)

	IF NOT EXISTS(SELECT * FROM DELETED)
	BEGIN
		SELECT @codigopedido = codigoPedido FROM INSERTED
	END
	ELSE
	BEGIN
		SELECT @codigopedido = codigoPedido FROM DELETED
	END

	SELECT @estado = estado FROM pedido WHERE codigo = @codigopedido

	IF(@estado = 'Pedido Finalizado')
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Impossivel alterar um pedido já finalizado', 16, 1)
		RETURN
	END
END
GO
CREATE TRIGGER t_fornecedor_insumo
ON fornecedor
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM deleted d JOIN insumo i ON d.codigo = i.fornecedor)
    BEGIN
        RAISERROR ('Não é possível excluir o fornecedor porque ele está associado a um ou mais insumos.', 16, 1);
        RETURN;
    END;

    DELETE FROM fornecedor
    WHERE codigo IN (SELECT codigo FROM deleted);
END
GO
CREATE TRIGGER t_insumo_produto
ON insumo
INSTEAD OF DELETE
AS
BEGIN
    -- Verificar se o insumo está sendo referenciado na tabela produtoInsumo
    IF EXISTS (
        SELECT 1 
        FROM deleted d
        JOIN insumosProduto pi ON d.codigo = pi.codigoInsumo
    )
    BEGIN
        -- Retornar mensagem de erro se houver referência
        RAISERROR ('Não é possível excluir o insumo porque ele está associado a um ou mais produtos.', 16, 1);
        RETURN;
    END;

    -- Se não houver referência, prosseguir com a exclusão
    DELETE FROM insumo
    WHERE codigo IN (SELECT codigo FROM deleted);
END
GO
CREATE TRIGGER t_cliente_pedido_orcamento
ON cliente
INSTEAD OF DELETE
AS
BEGIN
    -- Verifica se há pedidos ou orçamentos associados ao cliente
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN pedido p ON d.codigo = p.cliente
        UNION
        SELECT 1
        FROM deleted d
        JOIN orcamento o ON d.codigo = o.cliente
    )
    BEGIN
        -- Se houver associações, gera uma mensagem de erro
        RAISERROR('Não é possível excluir o cliente porque ele está associado a um ou mais pedidos ou orçamentos.', 16, 1);
        ROLLBACK TRANSACTION; -- Reverte a transação
    END
    ELSE
    BEGIN
        -- Caso não haja associações, realiza a exclusão normalmente
        DELETE FROM cliente
        WHERE codigo IN (SELECT codigo FROM deleted);
    END
END;
GO
CREATE TRIGGER t_despesa_pedido
ON pedido
AFTER UPDATE
AS
BEGIN
	DECLARE @estado VARCHAR(50),
			@codPedido INT,
			@nome VARCHAR(200),
			@valorTotal DECIMAL(10,2),
			@dataPedido DATE,
			@cliente INT,
			@nomeCliente VARCHAR(200),
			@nomePedido VARCHAR(200)

	SELECT @estado = estado, @cliente = cliente, @valorTotal = valorTotal, @dataPedido = dataPedido, @codPedido = codigo FROM inserted
	SELECT @nomeCliente = nome FROM cliente where codigo = @cliente
	SELECT @nomePedido = nome FROM pedido WHERE codigo = @codPedido

	IF @estado LIKE '%Finalizado'
	BEGIN
		INSERT INTO despesa (nome, dataInicio, dataVencimento, tipo, pagamento, valor, estado) VALUES
		(@nomePedido + ' - ' + @nomeCliente, @dataPedido, null, 'Entrada', 'PIX', @valorTotal, 'Pendente')
	END
END
GO
CREATE TRIGGER t_equipamento_manutencao
ON equipamento
INSTEAD OF DELETE
AS
BEGIN
    -- Verifica se há manutenções associadas ao equipamento que está sendo excluído
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN manutencoesEquipamento m ON d.codigo = m.codigoEquipamento
    )
    BEGIN
        -- Se houver associações, gera uma mensagem de erro e reverte a transação
        RAISERROR('Não é possível excluir o equipamento porque ele está associado a uma ou mais manutenções.', 16, 1);
        ROLLBACK TRANSACTION; -- Reverte a transação para garantir que a exclusão não ocorra
    END
    ELSE
    BEGIN
        -- Caso não haja associações, realiza a exclusão normalmente
        DELETE FROM equipamento
        WHERE codigo IN (SELECT codigo FROM deleted);
    END
END;
GO

CREATE VIEW vw_insumo AS
SELECT 
    i.codigo,
    i.nome,
    i.precoCompra,
    i.precoVenda,
    i.quantidade,
    i.unidade,
	i.dataCompra,
    f.nome AS nomeFornecedor,
    f.codigo AS codigoFornecedor  
FROM 
    insumo i
JOIN 
    fornecedor f ON i.fornecedor = f.codigo;
GO
CREATE VIEW vw_fornecedor AS
SELECT
    codigo,
    nome,
    telefone,
    email,
    empresa,
    CEP,
    logradouro,
    numero,
    bairro,
    complemento,
    cidade,
    UF
FROM
    fornecedor;
GO
CREATE VIEW vw_equipamento AS
SELECT 
    codigo,
    nome,
    descricao,
    fabricante,
    dataAquisicao
FROM 
    equipamento;
GO
CREATE VIEW vw_buscar_cliente AS
SELECT 
    codigo,
    nome,
    '(' + SUBSTRING(telefone, 1, 2) + ') ' + SUBSTRING(telefone, 3, 5) + '-' + SUBSTRING(telefone, 8, 4) AS telefone,  -- Formatação manual do telefone
    email,
    CASE 
        WHEN tipo = 'CNPJ' THEN 'Pessoa Jurídica'
        ELSE 'Pessoa Física'
    END AS tipo,
    documento,
    SUBSTRING(CEP, 1, 5) + '-' + SUBSTRING(CEP, 6, 3) AS CEP,  -- Formatação manual do CEP
    logradouro,
    bairro,
    localidade,
    UF,
    complemento,
    numero,
    dataNascimento
FROM 
    cliente;
GO
CREATE VIEW vw_orcamento AS
SELECT 
    o.codigo,
    o.nome,
    o.descricao,
    o.cliente,
    o.valorTotal,
	o.formaPagamento,
    o.status,
    o.observacao,
    o.dataOrcamento,
    e.nome AS nomeCliente,
    e.codigo AS codigoCliente 
FROM 
    orcamento o
JOIN 
    cliente e ON o.cliente = e.codigo;
GO
-- Inicio Funções para o Relatorio
CREATE FUNCTION fn_buscar_cliente (
    @tipoPesquisa VARCHAR(50),
    @valorPesquisa VARCHAR(150)
)
RETURNS @resultado TABLE (
    codigo INT,
    nome VARCHAR(50),
    telefone VARCHAR(20),
    email VARCHAR(100),
    tipo VARCHAR(20),
    documento VARCHAR(20),
    CEP VARCHAR(10),
    logradouro VARCHAR(100),
    bairro VARCHAR(50),
    localidade VARCHAR(50),
    UF VARCHAR(2),
    complemento VARCHAR(50),
    numero VARCHAR(10),
    dataNascimento DATE,
    quantidadeRegistros INT
)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @clientes TABLE (
        codigo INT,
        nome VARCHAR(50),
        telefone VARCHAR(20),
        email VARCHAR(100),
        tipo VARCHAR(20),
        documento VARCHAR(20),
        CEP VARCHAR(10),
        logradouro VARCHAR(100),
        bairro VARCHAR(50),
        localidade VARCHAR(50),
        UF VARCHAR(2),
        complemento VARCHAR(50),
        numero VARCHAR(10),
        dataNascimento VARCHAR(10)
    );

    INSERT INTO @clientes
    SELECT 
        c.codigo,
        c.nome,
        c.telefone,
        c.email,
        c.tipo,
        c.documento,
        c.CEP,
        c.logradouro,
        c.bairro,
        c.localidade,
        c.UF,
        c.complemento,
        c.numero,
        c.dataNascimento
    FROM 
        cliente c
    WHERE 
        (@tipoPesquisa = 'Nome' AND c.nome LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'CEP' AND c.CEP LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Bairro' AND c.bairro LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Localidade' AND c.localidade LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Tipo Cliente' AND c.tipo LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'UF' AND c.UF = @valorPesquisa) OR
        (@tipoPesquisa = 'Todos');

    SET @count = (SELECT COUNT(*) FROM @clientes);

    IF @count = 0
    BEGIN
        INSERT INTO @resultado (codigo, nome, telefone, email, tipo, documento, CEP, logradouro, bairro, localidade, UF, complemento, numero, dataNascimento, quantidadeRegistros)
        VALUES (0, 'Nenhum registro encontrado', '', '', '', '', '', '', '', '', '', '', '', GETDATE(), 0);
    END
    ELSE
    BEGIN
        INSERT INTO @resultado
        SELECT *, @count AS quantidadeRegistros
        FROM @clientes;
    END

    RETURN;
END;
GO

CREATE FUNCTION fn_buscar_fornecedor (
    @tipoPesquisa VARCHAR(50),
    @valorPesquisa VARCHAR(150)
)
RETURNS @resultado TABLE (
    codigo INT,
    nome VARCHAR(50),
    telefone VARCHAR(20),
    email VARCHAR(100),
    empresa VARCHAR(100),
    CEP VARCHAR(10),
    logradouro VARCHAR(100),
    numero VARCHAR(10),
    bairro VARCHAR(50),
    complemento VARCHAR(50),
    cidade VARCHAR(50),
    UF VARCHAR(2),
    quantidadeRegistros INT
)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @fornecedores TABLE (
        codigo INT,
        nome VARCHAR(50),
        telefone VARCHAR(20),
        email VARCHAR(100),
        empresa VARCHAR(100),
        CEP VARCHAR(10),
        logradouro VARCHAR(100),
        numero VARCHAR(10),
        bairro VARCHAR(50),
        complemento VARCHAR(50),
        cidade VARCHAR(50),
        UF VARCHAR(2)
    );

    INSERT INTO @fornecedores
    SELECT 
        f.codigo,
        f.nome,
        f.telefone,
        f.email,
        f.empresa,
        f.CEP,
        f.logradouro,
        f.numero,
        f.bairro,
        f.complemento,
        f.cidade,
        f.UF
    FROM fornecedor f
    WHERE 
        (@tipoPesquisa = 'Nome' AND f.nome LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'CEP' AND f.CEP LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Bairro' AND f.bairro LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Cidade' AND f.cidade LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'UF' AND f.UF = @valorPesquisa) OR
        (@tipoPesquisa = 'Todos');

    SET @count = (SELECT COUNT(*) FROM @fornecedores);

    IF @count = 0
    BEGIN
        INSERT INTO @resultado (codigo, nome, telefone, email, empresa, CEP, logradouro, numero, bairro, complemento, cidade, UF, quantidadeRegistros)
        VALUES (0, 'Nenhum registro encontrado', '', '', '', '', '', '', '', '', '', '', 0);
    END
    ELSE
    BEGIN
        INSERT INTO @resultado
        SELECT *, @count AS quantidadeRegistros
        FROM @fornecedores;
    END

    RETURN;
END;
GO


CREATE FUNCTION fn_buscar_insumo (
    @tipoPesquisa VARCHAR(50),
    @valorPesquisa VARCHAR(150)
)
RETURNS @resultado TABLE (
    codigo INT,
    nome VARCHAR(100),
    precoCompra DECIMAL(10,2),
    precoVenda DECIMAL(10,2),
    quantidade INT,
    unidade VARCHAR(50),
    nomeFornecedor VARCHAR(100),
    codigoFornecedor INT,
    dataCompra DATE,
    quantidadeRegistros INT
)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @insumos TABLE (
        codigo INT,
        nome VARCHAR(100),
        precoCompra DECIMAL(10,2),
        precoVenda DECIMAL(10,2),
        quantidade INT,
        unidade VARCHAR(50),
        nomeFornecedor VARCHAR(100),
        codigoFornecedor INT,
        dataCompra DATE
    );

    INSERT INTO @insumos
    SELECT 
        i.codigo,
        i.nome,
        i.precoCompra,
        i.precoVenda,
        i.quantidade,
        i.unidade,
        f.nome AS nomeFornecedor,
        f.codigo AS codigoFornecedor,
        i.dataCompra
    FROM 
        insumo i
        JOIN fornecedor f ON i.fornecedor = f.codigo
    WHERE 
        (@tipoPesquisa = 'Nome' AND i.nome LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Unidade' AND i.unidade LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Fornecedor' AND f.nome LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Preço Compra Igual' AND i.precoCompra = TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Preço Compra Maior Que' AND i.precoCompra > TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Preço Compra Menor Que' AND i.precoCompra < TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Preço Venda Igual' AND i.precoVenda = TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Preço Venda Maior Que' AND i.precoVenda > TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Preço Venda Menor Que' AND i.precoVenda < TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Todos');

    SET @count = (SELECT COUNT(*) FROM @insumos);

    IF @count = 0
    BEGIN
        INSERT INTO @resultado (codigo, nome, precoCompra, precoVenda, quantidade, unidade, nomeFornecedor, codigoFornecedor, dataCompra, quantidadeRegistros)
        VALUES (0, 'Nenhum registro encontrado', 0.0, 0.0, 0, '', '', 0, NULL, 0);
    END
    ELSE
    BEGIN
        INSERT INTO @resultado
        SELECT 
            codigo,
            nome,
            precoCompra,
            precoVenda,
            quantidade,
            unidade,
            nomeFornecedor,
            codigoFornecedor,
            dataCompra,
            @count AS quantidadeRegistros
        FROM @insumos;
    END

    RETURN;
END;
GO


CREATE FUNCTION fn_buscar_pedido (
    @tipoPesquisa VARCHAR(50),
    @valorPesquisa VARCHAR(150)
)
RETURNS @resultado TABLE (
    codigo INT,
    nomePedido VARCHAR(100),
    descricao VARCHAR(255),
    cliente INT,
    valorTotal DECIMAL(10,2),
    estado VARCHAR(50),
    codigoCliente INT,
    nomeCliente VARCHAR(100),
    dataPedido DATE,
    quantidadeRegistros INT
)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @pedidos TABLE (
        codigo INT,
        nomePedido VARCHAR(100),
        descricao VARCHAR(255),
        cliente INT,
        valorTotal DECIMAL(10,2),
        estado VARCHAR(50),
        codigoCliente INT,
        nomeCliente VARCHAR(100),
        dataPedido DATE
    );

    INSERT INTO @pedidos
    SELECT 
        p.codigo,
        p.nome AS nomePedido,
        p.descricao,
        p.cliente,
        p.valorTotal,
        p.estado,
        c.codigo AS codigoCliente,
        c.nome AS nomeCliente,
        p.dataPedido
    FROM 
        pedido p
        JOIN cliente c ON p.cliente = c.codigo
    WHERE 
        (@tipoPesquisa = 'Cliente' AND p.cliente = TRY_CAST(@valorPesquisa AS INT)) OR
        (@tipoPesquisa = 'Estado' AND p.estado LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Data' AND p.dataPedido = TRY_CAST(@valorPesquisa AS DATE)) OR
        (@tipoPesquisa = 'Maior Que' AND p.valorTotal > TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Menor Que' AND p.valorTotal < TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR    
        (@tipoPesquisa = 'Todos');

    SET @count = (SELECT COUNT(*) FROM @pedidos);

    IF @count = 0
    BEGIN
        INSERT INTO @resultado (codigo, nomePedido, descricao, cliente, valorTotal, estado, codigoCliente, nomeCliente, dataPedido, quantidadeRegistros)
        VALUES (0, 'Nenhum registro encontrado', '', 0, 0.0, '', 0, '', NULL, 0);
    END
    ELSE
    BEGIN
        INSERT INTO @resultado
        SELECT 
            codigo,
            nomePedido,
            descricao,
            cliente,
            valorTotal,
            estado,
            codigoCliente,
            nomeCliente,
            dataPedido,
            @count AS quantidadeRegistros
        FROM @pedidos;
    END

    RETURN;
END;
GO


CREATE FUNCTION fn_buscar_produto (
    @tipoPesquisa VARCHAR(50),
    @valorPesquisa VARCHAR(150)
)
RETURNS @resultado TABLE (
    codigo INT,
    nome VARCHAR(50),
    categoria VARCHAR(30),
    descricao VARCHAR(100),
    valorUnitario DECIMAL(10,2),
    status VARCHAR(30),
    quantidade INT,
    refEstoque VARCHAR(50),
    quantidadeRegistros INT
)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @produtos TABLE (
        codigo INT,
        nome VARCHAR(50),
        categoria VARCHAR(30),
        descricao VARCHAR(100),
        valorUnitario DECIMAL(10,2),
        status VARCHAR(30),
        quantidade INT,
        refEstoque VARCHAR(50)
    );

    INSERT INTO @produtos
    SELECT 
        p.codigo,
        p.nome,
        p.categoria,
        p.descricao,
        p.valorUnitario,
        p.status,
        p.quantidade,
        p.refEstoque
    FROM 
        produto p
    WHERE 
        (@tipoPesquisa = 'Código' AND p.codigo = TRY_CAST(@valorPesquisa AS INT)) OR
        (@tipoPesquisa = 'Nome' AND p.nome LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Categoria' AND p.categoria LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Descricao' AND p.descricao LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Status' AND p.status LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Quantidade' AND p.quantidade = TRY_CAST(@valorPesquisa AS INT)) OR
        (@tipoPesquisa = 'Ref Estoque' AND p.refEstoque LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Valor Unitario Igual' AND p.valorUnitario = TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Valor Unitario Maior Que' AND p.valorUnitario > TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Valor Unitario Menor Que' AND p.valorUnitario < TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'Todos');

    SET @count = (SELECT COUNT(*) FROM @produtos);

    IF @count = 0
    BEGIN
        INSERT INTO @resultado (codigo, nome, categoria, descricao, valorUnitario, status, quantidade, refEstoque, quantidadeRegistros)
        VALUES (0, 'Nenhum registro encontrado', '', '', 0, '', 0, '', 0);
    END
    ELSE
    BEGIN
        INSERT INTO @resultado
        SELECT *, @count AS quantidadeRegistros
        FROM @produtos;
    END

    RETURN;
END;
GO

CREATE FUNCTION fn_buscar_equipamento (
    @tipoPesquisa VARCHAR(50),
    @valorPesquisa VARCHAR(150)
)
RETURNS @resultado TABLE (
    codigo INT,
    nome VARCHAR(50),
    descricao VARCHAR(100),
    fabricante VARCHAR(50),
    dataAquisicao DATE,
    quantidadeRegistros INT
)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @equipamentos TABLE (
        codigo INT,
        nome VARCHAR(50),
        descricao VARCHAR(100),
        fabricante VARCHAR(50),
        dataAquisicao DATE
    );

    INSERT INTO @equipamentos
    SELECT 
        e.codigo,
        e.nome,
        e.descricao,
        e.fabricante,
        e.dataAquisicao
    FROM 
        equipamento e
    WHERE 
        (@tipoPesquisa = 'Código' AND e.codigo = TRY_CAST(@valorPesquisa AS INT)) OR
        (@tipoPesquisa = 'Nome' AND e.nome LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Descricao' AND e.descricao LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Fabricante' AND e.fabricante LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Todos');

    SET @count = (SELECT COUNT(*) FROM @equipamentos);

    IF @count = 0
    BEGIN
        INSERT INTO @resultado (codigo, nome, descricao, fabricante, dataAquisicao, quantidadeRegistros)
        VALUES (0, 'Nenhum registro encontrado', '', '', NULL, 0);
    END
    ELSE
    BEGIN
        INSERT INTO @resultado
        SELECT *, @count AS quantidadeRegistros
        FROM @equipamentos;
    END

    RETURN;
END;
GO
CREATE FUNCTION fn_buscar_funcionario (
    @tipoPesquisa VARCHAR(50),
    @valorPesquisa VARCHAR(150)
)
RETURNS @resultado TABLE (
    CPF CHAR(11),
    nome VARCHAR(100),
    nivelAcesso VARCHAR(30),
    email VARCHAR(100),
    senha VARCHAR(30),
    dataNascimento DATE,
    telefone CHAR(12),
    cargo VARCHAR(30),
    horario VARCHAR(30),
    salario DECIMAL(10,1),
    dataAdmissao DATE,
    dataDesligamento DATE NULL,
    observacao VARCHAR(200) NULL,
    quantidadeRegistros INT
)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @funcionarios TABLE (
        CPF CHAR(11),
        nome VARCHAR(100),
        nivelAcesso VARCHAR(30),
        email VARCHAR(100),
        senha VARCHAR(30),
        dataNascimento DATE,
        telefone CHAR(12),
        cargo VARCHAR(30),
        horario VARCHAR(30),
        salario DECIMAL(10,1),
        dataAdmissao DATE,
        dataDesligamento DATE NULL,
        observacao VARCHAR(200) NULL
    );

    INSERT INTO @funcionarios
    SELECT 
        f.CPF,
        f.nome,
        f.nivelAcesso,
        f.email,
        f.senha,
        f.dataNascimento,
        f.telefone,
        f.cargo,
        f.horario,
        f.salario,
        f.dataAdmissao,
        f.dataDesligamento,
        f.observacao
    FROM 
        funcionario f
    WHERE 
        (@tipoPesquisa = 'nivelAcesso' AND f.nivelAcesso LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'cargo' AND f.cargo LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'horario' AND f.horario LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'salario igual' AND f.salario = TRY_CAST(@valorPesquisa AS DECIMAL(10,1))) OR
        (@tipoPesquisa = 'salario maior que' AND f.salario > TRY_CAST(@valorPesquisa AS DECIMAL(10,1))) OR
        (@tipoPesquisa = 'salario menor que' AND f.salario < TRY_CAST(@valorPesquisa AS DECIMAL(10,1))) OR
        (@tipoPesquisa = 'dataAdmissao' AND f.dataAdmissao = TRY_CAST(@valorPesquisa AS DATE)) OR
        (@tipoPesquisa = 'nome' AND f.nome LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Todos');

    SET @count = (SELECT COUNT(*) FROM @funcionarios);

    IF @count = 0
    BEGIN
        INSERT INTO @resultado (CPF, nome, nivelAcesso, email, senha, dataNascimento, telefone, cargo, horario, salario, dataAdmissao, dataDesligamento, observacao, quantidadeRegistros)
        VALUES ('', 'Nenhum registro encontrado', '', '', '', NULL, '', '', '', 0.0, NULL, NULL, '', 0);
    END
    ELSE
    BEGIN
        INSERT INTO @resultado
        SELECT 
            CPF,
            nome,
            nivelAcesso,
            email,
            senha,
            dataNascimento,
            telefone,
            cargo,
            horario,
            salario,
            dataAdmissao,
            dataDesligamento,
            observacao,
            @count AS quantidadeRegistros
        FROM @funcionarios;
    END
    RETURN;
END;
GO
CREATE FUNCTION fn_buscar_orcamento (
    @tipoPesquisa VARCHAR(50),
    @valorPesquisa VARCHAR(150)
)
RETURNS @resultado TABLE (
    codigo INT,
    nome VARCHAR(100),
    descricao VARCHAR(200),
    cliente INT,
    nomeCliente VARCHAR(100),
    valorTotal DECIMAL(10,2),
    formaPagamento VARCHAR(25),
    status VARCHAR(50),
    observacao VARCHAR(200) NULL,
    dataOrcamento DATE,
    quantidadeRegistros INT
)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @orcamentos TABLE (
        codigo INT,
        nome VARCHAR(100),
        descricao VARCHAR(200),
        cliente INT,
        nomeCliente VARCHAR(100), 
        valorTotal DECIMAL(10,2),
        formaPagamento VARCHAR(25),
        status VARCHAR(50),
        observacao VARCHAR(200) NULL,
        dataOrcamento DATE
    );

    INSERT INTO @orcamentos
    SELECT 
        o.codigo,
        o.nome,
        o.descricao,
        o.cliente,
        c.nome AS nomeCliente, -- Nome do cliente adicionado
        o.valorTotal,
        o.formaPagamento,
        o.status,
        o.observacao,
        o.dataOrcamento
    FROM 
        orcamento o
    JOIN
        cliente c ON o.cliente = c.codigo
    WHERE 
        (@tipoPesquisa = 'nome' AND o.nome LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'descricao' AND o.descricao LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'cliente' AND o.cliente = TRY_CAST(@valorPesquisa AS INT)) OR
        (@tipoPesquisa = 'valorTotal igual' AND o.valorTotal = TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'valorTotal maior que' AND o.valorTotal > TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'valorTotal menor que' AND o.valorTotal < TRY_CAST(@valorPesquisa AS DECIMAL(10,2))) OR
        (@tipoPesquisa = 'formaPagamento' AND o.formaPagamento LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'status' AND o.status LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'dataOrcamento' AND o.dataOrcamento = TRY_CAST(@valorPesquisa AS DATE)) OR
        (@tipoPesquisa = 'Todos');

    SET @count = (SELECT COUNT(*) FROM @orcamentos);

    IF @count = 0
    BEGIN
        INSERT INTO @resultado (codigo, nome, descricao, cliente, nomeCliente, valorTotal, formaPagamento, status, observacao, dataOrcamento, quantidadeRegistros)
        VALUES (0, 'Nenhum registro encontrado', '', 0, '', 0.0, '', '', NULL, NULL, 0);
    END
    ELSE
    BEGIN
        INSERT INTO @resultado
        SELECT 
            codigo,
            nome,
            descricao,
            cliente,
            nomeCliente,
            valorTotal,
            formaPagamento,
            status,
            observacao,
            dataOrcamento,
            @count AS quantidadeRegistros
        FROM @orcamentos;
    END
    RETURN;
END;
GO
CREATE FUNCTION fn_buscar_despesa (
    @tipoPesquisa VARCHAR(50),
    @valorPesquisa VARCHAR(150)
)
RETURNS @resultado TABLE (
    codigo INT,
    nome VARCHAR(200),
    tipo VARCHAR(50),
    pagamento VARCHAR(50),
    dataInicio DATE,
    dataVencimento DATE NULL,
    valor DECIMAL(12,2),
    estado VARCHAR(50),
    quantidadeRegistros INT
)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @despesas TABLE (
        codigo INT,
        nome VARCHAR(200),
        tipo VARCHAR(50),
        pagamento VARCHAR(50),
        dataInicio DATE,
        dataVencimento DATE NULL,
        valor DECIMAL(12,2),
        estado VARCHAR(50)
    );

    INSERT INTO @despesas
    SELECT 
        d.codigo,
        d.nome,
        d.tipo,
        d.pagamento,
        d.dataInicio,
        d.dataVencimento,
        d.valor,
        d.estado
    FROM 
        despesa d
    WHERE 
        (@tipoPesquisa = 'tipo' AND d.tipo LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'pagamento' AND d.pagamento LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'dataInicio' AND d.dataInicio = TRY_CAST(@valorPesquisa AS DATE)) OR
        (@tipoPesquisa = 'dataVencimento' AND d.dataVencimento = TRY_CAST(@valorPesquisa AS DATE)) OR
        (@tipoPesquisa = 'valor igual' AND d.valor = TRY_CAST(@valorPesquisa AS DECIMAL(12,2))) OR
        (@tipoPesquisa = 'valor maior que' AND d.valor > TRY_CAST(@valorPesquisa AS DECIMAL(12,2))) OR
        (@tipoPesquisa = 'valor menor que' AND d.valor < TRY_CAST(@valorPesquisa AS DECIMAL(12,2))) OR
        (@tipoPesquisa = 'estado' AND d.estado LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'nome' AND d.nome LIKE '%' + @valorPesquisa + '%') OR
        (@tipoPesquisa = 'Todos');

    SET @count = (SELECT COUNT(*) FROM @despesas);

    IF @count = 0
    BEGIN
        INSERT INTO @resultado (codigo, nome, tipo, pagamento, dataInicio, dataVencimento, valor, estado, quantidadeRegistros)
        VALUES (0, 'Nenhum registro encontrado', '', '', NULL, NULL, 0.0, '', 0);
    END
    ELSE
    BEGIN
        INSERT INTO @resultado
        SELECT 
            codigo,
            nome,
            tipo,
            pagamento,
            dataInicio,
            dataVencimento,
            valor,
            estado,
            @count AS quantidadeRegistros
        FROM @despesas;
    END
    RETURN;
END;
GO
CREATE FUNCTION fn_buscar_etiqueta (
    @codigoCliente INT,
    @codigoPedido INT
)
RETURNS @resultado TABLE (
    codigoPedido INT,
    nomePedido VARCHAR(100),
    descricaoPedido VARCHAR(255),
    valorTotal DECIMAL(10,2),
    estadoPedido VARCHAR(50),
    dataPedido DATE,
    codigoCliente INT,
    nomeCliente VARCHAR(100),
    telefoneCliente CHAR(11),
    emailCliente VARCHAR(100),
    statusPagamento VARCHAR(30),
    CEP CHAR(9),
    logradouro VARCHAR(150),
    bairro VARCHAR(150),
    localidade VARCHAR(100),
    UF CHAR(2),
    complemento VARCHAR(100),
    numero VARCHAR(20),
    codigoProduto INT,
    nomeProduto VARCHAR(50),
    categoriaProduto VARCHAR(30),
    descricaoProduto VARCHAR(100),
    valorUnitarioProduto DECIMAL(10,2),
	referenciaEstoque VARCHAR(50), 
	observacao VARCHAR(200),
    quantidadeProduto INT
)
AS
BEGIN
    -- Insere os dados do pedido, cliente, endereço e produtos correspondentes
    INSERT INTO @resultado
    SELECT 
        p.codigo AS codigoPedido,
        p.nome AS nomePedido,
        p.descricao AS descricaoPedido,
        p.valorTotal,
        p.estado AS estadoPedido,
        p.dataPedido,
        c.codigo AS codigoCliente,
        c.nome AS nomeCliente,
        c.telefone AS telefoneCliente,
        c.email AS emailCliente,
        p.statusPagamento,
        c.CEP,
        c.logradouro,
        c.bairro,
        c.localidade,
        c.UF,
        c.complemento,
        c.numero,
        prod.codigo AS codigoProduto,
        prod.nome AS nomeProduto,
        prod.categoria AS categoriaProduto,
        prod.descricao AS descricaoProduto,
        prod.valorUnitario AS valorUnitarioProduto,
		prod.refEstoque,
		p.observacao,
        pp.quantidade AS quantidadeProduto
    FROM 
        pedido p
        JOIN cliente c ON p.cliente = c.codigo
        JOIN produtosPedido pp ON p.codigo = pp.codigoPedido
        JOIN produto prod ON pp.codigoProduto = prod.codigo
    WHERE 
        p.codigo = @codigoPedido AND c.codigo = @codigoCliente;

    RETURN;
END;
GO

