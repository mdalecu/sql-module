--1. Create the following tables: Games, Studios, Gamers, and Purchases.

 CREATE TABLE Games (
GameID INT,
Title varchar(255),
StudioID INT,
Genre varchar(255),
Price INT
);
 

CREATE TABLE Studios (
StudioID INT,
StudioName varchar(255)
);
 

CREATE TABLE Gamers (
GamerID INT,
FirstName varchar(255),
LastName varchar(255),
Email varchar(255),
Phone INT
);
 
 GRANT SELECT ON "Gamers" TO Public
 GRANT SELECT ON "Games" TO Public
 GRANT SELECT ON "Purchases" TO Public
 GRANT SELECT ON "Studios" TO Public

CREATE TABLE Purchase (
PurchaseID int,
GamerID INT,
GameID INT,
PurchaseDate DATE,
PurchaseAmount INT
);

--2. Insert Data:
--Populate each table with at least 10 records of sample data for each table

USE [SqlTraining2024]
GO
 
INSERT INTO [mradu].[Gamers]
           ([GamerID]
           ,[FirstName]
           ,[LastName]
           ,[Email]
           ,[Phone])
     VALUES
           (1
           ,'Andrei'
           ,'Alexandru'
           ,'andrei.alexandru@ubisoft.com'
           ,0766290012)
GO
-- 3. Retrieve Data:
--Craft SQL queries to retrieve the following information. Use only one stored procedure for all the queries.

--List all games along with their studios and prices.
select StudioName ,Title, Price
from mradu.Games, mradu.Studios

--Showcase details of gamers who have made a purchase.
select FirstName, LastName, Email, Phone, GameID, PurchaseDate, PurchaseAmount
from mradu.Gamers, mradu.Purchases
Where Purchases.GamerID=Gamers.GamerID

--Display the total number of purchases made by each gamer.
SELECT Purchases.GamerID, COUNT(*) AS total_purchases
FROM mradu.Purchases
GROUP BY GamerID;

--Formulate a query to find the average price of games in each genre.
SELECT Genre, AVG(Price) AS average_price 
FROM mradu.Games
GROUP BY genre;

--stored procedure
CREATE PROCEDURE AllinOneProcedure1
as
begin

select StudioName ,Title, Price
from mradu.Games, mradu.Studios

select FirstName, LastName, Email, Phone, GameID, PurchaseDate, PurchaseAmount
from mradu.Gamers, mradu.Purchases
Where Purchases.GamerID=Gamers.GamerID

select Purchases.GamerID, COUNT(*) AS total_purchases
FROM mradu.Purchases
GROUP BY GamerID

SELECT Genre, AVG(Price) AS average_price 
FROM mradu.Games
GROUP BY genre
end

execute AllinOneProcedure1

-- 4. Update Data. *Use a stored procedure for each update.
--Adjust the price of a specific game. *The price and the GameId should be passed as parameters.
CREATE PROCEDURE AdjustGamePrice -- Creare functie
@GameId INT, @Newprice INT
AS
BEGIN
    UPDATE [SqlTraining2024].[mradu].[Games]
    SET Price = @Newprice
    WHERE GameId = @GameId;
END;
 
EXEC AdjustGamePrice @gameid = 103, @newprice = 19; -- Apelare functie

--Update the email address of a specific gamer. The email and the GamerId should be passed as parameters

CREATE PROCEDURE UpdateGamerEmail
@GamerId INT, @NewEmail VARCHAR(255)
AS
BEGIN
    UPDATE [SqlTraining2024].[mradu].[Gamers]
    SET Email = @NewEmail
    WHERE GamerId = @GamerId;
END;
 
EXEC UpdateGamerEmail @GamerId = 8, @newemail = 'nbadica@ubisoft.com';

-- 5. Delete Data. *Use stored procedure
--Eliminate a gamer from the database. GamerId should be passed as parameter.

CREATE PROCEDURE DelGamer
    @GamerId INT
AS
BEGIN
    DELETE FROM mradu.Gamers
    WHERE GamerId = @GamerId;
END;
 
EXEC DelGamer @GamerId = 2;
 
SELECT *
FROM mradu.Gamers
