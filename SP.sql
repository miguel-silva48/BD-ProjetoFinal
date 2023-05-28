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
	SELECT @num=COUNT(*) FROM Empresa.Fornece
	WHERE nif_fornecedor=@nif
go

--DECLARE @num INT
--EXEC getMateriaPrimaFornecida 509111222, @num OUTPUT
--PRINT @num