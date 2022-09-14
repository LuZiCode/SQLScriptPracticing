--Database Definition Language (DDL) CREATE/ALTER/DROP
USE Master
GO
IF DB_ID('MovieDB') IS NOT NULL
	BEGIN
		ALTER DATABASE MovieDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE MovieDB
	END
GO
CREATE DATABASE MovieDB
GO
USE MovieDB
GO

DROP TABLE IF EXISTS Movie
CREATE TABLE Movie(
ID INT IDENTITY (1,1) PRIMARY KEY,
Title NVARCHAR(255)
)

DROP TABLE IF EXISTS Actor
CREATE TABLE Actor (
ID INT IDENTITY (1,1) PRIMARY KEY ,
[Name] NVARCHAR(255),
CONSTRAINT Un_name UNIQUE ([Name])
)

--Bridge Table for many 2 many relations

DROP TABLE IF EXISTS MovieActor
CREATE TABLE MovieActor(
MovieID INT FOREIGN KEY REFERENCES Movie(ID),
ActorID INT
CONSTRAINT FK_ActorID FOREIGN KEY (ActorID) REFERENCES Actor(ID)
)

INSERT INTO Movie VALUES ('Saving Private Ryan'), ('Forest Gump'), ('Sausage Party'), ('Ted')
INSERT INTO Actor VALUES ('Tom Hanks'), ('Seth Rogan'), ('Mark Wahlberg')

INSERT INTO MovieActor VALUES (1,1), (1,3), (2,1), (3,2), (4,2), (4,3)

SELECT Movie.Title as [Movie Title], STRING_AGG(Actor.[Name],', ') as [Actor] FROM Movie
JOIN MovieActor ON Movie.ID = MovieActor.MovieID
JOIN Actor ON Actor.ID = MovieActor.ActorID 
GROUP BY Movie.Title


