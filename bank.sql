CREATE DATABASE IF NOT EXISTS Bank;
use Bank;
CREATE TABLE IF NOT EXISTS Clients (
    id INT UNIQUE NOT NULL AUTO_INCREMENT,
    creditCardNumber VARCHAR(50),
    debitCard VARCHAR(50) NOT NULL,
    accountNumber VARCHAR(50) NOT NULL,
    clientUser VARCHAR(50) NOT NULL,
    clientPassword VARCHAR(10) NOT NULL,
    PRIMARY KEY (id)
	);
    
ALTER TABLE Clients DROP COLUMN fullName;
ALTER TABLE Clients ADD COLUMN fullName VARCHAR(50) NOT NULL;

CREATE TABLE IF NOT EXISTS Areas (
    id INT UNIQUE NOT NULL AUTO_INCREMENT,
    areaName VARCHAR(50),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Employees (
    id INT UNIQUE NOT NULL AUTO_INCREMENT,
    fullName VARCHAR(50) NOT NULL,
    socialSecurityNumber VARCHAR(50) NOT NULL UNIQUE,
    area INT NOT NULL,
    position INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Positions (
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    positionSName VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);
/*
ALTER TABLE Positions RENAME COLUMN positionSName TO positionsname;
ALTER TABLE Positions RENAME COLUMN positionsname TO positionName;
*/

CREATE TABLE IF NOT EXISTS DebitCards(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
	cardNumber INT NOT NULL UNIQUE,
    clientsId INT UNIQUE NOT NULL,
    PRIMARY KEY (id, clientsId),
    FOREIGN KEY (clientsId)
    REFERENCES Clients(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


ALTER TABLE Clients DROP COLUMN debitCard;
ALTER TABLE Clients ADD COLUMN debitCard VARCHAR(50) UNIQUE NOT NULL;
ALTER TABLE Clients DROP PRIMARY KEY;
ALTER TABLE Clients ADD PRIMARY KEY (id, debitCardId);
ALTER TABLE Clients ADD FOREIGN KEY debitCardClients(debitCardId) REFERENCES DebitCards(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Clients MODIFY debitCard VARCHAR(50) UNIQUE;
ALTER TABLE Clients MODIFY debitCardId INT UNIQUE;
ALTER TABLE Clients MODIFY creditCardNumber VARCHAR(50) UNIQUE;

CREATE TABLE IF NOT EXISTS Entities(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
	entityName VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS CreditCards(
	id INT NOT NULL UNIQUE AUTO_INCREMENT,
    cardNumber VARCHAR(50) UNIQUE NOT NULL,
    cardLimit INT NOT NULL,
    clientId INT NOT NULL UNIQUE,
    entityId INT NOT NULL UNIQUE,
    PRIMARY KEY(id, clientId, entityId),
    FOREIGN KEY (clientId)
    REFERENCES Clients(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (entityId)
    REFERENCES Entitys(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Banks(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
    bankName VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS BankHasClients(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
    bankId INT UNIQUE NOT NULL,
    clientsId INT UNIQUE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (clientsId)
    REFERENCES Clients(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (bankId)
    REFERENCES Banks(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Applicants(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
    fullName VARCHAR(50) NOT NULL,
    CV VARCHAR(50) NOT NULL,
    areaId INT UNIQUE NOT NULL,
    positionId INT UNIQUE NOT NULL,
    PRIMARY KEY(id, areaId, positionId),
    FOREIGN KEY (areaId)
    REFERENCES Areas(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (positionId)
    REFERENCES Positions(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS BankHasApplicants(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
    applicantId INT UNIQUE NOT NULL,
    bankId INT UNIQUE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (applicantId)
    REFERENCES Applicants(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (bankId)
    REFERENCES Banks(id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS Taxes(
	id INT NOT NULL UNIQUE AUTO_INCREMENT,
    taxName VARCHAR(50) UNIQUE,
    amount INT NOT NULL,
    PRIMARY KEY(id) 
);

CREATE TABLE IF NOT EXISTS BankHasTaxes(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
    bankId INT UNIQUE NOT NULL,
    taxId INT NOT NULL UNIQUE,
    FOREIGN KEY (bankId)
    REFERENCES Banks(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (taxId)
    REFERENCES Taxes(id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS Accounts(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
    accountNumber VARCHAR(50) NOT NULL UNIQUE,
    balance INT NOT NULL,
    clientId INT UNIQUE NOT NULL,
    PRIMARY KEY (id, clientId),
	FOREIGN KEY (clientId)
    REFERENCES Clients(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

SELECT * FROM Banks;

INSERT INTO Banks VALUES
	(null, 'Santander'),
    (null, 'JPMorgan'),
    (null, 'HSBC');
    
SELECT * FROM BANKS;

UPDATE Banks SET id = 1 WHERE bankName = 'Santander';
UPDATE Banks SET id = 2 WHERE bankName = 'JPMorgan';
UPDATE Banks SET id = 3 WHERE bankName = 'HSBC';

SELECT * FROM Banks;

ALTER TABLE Clients DROP PRIMARY KEY;
ALTER TABLE Clients ADD PRIMARY KEY(id);

ALTER TABLE DebitCards DROP PRIMARY KEY;
ALTER TABLE DebitCards ADD PRIMARY KEY(id);

DROP TABLE CreditCards;
DROP TABLE BankHasClients;
DROP TABLE Accounts;
ALTER TABLE DebitCards DROP FOREIGN KEY debitcards_ibfk_1; 
DROP TABLE Clients;

SELECT * FROM Clients;

CREATE TABLE IF NOT EXISTS Clients(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
    fullName VARCHAR(50) NOT NULL,
    socialSecurityNumber VARCHAR(50) NOT NULL,
    creditCardNumber VARCHAR(50) UNIQUE,
    accountNumber VARCHAR(50) NOT NULL UNIQUE,
    clientUser VARCHAR(50) NOT NULL UNIQUE,
    clientPassword VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

DROP TABLE DebitCards;

CREATE TABLE IF NOT EXISTS DebitCards(
	id INT UNIQUE NOT NULL AUTO_INCREMENT,
    cardNumber VARCHAR(50) NOT NULL UNIQUE,
    clientsId INT UNIQUE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (clientsId) REFERENCES Clients(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Clients VALUES
	(null, 'Celeste Gonzalez', '400', '123', '678', 'celesteG', '1234'),
    (null, 'Carina Pereira', '236', '345', '894', 'carinaP', '1234'),
    (null, 'Ami Gonzalez', '500', '861', '201', 'AmiG', '1234'),
	(null, 'Charlie Gonzalez', '900', '534', '813', 'charlieG', '1234');
    
INSERT INTO DebitCards VALUES
	(null, '123', (SELECT id FROM Clients WHERE fullName="Celeste Gonzalez")),
    (null, '345', (SELECT id FROM Clients WHERE fullName="Carina Pereira")),
    (null, '678', (SELECT id FROM Clients WHERE fullName="Ami Gonzalez")),
    (null, '978', (SELECT id FROM Clients WHERE fullName="Charlie Gonzalez"));
    
SELECT * FROM DebitCards;

CREATE TABLE IF NOT EXISTS Accounts(
	id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    accountNumber VARCHAR(50) UNIQUE NOT NULL,
    balance INT NOT NULL,
    clientsId INT NOT NULL UNIQUE,
    FOREIGN KEY (clientsId) REFERENCES Clients(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

SHOW TRIGGERS;

SELECT * FROM Clients;

SHOW FULL PROCESSLIST;

ALTER TABLE Clients ADD debitCardId INT NOT NULL;
ALTER TABLE Clients MODIFY debitCardId INT NOT NULL UNIQUE;

ALTER TABLE DebitCards DROP FOREIGN KEY debitcards_ibfk_1;

ALTER TABLE DebitCards ADD FOREIGN KEY (clientsId) REFERENCES Clients(debitCardId);
