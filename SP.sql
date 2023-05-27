-- Retorna o numero processos em determinado estado de uma seccao
CREATE PROCEDURE getNumEstadoBySeccao (@codigo INT, @estado VARCHAR(20), @numEstado INT OUTPUT)
AS
    SELECT @numEstado = COUNT(estado) 
	FROM Empresa.Processa JOIN Empresa.Operario ON Processa.ID_funcionario=Operario.ID_funcionario
	WHERE estado = @estado AND codigo_seccao = @codigo
go 

--DECLARE @numEstado INT; 
--EXEC getNumEstadoBySeccao 4,'em producao', @numEstado OUTPUT; 
--PRINT @numEstado

-- Quantidade materiaPrima fornecida por Fornecedor
CREATE PROCEDURE getMateriaPrimaFornecida (@nif INT, @num INT OUTPUT)
AS
	SELECT @num=COUNT(*) FROM Empresa.Fornece
	WHERE nif_fornecedor=@nif
go

--DECLARE @num INT
--EXEC getMateriaPrimaFornecida 509111222, @num OUTPUT
--PRINT @num