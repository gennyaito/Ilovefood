-- Create Age Bin from the consumer table

SELECT COUNT(*), MIN(Age), MAX(Age)
FROM [Restaurant Analysis].dbo.consumers

ALTER TABLE [Restaurant Analysis].dbo.consumers 
ADD AgeBin VARCHAR(20)
GO

UPDATE  [Restaurant Analysis].dbo.consumers
SET AgeBin = CASE
WHEN Age >= 18 AND Age <= 34 THEN '[18 -34]'
WHEN Age >= 35 AND Age <= 49 THEN  '[35 -49]'
WHEN Age >= 50 AND Age <= 64 THEN  '[50 -64]'
WHEN Age >= 65 AND Age <= 82 THEN '[65 and above]'
END 

--Consumer Details
SELECT AgeBin, COUNT(AgeBin) AS 'Age count', City, Occupation, Drink_Level, Transportation_Method
FROM [Restaurant Analysis].dbo.consumers
WHERE Occupation IS NOT NULL
AND Transportation_Method IS NOT NULL
GROUP BY AgeBin,  City, Occupation, Drink_Level, Transportation_Method
ORDER BY 2 DESC


SELECT Transportation_Method, COUNT(Transportation_Method)
FROM [Restaurant Analysis].dbo.consumers
WHERE Transportation_Method IS NOT NULL
GROUP BY Transportation_Method
ORDER BY 2 DESC


SELECT Occupation, COUNT(Occupation), MAX(Occupation)
FROM [Restaurant Analysis].dbo.consumers
WHERE Occupation IS NOT NULL
GROUP BY Occupation
ORDER BY 2 DESC


--The top 3 preferred cuisine by consumers
SELECT TOP 3 Preferred_Cuisine, COUNT(Preferred_Cuisine) AS 'Preferred Cuisine Count'
FROM [Restaurant Analysis].dbo.consumer_preferences
GROUP BY Preferred_Cuisine
ORDER BY 2 DESC


-- The top 3 rated restaurants by consumer preferred cuisine
SELECT TOP 3  Name, City, Preferred_Cuisine, SUM(Overall_Rating) AS 'Total Ratings'
FROM [Restaurant Analysis].dbo.restaurants r
JOIN dbo.ratings rtngs
ON
r.Restaurant_ID = rtngs.Restaurant_ID
JOIN dbo.consumer_preferences cp
ON rtngs.Consumer_ID = cp.Consumer_ID
GROUP BY Name, City, Preferred_Cuisine
ORDER BY 4 DESC

--The cities where the restaurants are located
SELECT City, COUNT(City) AS 'Restaurants Location'
From dbo.restaurants
GROUP BY City
ORDER BY 2 DESC

--Restaurants Price 
SELECT Price, COUNT(Price) AS 'Restaurants Price'
From dbo.restaurants
GROUP BY Price
ORDER BY 2 DESC

--Consumers Budget
SELECT Budget, COUNT(Budget) AS 'Consumers Budget'
From dbo.consumers
WHERE Budget IS NOT NULL
GROUP BY Budget
ORDER BY 2 DESC


