USE Empresa;
GO


INSERT INTO Fornecedor (nif, email, morada, nome)
	VALUES
	(509111222,'CouroBom@gmail.com',NULL,'CouroBom'),
	(509121212,'TextilFerreira@gmail.com','Rua do Complexo Grande - Edf 3','TextilFerreira'),
	(509294734,'PlasticoLDA@gmail.com','Rua Poente 723','PlasticoLDA'),
	(509827353,'PortoPlasticos@gmail.com',NULL,'PortoPlasticos'),
	(509836433,'sinteticoscoimbra@gmail.com','Rua Sol Poente 6243','Sinteticos Coimbra'),
	(509987654,'MaduTex@gmail.com','Estrada da Cincunvalacao 213','MaduTex'),
	(590972623,'winiw@gmail.com', 'Rua da Recta 233','Winiw');


INSERT INTO Fornece (nif, codigo_materia_prima)
	VALUES
	(509111222,101),
	(509111222,102),
	(509111222,103),
	(509121212,200),
	(509121212,600),
	(509294734,301),
	(509294734,302),
	(509294734,400),
	(509827353,502);


INSERT INTO Encomenda (numero, _data, nif_revendedor)
	VALUES
	(1, '2019-01-01', 409111222),
	(1, '2019-01-01', 409111222),
	(1, '2019-01-01', 409836433),
	(1, '2019-01-01', 409827353),
	(1, '2019-01-01', 409111222),
	(1, '2019-01-01', 490972623),
	(1, '2019-01-01', 490972623),
	(1, '2019-01-01', 409121212),
	(1, '2019-01-01', 409121212);


INSERT INTO Revendedor (nif, email, morada, nome)
	VALUES
	(409111222,'SapatariaBrasileira@gmail.com',NULL,'Sapataria Brasileira'),
	(409121212,'SapatosRia@gmail.com','Rua do Complexo Pequeno - Edf 4','Sapatos Ria'),
	(409294734,'softcalcados@gmail.com','Rua Poente 843','Soft Calçados'),
	(409827353,'PortoCalcados@gmail.com',NULL,'PortoCalcados'),
	(409836433,'sportsnow@gmail.com','Rua Sol 3243','Sports Now'),
	(409987654,'playsports@gmail.com','Estrada de Fátima 263','PlaySports'),
	(490972623,'klein@gmail.com', 'Rua da Redonda 90','Klein');


INSERT INTO MateriaPrima (nome, qualidade, quant_armazem, codigo)
	VALUES
	('Couro','Primeira', 300, 101),
    ('Couro','Segunda', 400, 102),
    ('Couro','Terceira', 350, 103),
    ('Couro Sintético',NULL, 300, 200),
    ('Tecido',NULL, 300, 600),
    ('Pele','Primeira', 300, 301),
    ('Pele','Segunda', 300, 302),
    ('Vinil',NULL, 200, 400),
    ('PVC','Segunda', 140, 502);


INSERT INTO Processa (codigo_materia_prima, estado, seccao_atual, ID_funcionario)
	VALUES
	(101, 'em espera', 'Corte', 105),
	(101, 'em producao', 'Costura', 106),
	(102, 'em espera', 'Costura', 107),
	(103, 'em producao', 'Corte', 101),
	(200, 'em producao', 'Corte', 109),
	(301, 'em producao', 'Acabamento', 107),
	(302, 'em producao', 'Montagem', 103),
	(400, 'em producao', 'Montagem', 108),
	(101, 'concluido', 'Acabamento', 106),
	(101, 'concluido', 'Montagem', 103),
	(102, 'concluido', 'Costura', 110),
	(103, 'concluido', 'Corte', 105);


INSERT INTO TipoProduto (custo_fabrico, preco_venda, categoria)
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


