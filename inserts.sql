USE Empresa;
GO

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

INSERT INTO Fornecedor (nif, email, morada, nome)
	VALUES
	(509111222,'CouroBom@gmail.com',NULL,'CouroBom'),
	(509121212,'TextilFerreira@gmail.com','Rua do Complexo Grande - Edf 3','TextilFerreira'),
	(509294734,'PlasticoLDA@gmail.com','Rua Poente 723','PlasticoLDA'),
	(509827353,'PortoPlasticos@gmail.com',NULL,'PortoPlasticos'),
	(509836433,'sinteticoscoimbra@gmail.com','Rua Sol Poente 6243','Sinteticos Coimbra'),
	(509987654,'MaduTex@gmail.com','Estrada da Cincunvalacao 213','MaduTex'),
	(590972623,'winiw@gmail.com', 'Rua da Recta 233','Winiw');

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

INSERT INTO produto (codigo, nome, preco, iva, unidades)
    VALUES	
	(10001,'Bife da Pa', 8.75,23,125),
	(10002,'Laranja Algarve',1.25,23,1000),
	(10003,'Pera Rocha',1.45,23,2000),
	(10004,'Secretos de Porco Preto',10.15,23,342),
	(10005,'Vinho Rose Plus',2.99,13,5232),
	(10006,'Queijo de Cabra da Serra',15.00,23,3243),
	(10007,'Queijo Fresco do Dia',0.65,23,452),
	(10008,'Cerveja Preta Artesanal',1.65,13,937),
	(10009,'Lixivia de Cor', 1.85,23,9382),
	(10010,'Amaciador Neutro', 4.05,23,932432),
	(10011,'Agua Natural',0.55,6,919323),
	(10012,'Pao de Leite',0.15,6,5434),
	(10013,'Arroz Agulha',1.00,13,7665),
	(10014,'Iogurte Natural',0.40,13,998);

INSERT INTO encomenda (numero, dataEnc, fornecedor)
	VALUES
	(1,'2015-03-03',509111222),
	(2,'2015-03-04',509121212),
	(3,'2015-03-05',509987654),
	(4,'2015-03-06',509827353),
	(5,'2015-03-07',509294734),
	(6,'2015-03-08',509836433),
	(7,'2015-03-09',509121212),
	(8,'2015-03-10',509987654),
	(9,'2015-03-11',509836433),
	(10,'2015-03-12',509987654);

INSERT INTO item (numEnc, codProd, unidades)
	VALUES
	(1,10001,200),
	(1,10004,300),
	(2,10002,1200),
	(2,10003,3200),
	(3,10013,900),
	(4,10006,50),
	(4,10007,40),
	(4,10014,200),
	(5,10005,500),
	(5,10008,10),
	(5,10011,1000),
	(6,10009,200),
	(6,10010,200),
	(7,10003,1200),
	(8,10013,350),
	(9,10009,100),
	(9,10010,300),
	(10,10012,200);