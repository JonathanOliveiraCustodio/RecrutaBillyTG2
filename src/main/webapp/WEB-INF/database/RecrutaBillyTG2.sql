USE master
--DROP DATABASE RecrutaBillyTG2
CREATE DATABASE RecrutaBillyTG2
GO
USE RecrutaBillyTG2 
GO
CREATE TABLE fornecedor(
codigo       INT           NOT NULL,
nome	     VARCHAR(50)   NOT NULL,
endereco     VARCHAR(50)   NOT NULL,
telefone	 CHAR(12)	   NOT NULL,
email         VARCHAR(100) NOT NULL, 
empresa		 VARCHAR(50)   NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE equipamento(
codigo				INT				NOT NULL,
nome				VARCHAR(50)		NOT NULL,
descricao			VARCHAR(100)	NOT NULL,
fabricante			VARCHAR(50)		NOT NULL,
dataManutencao		DATE			NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE insumo(
codigo			INT	        	NOT NULL,
nome			VARCHAR(100)    NOT NULL,
valor			DECIMAL(10,2)	NOT NULL,
quantidade		INT				NOT NULL,
unidade	     	VARCHAR(15)     NOT NULL,
fornecedor		INT				NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (fornecedor) REFERENCES fornecedor (codigo)
)
GO
CREATE TABLE usuario(
CPF         CHAR(11)		NOT NULL,
nome		VARCHAR(100)    NOT NULL,
nivelAcesso VARCHAR(30)     NOT NULL,
senha		VARCHAR(30)		NOT NULL,
email		varchar(100)	NOT NULL
PRIMARY KEY (CPF)
)
GO
CREATE TABLE produto(
codigo		   INT	         	NOT NULL,
nome		   VARCHAR(50)     NOT NULL,
categoria      VARCHAR(30) NOT NULL,
descricao      VARCHAR(100) NOT NULL,
valorUnitario  DECIMAL (10,2)  NOT NULL,
status		   VARCHAR(30)		NOT NULL,
quantidade	   INT				NOT NULL,
refEstoque     VARCHAR(50)     NOT NULL 
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
codigo			INT				NOT NULL,
nome			VARCHAR(100)	NOT NULL,
telefone		CHAR(12)		NOT NULL,
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
codigo	   INT		     		NOT NULL,
nome	   VARCHAR(MAX)		    NOT NULL,
descricao	   VARCHAR(MAX)		    NOT NULL,
cliente    INT  		  	    NOT NULL,
valorTotal DECIMAL(10,2)		NULL,
estado	   VARCHAR(100)		    NOT NULL,
dataPedido DATE					NULL	
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
-- Insert Usuario de Teste
INSERT INTO usuario (CPF,nome, nivelAcesso, senha, email) VALUES 
('25525320045','Administrador', 'admin', 'admin', 'admin'),
('76368440015','Evandro', 'admin', '123456', 'teste@teste.com'),
('37848890007','John', 'Funcion�rio', '123456', 'john@john.com')
GO
INSERT INTO cliente (codigo, nome, telefone, email, tipo, documento, CEP, logradouro, bairro, localidade, UF, complemento, numero, dataNascimento) VALUES
(1, 'Fabio de Lima', '11956432345', 'fdelima@email.com', 'CPF', '45230955074', '08120300', 'Rua Nogueira Viotti', 'Itaim Paulista', 'S�o Paulo', 'SP', NULL, '156B','1990-08-01'),
(2, 'Manoel Gon�alves Costa', '11983774561', 'manoelgoncosta@email.com', 'CPF', '14568711029', '09154900', 'Estrada de Ferro Santos Jundia�', 'Vila Elclor', 'Santo Andr�', 'SP', NULL, '45','1996-10-03'),
(3, 'Astolfo Melo de Cunha', '11984823716', 'astolfocunha@email.com', 'CNPJ', '70295892000180', '01531000', 'Rua da Gl�ria', 'Liberdade', 'S�o Paulo', 'SP', NULL, '234','2000-05-03'),
(4, 'Gabriela Bittencourt', '11965428657', 'gabiit@email.com', 'CNPJ', '32596552000109', '01002000', 'Rua Boa Vista', 'Centro', 'S�o Paulo', 'SP', NULL, '90','1997-11-01'),
(5, 'Yasmin Ribeiro Faganello', '11912438547', 'yasribeiro@email.com', 'CPF', '61837422010', '04050001', 'Avenida Jabaquara', 'Mirand�polis', 'S�o Paulo', 'SP', NULL, '452A','1984-02-02'),
(6, 'Rafaela Ferrari', '11943758121', 'raferrari@email.com', 'CPF', '28348483004', '01310000', 'Avenida Paulista', 'Bela Vista', 'S�o Paulo', 'SP', 'Apt 202', '1500','1945-08-08')
GO
INSERT INTO fornecedor (codigo, nome, endereco, telefone, email, empresa) VALUES
(1, 'Tech Solutions Ltda.', 'Rua das Inova��es, 123', '1234567890', 'contato@techsolutions.com', 'Tecnologia e Solu��es'),
(2, 'Eco Supply Co.', 'Avenida Sustent�vel, 456', '2345678901', 'contato@ecosupply.com', 'Fornecimento Ecol�gico'),
(3, 'ArtisanCraft Inc.', 'Pra�a dos Artes�os, 789', '3456789012', 'contato@artisancraft.com', 'Arte e Design'),
(4, 'Gourmet Essentials', 'Travessa dos Sabores, 101', '4567890123', 'contato@gourmetessentials.com', 'Alimentos Gourmet'),
(5, 'BioTech Innovations', 'Alameda da Ci�ncia, 202', '5678901234', 'contato@biotechinnovations.com', 'Inova��es Biom�dicas'),
(6, 'EduSmart Solutions', 'Avenida do Conhecimento, 303', '6789012345', 'contato@edusmart.com', 'Solu��es Educacionais'),
(7, 'Fashion Trends Inc.', 'Rua da Moda, 404', '7890123456', 'contato@fashiontrends.com', 'Tend�ncias de Moda'),
(8, 'GreenGrow Gardens', 'Estrada das Plantas, 505', '8901234567', 'contato@greengrowgardens.com', 'Jardins Sustent�veis'),
(9, 'TechNova Industries', 'Boulevard da Tecnologia, 606', '9012345678', 'contato@technovaindustries.com', 'Ind�stria Tecnol�gica'),
(10, 'Tranquil Retreats Ltd.', 'Rua da Serenidade, 707', '0123456789', 'contato@tranquilretreats.com', 'Retiros Tranquilos');
GO
INSERT INTO insumo (codigo, nome, valor, quantidade,unidade, fornecedor) VALUES
(1, 'Solvente', 30.00, 500,'ml', 1),
(2, 'Verniz', 50.00, 100,'ml', 2),
(3, 'Papel Offset', 15.00, 1000,'unidade', 3),
(4, 'Tinta Branca PU', 50.00, 50,'ml', 4),
(5, 'Tinta Preta PU', 40.00, 300,'ml', 5),
(6, 'Molecula Verrmelha', 25.00, 400,'kg', 1),
(7, 'Molecula Cinza', 120.00, 50,'kg', 8),
(8, 'Filamento Azul', 42.50, 200,'kg', 7),
(9, 'Poliester', 30.00, 10,'ml', 8),
(10, 'Tinta Met�lica', 20.10, 20,'ml', 6);
GO
INSERT INTO equipamento (codigo, nome, descricao, fabricante, dataManutencao) VALUES 
(1, 'Impressora Offset', 'Impressora Offset de alta velocidade', 'HP', '2024-04-27'),
(2, 'Guilhotina', 'Guilhotina de corte autom�tico', 'Guilhotinas S.A.', '2024-04-27'),
(3, 'Encadernadora', 'Encadernadora para acabamento de livros', 'Encaderna��es Ltda.', '2024-04-27'),
(4, 'M�quina de Corte e Vinco', 'M�quina para corte e vinco de papel�o', 'M�quinas Inc.', '2024-04-27'),
(5, 'Plotter de Impress�o', 'Plotter para impress�o de grandes formatos', 'Plotter Solutions', '2024-04-27'),
(6, 'Dobradeira', 'Dobradeira de papel autom�tica', 'Dobras & Cia.', '2024-04-27'),
(7, 'Laminadora', 'Laminadora para aplica��o de filmes pl�sticos', 'Laminadoras S.A.', '2024-04-27'),
(8, 'Grampeadora Autom�tica', 'Grampeadora autom�tica para acabamento de revistas', 'Grampeadoras Ltda.', '2024-04-27'),
(9, 'Sistema de Impress�o Digital', 'Impressora digital de alta resolu��o', 'Digital Print', '2024-04-27'),
(10, 'Fresadora CNC', 'Fresadora de controle num�rico computadorizado para usinagem de pe�as', 'CNC Solutions', '2024-04-27');
GO
INSERT INTO produto (codigo, nome, categoria, descricao, valorUnitario,status, quantidade,refEstoque) VALUES
(1, 'Caneca Personalizada', 'Utens�lio Dom�stico', 'Caneca de cer�mica com personaliza��o de foto ou texto.', 15.99,'Em Produ��o',2,'CX01'),
(2, 'Camiseta Personalizada', 'Vestu�rio', 'Camiseta de algod�o com estampa personalizada.', 24.99,'Em Produ��o',10,'CX02'),
(3, 'Calend�rio de Parede Personalizado', 'Papelaria', 'Calend�rio de parede personalizado com fotos.', 12.99,'N�o Aplic�vel',100,'CX05'),
(4, 'Caneta Personalizada', 'Papelaria', 'Caneta esferogr�fica com nome gravado.', 13.49,'Em Produ��o',100,'AR01'),
(5, 'Mouse Pad Personalizado', 'Acess�rio de Computador', 'Mouse pad com imagem personalizada.', 58.99,'N�o Aplic�vel',5,'CX10'),
(7, 'Caderno Personalizado', 'Papelaria', 'Caderno com capa personalizada.', 19.99, 'Em Produ��o',15,'CX03'),
(8, 'Almofada Personalizada', 'Decora��o', 'Almofada com foto personalizada.', 17.99, 'Em Produ��o',20,'CX02'),
(9, 'Chaveiro Personalizado', 'Acess�rio', 'Chaveiro com nome gravado.', 5.99,'N�o Aplic�vel',2,'AR01'),
(10, 'Patach emborrados', 'Emborachados', 'Emborachados personalizado com nome e tipo sanguineo.', 10.00,'N�o Aplic�vel',5,'AR01');
GO
CREATE PROCEDURE sp_iud_fornecedor
    @acao CHAR(1),
    @codigo INT,
    @nome VARCHAR(50),
    @endereco VARCHAR(50),
    @telefone CHAR(12),
    @email VARCHAR(100),
    @empresa VARCHAR(50),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM fornecedor WHERE codigo = @codigo)
        BEGIN
            RAISERROR('C�digo j� existe. N�o � poss�vel inserir o fornecedor.', 16, 1)
            RETURN
        END
        INSERT INTO fornecedor (codigo, nome, endereco, telefone, email, empresa)
        VALUES (@codigo, @nome, @endereco, @telefone, @email, @empresa)
        SET @saida = 'Fornecedor inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM fornecedor WHERE codigo = @codigo)
        BEGIN
            RAISERROR('C�digo n�o existe. N�o � poss�vel atualizar o fornecedor.', 16, 1)
            RETURN
        END

        UPDATE fornecedor
        SET nome = @nome, endereco = @endereco, telefone = @telefone, email = @email, empresa = @empresa
        WHERE codigo = @codigo
        SET @saida = 'Fornecedor alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM fornecedor WHERE codigo = @codigo)
        BEGIN
            RAISERROR('C�digo n�o existe. N�o � poss�vel excluir o fornecedor.', 16, 1)
            RETURN
        END

        DELETE FROM fornecedor WHERE codigo = @codigo
        SET @saida = 'Fornecedor exclu�do com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_equipamento
    @acao CHAR(1),
    @codigo INT,
    @nome VARCHAR(50),
    @descricao VARCHAR(100),
    @fabricante VARCHAR(50),
    @dataManutencao DATE,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM equipamento WHERE codigo = @codigo)
        BEGIN
            RAISERROR('C�digo j� existe. N�o � poss�vel inserir o equipamento.', 16, 1)
            RETURN
        END

        INSERT INTO equipamento (codigo, nome, descricao, fabricante, dataManutencao)
        VALUES (@codigo, @nome, @descricao, @fabricante, @dataManutencao)
        SET @saida = 'Equipamento inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM equipamento WHERE codigo = @codigo)
        BEGIN
            RAISERROR('C�digo n�o existe. N�o � poss�vel atualizar o equipamento.', 16, 1)
            RETURN
        END

        UPDATE equipamento
        SET nome = @nome,
            descricao = @descricao,
            fabricante = @fabricante,
            dataManutencao = @dataManutencao
        WHERE codigo = @codigo
        SET @saida = 'Equipamento alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM equipamento WHERE codigo = @codigo)
        BEGIN
            RAISERROR('C�digo n�o existe. N�o � poss�vel excluir o equipamento.', 16, 1)
            RETURN
        END

        DELETE FROM equipamento
        WHERE codigo = @codigo
        SET @saida = 'Equipamento exclu�do com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_insumo
    @acao CHAR(1),
    @codigo INT,
    @nome VARCHAR(100),
    @valor DECIMAL(10,2),
    @quantidade INT,
	@unidade VARCHAR(15),
    @fornecedor INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM insumo WHERE codigo = @codigo)
        BEGIN
            RAISERROR('C�digo j� existe. N�o � poss�vel inserir o insumo.', 16, 1)
            RETURN
        END
        INSERT INTO insumo (codigo, nome, valor, quantidade, unidade, fornecedor)
        VALUES (@codigo, @nome, @valor, @quantidade, @unidade, @fornecedor)
        SET @saida = 'Insumo inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM insumo WHERE codigo = @codigo)
        BEGIN
            RAISERROR('C�digo n�o existe. N�o � poss�vel atualizar o insumo.', 16, 1)
            RETURN
        END
        UPDATE insumo
        SET nome = @nome, valor = @valor, quantidade = @quantidade, unidade = @unidade, fornecedor = @fornecedor
        WHERE codigo = @codigo
        SET @saida = 'Insumo alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM insumo WHERE codigo = @codigo)
        BEGIN
            RAISERROR('C�digo n�o existe. N�o � poss�vel excluir o insumo.', 16, 1)
            RETURN
        END
        DELETE FROM insumo WHERE codigo = @codigo
        SET @saida = 'Insumo exclu�do com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_usuario
    @acao CHAR(1),
    @CPF CHAR(11),
    @nome VARCHAR(100),
    @nivelAcesso VARCHAR(30),
    @senha VARCHAR(30),
    @email VARCHAR(100),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM usuario WHERE CPF = @CPF)
        BEGIN
            RAISERROR('CPF j� existe. N�o � poss�vel inserir o usu�rio.', 16, 1)
            RETURN
        END

        INSERT INTO usuario (CPF, nome, nivelAcesso, senha, email)
        VALUES (@CPF, @nome, @nivelAcesso, @senha, @email)
        SET @saida = 'Usu�rio inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM usuario WHERE CPF = @CPF)
        BEGIN
            RAISERROR('CPF n�o existe. N�o � poss�vel atualizar o usu�rio.', 16, 1)
            RETURN
        END

        UPDATE usuario
        SET nome = @nome, nivelAcesso = @nivelAcesso, senha = @senha, email = @email
        WHERE CPF = @CPF
        SET @saida = 'Usu�rio alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM usuario WHERE CPF = @CPF)
        BEGIN
            RAISERROR('CPF n�o existe. N�o � poss�vel excluir o usu�rio.', 16, 1)
            RETURN
        END

        DELETE FROM usuario WHERE CPF = @CPF
        SET @saida = 'Usu�rio exclu�do com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_produto
