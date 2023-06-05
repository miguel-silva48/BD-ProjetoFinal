DROP TABLE IF EXISTS Empresa.Origina;
DROP TABLE IF EXISTS Empresa.Produto;
DROP TABLE IF EXISTS Empresa.TipoProduto;
DROP TABLE IF EXISTS Empresa.Operario;
DROP TABLE IF EXISTS Empresa.Gerente;
DROP TABLE IF EXISTS Empresa.Funcionario;
DROP TABLE IF EXISTS Empresa.Seccao;
DROP TABLE IF EXISTS Empresa.Encomenda;
DROP TABLE IF EXISTS Empresa.Revendedor;
DROP TABLE IF EXISTS Empresa.Fornece;
DROP TABLE IF EXISTS Empresa.MateriaPrima;
DROP TABLE IF EXISTS Empresa.Fornecedor;
DROP SCHEMA IF EXISTS Empresa;	
GO

CREATE SCHEMA Empresa;
GO


-- Fornecedor
CREATE TABLE Empresa.Fornecedor(
    nif						INT		PRIMARY KEY	NOT NULL,
	email				    VARCHAR(30),
    morada                  VARCHAR(50),
	nome					VARCHAR(40),
);

-- MateriaPrima
CREATE TABLE Empresa.MateriaPrima(
	nome					VARCHAR(40),
	qualidade				VARCHAR(20),
	codigo					INT		PRIMARY KEY	NOT NULL,
);

-- Fornece
CREATE TABLE Empresa.Fornece(
	quantidade 				INT		NOT NULL,
	nif_fornecedor			INT		NOT NULL	FOREIGN KEY REFERENCES Empresa.Fornecedor(nif) ON DELETE CASCADE,
	codigo_materia_prima	INT		NOT NULL	FOREIGN KEY REFERENCES Empresa.MateriaPrima(codigo) ON DELETE CASCADE,
	PRIMARY KEY(nif_fornecedor, codigo_materia_prima),
);

-- Revendedor
CREATE TABLE Empresa.Revendedor(
    nif						INT		PRIMARY KEY	NOT NULL,
	email				    VARCHAR(30),
    morada                  VARCHAR(50),
	nome					VARCHAR(40),
);

-- Encomenda
CREATE TABLE Empresa.Encomenda(
	numero			INT		PRIMARY KEY		NOT NULL,
	data_			DATE,
	nif_revendedor  INT	FOREIGN KEY REFERENCES Empresa.Revendedor(nif) ON DELETE CASCADE,	
);

-- Seccao
CREATE TABLE Empresa.Seccao(
	designacao		VARCHAR(20)	UNIQUE NOT NULL CHECK (designacao in ('Corte', 'Costura','Montagem','Acabamento')),
	codigo			INT		PRIMARY KEY		NOT NULL,
);

-- Funcionario
CREATE TABLE Empresa.Funcionario(
	nif 			INT		CHECK (nif BETWEEN 000000000 AND 999999999),
	salario			DECIMAL(8,2),
	morada			VARCHAR(50),
	numeroCC		INT,
	nome			VARCHAR(40),
	ID				INT		PRIMARY KEY		NOT NULL,
);

-- Gerente
CREATE TABLE Empresa.Gerente(
	ID_funcionario	INT		PRIMARY KEY		FOREIGN KEY REFERENCES Empresa.Funcionario(ID) ON DELETE CASCADE,
	codigo_seccao	INT		FOREIGN KEY REFERENCES Empresa.Seccao(codigo),
);

-- Operario
CREATE TABLE Empresa.Operario(
	ID_funcionario	INT		PRIMARY KEY		NOT NULL	FOREIGN KEY REFERENCES Empresa.Funcionario(ID) ON DELETE CASCADE,
	codigo_seccao	INT		FOREIGN KEY REFERENCES Empresa.Seccao(codigo),
);

-- TipoProduto
CREATE TABLE Empresa.TipoProduto(
	custo_fabrico			DECIMAL(6,2)	NOT NULL,
	preco_venda				DECIMAL(6,2)	NOT NULL,
	categoria				VARCHAR(40)		PRIMARY KEY			NOT NULL,
);

-- Produto
CREATE TABLE Empresa.Produto(
	codigo_produto		 INT	PRIMARY KEY		NOT NULL,
	categoria_tipo		 VARCHAR(40)		FOREIGN KEY REFERENCES Empresa.TipoProduto(categoria) ON DELETE CASCADE,
	num_encomenda		 INT				FOREIGN KEY REFERENCES Empresa.Encomenda(numero) ON DELETE CASCADE,
);

-- Origina
CREATE TABLE Empresa.Origina(
	codigo_materia_prima	INT		NOT NULL	FOREIGN KEY REFERENCES Empresa.MateriaPrima(codigo),
	estado 					VARCHAR(20)			CHECK (estado IN ('em espera', 'em producao', 'concluido')) DEFAULT 'em espera',
	ID_funcionario			INT		NOT NULL	FOREIGN KEY REFERENCES Empresa.Operario(ID_Funcionario) ON DELETE CASCADE,
	codigo_produto			INT		NOT NULL	FOREIGN KEY REFERENCES Empresa.Produto(codigo_produto) ON DELETE CASCADE,
	PRIMARY KEY(ID_funcionario, codigo_materia_prima,codigo_produto),
);