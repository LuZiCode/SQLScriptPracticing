--Database Definition Language (DDL) CREATE/ALTER/DROP
USE Master
GO
IF DB_ID('CarDB') IS NOT NULL
	BEGIN
		ALTER DATABASE CarDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE CarDB
	END
GO
CREATE DATABASE CarDB
GO
USE CarDB
GO

DROP TABLE IF EXISTS Car
CREATE TABLE Car(
ID INT IDENTITY (1,1) PRIMARY KEY,
Brand NVARCHAR(255), 
CONSTRAINT UN_Brand UNIQUE (Brand)
)

DROP TABLE IF EXISTS Accessory
CREATE TABLE Accessory (
ID INT IDENTITY (1,1) PRIMARY KEY,
[Type] NVARCHAR(255)
)

--Bridge Table for many 2 many relations

DROP TABLE IF EXISTS CarAccessory
CREATE TABLE CarAccessory(
CarID INT FOREIGN KEY REFERENCES Car(ID),
AccessoryID INT,
CONSTRAINT FK_Accessory FOREIGN KEY (AccessoryID) REFERENCES Accessory(ID) 
)

INSERT INTO Car VALUES ('Bmw'), ('Mercedes'), ('Ford')
INSERT INTO Accessory VALUES ('Steering Wheel'), ('Windows'), ('Aircondition'), ('Radiosystem'), ('Automatic Door Opener'), ('LED Lights')

-- Bmw INPUTS
INSERT INTO CarAccessory VALUES (1,1), (1,2), (1,3), (1,4), (1,5), (1,6)
-- Mercedes INPUTS
INSERT INTO CarAccessory VALUES (2,1), (2,2), (2,3), (2,4), (2,5)  
-- Ford INPUTS
INSERT INTO CarAccessory VALUES (3,1), (3,2), (3,3) 

SELECT Car.Brand as [Car Brand], STRING_AGG(Accessory.[Type],', ') as [Accessory] FROM Car
JOIN CarAccessory ON Car.ID = CarAccessory.CarID
JOIN Accessory ON Accessory.ID = CarAccessory.AccessoryID 
GROUP BY Car.Brand