@acao CHAR(1),
@codigo INT,
@nome VARCHAR(50),
@categoria VARCHAR(30),
@descricao VARCHAR(100),
@valorUnitario DECIMAL(10,2),
@status			VARCHAR(20),
@quantidade		INT, 
@refEstoque     VARCHAR(50),
@saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO produto (codigo, nome, categoria, descricao, valorUnitario,status, quantidade,refEstoque)
        VALUES (@codigo, @nome, @categoria, @descricao, @valorUnitario,@status, @quantidade,@refEstoque)
        SET @saida = 'Produto inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE produto
        SET nome = @nome, categoria = @categoria, descricao = @descricao, valorUnitario = @valorUnitario, status = @status, quantidade = @quantidade,refEstoque = @refEstoque
        WHERE codigo = @codigo
        SET @saida = 'Produto alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DELETE FROM produto WHERE codigo = @codigo
        SET @saida = 'Produto exclu�do com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
        RETURN
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
            RAISERROR('Rela��o produto-insumo j� existe. N�o � poss�vel inserir.', 16, 1)
            RETURN
        END

        INSERT INTO insumosProduto (codigoProduto, codigoInsumo,quantidade)
        VALUES (@codigoProduto, @codigoInsumo,@quantidade)
        SET @saida = 'Rela��o produto-insumo inserida com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM insumosProduto WHERE codigoProduto = @codigoProduto AND codigoInsumo = @codigoInsumo)
        BEGIN
            RAISERROR('Rela��o produto-insumo n�o existe. N�o � poss�vel atualizar.', 16, 1)
            RETURN
        END

        -- Atualizar a rela��o n�o faz sentido nesse contexto, mas se necess�rio, adicione o c�digo aqui
        SET @saida = 'Opera��o de atualiza��o n�o suportada para rela��o produto-insumo'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM insumosProduto WHERE codigoProduto = @codigoProduto AND codigoInsumo = @codigoInsumo)
        BEGIN
            RAISERROR('Rela��o produto-insumo n�o existe. N�o � poss�vel excluir.', 16, 1)
            RETURN
        END

        DELETE FROM insumosProduto 
        WHERE codigoProduto = @codigoProduto AND codigoInsumo = @codigoInsumo
        SET @saida = 'Rela��o produto-insumo exclu�da com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
        RETURN
    END
