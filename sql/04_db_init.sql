INSERT INTO Empresa.Fornecedor (nif, email, morada, nome)
	VALUES
	(509111222,'CouroBom@gmail.com',NULL,'CouroBom'),
	(509121212,'TextilFerreira@gmail.com','Rua do Complexo Grande - Edf 3','TextilFerreira'),
	(509294734,'PlasticoLDA@gmail.com','Rua Poente 723','PlasticoLDA'),
	(509827353,'PortoPlasticos@gmail.com',NULL,'PortoPlasticos'),
	(509836433,'sinteticoscoimbra@gmail.com','Rua Sol Poente 6243','Sinteticos Coimbra'),
	(509987654,'MaduTex@gmail.com','Estrada da Cincunvalacao 213','MaduTex'),
	(590972623,'winiw@gmail.com', 'Rua da Recta 233','Winiw');

INSERT INTO Empresa.MateriaPrima (nome, qualidade, codigo)
	VALUES
	('Couro','Primeira', 101),
    ('Couro','Segunda', 102),
    ('Couro','Terceira', 103),
    ('Couro Sintético', NULL, 200),
    ('Tecido', NULL, 600),
    ('Pele','Primeira', 301),
    ('Pele','Segunda', 302),
    ('Vinil',NULL, 400),
    ('PVC','Segunda', 502);

INSERT INTO Empresa.Fornece (quantidade, nif_fornecedor, codigo_materia_prima)
	VALUES
	(300, 509111222, 101),
	(400, 509111222, 102),
	(350, 509111222, 103),
	(300, 509121212, 200),
	(300, 509121212, 600),
	(250, 509294734, 301),
	(280, 509294734, 302),
	(190, 509294734, 400),
	(220, 509827353, 502);

INSERT INTO Empresa.Revendedor (nif, email, morada, nome)
	VALUES
	(409111222,'SapatariaBrasileira@gmail.com',NULL,'Sapataria Brasileira'),
	(409121212,'SapatosRia@gmail.com','Rua do Complexo Pequeno - Edf 4','Sapatos Ria'),
	(409294734,'softcalcados@gmail.com','Rua Poente 843','Soft Calçados'),
	(409827353,'PortoCalcados@gmail.com',NULL,'PortoCalcados'),
	(409836433,'sportsnow@gmail.com','Rua Sol 3243','Sports Now'),
	(409987654,'playsports@gmail.com','Estrada de Fátima 263','PlaySports'),
	(490972623,'klein@gmail.com', 'Rua da Redonda 90','Klein');

INSERT INTO Empresa.Encomenda (numero, data_, nif_revendedor)
	VALUES
	(1, '2019-01-01', 409111222),
	(2, '2019-02-01', 409111222),
	(3, '2019-01-21', 409836433),
	(4, '2019-01-25', 409827353),
	(5, '2019-03-01', 409111222),
	(6, '2019-04-01', 490972623),
	(7, '2019-05-01', 490972623),
	(8, '2019-05-01', 409121212),
	(9, '2019-06-01', 409121212);



INSERT INTO Empresa.Seccao (designacao, codigo)
	VALUES
	('Corte',1),
	('Costura',2),
	('Montagem',3),
	('Acabamento',4);


INSERT INTO Empresa.Funcionario (nif, salario, morada, numeroCC, nome, ID)
	VALUES
	(609111222, 1400, NULL,  12345678,'Nuno Miguel Farias',  101),
	(609121212, 1500,  'Rua do Complexo Pequeno - Edf 1',78931289,'José Carlos Costa', 102),
	(609294734, 1450, 'Rua Poente 846', 12378791,'João Miguel Arruda', 103),
	(609827353, 1300,  NULL,73828291,'Felipe Manoel do Carmo', 104),
	(609836433, 1000,  'Rua Sol 323',90901111,'Maria Gomes de Sousa', 105),
	(609987654, 1000,  'Estrada de Fátima 23',11888912,'Miguel Silva do Campo', 106),
	(690972623, 900, 'Rua da Redonda Azul 9',29309021, 'Jéssica Oliveira Silva', 107),
	(609836437, 1000,  'Rua Lua 323',90901111,'Joana Gomes da Silva', 108),
	(609987657, 1000, 'Estrada de Santiago 23',11888912, 'Roberto Castro Almeida', 109),
	(690972627, 900,  'Rua de Coimbra 91',29309021,'Inês Oliveira Silva', 110);


