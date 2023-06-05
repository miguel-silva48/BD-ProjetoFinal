
-- Impedir que 1 seccao tenha mais que 1 gerente
CREATE TRIGGER trig_gerente_seccao
ON Empresa.Gerente
AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT * FROM inserted AS I
                   JOIN Empresa.Gerente AS G ON I.codigo_seccao = G.codigo_seccao
                   WHERE I.ID_funcionario <> G.ID_funcionario)
            BEGIN
                RAISERROR ('ERRO: Ja existe um gerente para esta seccao!', 16, 1);
                ROLLBACK TRANSACTION;
            END;
    END;
GO


-- Nomear gerente quando um gerente é removido
CREATE TRIGGER trig_nomear_gerente
ON Empresa.Gerente
AFTER UPDATE, DELETE
AS
    BEGIN
        DECLARE @codigo_seccao INT;
        DECLARE @ID_novoFunc INT;
        SELECT @codigo_seccao = deleted.codigo_seccao
        FROM deleted;

        --Ir buscar o operario com o ID mais baixo da mesma secção
        SELECT @ID_novoFunc = MIN(ID_funcionario) 
        FROM Empresa.Operario AS O
        WHERE O.codigo_seccao = @codigo_seccao;

        IF EXISTS (SELECT * FROM Empresa.Operario AS O
                   WHERE O.codigo_seccao = @codigo_seccao)
            BEGIN
                INSERT INTO Empresa.Gerente VALUES (@ID_novoFunc, @codigo_seccao);
            END;
    END;
GO


-- Obrigar o salario de um operario a ser inferior ao do gerente da seccao
CREATE TRIGGER trig_salario_operario
ON Empresa.Operario
AFTER INSERT, UPDATE
AS
    BEGIN
		DECLARE @codigo INT;
		DECLARE @sal_gerente DECIMAL(8,2);
		DECLARE @sal_novoFunc DECIMAL (8,2);

		--Ir buscar a seccao em questao
		SELECT @codigo = codigo_seccao, @sal_novoFunc= salario FROM inserted AS I
		JOIN Empresa.Funcionario AS F ON I.ID_funcionario = F.ID;

		--Ir buscar o salario do gerente dessa seccao
		SELECT @sal_gerente=salario FROM Empresa.Funcionario AS F
		JOIN Empresa.Gerente AS G ON F.ID = G.ID_funcionario
		WHERE codigo_seccao = @codigo;

		IF (@sal_gerente <= @sal_novoFunc)
        
			BEGIN
                RAISERROR ('ERRO: Salario de operario tem que ser inferior ao do gerente da seccao!', 16, 1);
                ROLLBACK TRANSACTION;
            END;
    END;
GO