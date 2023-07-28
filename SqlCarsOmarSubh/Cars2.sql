/*
USE Master
GO
DROP DATABASE Cars
GO
*/

-- הקמת בסיס הנתונים
CREATE DATABASE Cars2 
COLLATE Hebrew_CI_AS
GO

USE Cars1
GO

-- שאלה 1
-- סעיף א
Select * From Drivers
GO
Select * From Drivers 
Where Last_Name Like 'כ%'
GO

-- שאלה 1
-- סעיף ב
Create View V_Drivers_History_Status  
AS
SELECT        dbo.Drivers.ID, dbo.Drivers.Last_Name, dbo.Drivers.First_Name, 
              dbo.Status.Description, dbo.Drivers_Status.Date_Of_Change, dbo.Drivers_Status.Heara
FROM            dbo.Drivers INNER JOIN  dbo.Drivers_Status 
                                ON dbo.Drivers.ID = dbo.Drivers_Status.ID 
					        INNER JOIN dbo.Status
							   ON dbo.Drivers_Status.Code_Status = dbo.Status.Code_Status
GO

Select * From V_Drivers_History_Status  
Order By last_Name, First_Name, Date_Of_Change
GO
  
-- שאלה 1
-- סעיף ג 
-- מופיעים רק הנהגים שיש עבורם מידע בטבלת הסטטוס של הנהגים
 
-- שאלה 1
-- סעיף ד 
SELECT        Last_Name, First_Name, COUNT(Date_Of_Change) AS Sfira_Status
FROM            dbo.V_Drivers_History_Status
GROUP BY Last_Name, First_Name
GO

-- שאלה 1
-- סעיף ה
Create Proc P_Drivers_History_Status
 @Family_Name Nvarchar(20) , @First_Name  Nvarchar(20)
AS 
Select * From V_Drivers_History_Status 
Where Last_Name = @Family_Name And First_Name = @First_Name
GO

EXEC P_Drivers_History_Status 'חדאד' , 'יוסף'
EXEC P_Drivers_History_Status 'חדאד' , 'ראניה'    
GO

-- שאלה 1
-- סעיף ו
Create Proc P_Insert_Driver_Status  
 @Id Int , @Code_Status Int , @Date_Of_Change Date , @Heara Nvarchar(40)
AS
  Insert Drivers_Status  (  Id ,  Code_Status ,  Date_Of_Change , Heara )
                  Values ( @Id , @Code_Status , @Date_Of_Change , @Heara )
GO

EXEC P_Insert_Driver_Status   4444 , 2 , '2020/5/15' , 'קולולו' 
EXEC P_Insert_Driver_Status   4444 , 3 , '2020/11/15' , 'חבל חבל'
EXEC P_Insert_Driver_Status   5555 , 2 , '2019/6/20' , 'קולולו' 
EXEC P_Insert_Driver_Status   5555 , 3 , '2020/11/25' , 'חבל חבל'

-- שאלה 1
-- סעיף ז
SELECT        Last_Name, First_Name, COUNT(Date_Of_Change) AS Sfira_Status
FROM            dbo.V_Drivers_History_Status
GROUP BY Last_Name, First_Name
GO
-- התוצאות השתנו בזכות ההכנסה של הנתונים מסעיף ו

-- ========================================================================================
                                                
-- שאלה 2
-- סעיף א
CREATE VIEW V_Accident_Car_Driver
AS
SELECT     dbo.Places.Description AS Place, dbo.Cars.Car_No, dbo.Car_Type.Description,
           dbo.Cars.Year_Car, 
           dbo.Accidents.Date_Of_Accident, 
           dbo.Accidents.Time_Of_Accident, 
           dbo.Accidents_Types.Description AS Acc_Type,  dbo.Accidents.ID, 
		   dbo.Drivers.Last_Name, dbo.Drivers.First_Name
FROM         dbo.Cars INNER JOIN  dbo.Car_Type 
                         ON dbo.Cars.Code_Type = dbo.Car_Type.Code_Type 
					  INNER JOIN dbo.Accidents
					     ON dbo.Cars.Car_No = dbo.Accidents.Car_No 
					  INNER JOIN  dbo.Accidents_Types 
					     ON dbo.Accidents.Code_Type_Accident = dbo.Accidents_Types.Code_Type_Accident 
					  INNER JOIN dbo.Places
					     ON dbo.Accidents.Code_Place = dbo.Places.Code_Place 
					  INNER JOIN dbo.Drivers
					     ON dbo.Accidents.ID = dbo.Drivers.ID
