USE HappyCamp
GO

CREATE VIEW CamperInfoView
AS 
SELECT Parent.ParentID
, Parent.ParentFirstName + ', ' + Parent.ParentLastName AS ParentFullName
, Parent.ParentEmail
, Camper.CamperID
, Camper.CamperFirstName + ', ' + Camper.CamperLastName AS CamperFullName
, Registration.RegistrationDateTime
, Unit.UnitName
, Specialty.SpecialtyType
FROM Parent
INNER JOIN Registration
	ON Parent.ParentID = Registration.ParentID
INNER JOIN Camper
	ON Camper.CamperID = Registration.CamperID
INNER JOIN Enroll
	ON Camper.CamperID = Enroll.CamperID
INNER JOIN Unit
	ON Unit.UnitID = Enroll.UnitID
INNER JOIN Specialty
	ON Specialty.SpecialtyID = Unit.SpecialtyID
WITH CHECK OPTION;
GO 