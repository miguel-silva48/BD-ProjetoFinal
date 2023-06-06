--*UDFs*
-- Ver numero funcionarios numa seccao
CREATE FUNCTION dbo.numFuncionariosSeccao (@designacao VARCHAR(20))
RETURNS INT
	BEGIN
		DECLARE @numOperarios INT;
        DECLARE @numGerentes INT;

        --Contar operarios
		SELECT @numOperarios = COUNT(*)
		FROM Empresa.Operario AS O
		JOIN Empresa.Seccao AS S ON O.codigo_seccao = S.codigo
		WHERE S.designacao = @designacao;

        --Contar gerentes que nao sejam operarios (improvavel que aconteca segundos os inserts atuais)
        SELECT @numGerentes = COUNT(*)
        FROM Empresa.Gerente AS G
        JOIN Empresa.Seccao AS S ON G.codigo_seccao = S.codigo
        WHERE S.designacao = @designacao
        AND G.ID_funcionario NOT IN (SELECT O.ID_funcionario FROM Empresa.Operario AS O);

	RETURN (@numOperarios + @numGerentes);
END;
GO
--Testar a funcao
--PRINT dbo.numFuncionariosSeccao('Costura')

-- Numero de produtos por tipo
CREATE FUNCTION dbo.numProdutosPorTipo (@categoria VARCHAR(40))
RETURNS INT
	BEGIN
		DECLARE @numProdutos INT;
        
		SELECT @numProdutos = COUNT(*)
		FROM Empresa.Produto
		WHERE categoria_tipo = @categoria

	RETURN @numProdutos
END;
GO

-- PRINT dbo.numProdutosPorTipo('Tênis Runner Branco')

-- Numero de encomendas por tipo de produto
CREATE FUNCTION dbo.numEncomendasPorTipo (@categoria VARCHAR(40))
RETURNS INT
	BEGIN
		DECLARE @numEncomendas INT;
        
		SELECT @numEncomendas = COUNT(DISTINCT num_encomenda)
		FROM Empresa.Produto
		WHERE categoria_tipo = @categoria

	RETURN @numEncomendas
END;
GO
--PRINT dbo.numEncomendasPorTipo('Tênis Runner Branco')



--*SPs*

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
GO 
--DECLARE @numEmEspera INT; 
--DECLARE @numEmProducao INT; 
--DECLARE @numConcluido INT; 
--EXEC getNumEstadoBySeccao 4, @numEmEspera OUTPUT, @numEmProducao OUTPUT, @numConcluido OUTPUT; 
--PRINT @numEmEspera
--PRINT @numEmProducao
--PRINT @numConcluido

-- Retorna os processos de cada secção
CREATE PROCEDURE getProcessos (@seccao INT)
AS
	SELECT Origina.ID_funcionario, codigo_produto, codigo_materia_prima, estado 
	FROM Empresa.Origina JOIN Empresa.Operario ON Origina.ID_funcionario=Operario.ID_funcionario
	WHERE codigo_seccao = @seccao
GO
-- EXEC getProcessos 4


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


-- Retorna secções
CREATE PROCEDURE getSeccoes
AS
	SELECT designacao, codigo, nome, dbo.numFuncionariosSeccao(designacao) AS numFunc 
	FROM Empresa.Seccao JOIN Empresa.Gerente ON codigo=codigo_seccao 
	JOIN Empresa.Funcionario ON ID_funcionario=ID
GO

-- Retorna gerentes
CREATE PROCEDURE getGerentes (@seccao INT)
AS
	IF @seccao BETWEEN 1 AND 4
		SELECT * FROM (Empresa.Gerente JOIN Empresa.Funcionario ON ID_Funcionario=ID) JOIN Empresa.Seccao ON codigo_seccao=codigo
		WHERE codigo_seccao = @seccao
	ELSE
	BEGIN
		SELECT * FROM (Empresa.Gerente JOIN Empresa.Funcionario ON ID_Funcionario=ID) JOIN Empresa.Seccao ON codigo_seccao=codigo
	END
GO

-- Retorna operarios
CREATE PROCEDURE getOperarios (@seccao INT)
AS
	IF @seccao BETWEEN 1 AND 4
		SELECT * FROM (Empresa.Operario JOIN  Empresa.Seccao ON codigo_seccao=codigo) JOIN Empresa.Funcionario ON ID_Funcionario=ID 
		WHERE Operario.ID_funcionario NOT IN (SELECT Gerente.ID_funcionario FROM Empresa.Gerente) AND codigo_seccao = @seccao
	ELSE
	BEGIN
		SELECT * FROM (Empresa.Operario JOIN  Empresa.Seccao ON codigo_seccao=codigo) JOIN Empresa.Funcionario ON ID_Funcionario=ID 
		WHERE Operario.ID_funcionario NOT IN (SELECT Gerente.ID_funcionario FROM Empresa.Gerente)
	END 
GO

-- Retorna tipos de produto
CREATE PROCEDURE getTiposProduto
AS
	SELECT * , dbo.numProdutosPorTipo(categoria) AS numProdutos, dbo.numEncomendasPorTipo(categoria) AS numEncomendas
	FROM Empresa.TipoProduto
GO

--Retorna todos os fornecedores
CREATE PROCEDURE getFornecedores	
AS
	SELECT * FROM Empresa.Fornecedor
GO

