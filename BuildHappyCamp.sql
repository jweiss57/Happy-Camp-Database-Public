-- Happy Camp database developed and written by Jacob Weiss
-- Written: April 2022
---------------------------------------------------------------
-- Replace <data_path> with the full path to this file 
-- Ensure it ends with a backslash 
-- E.g., C:\MyDatabases\ See line 18
---------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE NAME = N'HappyCamp')
	CREATE DATABASE HappyCamp
GO
USE HappyCamp
--
-- Alter the path so the script can find the CSV files
--
DECLARE
	@data_path NVARCHAR(256);
SELECT @data_path = 'C:\Users\jacob\Info 3240 (Enterpise DataBase Managment\INFO 3240 Project\Part 1\';
--
-- Delete existing tables
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Registration'
       )
	DROP TABLE Registration;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Parent'
       )
	DROP TABLE Parent;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Enroll'
       )
	DROP TABLE Enroll;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Camper'
       )
	DROP TABLE Camper;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'UnitStaff'
       )
	DROP TABLE UnitStaff;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'SummerStaff'
       )
	DROP TABLE SummerStaff;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Unit'
       )
	DROP TABLE Unit;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Specialty'
       )
	DROP TABLE Specialty;
--
--
-- Create tables
--
CREATE TABLE Parent
(
	ParentID 				INT CONSTRAINT pk_parent PRIMARY KEY,
    ParentFirstName			NVARCHAR(35) CONSTRAINT nn_parent_first_name NOT NULL,
    ParentLastName			NVARCHAR(45) CONSTRAINT nn_parent_last_name NOT NULL,
    ParentAdress			NVARCHAR(150) CONSTRAINT nn_parent_adress NOT NULL,
    ParentZipCode 			INT CONSTRAINT nn_parent_zip_code NOT NULL,
	ParentCity				NVARCHAR(100) CONSTRAINT nn_parent_city NOT NULL,
	ParentState				NVARCHAR(2) CONSTRAINT nn_parent_state NOT NULL,
	ParentEmail				NVARCHAR(60) CONSTRAINT nn_parent_email NOT NULL
);

CREATE TABLE Camper
(
	CamperID				INT CONSTRAINT pk_camper PRIMARY KEY,
	CamperFirstName			NVARCHAR(35) CONSTRAINT nn_camper_first_name NOT NULL,
	CamperLastName 			NVARCHAR(45) CONSTRAINT nn_camper_last_name NOT NULL,
	CamperAdress			NVARCHAR(150) CONSTRAINT nn_camper_adress NOT NULL,
    CamperZipCode 			INT CONSTRAINT nn_camper_zip_code NOT NULL,
	CamperCity				NVARCHAR(100) CONSTRAINT nn_camper_city NOT NULL,
	CamperState				NVARCHAR(2) CONSTRAINT nn_camper_state NOT NULL,
	CamperBirthday			DATE CONSTRAINT nn_camper_birthday NOT NULL,
);
	
CREATE TABLE Registration
(
	RegistrationDateTime	DATETIME CONSTRAINT pk_registration PRIMARY KEY,
	ParentID 				INT CONSTRAINT fk_registration_parent FOREIGN KEY (ParentID) REFERENCES Parent(ParentID),
	CamperID 				INT CONSTRAINT fk_registration_camper FOREIGN KEY (CamperID) REFERENCES Camper(CamperID)
);

CREATE TABLE Specialty
(
	SpecialtyID				INT CONSTRAINT pk_specialty PRIMARY KEY,
	SpecialtyType			NVARCHAR(20) CONSTRAINT nn_specialty_type NOT NULL,
	SpecialtyDescription	NVARCHAR(225) CONSTRAINT nn_specialty_description NOT Null
);

CREATE TABLE Unit
(
	UnitID					INT CONSTRAINT pk_unit PRIMARY KEY,
	UnitName				NVARCHAR(15) CONSTRAINT nn_unit_name NOT NULL,
	UnitAgeGroup			NVARCHAR(20) CONSTRAINT nn_unit_age_group NOT NULL,
	UnitLocation			NVARCHAR(30) CONSTRAINT nn_unit_location NOT NULL,
	SpecialtyID				INT CONSTRAINT fk_unit_specialty FOREIGN KEY (SpecialtyID) REFERENCES Specialty(SpecialtyID),
	UnitLength				NVARCHAR(20) CONSTRAINT nn_unit_length NOT NULL
);

CREATE TABLE Enroll
(
	EnrollmentID			INT CONSTRAINT pk_enroll PRIMARY KEY,
	UnitID					INT CONSTRAINT fk_enroll_unit FOREIGN KEY (UnitID) REFERENCES Unit(UnitID),
	CamperID				INT CONSTRAINT fk_enroll_camper FOREIGN KEY (CamperID) REFERENCES Camper(CamperID)
);

CREATE TABLE SummerStaff
(
	StaffID					INT CONSTRAINT pk_summer_staff PRIMARY KEY,
	StaffFirstName			NVARCHAR(35) CONSTRAINT nn_staff_first_name NOT NULL,
	StaffLastName 			NVARCHAR(45) CONSTRAINT nn_staff_last_name NOT NULL,
	StaffContactNumber		NVARCHAR(20) CONSTRAINT nn_staff_contact_number NOT NULL
);

CREATE TABLE UnitStaff
(
	ContractSignDate		DATETIME CONSTRAINT pk_unit_staff PRIMARY KEY,
	UnitID					INT CONSTRAINT fk_unit_staff_unit FOREIGN KEY (UnitID) REFERENCES Unit(UnitID),
	StaffID					INT CONSTRAINT fk_unit_staff_staff FOREIGN KEY (StaffID) REFERENCES SummerStaff (StaffID)
);


-- Load table data
--

EXECUTE (N'BULK INSERT Parent FROM ''' + @data_path + N'Parent.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
EXECUTE (N'BULK INSERT Camper FROM ''' + @data_path + N'Camper.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');

--

EXECUTE (N'BULK INSERT Registration FROM ''' + @data_path + N'Registration.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--

EXECUTE (N'BULK INSERT Specialty FROM ''' + @data_path + N'Specialty.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--

EXECUTE (N'BULK INSERT Unit FROM ''' + @data_path + N'Unit.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--

EXECUTE (N'BULK INSERT Enroll FROM ''' + @data_path + N'Enroll.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--

EXECUTE (N'BULK INSERT SummerStaff FROM ''' + @data_path + N'SummerStaff.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--

EXECUTE (N'BULK INSERT UnitStaff FROM ''' + @data_path + N'UnitStaff.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	TABLOCK
	);
');
--
-- List table names and row counts for confirmation
--
SET NOCOUNT ON
SELECT 'Parent' AS "Table",		COUNT(*) AS "Rows"	FROM Parent				UNION
SELECT 'Camper',				COUNT(*)			FROM Camper				UNION
SELECT 'Registration',			COUNT(*)			FROM Registration		UNION
SELECT 'Specialty',				COUNT(*)			FROM Specialty			UNION
SELECT 'Unit',					COUNT(*)			FROM Unit				UNION
SELECT 'Enroll',				COUNT(*)			FROM Enroll				UNION
SELECT 'SummerStaff',			COUNT(*)			FROM SummerStaff		UNION
SELECT 'UnitStaff',				COUNT(*)			FROM UnitStaff			           
ORDER BY 1;
SET NOCOUNT OFF
GO

