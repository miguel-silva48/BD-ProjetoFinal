CREATE PROCEDURE RemoveFuncionario @id int
AS
    DELETE FROM Empresa.Funcionario WHERE ID = @id
go 

-- EXEC RemoveFuncionario 107


-- Retorna o numero processos em determinado estado de uma seccao
CREATE PROCEDURE getNumEstadoBySeccao (@codigo INT, @estado VARCHAR(20), @numEstado INT OUTPUT)
AS
    SELECT @numEstado = COUNT(estado) 
	FROM Empresa.Processa JOIN (Empresa.Funcionario JOIN Empresa.Operario ON ID=ID_funcionario) ON Processa.ID_funcionario = ID
	WHERE estado = @estado AND codigo_seccao = @codigo
go 

--DECLARE @numEstado INT; 
--EXEC getNumEstadoBySeccao 4,'em producao', @numEstado OUTPUT; 
--PRINT @numEstado