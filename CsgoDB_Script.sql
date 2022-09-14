USE Master
GO
IF DB_ID('CsgoDB') IS NOT NULL
	BEGIN
		ALTER DATABASE CsgoDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE CsgoDB
	END
GO
CREATE DATABASE CsgoDB
GO
USE CsgoDB
GO

DROP TABLE IF EXISTS Player 
CREATE TABLE Player(
ID INT PRIMARY KEY IDENTITY(1,1),
PlayerName NVARCHAR(20)
)
GO
DROP TABLE IF EXISTS Weapon 
CREATE TABLE Weapon(
ID INT PRIMARY KEY IDENTITY(1,1),
WeaponName NVARCHAR(100)
)
GO
DROP TABLE IF EXISTS Skin 
CREATE TABLE Skin(
ID INT PRIMARY KEY IDENTITY(1,1),
SkinName NVARCHAR(100),
WeaponID INT,
CONSTRAINT FK_WeaponID FOREIGN KEY (WeaponID) REFERENCES Weapon(ID)
)
GO
INSERT INTO PLAYER VALUES ('Kjærbye'), ('Dev1ce'), ('KennyS')
INSERT INTO Weapon VALUES ('AK-47'), ('AWP'), ('USP-S')
INSERT INTO Skin VALUES ('Ice Coaled', 1), ('Asiimov', 1), ('Neo-Noir', 2), ('Printstream', 3)
GO
DROP TABLE IF EXISTS PlayerSkin 
CREATE TABLE PlayerSkin(
PlayerID INT,
SkinID INT,
CONSTRAINT FK_PlayerID FOREIGN KEY (PlayerID) REFERENCES Player(ID),
CONSTRAINT FK_SkinID FOREIGN KEY (SkinID) REFERENCES Skin(ID) 
)
GO
INSERT INTO PlayerSkin VALUES (1,1), (1,3), (2,1), (2,4), (2,3), (3,3)

GO
CREATE VIEW WeaponSkinView as
SELECT skin.ID, CONCAT(WeaponName, ' ', SkinName) as Inventory FROM Skin
JOIN Weapon ON Skin.WeaponID = Weapon.ID
GO

GO
CREATE VIEW PlayerSkinView as
	SELECT PlayerName as [Player Name], STRING_AGG(Inventory, ', ') as Inventory FROM Player
	JOIN PlayerSkin ON Player.ID = PlayerSkin.PlayerID
	JOIN WeaponSkinView ON WeaponSkinView.Id = PlayerSkin.SkinID
	GROUP BY PlayerName
GO
--SELECT * FROM PlayerSkinView WHERE [Player Name] Like 'Dev%'
SELECT * FROM PlayerSkinView
GO
SELECT SkinName as [Skin Name], STRING_AGG(PlayerName, ' - ')  as [Player Name] FROM Skin
JOIN PlayerSKin ON Skin.ID = PlayerSkin.SkinID
JOIN Player ON Player.ID = PlayerSkin.PlayerID
GROUP BY SkinName
GO