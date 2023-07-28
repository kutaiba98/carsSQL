/*
USE Master
GO
DROP DATABASE Cars
GO
*/

-- הקמת בסיס הנתונים
CREATE DATABASE Cars1
COLLATE Hebrew_CI_AS
GO

USE Cars1
GO

-- יצירת טבלאות
CREATE TABLE Drivers
( 	ID Int NOT NULL,
	First_Name Nvarchar(20) NULL,
	Last_Name Nvarchar(20) NULL,
	Tel_Home Nvarchar(10) NULL,
	Mobile Nvarchar(10) NULL,
	Birth Date NULL,
	Lic_No Int NULL,
	Comment Nvarchar(50) NULL   )
GO

CREATE TABLE Status
( 	Code_Status Int NOT NULL,
	Description Nvarchar(50) NULL )
GO

CREATE TABLE Drivers_Status
(   ID Int NOT NULL ,
    Code_Status Int NOT NULL ,
    Date_Of_Change Date NOT NULL ,
    Heara NVarChar(40) NULL   )
GO

CREATE TABLE Car_Type
( 	Code_Type Int NOT NULL,
	Description Nvarchar(50) NULL	)
GO

CREATE TABLE Cars
( 	Car_No int NOT NULL,
	Code_Type Int,
	Manufacturer Nvarchar(20) NULL,
	Model Nvarchar(20) NULL,
	Year_Car Int NULL   )
GO
CREATE TABLE Tipul_Types
(   Code_Type_Tipul Int NOT NULL , 
    Description Nvarchar(80)  )
GO

CREATE TABLE Tipul
 ( 	Car_No int NOT NULL ,
	Code_Type_Tipul Int NOT NULL,
	Date_Tipul Date NOT NULL ,
	Begin_Hour_Tipul Time NOT NULL ,
	End_Hour_Tipul Time  ,
	Description Nvarchar(50)  ) 
GO

CREATE TABLE Accidents
(   Car_No int NOT NULL ,
    Date_Of_Accident Date NOT NULL ,
    Time_Of_Accident Time NOT NULL ,
    ID Int ,
    Code_Type_Accident Int ,
    Code_Place  Int  )
GO

CREATE TABLE Accidents_Types
(   Code_Type_Accident Int NOT NULL , 
    Description Nvarchar(80) )
GO

CREATE TABLE Places
(   Code_Place Int NOT NULL ,
    Description NVarchar(20)  )
GO    
GO

--הגדרת מפתחות ראשיים
ALTER TABLE Drivers
ADD
CONSTRAINT PK_Drivers PRIMARY KEY (ID)
GO
ALTER TABLE Drivers_Status
ADD
CONSTRAINT PK_Drivers_Status PRIMARY KEY (ID , Code_Status , Date_Of_Change )
GO
ALTER TABLE Status 
ADD
CONSTRAINT PK_Status PRIMARY KEY (Code_Status)
GO  
ALTER TABLE Car_Type
ADD
CONSTRAINT PK_Type_Car PRIMARY KEY (Code_Type)
GO
ALTER TABLE Cars
ADD
CONSTRAINT PK_Cars PRIMARY KEY (Car_No)
GO
ALTER TABLE Tipul_Types
ADD
CONSTRAINT PK_Tipul_Types  PRIMARY KEY (Code_Type_Tipul)
GO
ALTER TABLE Tipul
ADD
CONSTRAINT PK_Tipul PRIMARY KEY (Car_No,Code_Type_Tipul, Date_Tipul, Begin_Hour_Tipul)
GO
ALTER TABLE Accidents
ADD
CONSTRAINT PK_Accidents PRIMARY KEY (Car_No,Date_Of_Accident,Time_Of_Accident)
GO
ALTER TABLE Accidents_Types
ADD
CONSTRAINT PK_Accidents_Types PRIMARY KEY (Code_Type_Accident)
GO
ALTER TABLE Places
ADD
CONSTRAINT PK_Places PRIMARY KEY (Code_Place)
GO

-- הגדרת מפתחות זרים
Alter Table Cars
ADD
CONSTRAINT FK_Cars_Types FOREIGN KEY
           (Code_Type) REFERENCES Car_Type (Code_Type)

Alter Table Drivers_Status	
ADD    
CONSTRAINT Fk_Drivers_Status_Status FOREIGN KEY 
	       (Code_Status) REFERENCES Status (Code_Status) ,
CONSTRAINT Fk_Drivers_Status FOREIGN KEY 
	       (ID) REFERENCES Drivers (ID)
GO
Alter Table Tipul 
ADD
CONSTRAINT Fk_Tipul_Types FOREIGN KEY 
	    (Code_Type_Tipul) REFERENCES Tipul_Types (Code_Type_Tipul) ,
CONSTRAINT Fk_Tipul_Cars FOREIGN KEY 
	    (Car_No) REFERENCES Cars (Car_No)	    
GO
Alter Table Accidents
Add
CONSTRAINT FK_Accident_Type FOREIGN KEY 
           (Code_Type_Accident) REFERENCES Accidents_Types (Code_Type_Accident) ,
