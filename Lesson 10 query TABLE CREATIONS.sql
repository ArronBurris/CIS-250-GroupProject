USE ab0902082

GO

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'g_Patients')
CREATE TABLE g_Patients(	
	PatientID		INT			PRIMARY KEY		IDENTITY,
	PatientNumber	VARCHAR(10) NOT NULL		UNIQUE,
	FirstName		VARCHAR(60)	NOT NULL,
	LastName		VARCHAR(60) NOT NULL,
	StreetAddress	VARCHAR(60) NOT NULL,
	City			VARCHAR(60) NOT NULL,
	State			VARCHAR(2)	NOT NULL,
	ZipCode			VARCHAR(10) NOT NULL
)
IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'g_CostCenters')
CREATE TABLE g_CostCenters(
	CenterID		INT			PRIMARY KEY		IDENTITY,
	CostName		VARCHAR(60)	NOT NULL		UNIQUE
)

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'g_PatientBills')
CREATE TABLE g_PatientBills(
	BillingID		INT			PRIMARY KEY		IDENTITY,
	CenterID		INT			REFERENCES g_CostCenters(CenterID),
	PatientID		INT			REFERENCES g_Patients(PatientID),
	BillDate		DATE	NOT NULL,
	DateAdmitted	DATE	NOT NULL,
	DateDischarged	DATE	NOT NULL
)

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'g_Items')
CREATE TABLE g_Items(
	ItemID			INT			PRIMARY KEY		IDENTITY,
	ItemCode		VARCHAR		CHECK((ItemCode < 10000) AND (ItemCode >= 0))	UNIQUE,
	CenterID		INT			REFERENCES g_CostCenters(CenterID),
	ItemDescription	VARCHAR(1000)	DEFAULT NULL
)

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'g_Charges')
CREATE TABLE g_Charges(
	BillingID		INT			REFERENCES g_PatientBills(BillingID),
	ItemID			INT			REFERENCES g_Items(ItemID),
	CenterID		INT			REFERENCES g_CostCenters(CenterID),
	DateCharged		DATE		NOT NULL,
	ChargeAmount	MONEY		NOT NULL		CHECK(ChargeAmount >= 0)
)



IF NOT EXISTS(SELECT * FROM g_Patients WHERE PatientID = 1)
INSERT INTO g_Patients (PatientNumber, FirstName, LastName, StreetAddress, City, State, ZipCode) VALUES
(12345, 'Mary', 'Baker', '300 Oak Street', 'Boulder', 'CO', '80638')


SELECT * FROM g_Patients;






/*
DROP TABLE g_Charges, g_PatientBills, g_Items, g_CostCenters, g_Patients;
*/