INSERT INTO Empresa.Gerente (ID_funcionario, codigo_seccao)
	VALUES
	(101, 1),
	(102, 2),
	(103, 3),
	(104, 4);

INSERT INTO Empresa.Operario (ID_funcionario, codigo_seccao)
	VALUES
	(101, 1),
	(102, 2),
	(103, 3),
	(104, 4),
	(105, 1),
	(106, 2),
	(107, 4),
	(108, 3),
	(109, 4),
	(110, 3);


INSERT INTO Empresa.TipoProduto (custo_fabrico, preco_venda, categoria)
	VALUES
    (50, 100, 'Bota Timber Castanha'),
	(52, 101,'Bota Timber Preta'),
    (52, 101,'Bota Timber Branca'),
	(25, 40, 'Sandália Confort Branca'),
    (25, 40, 'Sandália Confort Azul'),
	(33, 45, 'Sandália Confort Preta'),
	(44, 80, 'Sapato Elegante Preto'),
	(44, 80, 'Sapato Elegante Branco'),
	(44, 80, 'Sapato Elegante Castanho'),    
	(35, 70, 'Sapato Confort Preto'),
	(35, 70, 'Sapato Confort Branco'),
	(35, 70, 'Sapato Confort Castanho'),
	(15, 30,'Sapatilha Kid Adventure Azul'),
	(15, 30,'Sapatilha Kid Adventure Amarela'),
	(15, 30,'Sapatilha Kid Adventure Verde'),
	(15, 30,'Sapatilha Kid Adventure Preta'),
	(47, 80,'Tênis Runner Azul'),
    (47, 80,'Tênis Runner Branco'),
    (47, 80,'Tênis Runner Castanho'),
    (47, 80,'Tênis Runner Preto');


INSERT INTO Empresa.Produto (codigo_produto, categoria_tipo, num_encomenda)
    VALUES	
	(10001,'Bota Timber Castanha', 1),
	(10002,'Sapatilha Kid Adventure Preta', 1),
	(10003,'Tênis Runner Branco', 2),
	(10004,'Tênis Runner Branco', 3),
	(10005,'Tênis Runner Castanho', 4),
	(10006,'Bota Timber Branca', 5),
	(10007,'Bota Timber Branca', 6),
	(10008,'Sapatilha Kid Adventure Verde', 6),
	(10009,'Sapatilha Kid Adventure Verde', 7),
	(10010,'Sandália Confort Azul', 8),
	(10011,'Sapato Confort Preto', 9),
	(10012,'Sapato Confort Preto',9),
	(10013,'Sapato Confort Preto',8),
	(10014,'Tênis Runner Preto',6),
	(10015,'Tênis Runner Castanho', 4),
	(10016,'Bota Timber Branca', 5),
	(10017,'Bota Timber Branca', 6),
	(10018,'Sapatilha Kid Adventure Verde', 6),
	(10019,'Sapatilha Kid Adventure Verde', 7),
	(10020,'Bota Timber Castanha', 1),
	(10021,'Bota Timber Castanha', 1),
	(10022,'Sapatilha Kid Adventure Preta', 1),
	(10023,'Tênis Runner Branco', 2),
	(10024,'Tênis Runner Branco', 3),
	(10025,'Tênis Runner Castanho', 4),
	(10026,'Bota Timber Branca', 5),
	(10027,'Bota Timber Branca', 6),
	(10028,'Sapatilha Kid Adventure Verde', 6),
	(10029,'Sapatilha Kid Adventure Verde', 7),
	(10030,'Sandália Confort Azul', 8),
	(10031,'Sapato Confort Preto', 9),
	(10032,'Sapato Confort Preto',1),
	(10033,'Sapato Confort Preto',2);

INSERT INTO Empresa.Origina (codigo_materia_prima, estado, ID_funcionario, codigo_produto)
	VALUES
	(101, 'em espera', 105, 10001),
	(101, 'em producao', 106, 10001),
	(102, 'em espera', 107, 10004),
	(103, 'em producao', 101, 10002),
	(200, 'em producao', 109, 10005),
	(301, 'em producao', 107, 10006),
	(302, 'em producao', 103, 10002),
	(400, 'em producao', 108, 10030),
	(101, 'concluido', 109, 10010),
	(101, 'concluido', 103, 10008),
	(102, 'concluido', 110, 10024),
	(103, 'concluido', 105, 10015);