CONSTRAINT FK_Accident_Place FOREIGN KEY 
           (Code_Place) REFERENCES Places (Code_Place) ,
CONSTRAINT FK_Accident_Cars FOREIGN KEY 
           (Car_No) REFERENCES Cars (Car_No) ,
CONSTRAINT FK_Accident_Drivers FOREIGN KEY 
           (ID) REFERENCES Drivers (ID)
GO
           
-- הזנת נתונים לטבלאות
INSERT INTO [Status] ([Code_Status],[Description]) VALUES ( 1,'רווק')
INSERT INTO [Status] ([Code_Status],[Description]) VALUES ( 2,'נשוי')
INSERT INTO [Status] ([Code_Status],[Description]) VALUES ( 3,'גרוש')
INSERT INTO [Status] ([Code_Status],[Description]) VALUES ( 4,'אלמן')
GO
SET DATEFORMAT DMY
INSERT INTO [Drivers] ([ID],[First_Name],[Last_Name],[Tel_Home],[Mobile],[Birth],[Lic_No],[Comment])
             VALUES   ('1111' , 'יוסף' , 'חדאד' , '04456298', '0526789654','20/12/1985', 7643 , 'נהג פרוע')
INSERT INTO [Drivers] ([ID],[First_Name],[Last_Name],[Tel_Home],[Mobile],[Birth],[Lic_No],[Comment])
             VALUES   ('2222' , 'ראניה' , 'חדאד' , '04456298', '0526785454','10/1/1972', 5423 , 'נהג זהיר')
INSERT INTO [Drivers] ([ID],[First_Name],[Last_Name],[Tel_Home],[Mobile],[Birth],[Lic_No],[Comment])
             VALUES   ('3333' , 'דניאל' , 'לויס' , '03827646', '0528756395','04/11/1984', 2345 , 'נהג זהיר')   
INSERT INTO [Drivers] ([ID],[First_Name],[Last_Name],[Tel_Home],[Mobile],[Birth],[Lic_No],[Comment])
             VALUES   ('4444' , 'חנא' , 'תמיר' , '03957395', '0567839745','20/6/1986', 2345 , 'נהג זהיר')  
INSERT INTO [Drivers] ([ID],[First_Name],[Last_Name],[Tel_Home],[Mobile],[Birth],[Lic_No],[Comment])
             VALUES   ('5555' , 'עומר' , 'סובח' , '02856937', '0528765846','30/5/1999', 2365 , 'נהג זהיר') 
INSERT INTO [Drivers] ([ID],[First_Name],[Last_Name],[Tel_Home],[Mobile],[Birth],[Lic_No],[Comment])
             VALUES   ('6666' , 'אדם' , 'סובח' , '09698354', '0597472984','06/12/1968', 8475 , 'נהג זהיר') 
INSERT INTO [Drivers] ([ID],[First_Name],[Last_Name],[Tel_Home],[Mobile],[Birth],[Lic_No],[Comment])
             VALUES   ('7777' , 'כאמל' , 'חביב' , '02387456', '0537694039','30/11/1998', 9623 , 'נהג זהיר') 
INSERT INTO [Drivers] ([ID],[First_Name],[Last_Name],[Tel_Home],[Mobile],[Birth],[Lic_No],[Comment])
             VALUES   ('8888' , 'צוריאל' , 'כרמי' , '03965412', '0512346428','23/8/1989', 1028 , 'נהג זהיר')  
GO
INSERT INTO [Drivers_Status] ([ID],[Code_Status] ,[Date_Of_Change] ,[Heara])
             VALUES   ('1111',1, '12/12/2005','רווק מבוקש')
INSERT INTO [Drivers_Status] ([ID],[Code_Status] ,[Date_Of_Change] ,[Heara])
             VALUES   ('1111',2, '12/12/2006','חתונה מפוארת')
INSERT INTO [Drivers_Status] ([ID],[Code_Status] ,[Date_Of_Change] ,[Heara])
             VALUES   ('1111',3, '12/12/2007','איך נפלו גיבורים')
INSERT INTO [Drivers_Status] ([ID],[Code_Status] ,[Date_Of_Change] ,[Heara])
             VALUES   ('1111',2, '12/12/2008','חתונה צנועה')
INSERT INTO [Drivers_Status] ([ID],[Code_Status] ,[Date_Of_Change] ,[Heara])
             VALUES   ('2222',2, '12/3/2007','חתונה מפוארת')  
GO
INSERT INTO [Car_Type] ([Code_Type] ,[Description])
            VALUES    (1 , 'משאית')
INSERT INTO [Car_Type] ([Code_Type] ,[Description])
            VALUES    (2 , 'אוטובוס') 
INSERT INTO [Car_Type] ([Code_Type] ,[Description])
            VALUES    (3 , 'מכונית פרטית')
INSERT INTO [Car_Type] ([Code_Type] ,[Description])
            VALUES    (4 , 'אופנועים') 
GO
INSERT INTO [Cars] ([Car_No] ,[Code_Type] , [Manufacturer] ,[Model] ,[Year_Car])
            VALUES    ('1212' , 1 , 'אודי' , 'חדיש' , 2015)
