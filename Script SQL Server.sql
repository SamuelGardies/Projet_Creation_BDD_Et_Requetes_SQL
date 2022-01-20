-------------------------------- SQL server -------------------------------------
------------------------------- Création base -----------------------------------

CREATE TABLE Marques
	(idMarque int identity(1,1) primary key,
	nomMarque nvarchar(50) not null,
	descMarque nvarchar(150) not null);
	
CREATE TABLE Operations
	(idOp int identity(1,1) primary key,
	nomOp nvarchar(50) not null,
	dateDebutOp date not null,
	dateFinOp date not null);
	
CREATE TABLE Produits
	(idProd int identity(1,1) primary key,
	nomProd nvarchar(50) not null,
	descProd nvarchar(250) not null,
	idMarque int not null,
	idCat int not null);

CREATE TABLE Tailles
	(idTaille int identity(1,1) primary key,
	nomTaille nvarchar(50) not null);
	
CREATE TABLE Couleurs
	(idCouleur int identity(1,1) primary key,
	nomCouleur nvarchar(50) not null);
	
CREATE TABLE Promotions
	(idProd int not null,
	idOp int not null,
	idTaille int not null,
	idCouleur int not null,
	qteStock int not null,
	pxPromo float not null,
	primary key (idProd, idOp, idTaille, idCouleur));
	
CREATE TABLE TarifsPublics
	(idProd int not null,
	idTaille int not null,
	idCouleur int not null,
	pxInit float not null,
	primary key (idProd, idTaille, idCouleur));
	
CREATE TABLE Categories
	(idCat int identity(1,1) primary key,
	nomCat nvarchar(50) not null);
	
CREATE TABLE Clients
	(idCli int identity(1,1) primary key,
	nomCli nvarchar(50) not null,
	prenomCli nvarchar(50) not null,
	emailCli nvarchar(100) not null);
	
CREATE TABLE Commentaires
	(idComment int identity(1,1) primary key,
	texte nvarchar(250) not null,
	note smallint not null,
	idCli int not null);
	
ALTER TABLE Commentaires
	add constraint fk_Clients
	foreign key (idCli)
	references Clients(idCli)
		on update cascade
		on delete cascade;
		
ALTER TABLE Produits
	add constraint fk_Marques
	foreign key (idMarque)
	references Marques(idMarque)
		on update cascade
		on delete cascade;
		
ALTER TABLE Produits
	add constraint fk_Categories
	foreign key (idCat)
	references Categories(idCat)
		on update cascade
		on delete cascade;
		
ALTER TABLE Promotions
	add constraint fk_Produits
	foreign key (idProd)
	references Produits(idProd)
		on update cascade
		on delete cascade;
		
ALTER TABLE Promotions
	add constraint fk_Operations
	foreign key (idOp)
	references Operations(idOp)
		on update cascade
		on delete cascade;
		
ALTER TABLE Promotions
	add constraint fk_Tailles
	foreign key (idTaille)
	references Tailles(idTaille)
		on update cascade
		on delete cascade;
		
ALTER TABLE Promotions
	add constraint fk_Couleur
	foreign key (idCouleur)
	references Couleurs(idCouleur)
		on update cascade
		on delete cascade;
		
ALTER TABLE TarifsPublics
	add constraint fk_ProduitsTarifs
	foreign key (idProd)
	references Produits(idProd)
		on update cascade
		on delete cascade;
		
ALTER TABLE TarifsPublics
	add constraint fk_TaillesTarifs
	foreign key (idTaille)
	references Tailles(idTaille)
		on update cascade
		on delete cascade;
		
ALTER TABLE TarifsPublics
	add constraint fk_CouleurTarifs
	foreign key (idCouleur)
	references Couleurs(idCouleur)
		on update cascade
		on delete cascade;

---------------------------------------------------------------------------------
--------------------------------- Remplir base ----------------------------------

INSERT INTO Marques
	values('Nike', 'Nike est une société américaine créée en 1971 par Philip Knight et Bill Bowerman.');
	
INSERT INTO Marques
	values('Girafon', 'girafon est la première marque de mode éco-responsable qui agit pour la protection des girafes.');

INSERT INTO Marques
	values('Puma', 'Puma SE est une entreprise allemande spécialisée dans la fabrication d articles de sport fondée en 1948.');
	
INSERT INTO Marques
	values('Gucci', 'Gucci est une maison italienne spécialisée dans la mode et le luxe dont le siège est situé à Florence en Italie.');
	
INSERT INTO Operations
	values('Janvier chez Nike', '2022-01-05', '2022-02-05');
	
INSERT INTO Operations
	values('Hiver avec Girafon', '2022-01-12', '2022-03-26');
	
INSERT INTO Operations
	values('Les 74 ans de Puma', '2022-02-26', '2022-05-07');
	
INSERT INTO Operations
	values('Le weekend Gucci', '2022-01-05', '2022-01-07');
	
INSERT INTO Operations
	values('Bonne année 2022', '2022-01-01', '2022-01-31');
	