--Retorna todos os revendedores
CREATE PROCEDURE getRevendedores
AS
	SELECT * FROM Empresa.Revendedor
GO


-- INSERTS, DELETES, UPDATES

-- Remove Funcionario (on delete cascade garante que tambem remove de gerente ou operario)
CREATE PROCEDURE RemoveFuncionario @id int
AS
    DELETE FROM Empresa.Funcionario WHERE ID = @id
GO 
--EXEC RemoveFuncionario 107


-- Adiciona Funcionario
CREATE PROCEDURE AddFuncionario @nif int, @salario DECIMAL(8,2), @morada varchar(50), @numeroCC int, @nome VARCHAR(40), @isGerente INT, @codigo_seccao int
AS
	IF (@morada = '') SET @morada = NULL

	DECLARE @ID_seguinte INT
	SELECT @ID_seguinte = MAX(ID)+1 FROM Empresa.Funcionario

	BEGIN TRANSACTION

    INSERT INTO Empresa.Funcionario
	VALUES 
	(@nif, @salario, @morada, @numeroCC, @nome, @ID_seguinte);

	IF @isGerente = 1
	BEGIN
		INSERT INTO Empresa.Gerente
		VALUES 
		(@ID_seguinte, @codigo_seccao);
		COMMIT TRAN
	END
	ELSE IF @isGerente = 0
	BEGIN
		INSERT INTO Empresa.Operario
		VALUES 
		(@ID_seguinte, @codigo_seccao);
		COMMIT TRAN
	END
	ELSE
    BEGIN
		RAISERROR ('ERRO: Deve informar se o funcionário é gerente ou não!', 16, 1);
        ROLLBACK TRANSACTION
    END
GO 
--EXEC AddFuncionario 690972623, 900, 'Rua da Redonda Azul 9',29309021, 'Jéssica Oliveira Silva', 107, 0, 4;

-- Atualizar funcionario
CREATE PROCEDURE updateFuncionario @salario DECIMAL(8,2), @ID int, @isGerente INT, @codigo_seccao int
AS
    BEGIN TRANSACTION
    UPDATE Empresa.Funcionario SET salario=@salario WHERE ID=@ID

    IF @isGerente = 1
    BEGIN
        UPDATE Empresa.Gerente SET codigo_seccao=@codigo_seccao WHERE ID_funcionario=@ID
        COMMIT TRAN
    END
    ELSE IF @isGerente = 0
    BEGIN
		DELETE Empresa.Gerente WHERE ID_funcionario=@ID
        UPDATE Empresa.Operario SET codigo_seccao=@codigo_seccao WHERE ID_funcionario=@ID
        COMMIT TRAN
    END
    ELSE
    BEGIN
		RAISERROR ('ERRO: Deve informar se o funcionário é gerente ou não!', 16, 1);
        ROLLBACK TRANSACTION
    END
GO

--Remove um fornecedor
CREATE PROCEDURE removeFornecedor (@nif INT)
AS
	DELETE FROM Empresa.Fornecedor
	WHERE nif=@nif
GO

-- Update fornecedor
CREATE PROCEDURE updateFornecedor (@nif INT, @email VARCHAR(30), @morada VARCHAR(50), @nome VARCHAR(40))
AS
	IF (@email = '') 
	BEGIN	
		SET @email = null
	END

	IF (@morada = '') 
	BEGIN	
		SET @morada = null
	END

	IF (@nome = '') 
	BEGIN	
		SET @nome = null
	END

	UPDATE Empresa.Fornecedor SET nome=@nome, morada=@morada, email=@email WHERE nif=@nif
GO

--Remove um revendedor
CREATE PROCEDURE removeRevendedor (@nif INT)
AS
	DELETE FROM Empresa.Revendedor
	WHERE nif=@nif
GO

-- Update revendedor
CREATE PROCEDURE updateRevendedor (@nif INT, @email VARCHAR(30), @morada VARCHAR(50), @nome VARCHAR(40))
AS
	IF (@email = '') 
	BEGIN	
		SET @email = null
	END

	IF (@morada = '') 
	BEGIN	
		SET @morada = null
	END

	IF (@nome = '') 
	BEGIN	
		SET @nome = null
	END

	UPDATE Empresa.Revendedor SET nome=@nome, morada=@morada, email=@email WHERE nif=@nif
GO

-- Adiciona tipo de produto
CREATE PROCEDURE addProduto @custo_fabrico DECIMAL(6,2), @preco_venda DECIMAL(6,2), @categoria VARCHAR(40)
AS
    INSERT INTO Empresa.TipoProduto (custo_fabrico, preco_venda, categoria)
	VALUES
    (@custo_fabrico, @preco_venda,  @categoria);
GO 

-- Remover um tipo de produto e por cascade todos os produtos que são desse tipo
CREATE PROCEDURE removeTipoProduto (@categoria VARCHAR(40))
AS
    DELETE FROM Empresa.TipoProduto
    WHERE categoria=@categoria
GO
--EXEC removeTipoProduto 'Tênis Runner Branco'

-- Update tipo de produto
CREATE PROCEDURE updateProduto (@categoria VARCHAR(40), @custo_fabrico DECIMAL(6,2), @preco_venda DECIMAL(6,2))
AS
	UPDATE Empresa.TipoProduto SET custo_fabrico = @custo_fabrico, preco_venda = @preco_venda 
	WHERE categoria = @categoria;
GO
