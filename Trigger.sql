
-- Impedir que 1 seccao tenha mais que 1 gerente
CREATE TRIGGER trig_gerente_seccao
ON Empresa.Gerente
AFTER INSERT, UPDATE
AS
    BEGIN
    --TODO explicar raciocínio
        IF EXISTS (SELECT * FROM inserted AS I
                   JOIN Empresa.Gerente AS G ON I.codigo_seccao = G.codigo_seccao
                   WHERE I.ID_funcionario <> G.ID_funcionario)
            BEGIN
                RAISERROR ('ERRO: Ja existe um gerente para esta seccao!', 16, 1);
                ROLLBACK TRANSACTION;
            END;
    END;


--TODO arranjar
-- Nomear gerente quando um gerente é removido
CREATE TRIGGER trig_nomear_gerente
ON Empresa.Gerente
AFTER DELETE
AS
    BEGIN
        DECLARE @codigo_seccao INT;
        DECLARE @ID_funcionario INT;
        SELECT @codigo_seccao = deleted.codigo_seccao --, @ID_funcionario = deleted.ID_funcionario
        FROM deleted;

        --Ir buscar o operario com o ID mais baixo
        SELECT @ID_funcionario = MIN(ID_funcionario) 
        FROM Empresa.Operario AS O
        WHERE O.codigo_seccao = @codigo_seccao;

        IF EXISTS (SELECT * FROM Empresa.Operario AS O
                   WHERE O.codigo_seccao = @codigo_seccao)
            BEGIN
                UPDATE Empresa.Operario
                SET ID_gerente = @ID_funcionario
                WHERE codigo_seccao = @codigo_seccao;
            END;
    END;


--TODO arranjar
-- Impedir que salario de opearrio seja superior ao do gerente da seccao
CREATE TRIGGER trig_salario_operario
ON Empresa.Operario
AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT * FROM inserted AS I
                   JOIN Empresa.Gerente AS G ON I.codigo_seccao = G.codigo_seccao
                   JOIN Empresa.Funcionario AS F ON I.ID_funcionario = F.ID
                   WHERE I.salario > G.salario)
            BEGIN
                RAISERROR ('ERRO: Salario de operario nao pode ser superior ao do gerente da seccao!', 16, 1);
                ROLLBACK TRANSACTION;
            END;
    END;
