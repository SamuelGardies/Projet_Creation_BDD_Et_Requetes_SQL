---------------------------------------- MongoDB --------------------------------------
------------------------------------- Création base ------------------------------------

db.createCollection ("Clients") ;
db.Clients.insert ([{_id : "c1",
	nomCli : "Joestar",
	prenomCli : "Jolyne",
	emailCli : "jolyne.joestar@gmail.com"},
	{_id : "c2",
	nomCli : "Kujo",
	prenomCli : "Jotaro",
	emailCli : "jotaro.kujo@gmail.com"},
	{_id : "c3",
	nomCli : "Merveille",
	prenomCli : "Alice",
	emailCli : "alice.merveille@gmail.com"},
	{_id : "c4",
	nomCli : "Brando",
	prenomCli : "Dio",
	emailCli : "dio.brando@gmail.com"}
	]) ;

db.createCollection ("Produits") ;
db.Produits.insert ([{_id : "p1",
	nomProd : "sandales Girafon Rouge",
	descProd : "sandales Girafon de couleur rouge au style incroyable.",
	marque : "Girafon",
	categorie : "Chaussure",
	tarifsPublics : [{taille : "41", couleur : "rouge", pxInit : "65"}],
	commentaires: [{cliId : "c2", texte : "Super sandales très confortables et très fashion", note : "4"}]},	
	{_id : "p2",
	nomProd : "Sac à épaule Gucci 1955",
	descProd : "Présenté lors du défilé Cruise 2020, le sac Gucci 1955 orné du détail Mors revisite un modèle issu des archives.",
	marque : "Gucci",
	categorie : "Sac",
	tarifsPublics : [{taille : "42", couleur : "vert", pxInit : "1780"}],
	commentaires: [{cliId : "c3", texte : "Sac arrivé en mauvais état très déçu du produit surtout pour son prix", note : "1"}]},
	{_id : "p3",
	nomProd : "Nike Sportswear",
	descProd : "Le tee-shirt Nike Sportswear est confectionné dans un tissu en coton avec une coupe classique, pour une sensation de douceur et de confort.",
	marque : "Nike",
	categorie : "Vétement",
	tarifsPublics : [{taille : "40", couleur : "jaune", pxInit : "70"}],
	commentaires: [{cliId : "c3", texte : "T-shirt très confortable, je recommande", note : "4"}]},
	{_id : "p4",
	nomProd : "Bob RE.GEN",
	descProd : "Au-delà du recyclage, PUMA vise la régénération avec la ligne RE.GEN, qui réinvente la durabilité.",
	marque : "Puma",
	categorie : "Accessoire",
	tarifsPublics : [{taille : "44", couleur : "bleu", pxInit : "50"}],
	commentaires: [{cliId : "c4", texte : "Depuis que je porte ce bob mes cheuveux ont repoussés incroyable", note : "5"}]},
	{_id : "p5",
	nomProd : "Air Jordan 1 Mid",
	descProd : "Les couleurs neutres, le daim doux et le cuir pur s’associent sur la Air Jordan 1 Mid.",
	marque : "Nike",
	categorie : "Chaussure",
	tarifsPublics : [{taille : "44", couleur : "jaune", pxInit : "120.50"}],
	commentaires: [{cliId : "c4", texte : "Chaussure peu confortable...", note : "2"}]},
	]) ; 
	
db.createCollection ("Operations") ;
db.Operations.insert ([{_id : "o1",
	nomOp : "Janvier chez Nike",
	dateDebutOp : ISODate("2022-01-05"), 
	dateFinOp : ISODate("2022-02-05"),
	promotions : [{idProd : "p3",
		tarifs : [{taille : "40", couleur : "jaune", qteStock : "26", pxPromo : "50.35"}]}]},
	{_id : "o2",
	nomOp : "Hiver avec Girafon",
	dateDebutOp : ISODate("2022-01-12"), 
	dateFinOp : ISODate("2022-03-26"),
	promotions : [{idProd : "p1",
		tarifs : [{taille : "41", couleur : "Rouge", qteStock : "6", pxPromo : "45"}]}]},
	{_id : "o3",
	nomOp : "Les 74 ans de Puma",
	dateDebutOp : ISODate("2022-02-26"), 
	dateFinOp : ISODate("2022-05-07"),
	promotions : [{idProd : "p4",
		tarifs : [{taille : "43", couleur : "Bleu", qteStock : "73", pxPromo : "35.50"}]}]},
	{_id : "o4",
	nomOp : "Le weekend Gucci",
	dateDebutOp : ISODate("2022-01-05"), 
	dateFinOp : ISODate("2022-01-07"),
	promotions : [{idProd : "p2",
		tarifs : [{taille : "42", couleur : "Vert", qteStock : "12", pxPromo : "1637.99"}]}]},
	{_id : "o5",
	nomOp : "Bonne année 2022",
	dateDebutOp : ISODate("2022-01-01"), 
	dateFinOp : ISODate("2022-01-31"),
	promotions : [{idProd : "p5",
		tarifs : [{taille : "43", couleur : "Jaune", qteStock : "34", pxPromo : "90"}]}]}])

---------------------------------------------------------------------------------
------------------------------ Requetes MongoDB ---------------------------------

-- a. Afficher les produits (nom, taille, couleur, prix promotionnel) de la catégorie
« Chaussures » proposés lors de l’opération promotionnelle « Bonne année
2022 ». --

db.Produits.aggregate({
  $lookup: {
    from: "Operations",
    localField: "_id",
    foreignField: "promotions.idProd",
    as: "ChaussureProposeLorsDeBonneAnnee2022"
  }
},
{
  $match: {
    $and: [
      {
        categorie: "Chaussure"
      },
      {
        ChaussureProposeLorsDeBonneAnnee2022: {
          $elemMatch: {
            nomOp: "Bonne année 2022"
          }
        }
      }
    ]
  }
})

-- Initialement nous avions utilisé $unset pour supprimer de l'affichage les champs inutiles
mais la version de mongo DB du serveur de l'université ne semble pas le reconnaitre --

,{
  $unset: [
    "ChaussureProposeLorsDeBonneAnnee2022._id",
    "ChaussureProposeLorsDeBonneAnnee2022.dateDebutOp",
    "ChaussureProposeLorsDeBonneAnnee2022.dateFinOp",
    "ChaussureProposeLorsDeBonneAnnee2022.nomOp",
    "ChaussureProposeLorsDeBonneAnnee2022.promotions.idProd",
    "ChaussureProposeLorsDeBonneAnnee2022.promotions.tarifs.qteStock",
    "tarifsPublics",
    "_id",
    "categorie",
    "descProd",
    "marque",
    "commentaires"
  ]
})				

-- b. Afficher le nombre de commentaires publiés par client. --

db.Produits.aggregate([
  {
    $group: {
      _id: "$commentaires.cliId",
      nbCom: {
        $sum: 1
      }
    }
  }
])