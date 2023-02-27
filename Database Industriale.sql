-- ----------------------------
-- `CREAZIONE DEL DATABASE`
-- ----------------------------

SET NAMES latin1;

SET FOREIGN_KEY_CHECKS = 0;


BEGIN;
CREATE DATABASE IF NOT EXISTS `Azienda`;
COMMIT;

USE `Azienda`;

-- ----------------------------
--  Table structure for `Prodotto`
-- ----------------------------

DROP TABLE IF EXISTS `Prodotto`;
CREATE TABLE `Prodotto` (
  `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  `NFacce` int NOT NULL,
  `Nome` char(50) NOT NULL,
  `NumValutazioni` int NOT  NULL,
  `TotValutazioni` int NOT  NULL,
  `NumVendite` int NOT  NULL,
  `Tipo`  char(50) NOT NULL,
  PRIMARY KEY (`Marca`,`Modello`),
   FOREIGN KEY (`Tipo`)
  REFERENCES `Categoria` (`Tipo`)
  on delete NO ACTION
  on update NO ACTION,
  INDEX `MarcaModelloIND` (`Marca`, `Modello`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 
-- ----------------------------
--  Table structure for `ProdottoSpecifico`
-- ----------------------------

DROP TABLE IF EXISTS `ProdottoSpecifico`;
CREATE TABLE `ProdottoSpecifico`(
  `CodSeriale` int(5) zerofill NOT NULL AUTO_INCREMENT,
   `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  `Lotto` int(5) NOT NULL,
  `CodVariante` int(5) NOT NULL,
  PRIMARY KEY (`CodSeriale`),
 FOREIGN KEY (`Marca`, `Modello`)
  REFERENCES `Prodotto` (`Marca`, `Modello`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- ----------------------------
--  Table structure for `Differenza`
-- ----------------------------

DROP TABLE IF EXISTS `Differenza`;
CREATE TABLE `Differenza`(
  `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  `CodVariante` int(5)  zerofill NOT NULL,
  PRIMARY KEY (`Marca`, `Modello`, `CodVariante`),
  FOREIGN KEY (`Marca`, `Modello`)
  REFERENCES `Prodotto` (`Marca`, `Modello`)
  on delete NO ACTION
  on update NO ACTION,
   FOREIGN KEY (`CodVariante`)
  REFERENCES `Variante` (`CodVariante`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Recensione`
-- ----------------------------

DROP TABLE IF EXISTS `Recensione`;
CREATE TABLE `Recensione`(
  `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  `Username` char(50) NOT NULL,
  `Voto` enum('1', '2', '3', '4', '5') NOT NULL,
  `Testo` char(50) NOT NULL,
  `Affidabilità` enum('1', '2', '3', '4', '5') NOT NULL,
  `Performance`enum('1', '2', '3', '4', '5') NOT NULL,
  `EsperienzaUso` enum('1', '2', '3', '4', '5') NOT NULL,
  PRIMARY KEY (`Marca`, `Modello`, `Username`),
  FOREIGN KEY (`Marca`, `Modello`)
  REFERENCES `Prodotto` (`Marca`, `Modello`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Categoria`
-- ----------------------------

DROP TABLE IF EXISTS `Categoria`;
CREATE TABLE `Categoria`(
  `Tipo` char(50) NOT NULL,
  `Descrizione` char(200) NOT NULL,
  PRIMARY KEY (`Tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Variante`
-- ----------------------------

DROP TABLE IF EXISTS `Variante`;
CREATE TABLE `Variante`(
  `CodVariante` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Caratteristica` char(50) NOT NULL,
  `Dato` char(50) NOT NULL,
  `Unitadimisura` char(50),
  PRIMARY KEY (`CodVariante`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- ----------------------------
--  Table structure for `Garanzia`
-- ----------------------------

DROP TABLE IF EXISTS `Garanzia`;
CREATE TABLE `Garanzia`(
  `CodGaranzia` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Costo` float(7,2) NOT NULL,
  `MesiValidita` int NOT NULL,
  `Classe` char(50) NOT NULL,
  PRIMARY KEY (`CodGaranzia`),
   INDEX `GaranziaIND` (`CodGaranzia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Propone`
-- ----------------------------

DROP TABLE IF EXISTS `Propone`;
CREATE TABLE `Propone`(
  `CodGaranzia` int(5) zerofill NOT NULL,
  `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  PRIMARY KEY (`CodGaranzia`, `Marca`, `Modello`),
FOREIGN KEY (`Marca`, `Modello`)
  REFERENCES `Prodotto` (`Marca`, `Modello`)
  on delete NO ACTION
  on update NO ACTION,
  
  FOREIGN KEY (`CodGaranzia`)
  REFERENCES `Garanzia` (`CodGaranzia`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Attivazione`
-- ----------------------------

DROP TABLE IF EXISTS `Attivazione`;
CREATE TABLE `Attivazione`(
  `CodGaranzia` int(5) zerofill NOT NULL,
  `CodSeriale` int(5) zerofill NOT NULL,
  `DataAttivazione` date NOT NULL,
  PRIMARY KEY (`CodGaranzia`, `CodSeriale`, `DataAttivazione`),
  FOREIGN KEY (`CodSeriale`)
  REFERENCES `ProdottoSpecifico` (`CodSeriale`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`CodGaranzia`)
  REFERENCES `Garanzia` (`CodGaranzia`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Utente`
-- ----------------------------

DROP TABLE IF EXISTS `Utente`;
CREATE TABLE `Utente`(
  `CodFiscale` char(16) NOT NULL,
  `DataIscrizione` date NOT NULL,
  `Username` char(50) NOT NULL,
  `Nome` char(50) NOT NULL,
  `Cognome` char(50) NOT NULL,
  `Indirizzo` char(50) NOT NULL,
  `NumTelefono` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`CodFiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Documento`
-- ----------------------------

DROP TABLE IF EXISTS `Documento`;
CREATE TABLE `Documento`(
  `Tipologia` enum('Carta identita', 'Patente', 'Altro') NOT NULL,
  `Numero` char(50) NOT NULL,
  `CodFiscale` char(16) NOT NULL,
  `Ente` char(50) NOT NULL,
  `Scadenza` date NOT NULL,
  PRIMARY KEY (`Tipologia`, `Numero`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Login`
-- ----------------------------

DROP TABLE IF EXISTS `Login`;
CREATE TABLE `Login`(
  `Username` char(50) NOT NULL,
  `Password` char(50) NOT NULL,
  `Domanda` char(50) NOT NULL,
  `Risposta` char(50) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Ordine`
-- ----------------------------

DROP TABLE IF EXISTS `Ordine`;
CREATE TABLE `Ordine` (
  `CodOrdine` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Username` char(50) NOT NULL,
  `StatoOrdine` enum('in processazione', 'in preparazione', 'spedito', 'evaso') NOT NULL,
  `IndConsegna` char(50) NOT NULL,
  `Data` date,
  PRIMARY KEY (`CodOrdine`),
   FOREIGN KEY (`Username`)
  REFERENCES `Login` (`Username`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Ordinazione`
-- ----------------------------

DROP TABLE IF EXISTS `Ordinazione`;
CREATE TABLE `Ordinazione` (
  `CodOrdine` int(5) zerofill NOT NULL,
  `CodSeriale` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodOrdine`,`CodSeriale`),
  FOREIGN KEY (`CodOrdine`)
  REFERENCES `Ordine` (`CodOrdine`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`CodSeriale`)
  REFERENCES `ProdottoSpecifico` (`CodSeriale`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Consegna`
-- ----------------------------
DROP TABLE IF EXISTS `Consegna`;
CREATE TABLE `Consegna` (
  `CodConsegna` int(5) zerofill NOT NULL,
  `CodOrdine` int(5) zerofill NOT NULL,
  `StatoConsegna` enum('spedita', 'in transito', 'in consegna', 'consegnata') NOT NULL,
  `DataPrevista` date NOT NULL,
  PRIMARY KEY (`CodConsegna`,`CodOrdine`),
  FOREIGN KEY (`CodOrdine`)
  REFERENCES `Ordine` (`CodOrdine`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Hub`
-- ----------------------------
DROP TABLE IF EXISTS `Hub`;
CREATE TABLE `Hub` (
  `CodHub` int(5) zerofill NOT NULL,
  `NomeHub` char(50) NOT NULL,
  PRIMARY KEY (`CodHub`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Tracciamento`
-- ----------------------------
DROP TABLE IF EXISTS `Tracciamento`;
CREATE TABLE `Tracciamento` (
  `CodHub` int(5) NOT NULL,
  `CodConsegna` int(5) NOT NULL,
  `DataPassaggio` date NOT NULL,
  PRIMARY KEY (`CodHub`, `CodConsegna`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Guasto`
-- ----------------------------

DROP TABLE IF EXISTS `Guasto`;
CREATE TABLE `Guasto` (
  `CodGuasto` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Nome` char(50) NOT NULL,
  `Classe` char(50) NOT NULL,
  PRIMARY KEY (`CodGuasto`),
  INDEX `GuastoIND` (`CodGuasto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Problematica`
-- ----------------------------

DROP TABLE IF EXISTS `Problematica`;
CREATE TABLE `Problematica` (
  `CodGuasto` int(5) zerofill NOT NULL,
  `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  `CodErrore` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodGuasto`, `Marca`, `Modello`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `RimedioFisico`
-- ----------------------------

DROP TABLE IF EXISTS `RimedioFisico`;
CREATE TABLE `RimedioFisico` (
  `CodTicket` int(5) zerofill auto_increment NOT NULL,
  `Accettato` enum("si", "no") NOT NULL,
  `Prezzo` float(7,2) NOT NULL,
  PRIMARY KEY (`CodTicket`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `AssistenzaFisica`
-- ----------------------------

DROP TABLE IF EXISTS `AssistenzaFisica`;
CREATE TABLE `AssistenzaFisica` (
  `CodTicket` int(5) zerofill NOT NULL,
  `CodGuasto` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodTicket`, `CodGuasto`),
  FOREIGN KEY (`CodTicket`)
  REFERENCES `RimedioFisico` (`CodTicket`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`CodGuasto`)
  REFERENCES `Guasto` (`CodGuasto`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `RicevutaFiscale`
-- ----------------------------

DROP TABLE IF EXISTS `RicevutaFiscale`;
CREATE TABLE `RicevutaFiscale` (
  `CodRicevuta` int(15) zerofill NOT NULL,
  `CodTicket` int(5) zerofill NOT NULL,
  `ModPagamento` char(50) NOT NULL,
  PRIMARY KEY (`CodRicevuta`),
  FOREIGN KEY (`CodTicket`)
  REFERENCES `RimedioFisico` (`CodTicket`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Tecnico`
-- ----------------------------

DROP TABLE IF EXISTS `Tecnico`;
CREATE TABLE `Tecnico` (
  `CodTecnico` int(5) zerofill NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`CodTecnico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Interventi`
-- ----------------------------

DROP TABLE IF EXISTS `Interventi`;
CREATE TABLE `Interventi` (
  `CodTecnico` int(5) zerofill,
  `CodTicket` int(5) zerofill,
  `DataIntervento` date NOT NULL,
  `FasciaOraria` char(50) NOT NULL,
  `Zona` VARCHAR(50),
  PRIMARY KEY (`CodTecnico`, `DataIntervento`, `FasciaOraria` ),
  FOREIGN KEY (`CodTicket`)
  REFERENCES `RimedioFisico` (`CodTicket`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`CodTecnico`)
  REFERENCES `Tecnico` (`CodTecnico`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




-- ----------------------------
--  Table structure for `Rimedio`
-- ----------------------------

DROP TABLE IF EXISTS `Rimedio`;
CREATE TABLE `Rimedio` ( 
  `CodRimedio` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `DescRimedio` char(250) NOT NULL,
  PRIMARY KEY (`CodRimedio`),
  INDEX `RimedioIND` (`CodRimedio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `AssistenzaVirtuale`
-- ----------------------------

DROP TABLE IF EXISTS `AssistenzaVirtuale`;
CREATE TABLE `AssistenzaVirtuale` (
  `CodGuasto` int(5) zerofill NOT NULL,
  `CodRimedio` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodGuasto`, `CodRimedio`),
  FOREIGN KEY (`CodGuasto`)
  REFERENCES `Guasto` (`CodGuasto`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`CodRimedio`)
  REFERENCES `Rimedio` (`CodRimedio`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Domanda`
-- ----------------------------

DROP TABLE IF EXISTS `Domanda`;
CREATE TABLE `Domanda` (
  `CodDomanda` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `TestoDomanda` char(50) NOT NULL,
  `Precedente` char(50) NOT NULL,
  `Rimedio` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodDomanda`),
  FOREIGN KEY (`Rimedio`)
  REFERENCES `Rimedio` (`CodRimedio`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Soluzione`
-- ----------------------------

DROP TABLE IF EXISTS `Soluzione`;
CREATE TABLE `Soluzione` (
  `CodDomanda` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  PRIMARY KEY (`CodDomanda`, `Marca`, `Modello`),
  FOREIGN KEY (`CodDomanda`)
  REFERENCES `Domanda` (`CodDomanda`)
  on delete NO ACTION
  on update NO ACTION,
   FOREIGN KEY (`Marca`, `Modello`)
  REFERENCES `Prodotto` (`Marca`, `Modello`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




-- ----------------------------
--  Table structure for `OrdineParte`
-- ----------------------------

DROP TABLE IF EXISTS `OrdineParte`;
CREATE TABLE `OrdineParte` (
  `CodOrdineParte` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `DataPrevista` date NOT NULL,
  `Precedente` date default NULL,
  PRIMARY KEY (`CodOrdineParte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Richiesta`
-- ----------------------------

DROP TABLE IF EXISTS `Richiesta`;
CREATE TABLE `Richiesta` (
  `Ticket` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `CodOrdineParte` int(50) zerofill NOT NULL,
  PRIMARY KEY (`Ticket`, `CodOrdineParte`),
  FOREIGN KEY (`Ticket`)
  REFERENCES `RimedioFisico` (`CodTicket`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`CodOrdineParte`)
  REFERENCES `OrdineParte` (`CodOrdineParte`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `ListaOrdineParte`
-- ----------------------------

DROP TABLE IF EXISTS `ListaOrdineParte`;
CREATE TABLE `ListaOrdineParte` (
  `CodOrdineParte` int(5) zerofill NOT NULL,
  `Parte` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodOrdineParte`, `Parte`),
  FOREIGN KEY (`CodOrdineParte`)
  REFERENCES `OrdineParte` (`CodOrdineParte`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`Parte`)
  REFERENCES `Parte` (`CodParte`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Lotto`
-- ----------------------------

DROP TABLE IF EXISTS `Lotto`;
CREATE TABLE `Lotto` (
  `CodLotto` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `DataProduzione` date NOT NULL,
  `SedeProduzione` char(50) NOT NULL,
  `DurataPreventiva` int(3) NOT NULL,
  `DurataEffettiva` int(3) NOT NULL,
  `Predisposizione` int(5) zerofill NOT NULL,
  `SerieOperazioni` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodLotto`),
   INDEX `CodLottoIND` (`CodLotto`),
  FOREIGN KEY (`Predisposizione`)
  REFERENCES `Predisposizione` (`CodPredisposizione`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`SerieOperazioni`)
  REFERENCES `SerieOperazioni` (`CodSerie`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Posizione`
-- ----------------------------

DROP TABLE IF EXISTS `Posizione`;
CREATE TABLE `Posizione` (
 `Corridoio` int(3) NOT NULL,
  `Altezza` char(2) NOT NULL,
  `Scaffale` int(3) NOT NULL,
  `Magazzino` int(5) zerofill NOT NULL,
  PRIMARY KEY (`Corridoio`, `Altezza`, `Scaffale`, `Magazzino`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Magazzino`
-- ----------------------------


DROP TABLE IF EXISTS `Magazzino`;
CREATE TABLE `Magazzino` (
 `CodMagazzino` int(3) NOT NULL,
  `CodPosizione` char(2) NOT NULL,
  PRIMARY KEY (`CodMagazzino`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- ----------------------------
--  Table structure for `Ubicazione`
-- ----------------------------

DROP TABLE IF EXISTS `Ubicazione`;
CREATE TABLE `Ubicazione` (
  `Lotto` int(5) zerofill NOT NULL,
  `Corridoio` int(3) NOT NULL,
  `Altezza` char(2) NOT NULL,
  `Scaffale` int(3) NOT NULL,
  `Magazzino` int(5) zerofill NOT NULL,
  `DataStoccaggio` date NOT NULL,
  `DataSpostamento` date,
  PRIMARY KEY (`Lotto`, `Corridoio`, `Altezza`, `Scaffale`, `Magazzino`),
	FOREIGN KEY (`Lotto`)
	REFERENCES `Lotto` (`CodLotto`)
	on delete NO ACTION
	on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Predisposizione`
-- ----------------------------

DROP TABLE IF EXISTS `Predisposizione`;
CREATE TABLE `Predisposizione` (
  `CodPredisposizione` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `LunghezzaCorsie` INT,
  `Temperatura` enum("Bassa", "Media", "Alta"),
  `LarghezzaCorsie` int(3),
  PRIMARY KEY (`CodPredisposizione`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `SerieOperazioni`
-- ----------------------------

DROP TABLE IF EXISTS `SerieOperazioni`;
CREATE TABLE `SerieOperazioni` (
  `CodSerie` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Tempo` int(3) NOT NULL,
  PRIMARY KEY (`CodSerie`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `ReportPerdite`
-- ----------------------------

DROP TABLE IF EXISTS `ReportPerdite`;
CREATE TABLE `ReportPerdite` (
  `Data` date NOT NULL,
  `SerieOperazioni` int(5) zerofill NOT NULL,
  `Scarti` int(5) NOT NULL,
  `UltimaOperazione` int(5) zerofill,
  `NumSerieOperazioni` int,
  PRIMARY KEY (`Data`, `SerieOperazioni`),
  FOREIGN KEY (`SerieOperazioni`)
  REFERENCES `SerieOperazioni` (`CodSerie`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`UltimaOperazione`)
  REFERENCES `Operazione` (`CodOperazione`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Operazione`
-- ----------------------------

DROP TABLE IF EXISTS `Operazione`;
CREATE TABLE `Operazione` (
  `CodOperazione` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Saldatura` enum("si", "no") NOT NULL,
  `Nome` char(50) NOT NULL,
  `Faccia` int(2) zerofill,
  `Parte` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodOperazione`),
  FOREIGN KEY (`Parte`)
  REFERENCES `Parte` (`CodParte`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Sequenza`
-- ----------------------------

DROP TABLE IF EXISTS `Sequenza`;
CREATE TABLE `Sequenza` (
  `Serie` int(5) zerofill NOT NULL,
  `Operazione` int(5) zerofill NOT NULL,
  `Ordine` int NOT NULL,
  PRIMARY KEY (`Operazione`, `Serie`),
  FOREIGN KEY (`Operazione`)
  REFERENCES `Operazione` (`CodOperazione`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`Serie`)
  REFERENCES `SerieOperazioni` (`CodSerie`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Giunzione`
-- ----------------------------

DROP TABLE IF EXISTS `Giunzione`;
CREATE TABLE `Giunzione` (
  `CodGiunzione` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Tipo` enum( "vite", "rivetto", "bullone" , "fascetta", "grillo", 
		"fune", "copiglia", "tenditore") NOT NULL,
  `Descrizione` char(50) NOT NULL,
  PRIMARY KEY (`CodGiunzione`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Legame`
-- ----------------------------

DROP TABLE IF EXISTS `Legame`;
CREATE TABLE `Legame` (
  `Giunzione` int(5) zerofill NOT NULL,
  `Operazione` int(5) zerofill NOT NULL,
  PRIMARY KEY (`Giunzione`, `Operazione`),
  FOREIGN KEY (`Giunzione`)
  REFERENCES `Giunzione` (`CodGiunzione`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`Operazione`)
  REFERENCES `Operazione` (`CodOperazione`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Utensile`
-- ----------------------------

DROP TABLE IF EXISTS `Utensile`;
CREATE TABLE `Utensile` (
  `NomeUtensile` char(50) NOT NULL,
  PRIMARY KEY (`NomeUtensile`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Utilizzo`
-- ----------------------------

DROP TABLE IF EXISTS `Utilizzo`;
CREATE TABLE `Utilizzo` (
  `NomeUtensile` char(50) NOT NULL,
  `Operazione` int(5) zerofill NOT NULL,
  PRIMARY KEY (`NomeUtensile`, `Operazione`),
  FOREIGN KEY (`Operazione`)
  REFERENCES `Operazione` (`CodOperazione`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Operatore`
-- ----------------------------

DROP TABLE IF EXISTS `Operatore`;
CREATE TABLE `Operatore` (
  `CodOperatore` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Operazione` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodOperatore`, `Operazione`),
  FOREIGN KEY (`Operazione`)
  REFERENCES `Operazione` (`CodOperazione`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ReportOperatore`
-- ----------------------------

DROP TABLE IF EXISTS `ReportOperatore`;
CREATE TABLE `ReportOperatore` (
  `CodOperatore` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `Data` date NOT NULL,
  `Operazione` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodOperatore`, `Operazione`),
  FOREIGN KEY (`Operazione`)
  REFERENCES `Operazione` (`CodOperazione`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- ----------------------------
--  Table structure for `ReportOperatore`
-- ----------------------------

DROP TABLE IF EXISTS `ReportOperatore`;
CREATE TABLE `ReportOperatore` (
  `DataReport` date NOT NULL,
  `Operatore` int(5) zerofill NOT NULL,
  `OperazioneCampione` int(5) zerofill NOT NULL,
  `Tempo` int(5) NOT NULL,
  PRIMARY KEY (`DataReport`, `Operatore`, `OperazioneCampione`),
  FOREIGN KEY (`Operatore`)
  REFERENCES `Operatore` (`CodOperatore`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`OperazioneCampione`)
  REFERENCES `OperazioneCampione` (`CodOperazioneCampione`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Parte`
-- ----------------------------

DROP TABLE IF EXISTS `Parte`;
CREATE TABLE `Parte` (
  `CodParte` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `NomeParte` char(50) NOT NULL,
  `Peso` int NOT NULL,
  `CoeffSvalutazione` float NOT NULL,
  `PrezzoParte` float(7,2) NOT NULL,
  PRIMARY KEY (`CodParte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;-


-- ----------------------------
--  Table structure for `Precedenza`
-- ----------------------------

DROP TABLE IF EXISTS `Precedenza`;
CREATE TABLE `Precedenza` (
 `Parte1` int(5) zerofill NOT NULL,
 `Parte2` int(5) zerofill NOT NULL,
  PRIMARY KEY (`Parte1`, `Parte2`),
  FOREIGN KEY (`Parte1`)
  REFERENCES `Parte` (`CodParte`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`Parte2`)
  REFERENCES `Parte` (`CodParte`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;-


-- ----------------------------
--  Table structure for `Costituire`
-- ----------------------------

DROP TABLE IF EXISTS `Costituire`;
CREATE TABLE `Costituire` (
  `Parte` int(5) zerofill NOT NULL,
  `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  PRIMARY KEY (`Parte`, `Marca`, `Modello`),
  FOREIGN KEY (`Parte`)
  REFERENCES `Parte` (`CodParte`)
  on delete NO ACTION
  on update NO ACTION,
   FOREIGN KEY (`Marca`, `Modello`)
  REFERENCES `Prodotto` (`Marca`, `Modello`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;-


-- ----------------------------
--  Table structure for `Materiale`
-- ----------------------------

DROP TABLE IF EXISTS `Materiale`;
CREATE TABLE `Materiale` (
  `NomeMateriale` char(50) NOT NULL,
  `Valore` float(7,2) NOT NULL,
  PRIMARY KEY (`NomeMateriale`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;-


-- ----------------------------
--  Table structure for `Composizione`
-- ----------------------------

DROP TABLE IF EXISTS `Composizione`;
CREATE TABLE `Composizione` (
  `Parte` int(5) zerofill NOT NULL,
  `Materiale` char(50) NOT NULL,
  `Quantità` int NOT NULL,
  PRIMARY KEY (`Parte`, `Materiale`),
  FOREIGN KEY (`Parte`)
  REFERENCES `Parte` (`CodParte`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`Materiale`)
  REFERENCES `Materiale` (`NomeMateriale`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;-


-- ----------------------------
--  Table structure for `MotivazioneReso`
-- ----------------------------

DROP TABLE IF EXISTS `MotivazioneReso`;
CREATE TABLE `MotivazioneReso` (
  `CodMotivazione` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `NomeMotivazione` char(50) NOT NULL,
  `DescMotivazione` char(255) NOT NULL,
  PRIMARY KEY (`CodMotivazione`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;-


-- ----------------------------
--  Table structure for `Reso`
-- ----------------------------

DROP TABLE IF EXISTS `Reso`;
CREATE TABLE `Reso` (
  `CodReso` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `CodSeriale` int(5) zerofill NOT NULL,
  `Motivazione` int(5) zerofill NOT NULL,
  `Data` date NOT NULL,
  PRIMARY KEY (`CodReso`),
  FOREIGN KEY (`CodSeriale`)
  REFERENCES `ProdottoSpecifico` (`CodSeriale`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`Motivazione`)
  REFERENCES `MotivazioneReso` (`CodMotivazione`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Test`
-- ----------------------------

DROP TABLE IF EXISTS `Test`;
CREATE TABLE `Test` (
  `CodTest` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `NomeTest` char(50) NOT NULL,
  PRIMARY KEY (`CodTest`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Refurbishment`
-- ----------------------------

DROP TABLE IF EXISTS `Refurbishment`;
CREATE TABLE `Refurbishment` (
  `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  `CodTest` int(5) zerofill NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Marca`, `Modello`, `CodTest`),
   FOREIGN KEY (`Marca`, `Modello`)
  REFERENCES `Prodotto` (`Marca`, `Modello`)
  on delete NO ACTION
  on update NO ACTION,
 FOREIGN KEY (`CodTest`)
  REFERENCES `Test` (`CodTest`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `SuccessioneTest`
-- ----------------------------

DROP TABLE IF EXISTS `SuccessioneTest`;
CREATE TABLE `SuccessioneTest` (
  `TestPrecedente` int(5) zerofill NOT NULL,
  `TestSuccessivo` int(5) zerofill NOT NULL,
  PRIMARY KEY (`TestPrecedente`, `TestSuccessivo`),
  FOREIGN KEY (`TestPrecedente`)
  REFERENCES `Test` (`CodTest`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`TestSuccessivo`)
  REFERENCES `Test` (`CodTest`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Ricondizionamento`
-- ----------------------------

DROP TABLE IF EXISTS `Ricondizionamento`;
CREATE TABLE `Ricondizionamento` (
  `CodSeriale` int(5) zerofill NOT NULL,
  `Categoria` char(50) NOT NULL,
  `Sconto` enum('10%', '20%', '30%', '50%') NOT NULL,
  `Data` date NOT NULL,
  PRIMARY KEY (`CodSeriale`, `Data`),
  FOREIGN KEY (`CodSeriale`)
  REFERENCES `ProddottoSpecifico` (`CodSeriale`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `PartiRicondizionate`
-- ----------------------------

DROP TABLE IF EXISTS `PartiRicondizionate`;
CREATE TABLE `PartiRicondizionate` (
  `CodSeriale` int(5) zerofill NOT NULL,
  `Parte` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodSeriale`, `Parte`),
  FOREIGN KEY (`CodSeriale`)
  REFERENCES `ProdottoSpecifico` (`CodSeriale`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`Parte`)
  REFERENCES `Parte` (`CodParte`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;



-- ----------------------------
-- `CREAZIONE DEI TRIGGER`
-- ----------------------------

# Trigger che vieta l'acquisto di Prodotti Specifici se già acquistati

DROP TRIGGER IF EXISTS Prodotti_non_acquistabili;
DELIMITER $$
CREATE TRIGGER Prodotti_non_acquistabili
BEFORE INSERT ON Ordinazione
FOR EACH ROW
	BEGIN
		IF new.CodSeriale IN	
			(SELECT CodSeriale
            FROM Ordinazione)
		THEN
			signal sqlstate '45000'
        SET MESSAGE_TEXT = "Prodotto non acquistabile";
		END IF;
	END $$ 
DELIMITER ;

# Trigger che vieta il reso di prodotti resi precedentemente

DROP TRIGGER IF EXISTS Prodotti_resi_precedentemente;
DELIMITER $$
CREATE TRIGGER Prodotti_resi_precedentemente
BEFORE INSERT ON Reso
FOR EACH ROW
	BEGIN
		IF new.CodSeriale IN	
			(SELECT CodSeriale
            FROM Reso)
		THEN
			signal sqlstate '45000'
        SET MESSAGE_TEXT = "Prodotto non rendibile";
		END IF;
	END $$ 
DELIMITER ;

# Trigger che aggiorna gli attributi ridondanti NumValutazioni e TotValutazioni 
# di Prodotto

DROP TRIGGER IF EXISTS Valutazioni_prodotto;
DELIMITER $$
CREATE TRIGGER Valutazioni_prodotto
AFTER INSERT on Recensione
FOR EACH ROW
	BEGIN
		UPDATE Prodotto 
		SET NumValutazioni= NumValutazioni+1 , TotValutazioni= TotValutazioni+NEW.Voto
        WHERE Prodotto.Marca=NEW.Marca
			AND Prodotto.Modello=NEW.Modello;
	END $$
DELIMITER ;


# Trigger che aggiorna l'attributo ridondante Venduto di Prodotto

DROP TRIGGER IF EXISTS Prodotti_venduti;
DELIMITER $$
CREATE TRIGGER Prodotti_venduti
AFTER INSERT on Ordinazione
FOR EACH ROW
	BEGIN
		UPDATE Prodotto 
		SET NumVendite = NumVendite + 1 
        WHERE Prodotto.Marca=  (SELECT Marca
								FROM ProdottoSpecifico
								WHERE CodSeriale = NEW.CodSeriale)
			AND Prodotto.Modello=  (SELECT Modello
									FROM ProdottoSpecifico 
									WHERE CodSeriale = NEW.CodSeriale);

	END $$
DELIMITER ;



# Trigger che vieta l'attivazione di garanzie non proposte per un dato prodotto

DROP TRIGGER IF EXISTS garanzieNonProposte;
DELIMITER $$
CREATE TRIGGER garanzieNonProposte
BEFORE INSERT ON Attivazione
FOR EACH ROW 
BEGIN 
DECLARE Marca_ VARCHAR(50);
DECLARE Modello_ VARCHAR(50);
DECLARE Presente_ SMALLINT;
 SET Marca_ = 
		(SELECT p.marca
        FROM prodotto p INNER JOIN prodottoSpecifico ps
			ON (p.Marca=ps.Marca AND p.Modello=ps.Modello) 
        WHERE ps.CodSeriale = new.CodSeriale);
        
	SET modello_ =
		(SELECT p.modello
        FROM Prodotto p INNER JOIN ProdottoSpecifico ps
			ON (p.Marca=ps.Marca AND p.Modello=ps.Modello) 
        WHERE ps.CodSeriale =new.CodSeriale);

	SELECT count(*) INTO Presente_ 
    FROM Propone gp
    WHERE gp.modello = Modello_ AND gp.Marca = Marca_ 
		AND gp.CodGaranzia=new.CodGaranzia;
        
	IF Presente_ = 0 THEN 
		signal sqlstate '45000'
        SET MESSAGE_TEXT = "Garanzia non attivabile per il prodotto inserito" ;
		end if;
		end$$
        DELIMITER ;
        


-- ----------------------------
-- `CREAZIONE DELLE PROCEDURE`
-- ----------------------------



# Operazione 1: Inserimento di un nuovo utente

DROP PROCEDURE IF EXISTS Nuovo_utente;
DELIMITER $$
CREATE PROCEDURE Nuovo_utente (IN _cod_fiscale varchar(16), IN _username varchar(50), 
	IN _nome varchar(50), IN _cognome varchar(50), IN _indirizzo varchar(50), 
	IN _num_telefono varchar(50), IN _tipologia enum('Carta identita', 'Patente', 'Altro'),
    IN _numero varchar(50), IN _ente varchar(50), IN _scadenza date,
    IN _password varchar(50), IN _domanda varchar(50), IN _risposta varchar(50))
    BEGIN
		INSERT INTO Utente
        VALUES (_cod_fiscale, current_date(), _username, _nome, _cognome, _indirizzo,
        _num_telefono);
        
        INSERT INTO Documento
        VALUES (_tipologia, _numero, _cod_fiscale, _ente, _scadenza);
        
        INSERT INTO Login
        VALUES (_username, _password, _domanda, _risposta);
    END $$ 
DELIMITER ;


# Operazione 2: Creazione di un ordine

DROP PROCEDURE IF EXISTS Crea_ordine;
DELIMITER $$
CREATE PROCEDURE Crea_ordine(IN _username VARCHAR(50), IN _pr1 INT(5), 
	IN _pr2 INT(5), IN _pr3 INT(5), IN _pr4 INT(5)
	, IN _pr5 INT(5), IN _indirizzo VARCHAR(50))
BEGIN
	DECLARE cod_ordine_ INT;
    
	INSERT INTO ordine
    VALUES (0, _username, 'in processazione', _indirizzo, NULL);
    
    SET cod_ordine_ = last_insert_id();
    
		IF _pr5 IS NOT NULL
		THEN
			INSERT INTO Ordinazione
			VALUES(cod_ordine_, _pr1);
			INSERT INTO Ordinazione
			VALUES(cod_ordine_, _pr2);
            INSERT INTO Ordinazione
			VALUES(cod_ordine_, _pr3);
            INSERT INTO Ordinazione
			VALUES(cod_ordine_, _pr4);
            INSERT INTO Ordinazione
			VALUES(cod_ordine_, _pr5);
            
            
		ELSEIF _pr4 IS NOT NULL
			THEN
			INSERT INTO Ordinazione
			VALUES(cod_ordine_, _pr1);
			INSERT INTO Ordinazione
			VALUES(cod_ordine_, _pr2);
            INSERT INTO Ordinazione
			VALUES(cod_ordine_, _pr3);
            INSERT INTO Ordinazione
			VALUES(cod_ordine_, _pr4);
	
		ELSEIF _pr3 IS NOT NULL
			THEN
				INSERT INTO Ordinazione
				VALUES(cod_ordine_, _pr1);
				INSERT INTO Ordinazione
				VALUES(cod_ordine_, _pr2);
				INSERT INTO Ordinazione
				VALUES(cod_ordine_, _pr3);
            
        ELSEIF _pR2 IS NOT NULL
			THEN	
                INSERT INTO Ordinazione
				VALUES(cod_ordine_, _pr1);
				INSERT INTO Ordinazione
				VALUES(cod_ordine_, _pr2);
		
            
		ELSEIF _pR1 IS NOT NULL
			THEN	
                INSERT INTO Ordinazione
				VALUES(cod_ordine_, _pr1);
		END IF;

	END$$
	DELIMITER ;
        

# Operazione 3: Visualizzazione della valutazione media di un prodotto

DROP PROCEDURE IF EXISTS Valutazione_media;
DELIMITER $$
CREATE PROCEDURE Valutazione_media (IN _marca varchar(50), IN _modello varchar(50))
    BEGIN
		SELECT TotValutazioni/NumValutazioni as ValutazioneMedia
        FROM Prodotto
        WHERE Marca=_marca
			AND Modello=_modello;
    END $$ 
DELIMITER ;


# Operazione 4: Visualizzazione parti costituenti di un prodotto

DROP PROCEDURE IF EXISTS Parti_prodotto;
DELIMITER $$
CREATE PROCEDURE Parti_prodotto (IN _marca varchar(50), IN _modello varchar(50))
    BEGIN
		SELECT p.CodParte AS Codice, p.nomeparte AS Nome
        FROM Costituire pp INNER JOIN Parte p on pp.parte = p.CodParte
        WHERE Marca=_marca
			AND Modello=_modello;
    END $$ 
DELIMITER ;


# Operazione 5: Aggiornamento della posizione di un lotto all'interno di un magazzino

DROP PROCEDURE IF EXISTS Posizione_lotto;
DELIMITER $$
CREATE PROCEDURE Posizione_lotto (IN _lotto int(5), IN _corridoio int(3), IN _altezza char(2), IN _scaffale int(3), IN _magazzino int(5))
    BEGIN
		UPDATE Ubicazione
        SET DataSpostamento=current_date()
        WHERE Lotto=_lotto;
        
		INSERT Ubicazione
		VALUES (_lotto, _corridoio, _altezza, _scaffale, _magazzino, current_date(), null);
    END $$ 
DELIMITER ;


# Operazione 6: Visualizza tutti i possibili guasti e i relativi rimedi di un prodotto

DROP PROCEDURE IF EXISTS Assistenza_virtuale;
DELIMITER $$
CREATE PROCEDURE Assistenza_virtuale (IN _marca varchar(50), IN _modello varchar(50))
    BEGIN
		SELECT G.Nome AS NomeGuasto, E.CodErrore AS CodiceErrore, 
			R.DescRimedio AS DescrizioneRimedio
        FROM Problematica E inner join AssistenzaVirtuale A on E.CodGuasto=A.CodGuasto 
			INNER JOIN Rimedio R on A.CodRimedio = r.CodRimedio
			INNER JOIN guasto G on A.CodGuasto = G.CodGuasto
        WHERE Marca=_marca
			AND Modello=_modello;
    END $$ 
DELIMITER ;

        
# Operazione 7: Inserimento di una recensione

DROP PROCEDURE IF EXISTS Inserisci_Recensione;
DELIMITER $$
CREATE PROCEDURE Inserisci_recensione(IN _username VARCHAR(50), IN _cod_seriale INT(5),
	IN _esperienza_uso char(1), IN _affidabilita char(1), 
    IN _performance char(1), IN _voto char(1), IN _testo char(50))
BEGIN
	DECLARE Marca_ VARCHAR(50);
    DECLARE Modello_ VARCHAR(50);
	
    SET Marca_ = 
		(SELECT p.marca
        FROM prodotto p INNER JOIN prodottoSpecifico ps
			ON (p.Marca=ps.Marca AND p.Modello=ps.Modello) 
        WHERE ps.CodSeriale = _cod_seriale);
        
	SET modello_ =
		(SELECT p.modello
        FROM Prodotto p INNER JOIN ProdottoSpecifico ps
			ON (p.Marca=ps.Marca AND p.Modello=ps.Modello) 
        WHERE ps.CodSeriale = _cod_seriale);
        
    INSERT INTO Recensione   
	VALUES (marca_, modello_, _username, _voto, _testo, 
		_affidabilita, _performance, _esperienza_uso);
	END $$
    DELIMITER ;
        
# Operazione 8: Visualizzazione garanzie disponibili per un prodotto

DROP PROCEDURE IF EXISTS Visualizza_garanzie;
DELIMITER $$
CREATE PROCEDURE Visualizza_garanzie(IN _marca VARCHAR(50), 
	IN _modello VARCHAR(50))
BEGIN
	SELECT G.*
    FROM Propone GP inner join Garanzia G
		on (GP.CodGaranzia = G.CodGaranzia)
    WHERE GP.Marca = _marca and GP.Modello = _modello;
END$$
DELIMITER ;


# Operazione 9: Attivazione di una garanzia 

DROP PROCEDURE IF EXISTS Attiva_garanzia;
DELIMITER $$
CREATE PROCEDURE Attiva_garanzia(IN _cod_seriale INT(5), IN _cod_garanzia INT(5))
BEGIN
	INSERT INTO Attivazione
    VALUES(_cod_garanzia, _cod_seriale, current_date);
END $$
DELIMITER ;
	

# Operazione 10: Inserimento di un nuovo intervento

DROP PROCEDURE IF EXISTS Nuovo_Intervento;
DELIMITER $$
CREATE PROCEDURE Nuovo_Intervento(IN data_intervento_ DATE, IN Zona_ VARCHAR(50), IN Cod_ticket INT)
BEGIN

DECLARE _tecnico INT;
DECLARE _fascia_oraria CHAR(255);

SET _tecnico = (SELECT t.CodTecnico
	FROM interventi t
 	WHERE t.zona = ZONA_ AND t.DataIntervento = data_intervento_
    GROUP BY CodTecnico
    HAVING count(*) <5);
    #caso in cui non ci siano tecnici quel giorno in quella zona oppure che i tecnici
    # quel giorno abbiano già 5 interventi da effettuare
	
    IF _tecnico IS NULL THEN	
	SIGNAL SQLSTATE '45000'						
	SET MESSAGE_TEXT = "Nessun tecnico disponibile. 
    Chiamare la procedura Nuovo_intervento_tecnico" ;
    END IF;
    
    IF "8.00-9.30" NOT IN
			(SELECT FasciaOraria
			FROM interventi
            WHERE CodTecnico = _tecnico
				AND DataIntervento = data_intervento_
                AND zona = ZONA_)
        THEN 
			SET _fascia_oraria = "8.00-9.30";
    
		ELSEIF "10.00-11.30" NOT IN 
				(SELECT FasciaOraria
			FROM interventi
            WHERE CodTecnico = _tecnico
				AND DataIntervento = data_intervento_
                AND zona = ZONA_)
			THEN 
				SET _fascia_oraria = "10.00-11.30";
		
        ELSEIF "12.00-13.30" NOT IN
				(SELECT FasciaOraria
			FROM interventi
            WHERE CodTecnico = _tecnico
				AND DataIntervento = data_intervento_
                AND zona = ZONA_)
			THEN 
				SET _fascia_oraria = "12.00-13.30";
		
		ELSEIF "15.00-16.30" NOT IN
				(SELECT FasciaOraria
			FROM interventi
            WHERE CodTecnico = _tecnico
				AND DataIntervento = data_intervento_
                AND zona = ZONA_)
			THEN 
				SET _fascia_oraria = "15.00-16.30";
                
		ELSEIF "17.00-18.30" NOT IN
				(SELECT FasciaOraria
			FROM interventi
            WHERE CodTecnico = _tecnico
				AND DataIntervento = data_intervento_
                AND zona = ZONA_)
			THEN 
				SET _fascia_oraria = "17.00-18.30";
    
    	END IF;
	
    INSERT INTO Interventi
		VALUES(_tecnico, Cod_ticket, data_intervento_, _fascia_oraria, zona_);
        
	SELECT *
    FROM INTERVENTI t
    WHERE t.CodTecnico = _tecnico AND t.dataintervento = data_intervento_ AND
		t.fasciaoraria = _fascia_oraria AND t.zona = zona_;
    
    END $$
    delimiter ;
    
# Operazione 11 Inserimento di un reso 

DROP PROCEDURE IF EXISTS Reso;
DELIMITER $$
CREATE PROCEDURE Reso(IN _cod_seriale INT(5), IN _motivazione INT(5))
BEGIN
	INSERT INTO RESO
    VALUES(0, _cod_seriale, _motivazione, current_date );
END $$ 
DELIMITER ;

# Operazione 12: Visualizzazione numero di vendite di un prodotto

DROP PROCEDURE IF EXISTS Vendite_prodotto;
DELIMITER $$
CREATE PROCEDURE Vendite_prodotto(IN _marca VARCHAR(50), IN _modello VARCHAR(50))
BEGIN
	SELECT NumVendite
	FROM Prodotto P
	WHERE P.Marca = _Marca and P.Modello = _Modello;
END $$ 
DELIMITER ;


# Operazione 13: Inserimento di un nuovo intervento aggiungendo il CodTecnico

DROP PROCEDURE IF EXISTS Nuovo_Intervento_Tecnico;
DELIMITER $$
CREATE PROCEDURE Nuovo_Intervento_Tecnico(IN data_intervento_ DATE, IN Zona_ VARCHAR(50),
	IN Tecnico_ INT, IN Cod_ticket INT)
BEGIN
INSERT INTO Interventi
	VALUES (Tecnico_, Cod_ticket, data_intervento_, "8.00-9.30", Zona_);
END$$
DELIMITER ;


-- ----------------------------
-- `POPOLAMENTO DEL DATABASE`
-- ----------------------------
# Inserimenti in Categoria

INSERT INTO Categoria
VALUES ("Console", "Un apparecchio elettronico creato principalmente per giocare con i videogiochi"),
    ("Televisione", "Sistema di telecomunicazione destinato alla trasmissione di programmi televisivi"),
	("Tablet", "Computer portatile di dimensioni ridotte, sul cui schermo è possibile scrivere"),
	("Frigorifero", "Apparecchio capace di produrre e mantenere una temperatura sufficientemente bassa per un determinato uso"),
	("Telefono", "Dispositivo che permette la trasmissione a distanza di voci e suoni"),
    ("Frullatore", "Elettrodomestico con organo rotante per ridurre in poltiglia gli ingredienti di bevande o salse");
    

# Inserimenti in Prodotto

INSERT INTO Prodotto
VALUES ("Apple", "iPhone5", 2, "iPhone5", 0, 0, 0, "Telefono"),
    ("Apple", "iPhone6", 2, "iPhone6", 0, 0, 0, "Telefono"),
	("Apple", "iPhone7", 2, "iPhone7", 0, 0, 0, "Telefono"),
	("LG", "SmartTVOLED", 2, "Oled558CPLA", 0, 0, 0, "Televisione"),
	("LG", "SmartTVQLED", 2, "Oled612CPLB",  0, 0, 0, "Televisione"),
    ("Sony", "PlayStation4", 6, "Playstation4", 0, 0, 0, "Console"),
	("Sony", "PlayStation3", 6, "Playstation3", 0, 0, 0, "Console"),
    ("Samsung", "GalaxyTabS6", 2, "SamsungGalaxyTabS6", 0, 0, 0, "Tablet"),
    ("Electroline", "BME-309X", 6, "RerifregeratorX", 0, 0, 0, "Frigorifero"),
    ("Trevi", "Turbillon", 3, "PR168", 0, 0, 0, "Frullatore");
    
    
# Inserimenti in Variante

INSERT INTO Variante 
VALUES (0, "Colore", "Bianco", null),
	(0, "Colore", "Nero", null),
    (0, "Colore", "Azzurro", null),
    (0, "Colore", "Giallo", null),
    (0, "Memoria", "32", "GB"),
    (0, "Memoria", "64", "GB"),
	(0, "Dimensione", "30", "Pollice"),
    (0, "Dimensione", "42", "Pollice"),
    (0, "Dimensione", "50", "Pollice"),
    (0, "Dimensione", "70", "Pollice"),
	(0, "Capacità", "400", "Litri"),
    (0, "Capacità", "150", "Litri"),
    (0, "Capacità", "300", "Litri"),
	(0, "NumSportelli", "2", null),
    (0, "NumSportelli", "3", null),
    (0, "NumSportelli", "4", null);
    
	
# Inserimenti in Parte
INSERT INTO Parte
	VALUES 
		(0, "BatteriaiPhone", 20, 0.9, 40),
        (0, "SchermoiPhone", 20, 0.7, 150),
		(0, "SchermoLCD", 40, 0.5, 120),
		(0, "SchermoOLED", 80, 0.6, 170),
        (0, "SchedaMadre", 100, 0.7, 150),
        (0, "CPU", 25, 0.7, 80),
        (0, "CaseIphone5", 70, 0.9, 50),
        (0, "CaseIphone6", 70, 0.9, 50),
        (0, "CaseIphone7", 70, 0.9, 50),
        (0, "Batteria Frigorifero", 1000, 0.7, 40),
		(0, "Sportello", 10000, 0.7, 40),
		(0, "Ripiani", 1000, 0.3, 15),
		(0, "Ventola", 1000, 0.6, 60),
		(0, "Lampadina", 20, 0.7, 5),
        (0, "Scocca", 20000, 0.7, 240),
        (0, "Batteria Samsung", 50, 0.8, 20),
        (0, "Schermo Tablet", 200, 0.4, 90),
        (0, "CPU Samsung", 130, 0.8, 90),
        (0, "Case", 90, 0.7, 120),
        (0, "Struttura iniziale iPhone", 500, 0.6, 70),
        (0, "Struttura iniziale televisore", 3000, 0.5, 90),
        (0, "Struttura iniziale tablet", 1000, 0.7, 90);
        
        
        
# Inserimenti in Costituire

INSERT INTO Costituire
	VALUES
		(00001, "Apple", "iPhone5"),
        (00002, "Apple", "iPhone5"),
        (00004, "Apple", "iPhone5"),
        (00005, "Apple", "iPhone5"),
        (00001, "Apple", "iPhone6"),
		(00003, "Apple", "iPhone6"),
        (00004, "Apple", "iPhone6"),
        (00005, "Apple", "iPhone6"),
        (00007, "Apple", "iPhone6"),
        (00009, "Electroline", "BME-309X"),
		(00010, "Electroline", "BME-309X"),
		(00011, "Electroline", "BME-309X"),
		(00012, "Electroline", "BME-309X"),
		(00013, "Electroline", "BME-309X"),
		(00014, "Electroline", "BME-309X"),
		(00015, "Samsung", "GalaxyTabS6"),
		(00016, "Samsung", "GalaxyTabS6"),
		(00017, "Samsung", "GalaxyTabS6");
	
    
# Inserimenti in SerieOperazioni

INSERT INTO SerieOperazioni
	VALUES
		(0, 40),
        (0, 80),
        (0, 70),
        (0, 120);
    
    
# Inserimenti in ProdottoSpecifico

INSERT INTO ProdottoSpecifico
	VALUES
		(0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
        (0, "Apple", "iPhone5", 1, 0),
		(0, "Electroline", "BME-309X", 2, 0),
        (0, "Electroline", "BME-309X", 2, 0),
        (0, "Electroline", "BME-309X", 2, 0),
        (0, "Electroline", "BME-309X", 2, 0),
		(0, "Samsung", "GalaxyTabS6", 3, 0),
        (0, "Samsung", "GalaxyTabS6", 3, 0),
        (0, "Samsung", "GalaxyTabS6", 3, 0),
        (0, "Samsung", "GalaxyTabS6", 3, 0),
        (0, "Samsung", "GalaxyTabS6", 3, 0),
        (0, "Samsung", "GalaxyTabS6", 3, 0),
        (0, "Samsung", "GalaxyTabS6", 3, 0);
    

# Inserimenti in Garanzia
INSERT INTO Garanzia
VALUES  (0, 20, 6, "Schermo"),
		(0, 50, 12, "Memoria"),
        (0, 80, 24, "Schermo"),
        (0, 30, 6, "Scocca"),
        (0, 50, 12, "Batteria"),
        (0, 90, 24, "Batteria"),
        (0, 80, 12, "Scocca"),
        (0, 70, 12, "Impianto elettrico"),
        (0, 120, 24, "Impianto elettrico"),
        (0, 60, 12, "Lame");
        
# Inserimenti in Propone
INSERT INTO Propone
VALUES  (00003, "Apple", "iPhone7"),
		(00001, "Apple", "iPhone7"),
        (00003, "Apple", "iPhone6"),
        (00001, "Apple", "iPhone5"),
        (00002, "Apple", "iPhone5"),
        (00002, "Apple", "iPhone6"),
        (00004, "Electroline", "BME-309X"),
        (00007, "Electroline", "BME-309X"),
        (00006, "Electroline", "BME-309X"),
        (00009, "Electroline", "BME-309X"),
        (00002, "Samsung", "GalaxyTabS6"),
        (00003, "Samsung", "GalaxyTabS6"),
        (00008, "Samsung", "GalaxyTabS6");
        

# Inserimenti in Predisposizione
INSERT INTO Predisposizione
VALUES 	(1, NULL, NULL, NULL),
		(2, 100, "Media", 20);
	
   

# Inserimenti in Operazione
INSERT INTO Operazione
VALUES  (0, "no", "Inserimento batteria", 2, 00001),
		(0, "no", "Inserimento batteria", 2, 00010),
        (0, "no", "Inserimento batteria", 2, 00016),
		(0, "si", "Inserimento schermo", 1, 00002),
        (0, "si", "Inserimento schermo", 1, 00003),
        (0, "si", "Inserimento schermo", 1, 00004),
        (0, "si", "Inserimento schermo", 1, 00017),
        (0, "si", "Inserimento scheda madre", 2, 00005),
        (0, "no", "Inserimento CPU", 2, 00006),
        (0, "no", "Inserimento CPU Samsung", 2, 00018),
        (0, "no", "Inserimento Case", 2, 00007),
        (0, "no", "Inserimento Case", 2, 00019),
        (0, "si", "Inserimento oggetti", 3, 00011),
        (0, "si", "Inserimento oggetti", 3, 00012),
        (0, "si", "Inserimento ventola", 4, 00013),
		(0, "no", "Inserimento lampadina", 4, 00014),
        (0, "si", "Assemblaggio scocca", 4, 00015),
        (0, "si", "Assemblaggio struttura", 4, 00020),
        (0, "si", "Asseblaggio struttura", 4, 00021),
        (0, "si", "Asseblaggio struttura", 4, 00022),
        (0, "no", "Inserimento Case", 2, 00008);   
   
# Inserimenti in Sequenza
INSERT INTO Sequenza
	VALUES
		(00001, 0009, 3),
        (00001, 00018, 1),
        (00001, 00008, 2),
        (00001, 00011, 4),
        (00001, 00004, 6),
        (00001, 00001, 5),
        (00002, 00017, 1),
        (00002, 00016, 3),
		(00002, 00014, 6),
        (00002, 00015, 4),
        (00002, 00002, 2),
        (00002, 00013, 5),
        (00003, 00020, 1),
        (00003, 00008, 2),
        (00003, 00003, 5),
        (00003, 00010, 4),
        (00003, 00012, 3),
        (00003, 00007, 6);
        
# Inserimenti in Lotto
INSERT INTO Lotto
VALUES  (0, "2012-08-23", "Milano", 3, 3, 1,1),
		(0, "2015-05-13", "Milano", 3, 3, 1,3),
        (0, "2017-03-26", "Roma", 3,4, 1,4),
        (0, "2012-08-25", "Roma", 4, 4, 1,1),
        (0, "2015-10-06", "Milano", 9, 9, 1,2),
        (0, "2020-03-08", "Pisa", 2, 1, 1,3),
        (0, "2018-011-29", "Firenze", 5, 4, 1,3),
        (0, "2017-01-22", "Pisa", 6, 6, 1,3),
        (0, "2014-05-15", "Salerno", 3, 5, 1,4),
        (0, "2011-07-18", "Torino", 2, 2, 1,2),
        (0, "2018-08-01", "Genova", 2, 3, 1,2);
        
# Inserimenti in Guasto
INSERT INTO Guasto
VALUES  (0, "Non risposta ai comandi TouchScreen", "Schermo"),
		(0, "Problemi di ricezione WiFi", "Connessione"),
        (0, "Malfunzionamento audio cassa superiore", "Audio"),
        (0, "Malfunzionamento audio cassa inferiore", "Audio"),
        (0, "Fotocamera anteriore sfocata", "Fotocamera"),
        (0, "Malfunzionamento lettura impronta digitale", "Altro"),
        (0, "Malfunzionamento flash fotocamera", "Fotocamera"),
        (0, "Fotocamera posteriore sfocata", "Fotocamera"),
        (0, "Lampadina non si accende all'apertura", "Impianto elettrico"),
        (0, "Frigorifero non raffredda sufficientemente", "Impianto elettrico"),
        (0, "Temperatura troppo bassa", "Impianto elettrico") ,
        (0, "Presenza di acqua nel vano frigorifero", "Convogliatore"),
        (0, "Lame non tagliano", "Lame"),
        (0, "Malfunzionamento regolatore di velocita", "Impianto elettrico"),
        (0, "Ugello non ruota bene o non ruota affatto", "Ugello");
        



# Inserimenti in Problematica
INSERT INTO Problematica
VALUES 	(1, "Apple", "iPhone5", 1),
		(2, "Apple", "iPhone5", 2),
        (3, "Apple", "iPhone5", 3),
        (4, "Apple", "iPhone5", 4),
        (5, "Apple", "iPhone5", 5),
        (6, "Apple", "iPhone5", 6),
        (7, "Apple", "iPhone5", 7),
        (8, "Apple", "iPhone5", 8),
        (1, "Apple", "iPhone6", 1),
        (2, "Apple", "iPhone6", 2),
        (3, "Apple", "iPhone6", 3),
        (4, "Apple", "iPhone6", 4),
        (5, "Apple", "iPhone6", 5),
        (6, "Apple", "iPhone6", 6),
		(7, "Apple", "iPhone6", 7),
		(8, "Apple", "iPhone6", 8),
        (1, "Apple", "iPhone7", 1),
        (2, "Apple", "iPhone7", 2),
        (3, "Apple", "iPhone7", 3),
        (4, "Apple", "iPhone7", 4),
        (5, "Apple", "iPhone7", 5),
        (6, "Apple", "iPhone7", 6),
		(7, "Apple", "iPhone7", 7),
		(8, "Apple", "iPhone7", 8),
        (9, "Electroline", "BME-309X", 1),
        (10, "Electroline", "BME-309X", 2),
        (11, "Electroline", "BME-309X", 3),
        (12, "Electroline", "BME-309X", 4),
        (13, "Trevi", "Turbillon", 1),
        (14, "Trevi", "Turbillon", 2),
        (15, "Trevi", "Turbillon", 3),
		(1, "Samsung", "GalaxyTabS6", 1),
        (2, "Samsung", "GalaxyTabS6", 2),
        (3, "Samsung", "GalaxyTabS6", 3),
        (4, "Samsung", "GalaxyTabS6", 4),
        (5, "Samsung", "GalaxyTabS6", 5),
        (6, "Samsung", "GalaxyTabS6", 6),
        (7, "Samsung", "GalaxyTabS6", 7),
		(8, "Samsung", "GalaxyTabS6", 8);
        
# Inserimenti in Rimedio
INSERT INTO Rimedio
VALUES 	(1, "Tenere premuto il tasto di spegnimento fino al riavvio"),
		(2, "Pulire con un panno morbido la fotocamera"),
        (3, "Caricare il telefono fino al 10%"),
        (4, "Pulire eventuali eccessi di polvere dalla cassa"),
        (5, "Cambiare lampadina"),
        (6, "Pulire condensatore"),
        (7, "Girare la manopola della temperatura su un valore superiore"),
        (8, "Disostruire convogliatore"),
        (9, "Affilare le lame"),
        (10, "Staccare e riattacare la spina di corrente"),
        (11, "Diminuire il carico");
        
        
# Inserimenti in AssistenzaVirtuale
INSERT INTO AssistenzaVirtuale
VALUES 	(1, 1), 
		(2, 1),
        (6, 1),
		(7, 3),
        (5, 2),
        (8, 2),
        (3, 4),
        (4, 4),
        (9, 5),
        (10, 6),
        (11, 7),
        (12, 8),
        (13, 9),
        (14, 10),
        (15, 11);
        
        

# Inserimenti in Tecnico
INSERT INTO Tecnico
VALUES  (1), (2), (3), (4), (5);
  


# Inserimenti in RimedioFisico
INSERT INTO RimedioFisico
VALUES  (0, 'si', 25.00), (0, 'si', 32.00), (0, 'si', 11.00);



# Inserimenti in Precedenza
INSERT INTO Precedenza
VALUES  (00020, 00005),
		(00020, 00006),
        (00020, 00007),
		(00020, 00008),
        (00020, 00009),
        (00006, 00001),
        (00007, 00001),
        (00008, 00001),
        (00001, 00002),
        (00015, 00010),
        (00010, 00013),
        (00010, 00014),
        (00013, 00011),
        (00011, 00012),
        (00022, 00005),
        (00022, 00018),
        (00022, 00019),
        (00014, 00011),
        (00018, 00016),
        (00019, 00016),
        (00016, 00017);
        

# Inserimenti in MotivazioneReso
INSERT INTO MotivazioneReso
VALUES  (0, "Accensione", "Il prodotto non si accende"),
		(0, "Memoria occcupata", "La memoria del dispositivo risulta piena"),
        (0, "Schermo rotto", "Lo schermo del dispositivo è rovinato oppure il touch non funziona"),
        (0, "Lampadina rotta", "La lampadina non si accende nonostante il resto del prodotto funzioni"),
        (0, "Malfunzionamento ventola", "La ventola del prodotto non fa mantenere la temperatura adeguata all'interno"),
        (0, "Disgiunzione materiale", "Il prodotto deve essere riassemblato correttamente"),
        (0, "Malfunzionamento", "Malfunzionamento delle parti interne del dispositivo"),
        (0, "Batteria dispositivo", "La batteria del dispositivo non si carica oppure ha una durata breve");
        
        
        
# Inserimenti in Utilizzo
INSERT INTO Utilizzo
	VALUES
		("utensile1", 00001),
        ("utensile1", 00002),
        ("utensile1", 00003),
        ("utensile2", 00004),
        ("utensile2", 00005),
        ("utensile2", 00006),
        ("utensile2", 00007),
        ("utensile3", 00008),
        ("utensile4", 00009),
        ("utensile4", 00010),
        ("utensile5", 00011),
        ("utensile5", 00012),
        ("utensile6", 00013),
        ("utensile6", 00014),
        ("utensile7", 00015),
        ("utensile8", 00016),
        ("utensile9", 00017),
        ("utensile10", 00018),
        ("utensile10", 00019),
        ("utensile10", 00020),
        ("utensile10", 00021);
        
        
# Inserimenti in Utensile
INSERT INTO Utensile
	VALUES
		("utensile1"),
        ("utensile2"),
        ("utensile3"),
        ("utensile4"),
        ("utensile5"),
        ("utensile6"),
        ("utensile7"),
        ("utensile8"),
        ("utensile9"),
        ("utensile10");

# Inserimenti in Posizione
INSERT INTO Posizione
	VALUES
		(1, 2, 4, 1),
        (9, 3, 2, 1),
        (4, 1, 1, 1),
        (8, 3, 1, 1),
        (3, 1, 8, 1),
        (1, 1, 3, 4),
        (1, 2, 3, 1),
        (4, 1, 2, 1),
        (1, 5, 9, 11),
        (2, 8, 6, 3),
        (9, 4, 4, 7),  
        (3, 4, 6, 1),
        (2, 5, 9, 11),
        (5, 8, 6, 3),
        (9, 3, 2, 7);
        
# Inserimenti in Ubicazione
INSERT INTO Ubicazione
	VALUES
		(1, 1, 2, 4, 1, "2020-3-3", NULL),
        (2, 9, 3, 2, 1, "2020-3-3", NULL),
        (3, 4, 1, 1, 1, "2020-3-3", NULL),
        (4, 8, 3, 1, 1, "2020-3-3", NULL),
        (5, 3, 1, 8, 1, "2020-3-3", NULL),
        (6, 1, 1, 3, 4, "2020-3-3", NULL),
        (7, 1, 2, 3, 1, "2020-3-3", NULL),
        (8, 4, 1, 2, 1, "2020-3-3", NULL),
        (9, 1, 5, 9, 11, "2020-3-3", NULL),
        (10, 2, 8, 6, 3, "2020-3-3", NULL),
        (11,9, 4, 4, 7, "2020-3-3", NULL);
        
# Inserimenti in ReportPerdite
INSERT INTO ReportPerdite
	VALUES
		("2020-09-8", 00001, 3, 00001, 17),
        ("2020-09-15", 00001, 1, 00008, 15),
        ("2020-09-23", 00001, 3, 00004, 16),
        ("2020-09-29", 00001, 2, 00011, 14),
        ("2020-08-12", 00002, 2, 00017, 7),
        ("2020-08-25", 00002, 1, 00013, 7),
        ("2020-10-10", 00002, 2, 00015, 8),
        ("2020-10-24", 00003, 1, 00008, 12),
        ("2020-10-25", 00003, 2, 00003, 13),
        ("2020-10-27", 00002, 1, 00012, 12);

# Inserimenti in Documento
INSERT INTO Documento
	VALUES
		("Carta identita", "12345", "0123456789abcdef",  
			"Comune di San Giuliano Terme", "2022-12-10"),
		("Carta identita", "54321", "abcdef0123456789",  
			"Comune di San Giuliano Terme", "2022-10-12");
            
# Inserimenti in Utente
INSERT INTO Utente
	VALUES
		("0123456789abcdef", current_date(), "c.panchetti", "Christian", "Panchetti",
			"Via dei pini 90", "1234567890"),
		("abcdef0123456789", current_date(), "l.cappabi", "Luca", "Cappabianca", 
			"Via degli abiti 21", "0987654321");

# Inserimenti in Login
INSERT INTO Login
	VALUES
		("c.panchetti", "qwerty", "Nome del primo animale domestico?", "Spugna"),
        ("l.cappabi", "abcdef", "Nome della nonna materna?", "Orlanda");



-- ----------------------------
-- `CBR`
-- ----------------------------

#DATA ANALYTICS (2.6.1):  CBR

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `Sintomi`
-- ----------------------------

DROP TABLE IF EXISTS `Sintomi`;
CREATE TABLE `Sintomi` (
  `CodSintomo` int(5) zerofill NOT NULL AUTO_INCREMENT,
  `DescSintomo` char(50) NOT NULL,
  PRIMARY KEY (`CodSintomo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for `Memoria`
-- ----------------------------

DROP TABLE IF EXISTS `Memoria`;
CREATE TABLE `Memoria` (
  `CodSintomo` int(5) zerofill NOT NULL,
  `CodCaso` int(5) zerofill NOT NULL,
  PRIMARY KEY (`CodSintomo`, `CodCaso`),
  FOREIGN KEY (`CodSintomo`)
  REFERENCES `Sintomi` (`CodSintomo`)
  on delete NO ACTION
  on update NO ACTION,
  FOREIGN KEY (`CodCaso`)
  REFERENCES `RimediCaso` (`CodCaso`)
  on delete NO ACTION
  on update NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `RimediCaso`
-- ----------------------------

DROP TABLE IF EXISTS `RimediCaso`;
CREATE TABLE `RimediCaso` (
  `CodRimedio` int(5) zerofill NOT NULL,
  `CodCaso` int(5) zerofill NOT NULL  auto_increment,
  PRIMARY KEY (`CodRimedio`, `CodCaso`),
  FOREIGN KEY (`CodRimedio`)
  REFERENCES `Rimedio` (`CodRimedio`)
  on delete NO ACTION
  on update NO ACTION,
  INDEX `CasoIND` (`CodCaso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;

# Inserimenti in Rimedio

INSERT INTO Rimedio
	VALUES
		(0, "r.a"),
        (0, "r.b"),
        (0, "r.c"),
        (0, "r.d"),
        (0, "r.e"),
        (0, "r.f"),
        (0, "r.g"),
        (0, "r.h"),
        (0, "r.i"),
        (0, "r.j"),
        (0, "r.k");



# Inserimenti in Sintomi

INSERT INTO Sintomi
	VALUES
		(00001, "1.a"),
        (00002, "1.b"),
        (00003, "1.c"),
        (00004, "2.a"),
        (00005, "3.a"),
        (00006, "3.b"),
        (00007, "3.c"),
        (00008, "3.d"),
        (00009, "4.a"),
        (00010, "5.a"),
        (00011, "5.b"),
        (00012, "6.a"),
        (00013, "7.a"),
        (00014, "7.b"),
        (00015, "7.c"),
        (00016, "8.a"),
        (00017, "8.b"),
        (00018, "9.a"),
        (00019, "10.a"),
        (00020, "10.b"),
        (00021, "10.c"),
        (00022, "10.d"),
        (00023, "10.e"),
        (00024, "11.a");
	
# Inserimenti in RimediCaso

INSERT INTO RimediCaso
	VALUES
    (00001, 00001),
	(00001, 00002),
    (00001, 00003),
    (00002, 00004),
    (00003, 00005),
    (00003, 00006),
    (00004, 00007),
    (00004, 00008),
    (00005, 00009),
    (00005, 00010),
    (00005, 00011),
	(00006, 00001),
    (00006, 00002),
    (00007, 00003),
    (00007, 00004),
    (00008, 00005),
    (00009, 00006),
    (00010, 00002),
    (00010, 00007),
    (00011, 00008);
# Inserimenti in Memoria

INSERT INTO Memoria
	VALUES
		
		(00001, "00001"),
        (00002, "00001"),
        (00003, "00001"),
        (00003, "00002"),
        (00004, "00002"),
        (00005, "00002"),
        (00005, "00003"),
        (00006, "00003"),
        (00007, "00003"),
        (00008, "00003"),
        (00009, "00003"),
        (00009, "00004"),
        (00010, "00004"),
        (00012, "00004"),
        (00010, "00005"),
        (00011, "00005"),
        (00012, "00005"),
        (00013, "00005"),
        (00012, "00006"),
        (00013, "00007"),
        (00014, "00007"),
        (00015, "00007"),
        (00016, "00008"),
        (00017, "00008"),
        (00017, "00009"),
        (00018, "00009"),
        (00018, "00010"),
        (00019, "00010"),
        (00020, "00010"),
        (00021, "00010"),
        (00022, "00010"),
        (00023, "00010"),
        (00023, "00011"),
        (00024, "00011");

        
# Definizione della Procedure Retrieve
        
DROP PROCEDURE IF EXISTS Retrieve;
DELIMITER $$
CREATE PROCEDURE Retrieve(IN _sin1 INT(5), IN _sin2 INT(5), IN _sin3 INT(5), IN _sin4 INT(5),
	IN _sin5 INT(5), IN _sin6 INT(5))
BEGIN        

DECLARE NS INT; # Numero di sintomi inseriti (non nulli)
DECLARE SV INT; # Numero di sintomi verificati rispetto ad un certo rimedio memoria
DECLARE ST INT; # Numero di sintomi totali riguardanti un rimedio in memoria

DROP VIEW IF EXISTS SintomiTotali;

		CREATE VIEW SintomiTotali 
	AS(
		SELECT CodCaso, count(*) AS ST
		FROM MEMORIA
        GROUP BY CodCaso);
        
	IF _sin6 IS NOT NULL
    THEN 
		SET NS = 6;
	ELSEIF _sin5 IS NOT NULL
    THEN 
		SET NS = 5;
	ELSEIF _sin4 IS NOT NULL
    THEN 
		SET NS = 4;
	ELSEIF _sin3 IS NOT NULL
    THEN 
		SET NS = 3;
	ELSEIF _sin2 IS NOT NULL
    THEN 
		SET NS = 2;
	ELSE SET NS = 1;
    END IF;
    
     SELECT rc.CodCaso, rc.CodRimedio
            FROM RimediCaso rc INNER JOIN
				(SELECT CodCaso, count(*) AS SV
				FROM Memoria
				WHERE CodSintomo = _sin1 OR CodSintomo = _sin2 OR CodSintomo = _sin3 OR 
					CodSintomo = _sin4 OR CodSintomo = _sin5 OR CodSintomo = _sin6
					GROUP BY CodCaso) AS V
                    ON (V.CodCaso=rc.CodCaso);
    
    SELECT *
    FROM(
		SELECT V.CodCaso AS Caso, Truncate( 50 * (V.SV / T.ST + V.SV / NS) , 1) AS Score
		FROM SintomiTotali T 
			INNER JOIN 
				(SELECT CodCaso, count(*) AS SV
				FROM Memoria
				WHERE CodSintomo = _sin1 OR CodSintomo = _sin2 OR CodSintomo = _sin3 OR 
					CodSintomo = _sin4 OR CodSintomo = _sin5 OR CodSintomo = _sin6
					GROUP BY CodCaso) AS V
			ON (V.CodCaso=T.CodCaso)) AS Tab
            ORDER BY score DESC;
            
           
            
            
	END$$
	DELIMITER ;
    

    
# Definizione della Procedure Retain
    
DROP PROCEDURE IF EXISTS Retain;
DELIMITER $$
CREATE PROCEDURE Retain(IN _rim1 INT(5), IN _rim2 INT(5), IN _rim3 INT(5),
	IN _sin1 INT(5), IN _sin2 INT(5), IN _sin3 INT(5), IN _sin4 INT(5),
	IN _sin5 INT(5), IN _sin6 INT(5))
BEGIN
Declare Caso INT; # Vi verrà inserito il valore di auto_increment che prenderà CodCaso nella tabella RimediCaso

IF _sin1 IS NULL THEN	
	SIGNAL SQLSTATE '45000'						
	SET MESSAGE_TEXT = "_sin1 non può essere NULL" ;
    END IF;

IF _rim1 IS NULL THEN	
	SIGNAL SQLSTATE '45000'						
	SET MESSAGE_TEXT = "_rim1 non può essere NULL" ;
    END IF;

IF _rim3 IS NOT NULL
	THEN
	INSERT INTO RimediCaso
		VALUES (_rim1, 0);
	SET Caso = last_insert_id();    
	INSERT INTO RimediCaso
		VALUES (_rim2, Caso), (_rim3, Caso);
    
ELSEIF _rim2 IS NOT NULL
	THEN
	INSERT INTO RimediCaso
		VALUES (_rim1, 0);
	SET Caso = last_insert_id();   
    INSERT INTO RimediCaso
        VALUES (_rim2, Caso);
        
ELSE INSERT INTO RimediCaso
		VALUES (_rim1, 0);
	SET Caso = last_insert_id();   

END IF;

IF _sin6 IS NOT NULL
	THEN 
		INSERT INTO Memoria
        VALUES 
			(_sin1, Caso), (_sin2, Caso), (_sin3, Caso), (_sin4, Caso), (_sin5, Caso), (_sin6, Caso);

ELSEIF _sin5 IS NOT NULL
	THEN 
		INSERT INTO Memoria
        VALUES 
			(_sin1, Caso), (_sin2, Caso), (_sin3, Caso), (_sin4, Caso), (_sin5, Caso);

ELSEIF _sin4 IS NOT NULL
	THEN 
		INSERT INTO Memoria
        VALUES 
			(_sin1, Caso), (_sin2, Caso), (_sin3, Caso), (_sin4, Caso);
            
ELSEIF _sin3 IS NOT NULL
	THEN 
		INSERT INTO Memoria
        VALUES 
			(_sin1, Caso), (_sin2, Caso), (_sin3, Caso);

ELSEIF _sin2 IS NOT NULL
	THEN 
		INSERT INTO Memoria
        VALUES 
			(_sin1, Caso), (_sin2, Caso);

ELSEIF _sin1 IS NOT NULL
	THEN 
		INSERT INTO Memoria
        VALUES 
			(_sin1, Caso);

END IF;

END $$
DELIMITER ;

-- ----------------------------
-- `EFFICIENZA PROCESSO`
-- ----------------------------


# Definizione della Procedure Efficienza_processo

SET FOREIGN_KEY_CHECKS = 0;

DROP PROCEDURE IF EXISTS Efficienza_processo;
DELIMITER $$
CREATE PROCEDURE Efficienza_processo(IN _serie_operazione INT(5), _coef_cambio_utensili INT(1), _coef_cambio_facce INT(1), _coef_scarti INT(1))
BEGIN        

DECLARE CU INT; # Quanti cambi di utensile
DECLARE NU INT; # Numero utensili
DECLARE CF INT; # Quanti cambi di faccia 
DECLARE NF INT; # Numero facce
DECLARE NS INT; # Numero scarti
DECLARE NSO INT; # Numero serie operazioni eseguite
DECLARE ValutazioneProcesso FLOAT; #Valore di uscita che rappresenta l'efficienza del processo
DECLARE CoefU FLOAT;
DECLARE CoefF FLOAT;
DECLARE CoefS FLOAT;

SET CU =   (SELECT count(*)
			FROM  (SELECT U.NomeUtensile as Utensile1, lead(U.NomeUtensile, 1) over (order by S.Ordine) as Utensile2
				   FROM Sequenza S inner join Operazione O on S.Operazione=O.CodOperazione
							inner join Utilizzo U on O.CodOperazione=U.Operazione
				   WHERE S.Serie=_serie_operazione
				  ) as tab_cu
			WHERE Utensile1 <> Utensile2
            );

SET NU =    (SELECT count(distinct U.NomeUtensile)
			 FROM  Utilizzo U inner join Sequenza S on U.Operazione=S.Operazione
			 WHERE S.Serie=_serie_operazione
			 ); 


SET CF =   (SELECT count(*)
			FROM  (SELECT O.Faccia as Faccia1, lead(O.Faccia, 1) over (order by S.Ordine) as Faccia2
				   FROM Sequenza S inner join Operazione O on S.Operazione=O.CodOperazione
                   WHERE S.Serie=_serie_operazione
				  ) as tab_cf
			WHERE Faccia1 <> Faccia2
            );
            
SET NF =   (SELECT count(distinct O.Faccia)
			 FROM  Operazione O inner join Sequenza S on O.CodOperazione=S.Operazione
			 WHERE S.Serie=_serie_operazione
			 ); 


SET NS =    (SELECT sum(Scarti)
			 FROM  ReportPerdite
			 WHERE SerieOperazioni=_serie_operazione
			 ); 

SET NSO =   (SELECT sum(NumSerieOperazioni)
			 FROM  ReportPerdite
			 WHERE SerieOperazioni=_serie_operazione
			 ); 

SET CoefU=_coef_cambio_utensili;  
SET CoefF=_coef_cambio_facce;  
SET CoefS=_coef_scarti; 

IF CoefU > 3 THEN	
	SET CoefU=1 ;
    END IF;
    
IF CoefF > 3 THEN	
	SET CoefF=1 ;
    END IF;

IF CoefS > 3 THEN	
	SET CoefS=1 ;
    END IF;

SET ValutazioneProcesso = ((CU*CoefU)/NU) + ((CF*CoefF)/NF) + ((NS*CoefS)/NSO);

SELECT ValutazioneProcesso;

END $$
delimiter ;


-- ----------------------------
-- `CUSTOM ANALYTIC`
-- ----------------------------


# Aggiornamento immediate della MV che gestisce le motivazioni di reso più frequenti
# utilizzata dalla procedura " Motivazione_frequente_reso "

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `MVMotivazioneReso`;
CREATE TABLE `MVMotivazioneReso` (
  `CodMotivazione` int(5) zerofill NOT NULL,
  `Volte` int(5) NOT NULL,
  `Marca` char(50) NOT NULL,
  `Modello` char(50) NOT NULL,
  PRIMARY KEY (`Marca`,`Modello`, `CodMotivazione`),
  FOREIGN KEY (`Marca`, `Modello`)
  REFERENCES `Prodotto` (`Marca`, `Modello`),
  FOREIGN KEY (`CodMotivazione`)
  REFERENCES `Motivazionereso` (`CodMotivazione`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;

DROP TRIGGER IF EXISTS aggiornaMotFrequenteReso;
DELIMITER $$
CREATE TRIGGER aggiornaMotFrequenteReso
AFTER INSERT ON reso
FOR EACH ROW
BEGIN

DECLARE Marca_ VARCHAR(50);
DECLARE Modello_ VARCHAR(50);
	
    SET Marca_ = 
		(SELECT p.marca
        FROM prodotto p INNER JOIN prodottoSpecifico ps
			ON (p.Marca=ps.Marca AND p.Modello=ps.Modello) 
        WHERE ps.CodSeriale = new.CodSeriale);
        
	SET modello_ =
		(SELECT p.modello
        FROM Prodotto p INNER JOIN ProdottoSpecifico ps
			ON (p.Marca=ps.Marca AND p.Modello=ps.Modello) 
        WHERE ps.CodSeriale =new.CodSeriale);
        
	IF new.Motivazione NOT IN 			#se è la prima volta che viene inserito
		(SELECT CodMotivazione			#un reso con quella motivazione, la aggiungo
        FROM MVMotivazioneReso lmr		#alla MV con volte=1
        WHERE lmr.Marca = Marca_
			AND lmr.Modello = Modello_)
		THEN 
			INSERT INTO 	mvMotivazioneReso
            VALUES (new.Motivazione, 1, Marca_, Modello_);
            
		ELSE 
			UPDATE MVMotivazioneReso mvmr
            SET Volte=Volte + 1
            WHERE  mvmr.Marca = Marca_
				AND mvmr.Modello = Modello_
                AND mvmr.CodMotivazione = new.Motivazione;
		END IF;
		END $$
		DELIMITER ;



DROP PROCEDURE IF EXISTS Motivazione_frequente_reso;
DELIMITER $$
CREATE PROCEDURE Motivazione_frequente_reso(IN _marca VARCHAR(50), 
	IN _modello VARCHAR(50))
BEGIN 
	SELECT CodMotivazione
    FROM mvmotivazionereso
    WHERE Marca = _marca and Modello = _modello AND volte =(
		SELECT max(volte)
		FROM mvmotivazionereso
		WHERE Marca = _marca and Modello = _modello);
END $$ 
DELIMITER ;

        