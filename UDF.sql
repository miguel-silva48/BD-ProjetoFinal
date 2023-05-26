
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


-- Ver numero de encomendas de um revendedor
CREATE FUNCTION dbo.numEncomendasRevendedor (@nif_revendedor INT)
RETURNS INT
    BEGIN
        DECLARE @numEncomendas INT;
        SELECT @numEncomendas = COUNT(*)
        FROM Empresa.Encomenda AS E
        WHERE E.nif_revendedor = @nif_revendedor;
    RETURN @numEncomendas;
END;
--Testar a funcao
--PRINT dbo.numEncomendasRevendedor(409111222)


-- Ver quantidade de produtos de uma encomenda
CREATE FUNCTION dbo.quantProdutosEncomenda (@numero_encomenda INT)
RETURNS INT
    BEGIN
        DECLARE @quantProdutos INT;
        SELECT @quantProdutos = SUM(quantidade)
        FROM Empresa.Produto AS P
        WHERE P.numero_encomenda = @numero_encomenda;
    RETURN @quantProdutos; --TODO num esquisito
END;
--Testar a funcao
--PRINT dbo.quantProdutosEncomenda(1)