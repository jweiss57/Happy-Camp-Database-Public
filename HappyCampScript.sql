-- Happy Camp View, Function, and Stored Procedure developed and written by Jacob Weiss
-- Peer Reviewed by Chris Virostek
-- Written: April 2022
---------------------------------------------------------------
--This view tells the user which camper is enrolled in each unit and by which parent. 
--This will assist the camp to see the camper’s progression through each unit and the parent contact
--This will allow the staff of camp to best assist campers and parents pick the best future units for the campers.
USE HappyCamp
GO

CREATE VIEW CamperInfo
AS 
SELECT Parent.ParentID
, Parent.ParentFirstName
, Parent.ParentLastName
, Parent.ParentEmail
, Camper.CamperID
, Camper.CamperFirstName
, Camper.CamperLastName
, Registration.RegistrationDateTime
, Unit.UnitName
FROM Parent
INNER JOIN Registration
	ON Parent.ParentID = Registration.ParentID
INNER JOIN Camper
	ON Camper.CamperID = Registration.CamperID
INNER JOIN Enroll
	ON Camper.CamperID = Enroll.CamperID
INNER JOIN Unit
	ON Unit.UnitID = Enroll.UnitID
WITH CHECK OPTION;
GO 

--Test view
SELECT * FROM CamperInfo

-- Query: creating a function that returns the Unit that a certain staff member is working in
-- This will assist the camp to be able to look up the unit the staff member is working in
-- This will also help in the future because the camp will be able to look up what previous staff member have worked in what specialties so they can ask for help when needed
USE HappyCamp
GO
CREATE FUNCTION ufn_staffspecialty
	 (@InputFirstName NVARCHAR(35), @InputLastName NVARCHAR(45))
 	 RETURNS NVARCHAR(15)
BEGIN
  	DECLARE @SpecialtyType NVARCHAR(20)
  	SELECT @SpecialtyType = Specialty.SpecialtyType
  	FROM Specialty
	INNER JOIN Unit
		ON Specialty.SpecialtyID = Unit.SpecialtyID
	INNER JOIN UnitStaff
		ON Unit.UnitID = UnitStaff.UnitID
	INNER JOIN SummerStaff
		ON SummerStaff.StaffID = UnitStaff.StaffID
 	WHERE SummerStaff.StaffFirstName = @InputFirstName AND SummerStaff.StaffLastName = @InputLastName
	IF @InputFirstName IS NULL OR @InputLastName IS NULL
		Begin 
			SET @SpecialtyType = NULL
		END 
RETURN @SpecialtyType
END;

--Test function
SELECT dbo.ufn_staffspecialty('Angy', 'Wanless') AS 'Specialty'

--When entering a staff member this stored procedure shows the parent, unit and registraition time of each camper
--This will assist the heads of the staff be able to look at which staff member has which campers and if anything happens to one of their campers they will be able to email the parents
--This will also help with before camp learning about each camper
USE HappyCamp
GO
CREATE PROCEDURE usp_camperinfo (@FirstName NVARCHAR(35)=NULL, @LastName NVARCHAR(45)=NULL)  
AS
BEGIN
	DECLARE @UnitCount INT
	IF @FirstName IS NOT NULL AND @LastName IS NOT NULL
	  BEGIN
      -- Determine if any properties exist
      SELECT @UnitCount = COUNT(*)
      FROM SummerStaff 
		INNER JOIN UnitStaff
           ON SummerStaff.StaffID = UnitStaff.StaffID
      WHERE @LastName = SummerStaff.StaffLastName AND @FirstName = SummerStaff.StaffFirstName
	  IF @UnitCount = 0
        BEGIN
          SELECT @FirstName+ ' ' + @LastName + ' does not have any campers' AS "Warning"
		END
		ELSE
	-- Persons name specified; retrieve for given person 
		SELECT Camper.CamperID, Camper.CamperState, Camper.CamperBirthday, Registration.RegistrationDateTime, Unit.UnitName, Specialty.SpecialtyType
		FROM Registration
		INNER JOIN Camper
			ON Camper.CamperID = Registration.CamperID
		INNER JOIN Enroll
			ON Camper.CamperID = Enroll.CamperID
		INNER JOIN Unit
			ON Unit.UnitID = Enroll.UnitID
		INNER JOIN Specialty
			ON Specialty.SpecialtyID = Unit.SpecialtyID
		INNER JOIN UnitStaff
			ON Unit.UnitID = UnitStaff. UnitID
		INNER JOIN SummerStaff
			ON SummerStaff.StaffID = UnitStaff.StaffID
		WHERE @LastName = SummerStaff.StaffLastName AND @FirstName = SummerStaff.StaffFirstName
		ORDER BY Camper.CamperID
		RETURN (0); 
      END;
   ELSE
      BEGIN
		-- Argument omitted:
		Select 'Ommited Paramiter: The form for this procedure is: EXEC usp_camperinfo "<FirstName>" "<LastName>"' AS "Warning"
		RETURN (1); 
      END;
END;

--Test stored procedure
EXEC usp_camperinfo'Aryn','Clue';
--
EXEC usp_camperinfo @LastName='Weiss', @FirstName='Jacob';
--
EXEC usp_camperinfo;