INSERT INTO [Cars] ([Car_No] ,[Code_Type] , [Manufacturer] ,[Model] ,[Year_Car])
            VALUES    ('2323' , 1 , 'אודי' , 'חדיש' , 2016)   
INSERT INTO [Cars] ([Car_No] ,[Code_Type] , [Manufacturer] ,[Model] ,[Year_Car])
            VALUES    ('3434' , 2 , 'וולוו' , 'חדיש' , 2018) 
INSERT INTO [Cars] ([Car_No] ,[Code_Type] , [Manufacturer] ,[Model] ,[Year_Car])
            VALUES    ('4545' , 2 , 'פורד' , 'חדיש' , 2019) 
INSERT INTO [Cars] ([Car_No] ,[Code_Type] , [Manufacturer] ,[Model] ,[Year_Car])
            VALUES    ('5656' , 3 , 'יונדאי' , 'חדיש' , 2015)
INSERT INTO [Cars] ([Car_No] ,[Code_Type] , [Manufacturer] ,[Model] ,[Year_Car])
            VALUES    ('6767' , 3 , 'פיאט' , 'חדש' , 2017)
INSERT INTO [Cars] ([Car_No] ,[Code_Type] , [Manufacturer] ,[Model] ,[Year_Car])
            VALUES    ('7878' , 3 , 'קיה' , 'חדש' , 2017)
GO
INSERT INTO [Tipul_Types] ([Code_Type_Tipul] ,[Description])                                                                 
            VALUES  ( 1 , 'החלפת שמנים')
INSERT INTO [Tipul_Types] ([Code_Type_Tipul] ,[Description])                                                                 
            VALUES  ( 2 , 'החלפת מנוע') 
INSERT INTO [Tipul_Types] ([Code_Type_Tipul] ,[Description])                                                                 
            VALUES  ( 3 , 'החלפת אגזוז')
INSERT INTO [Tipul_Types] ([Code_Type_Tipul] ,[Description])                                                                 
            VALUES  ( 4 , 'טיפול 100000')  
GO
INSERT INTO [Tipul] ([Car_No] ,[Code_Type_Tipul] ,[Date_Tipul] ,[Begin_Hour_Tipul] ,[End_Hour_Tipul] ,[Description])
            VALUES  ('1212' , 1, '27/1/2020' , '8:30' , '12:30' , 'המון בעיות')
INSERT INTO [Tipul] ([Car_No] ,[Code_Type_Tipul] ,[Date_Tipul] ,[Begin_Hour_Tipul] ,[End_Hour_Tipul] ,[Description])
            VALUES  ('2323' , 4, '27/1/2020' , '8:30' , '14:30' , 'המון בעיות') 
INSERT INTO [Tipul] ([Car_No] ,[Code_Type_Tipul] ,[Date_Tipul] ,[Begin_Hour_Tipul] ,[End_Hour_Tipul] ,[Description])
            VALUES  ('2323' , 3, '27/1/2020' , '8:30' , '11:30' , 'הלך חלק') 
GO
INSERT INTO [Accidents_Types] ([Code_Type_Accident] ,[Description])
            VALUES  (1 , 'תאונת פגע וברח' )
INSERT INTO [Accidents_Types] ([Code_Type_Accident] ,[Description])
            VALUES  (2 , 'תאונת חזיתית' )  
INSERT INTO [Accidents_Types] ([Code_Type_Accident] ,[Description])
            VALUES  (3 , 'התנגשות' )
INSERT INTO [Accidents_Types] ([Code_Type_Accident] ,[Description])
            VALUES  (4 , 'התהפכות' )               
GO
INSERT INTO [Places] ([Code_Place] , [Description])
            VALUES   (1 , 'צומת העוגן')    
INSERT INTO [Places] ([Code_Place] , [Description])
            VALUES   (2 , 'צומת כברי')
INSERT INTO [Places] ([Code_Place] , [Description])
            VALUES   (3 , 'כפר קרע')   
GO
SET DATEFORMAT DMY
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('1212','28/1/2020','8:30','1111',1,1)
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('1212','29/1/2020','8:30','1111',1,1)
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('2323','28/1/2020','8:30','1111',1,2) 
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('3434','28/1/2020','8:30','1111',2,3)  
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('4545','29/1/2020','8:30','1111',3,3) 
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('4545','27/1/2020','9:30','1111',4,2)
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('5656','27/1/2020','10:30','1111',4,3)
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('2323','24/1/2020','8:30','2222',1,1)
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('3434','29/1/2020','8:30','2222',1,1)
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('4545','28/1/2020','8:30','2222',1,2) 
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('5656','22/1/2020','8:30','2222',2,3)  
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('4545','23/1/2020','8:30','2222',3,3) 
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('4545','24/1/2020','9:30','2222',4,2)
INSERT INTO [Accidents] ([Car_No],[Date_Of_Accident],[Time_Of_Accident],[ID],[Code_Type_Accident],[Code_Place])
            VALUES  ('5656','26/1/2020','10:30','3333',4,3)                                                                                                                                                                                                                                         
GO

