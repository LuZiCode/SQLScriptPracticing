--Database Definition Language (DDL) CREATE/ALTER/DROP
USE Master
GO
IF DB_ID('DBProg_Opg1') IS NOT NULL
	BEGIN
		ALTER DATABASE DBProg_Opg1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE DBProg_Opg1
	END
GO
CREATE DATABASE DBProg_Opg1
GO
USE DBProg_Opg1
GO

DROP TABLE IF EXISTS BankAccount
CREATE TABLE BankAccount (
AccountID INT IDENTITY(1,1),
[Owner] NVARCHAR(255),
Assit MONEY,
CountryID INT
)

DROP TABLE IF EXISTS Country
CREATE TABLE Country (
ID INT IDENTITY(1,1),
[Name] NVARCHAR(255),
)

INSERT INTO BankAccount ([Owner], Assit) VALUES ('Lucas', 13203.8923)
INSERT INTO BankAccount ([Owner], Assit, CountryID) VALUES ('Usama', 2132123.231, 2)
INSERT INTO BankAccount ([Owner], Assit, CountryID) VALUES ('DanielZito', 5634454.892, 3)

INSERT INTO Country VALUES ('Denmark')
INSERT INTO Country VALUES ('Norge')
INSERT INTO Country VALUES ('Sverige')
GO
UPDATE BankAccount
SET [Owner] = 'JohanZito', Assit = 999922.99
WHERE AccountID = 3

SELECT BankAccount.AccountID as [Account ID], BankAccount.[Owner] as [Account Owner], FORMAT(BankAccount.Assit, 'C', 'dk-DK') [Balance], Country.[Name] as [Country] from BankAccount
INNER JOIN Country ON BankAccount.CountryID = Country.ID

SELECT BankAccount.AccountID as [Account ID], BankAccount.[Owner] as [Account Owner], FORMAT(BankAccount.Assit, 'C', 'dk-DK') [Balance], Country.[Name] as [Country] from BankAccount
LEFT JOIN Country ON BankAccount.CountryID = Country.ID

SELECT BankAccount.AccountID as [Account ID], BankAccount.[Owner] as [Account Owner], FORMAT(BankAccount.Assit, 'C', 'dk-DK') [Balance], Country.[Name] as [Country] from BankAccount
RIGHT JOIN Country ON BankAccount.CountryID = Country.ID

SELECT BankAccount.AccountID as [Account ID], BankAccount.[Owner] as [Account Owner], FORMAT(BankAccount.Assit, 'C', 'dk-DK') [Balance], Country.[Name] as [Country] from BankAccount
FULL JOIN Country ON BankAccount.CountryID = Country.ID