GO   

SELECT * FROM  V_Accident_Car_Driver                 
ORDER BY Place
GO

-- שאלה 2
-- סעיף ב
CREATE VIEW V_Sfirat_Acc 
AS
SELECT       dbo.Drivers.ID, dbo.Drivers.First_Name, dbo.Drivers.Last_Name ,
             COUNT(V_Accident_Car_Driver.Car_No) AS Sfira_Acc 
             FROM    dbo.V_Accident_Car_Driver INNER JOIN  dbo.Drivers
			         ON dbo.V_Accident_Car_Driver.ID = dbo.Drivers.ID
GROUP BY  dbo.Drivers.ID, dbo.Drivers.First_Name, dbo.Drivers.Last_Name
GO

Select * From V_SFirat_Acc 
GO

-- שאלה 2
-- סעיף ג
CREATE View V_Accidents_Details_All
as
	SELECT       dbo.Drivers.ID, dbo.Drivers.First_Name, dbo.Drivers.Last_Name , dbo.V_SFirat_Acc.Sfira_Acc
	FROM         dbo.V_Sfirat_Acc RIGHT JOIN dbo.Drivers
	                      ON  dbo.V_SFirat_Acc.ID = dbo.Drivers.ID
GO

Select * From V_Accidents_Details_All
GO

-- שאלה 2 
-- סעיף ד
Select * From V_Accidents_Details_All
Where Sfira_Acc IS NUll
GO

-- שאלה 2
-- סעיף ה
Select * From V_Accidents_Details_All
Where Sfira_Acc > 3
GO

-- שאלה 2
-- סעיף ו
Create Proc P_Update_Car
 @Car_No  Int , @Year_Car Int
AS
Update Cars
Set year_Car = @Year_Car
Where  Car_No = @Car_No
GO

EXEC P_Update_Car 1212 , 2018
EXEC P_Update_Car 5656 , 2018
GO


-- =========================================================================================

-- שאלה 3	 
-- סעיף א
-- לאיזה סוג טיפול לא היה אף טיפול
SELECT       dbo.Tipul_Types.Description
FROM         dbo.Tipul RIGHT JOIN  dbo.Tipul_Types
ON   dbo.Tipul.Code_Type_Tipul = dbo.Tipul_Types.Code_Type_Tipul
WHERE Car_No IS NULL  
go

-- שאלה 3
-- סעיף ב
CREATE View V_History_Tipul_Accident
AS 
SELECT        dbo.Cars.Car_No,  dbo.Tipul.Date_Tipul as DateOfAction, dbo.Tipul.Description ,
              'טיפול' as SugPeilut
FROM              dbo.Cars INNER JOIN dbo.Tipul
                              ON dbo.Cars.Car_No = dbo.Tipul.Car_No 
UNION
SELECT        dbo.Cars.Car_No, dbo.Accidents.Date_Of_Accident as DateOfAction, 
              dbo.Accidents_Types.Description , 'תאונה' as SugPeilut
FROM             dbo.Cars INNER JOIN dbo.Accidents 
	               ON dbo.Cars.Car_No = dbo.Accidents.Car_No 
					      INNER JOIN dbo.Accidents_Types 
			       ON dbo.Accidents.Code_Type_Accident = dbo.Accidents_Types.Code_Type_Accident
Go	 	 
      
Select * From V_History_Tipul_Accident	
Order By Car_No
go

-- שאלה 3   
-- סעיף ג
Select * From V_History_Tipul_Accident	
Where Car_No = 2323
go

-- שאלה 3 
-- סעיף ד
SELECT DISTINCT dbo.Cars.Car_No, dbo.Cars.Model, dbo.Cars.Manufacturer, dbo.Cars.Year_Car, dbo.Car_Type.Description, dbo.V_History_Tipul_Accident.DateOfAction
FROM            dbo.Cars INNER JOIN dbo.Car_Type 
                            ON dbo.Cars.Code_Type = dbo.Car_Type.Code_Type
					     LEFT JOIN dbo.V_History_Tipul_Accident 
						    ON dbo.Cars.Car_No = dbo.V_History_Tipul_Accident.Car_No
WHERE        (dbo.V_History_Tipul_Accident.DateOfAction IS NULL)
go

--שאלה 3
-- סעיף ה
Create Proc P_Delete_Car
 @Car_No Int
AS 
Delete From Cars
Where Car_No = @Car_No
GO

Exec P_Delete_Car 7878
GO