END

GO
CREATE PROCEDURE sp_iud_cliente(
    @acao CHAR(1), 
    @codigocliente INT, 
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
            RAISERROR('C�digo j� existe. N�o � poss�vel inserir o cliente.', 16, 1)
            RETURN
        END

        INSERT INTO cliente (codigo, nome, telefone, email, tipo, documento,CEP,logradouro,bairro,localidade,UF,complemento,numero,dataNascimento)
        VALUES (@codigocliente, @nome, @telefone, @email, @tipo, @documento,@CEP,@logradouro,@bairro,@localidade,@UF,@complemento,@numero,@dataNascimento)
        SET @saida = 'Cliente inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM cliente WHERE codigo = @codigocliente)
        BEGIN
            RAISERROR('C�digo n�o existe. N�o � poss�vel atualizar o cliente.', 16, 1)
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
            RAISERROR('C�digo n�o existe. N�o � poss�vel excluir o cliente.', 16, 1)
            RETURN
        END
        DELETE FROM cliente
        WHERE codigo = @codigocliente
        SET @saida = 'Cliente exclu�do com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_pedido(@acao CHAR(1), 
@codigopedido INT, 
@nomepedido VARCHAR(MAX),
@descricao VARCHAR(MAX),
@codigocliente INT,
@estado VARCHAR(100),
@saida VARCHAR(200) OUTPUT)
AS
BEGIN
	IF(@acao = 'I')
	BEGIN
		INSERT INTO pedido (codigo, nome,descricao, cliente, estado,dataPedido) VALUES
		(@codigopedido, @nomepedido,@descricao, @codigocliente, @estado,GETDATE())
		SET @saida = 'Pedido inserido com sucesso'
	END
	ELSE
	IF(@acao = 'U')
	BEGIN
		UPDATE pedido
		SET nome = @nomepedido,
		    descricao=@descricao,
			cliente = @codigocliente,
			estado = @estado
		WHERE codigo = @codigopedido
	END
	ELSE
	IF(@acao = 'D')
	BEGIN
		DELETE pedido
		WHERE codigo = @codigopedido
	END
	ELSE
	BEGIN
		RAISERROR('Opera��o inv�lida', 16, 1)
		RETURN
	END