INSERT INTO Categories
	values('Chaussure');

INSERT INTO Categories
	values('Sac');
	
INSERT INTO Categories
	values('Vétement');
	
INSERT INTO Categories
	values('Accessoire');
	
INSERT INTO Produits
	values('sandales Girafon Rouge', 'sandales Girafon de couleur rouge au style incroyable.', 2, 1);
	
INSERT INTO Produits
	values('Sac à épaule Gucci 1955', 'Présenté lors du défilé Cruise 2020, le sac Gucci 1955 orné du détail Mors revisite un modèle issu des archives.', 4, 2);
	
INSERT INTO Produits
	values('Nike Sportswear', 'Le tee-shirt Nike Sportswear est confectionné dans un tissu en coton avec une coupe classique, pour une sensation de douceur et de confort.', 1, 3);
	
INSERT INTO Produits
	values('Bob RE.GEN', 'Au-delà du recyclage, PUMA vise la régénération avec la ligne RE.GEN, qui réinvente la durabilité.', 3, 4);
	
INSERT INTO Produits
	values('Air Jordan 1 Mid', 'Les couleurs neutres, le daim doux et le cuir pur s’associent sur la Air Jordan 1 Mid.', 1, 1);

INSERT INTO Tailles
	values('taille 40');
	
INSERT INTO Tailles
	values('taille 41');

INSERT INTO Tailles
	values('taille 42');

INSERT INTO Tailles
	values('taille 43');
	
INSERT INTO Tailles
	values('taille 44');
	
INSERT INTO Couleurs
	values('Bleu');
	
INSERT INTO Couleurs 
	values('Vert');
	
INSERT INTO Couleurs 
	values('Jaune');
	
INSERT INTO Couleurs 
	values('Rouge');
	
INSERT INTO Promotions
	values(4, 3, 4, 1, 73, 35.50);
	
INSERT INTO Promotions
	values(1, 2, 2, 4, 6, 45);
	
INSERT INTO Promotions
	values(2, 4, 3, 2, 12, 1637.99);
	
INSERT INTO Promotions
	values(3, 1, 1, 3, 26, 50.35);
	
INSERT INTO Promotions
	values(5, 5, 4, 3, 34, 90);
	
INSERT INTO TarifsPublics
	values(4, 4, 1, 50);
	
INSERT INTO TarifsPublics
	values(1, 2, 4, 65);
	
INSERT INTO TarifsPublics
	values(2, 3, 2, 1780);
	
INSERT INTO TarifsPublics
	values(3, 1, 3, 70);
	
INSERT INTO TarifsPublics
	values(5, 4, 3, 120.50);

INSERT INTO Clients
	values('Joestar', 'Jolyne', 'jolyne.joestar@gmail.com');
	
INSERT INTO Clients
	values('Kujo', 'Jotaro', 'jotaro.kujo@gmail.com');
	
INSERT INTO Clients
	values('Merveille', 'Alice', 'alice.merveille@gmail.com');
	
INSERT INTO Clients
	values('Brando', 'Dio', 'dio.brando@gmail.com');
	
INSERT INTO Commentaires
	values('Super sandales très confortables et très fashion', 4, 2);
	
INSERT INTO Commentaires
	values('Sac arrivé en mauvais état très déçu du produit surtout pour son prix', 1, 3);
	
INSERT INTO Commentaires
	values('Depuis que je porte ce bob mes cheuveux ont repoussés incroyable', 5, 4);
	
INSERT INTO Commentaires
	values('grâce à ces sandales j arrive à courrir très vite merci Girafon!', 3, 3);

---------------------------------------------------------------------------------
------------------------------- Requetes SQL ------------------------------------

-- a. Modifiez la quantité en stock des « sandales Girafon Rouge », « taille 41 » pour que celle-ci soit égale à zéro. --

UPDATE Promotions
	SET qteStock=0
	FROM Promotions, Produits, Tailles
	WHERE nomTaille='taille 41'
	AND nomProd='sandales Girafon Rouge'
	AND Tailles.idTaille=Promotions.idTaille
	AND Produits.idProd=Promotions.idProd
	
-- b. Supprimer le client « Alice » avec tous les commentaires qu’elle aurait publié. --

DELETE FROM Clients
	WHERE prenomCli='Alice' 
-- rq commentaires automatiquement supprimés par 'on delete cascade' --


-- c. Créer une vue permettant de connaitre tous les produits encore disponibles de la catégorie « Chaussures » pendant les opérations promotionnelles du mois de janvier 2022. --

CREATE VIEW chaussuresDispoJanvier22 AS
	(SELECT Produits.idProd, nomProd, descProd
	FROM Produits, Categories, Operations, Promotions
	WHERE nomCat='Chaussure'
	AND qteStock>0
	AND month(dateDebutOp)=1
	AND month(dateFinOp)=1
	AND Categories.idCat=Produits.idCat
	AND Operations.idOp=Promotions.idOp
	AND Produits.idProd=Promotions.idProd)