INSERT INTO Produto (codigo_produto, codigo_materia_prima, categoria_tipo, num_encomenda, ID_funcionario)
    VALUES	
	(10001,101,'Bota Timber Castanha', 1, 101),
	(10002,101,'Sapatilha Kid Adventure Preta', 1, 102),
	(10003,103,'Tênis Runner Branco', 2, 103),
	(10004,103,'Tênis Runner Branco', 3, 104),
	(10005,102,'Tênis Runner Castanho', 4, 102),
	(10006,200,'Bota Timber Branca', 5, 104),
	(10007,200,'Bota Timber Branca', 6, 101),
	(10008,502,'Sapatilha Kid Adventure Verde', 6, 103),
	(10009,502,'Sapatilha Kid Adventure Verde', 7, 105),
	(10010,600,'Sandália Confort Azul', 8, 105),
	(10011,301,'Sapato Confort Preto', 9, 106),
	(10012,301,'Sapato Confort Preto',10, 107),
	(10013,301,'Sapato Confort Preto',11, 108),
	(10014,302,'Tênis Runner Preto',12, 109),
	(10015,102,'Tênis Runner Castanho', 4, 104),
	(10016,200,'Bota Timber Branca', 5, 108),
	(10017,200,'Bota Timber Branca', 6, 109),
	(10018,502,'Sapatilha Kid Adventure Verde', 6, 105),
	(10019,502,'Sapatilha Kid Adventure Verde', 7, 103),
	(10020,101,'Bota Timber Castanha', 1, 102),
	(10021,101,'Bota Timber Castanha', 1, 103),
	(10022,101,'Sapatilha Kid Adventure Preta', 1, 102),
	(10023,103,'Tênis Runner Branco', 2, 101),
	(10024,103,'Tênis Runner Branco', 3, 109),
	(10025,102,'Tênis Runner Castanho', 4, 107),
	(10026,200,'Bota Timber Branca', 5, 110),
	(10027,200,'Bota Timber Branca', 6, 102),
	(10028,502,'Sapatilha Kid Adventure Verde', 6, 101),
	(10029,502,'Sapatilha Kid Adventure Verde', 7, 101),
	(10030,600,'Sandália Confort Azul', 8, 104),
	(10031,301,'Sapato Confort Preto', 9, 104),
	(10032,301,'Sapato Confort Preto',10, 102),
	(10033,301,'Sapato Confort Preto',11, 101);


INSERT INTO Funcionario (nif, salario, morada, numeroCC, nome, ID)
	VALUES
	(609111222, 1400, NULL, 12345678, 'Nuno Miguel Farias', 101),
	(609121212, 1500, 78931289, 'Rua do Complexo Pequeno - Edf 1','José Carlos Costa', 102),
	(609294734, 1450, 12378791, 'Rua Poente 846','João Miguel Arruda', 103),
	(609827353, 1300, 73828291, NULL,'Felipe Manoel do Carmo', 104),
	(609836433, 1000, 90901111, 'Rua Sol 323','Maria Gomes de Sousa', 105),
	(609987654, 1000, 11888912, 'Estrada de Fátima 23','Miguel Silva do Campo', 106),
	(690972623, 900, 29309021, 'Rua da Redonda Azul 9','Jéssica Oliveira Silva', 107),
	(609836437, 1000, 90901111, 'Rua Lua 323','Joana Gomes da Silva', 108),
	(609987657, 1000, 11888912, 'Estrada de Santiago 23','Roberto Castro Almeida', 109),
	(690972627, 900, 29309021, 'Rua de Coimbra 91','Inês Oliveira Silva', 110);


INSERT INTO Seccao (designacao, codigo)
	VALUES
	(1,'Corte'),
	(2,'Costura'),
	(3,'Montagem'),
	(4,'Acabamento');


INSERT INTO Operario (designacao, codigo)
	VALUES
	(101, 1),
	(102, 2),
	(103, 2),
	(104, 1),
	(105, 1),
	(106, 4),
	(107, 4),
	(108, 3),
	(109, 1),
	(110, 3);


INSERT INTO Gerente (designacao, codigo)
	VALUES
	(101, 1),
	(102, 2),
	(103, 3),
	(104, 4);