END
GO
CREATE PROCEDURE sp_iud_produtos_pedido(@acao CHAR(1), @codigopedido INT, @codigoproduto INT, @quantidade INT, @saida VARCHAR(200) OUTPUT)
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
CREATE PROCEDURE sp_login_usuario
    @Email NVARCHAR(100),
    @Senha NVARCHAR(30),
    @Resultado NVARCHAR(100) OUTPUT,
    @NivelAcesso NVARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @SenhaDb NVARCHAR(30)  
    -- Verifica se o usu�rio existe e obt�m a senha armazenada
    SELECT @SenhaDb = senha, @NivelAcesso = nivelAcesso
    FROM usuario
    WHERE email = @Email

    -- Verifica se o usu�rio existe e a senha est� correta
    IF @SenhaDb IS NULL OR @SenhaDb != @Senha
    BEGIN
        SET @Resultado = 'Usu�rio ou senha incorretos'
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
    i.valor AS valorInsumo,
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
 SELECT codigo, nome, descricao, fabricante, dataManutencao FROM equipamento
);
GO
CREATE FUNCTION fn_produto()
RETURNS TABLE
AS
RETURN
(
 SELECT codigo, nome, categoria, descricao, valorUnitario, status, quantidade, refEstoque FROM produto
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
        dataManutencao
    FROM 
        equipamento
    WHERE
        codigo = @codigoEquipamento
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
CREATE VIEW v_pedidos
AS
SELECT p.codigo AS codigo_pedido, p.nome AS nome_pedido, p.cliente AS cliente_pedido, c.nome AS cliente_nome, 
p.estado AS estado, p.valorTotal, p.dataPedido, p.descricao
FROM pedido p, cliente c
WHERE p.cliente = c.codigo
GO
CREATE VIEW v_pedido_produto
AS
SELECT pp.codigoPedido AS codigo_pedido, p.codigo AS codigo_produto, p.nome AS nome_produto, p.categoria AS categoria_produto, p.descricao AS descricao_produto, p.valorUnitario AS valor_unitario, pp.quantidade
FROM produtosPedido pp, produto p
WHERE p.codigo = pp.codigoProduto
GO
CREATE VIEW v_usuario AS
SELECT 
    CPF,
    nome,
    nivelAcesso,
    senha,
    email
FROM 
    usuario;
GO
CREATE FUNCTION fn_listar_usuario_cpf(@CPF CHAR(11))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        CPF,
        nome,
        nivelAcesso,
        senha,
        email
    FROM 
        usuario
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
		RAISERROR('Impossivel alterar um pedido j� finalizado', 16, 1)
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
        RAISERROR ('N�o � poss�vel excluir o fornecedor porque ele est� associado a um ou mais insumos.', 16, 1);
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
    -- Verificar se o insumo est� sendo referenciado na tabela produtoInsumo
    IF EXISTS (
        SELECT 1 
        FROM deleted d
        JOIN insumosProduto pi ON d.codigo = pi.codigoInsumo
    )
    BEGIN
        -- Retornar mensagem de erro se houver refer�ncia
        RAISERROR ('N�o � poss�vel excluir o insumo porque ele est� associado a um ou mais produtos.', 16, 1);
        RETURN;
    END;

    -- Se n�o houver refer�ncia, prosseguir com a exclus�o
    DELETE FROM insumo
    WHERE codigo IN (SELECT codigo FROM deleted);
END
GO
CREATE TRIGGER t_cliente_pedido
ON cliente
INSTEAD OF DELETE
AS
BEGIN
    -- Verificar se o cliente est� sendo referenciado na tabela pedido
    IF EXISTS (
        SELECT 1 
        FROM deleted d
        JOIN pedido p ON d.codigo = p.cliente
    )
    BEGIN
        -- Retornar mensagem de erro se houver refer�ncia
        RAISERROR ('N�o � poss�vel excluir o cliente porque ele est� associado a um ou mais pedidos.', 16, 1);
        RETURN;
    END;
    -- Se n�o houver refer�ncia, prosseguir com a exclus�o
    DELETE FROM cliente
    WHERE codigo IN (SELECT codigo FROM deleted);
END
GO

SELECT * FROM insumosProduto