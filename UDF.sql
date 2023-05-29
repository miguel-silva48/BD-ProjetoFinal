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

