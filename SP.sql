-- Retorna o numero processos em determinado estado de uma seccao
--DROP PROC getNumEstadoBySeccao;
--go

CREATE PROCEDURE getNumEstadoBySeccao (@codigo INT, @numEmEspera INT OUTPUT, @numEmProducao INT OUTPUT, @numConcluido INT OUTPUT)
AS
    SELECT @numEmEspera = COUNT(estado) 
	FROM Empresa.Origina JOIN Empresa.Operario ON Origina.ID_funcionario=Operario.ID_funcionario
	WHERE estado = 'em espera' AND codigo_seccao = @codigo

	SELECT @numEmProducao = COUNT(estado) 
	FROM Empresa.Origina JOIN Empresa.Operario ON Origina.ID_funcionario=Operario.ID_funcionario
	WHERE estado = 'em producao' AND codigo_seccao = @codigo

	SELECT @numConcluido = COUNT(estado) 
	FROM Empresa.Origina JOIN Empresa.Operario ON Origina.ID_funcionario=Operario.ID_funcionario
	WHERE estado = 'concluido' AND codigo_seccao = @codigo
go 

--DECLARE @numEmEspera INT; 
--DECLARE @numEmProducao INT; 
--DECLARE @numConcluido INT; 
--EXEC getNumEstadoBySeccao 4, @numEmEspera OUTPUT, @numEmProducao OUTPUT, @numConcluido OUTPUT; 
--PRINT @numEmEspera
--PRINT @numEmProducao
--PRINT @numConcluido


-- Quantidade materiaPrima fornecida por Fornecedor
CREATE PROCEDURE getMateriaPrimaFornecida (@nif INT, @num INT OUTPUT)
AS
	SELECT @num=SUM(quantidade) FROM Empresa.Fornece
	WHERE nif_fornecedor=@nif
GO

--DECLARE @num INT
--EXEC getMateriaPrimaFornecida 509111222, @num OUTPUT
--PRINT @num


-- Num encomendas e quantidade total de produtos encomendados por Revendedor
CREATE PROCEDURE getEncomendasRevendedor (@nif INT, @num INT OUTPUT, @quantidade INT OUTPUT)
AS
	--Numero de Encomendas
	SELECT @num=COUNT(*) FROM Empresa.Encomenda
	WHERE nif_revendedor=@nif
	
	--Quantidade total de Produtos (todas as Encomendas)
	SELECT @quantidade=COUNT(codigo_produto) FROM Empresa.Encomenda
	JOIN Empresa.Produto ON Encomenda.numero=Produto.num_encomenda
	WHERE nif_revendedor=@nif
GO

--DECLARE @num INT
--DECLARE @quantidade INT
--EXEC getEncomendasRevendedor 409111222, @num OUTPUT, @quantidade OUTPUT
--PRINT @num
--PRINT @quantidade


-- Media Salarial por Seccao
CREATE PROCEDURE getMediaSalarialBySeccao (@codigo INT, @media INT OUTPUT)
AS
	SELECT @media=AVG(salario) FROM Empresa.Operario JOIN Empresa.Funcionario ON Operario.ID_funcionario=Funcionario.ID
	WHERE codigo_seccao=@codigo
GO

-- DECLARE @media INT
-- Exec getMediaSalarialBySeccao 4, @media OUTPUT
-- PRINT @media



-- Tipo de Produto mais encomendado
CREATE PROCEDURE getCategoriaProdutoMaisEncomendado (@categoria VARCHAR(40) OUTPUT)
AS
	SELECT TOP 1 @categoria=categoria_tipo FROM Empresa.Encomenda JOIN Empresa.Produto ON Encomenda.numero=Produto.num_encomenda
	GROUP BY categoria_tipo
	ORDER BY COUNT(*) DESC
GO

-- DECLARE @categoria VARCHAR(20)
-- EXEC getCategoriaProdutoMaisEncomendado @categoria OUTPUT
-- PRINT @categoria


-- Remove Funcionario (on delete cascade garante que tambem remove de gerente ou operario)
CREATE PROCEDURE RemoveFuncionario @id int
AS
    DELETE FROM Empresa.Funcionario WHERE ID = @id
go 

--EXEC RemoveFuncionario 107

go


-- Adiciona Funcionario
CREATE PROCEDURE AddFuncionario @nif int, @salario DECIMAL(8,2), @morada varchar(50), @numeroCC int, @nome VARCHAR(40), @ID int, @isGerente INT, @codigo_seccao int
AS
    INSERT INTO Empresa.Funcionario
	VALUES 
	(@nif, @salario, @morada, @numeroCC, @nome, @ID);

	IF @isGerente = 1
		INSERT INTO Empresa.Gerente
		VALUES 
		(@ID, @codigo_seccao);
	ELSE
		INSERT INTO Empresa.Operario
		VALUES 
		(@ID, @codigo_seccao);
go 

--EXEC AddFuncionario 690972623, 900, 'Rua da Redonda Azul 9',29309021, 'Jéssica Oliveira Silva', 107, 0, 4;


-- Retorna secções
CREATE PROCEDURE getSeccoes
AS
	SELECT *,dbo.numFuncionariosSeccao(designacao) AS numFunc FROM Empresa.Seccao