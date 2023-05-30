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

go

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

go

--PRINT dbo.numEncomendasPorTipo('Tênis Runner Branco')

