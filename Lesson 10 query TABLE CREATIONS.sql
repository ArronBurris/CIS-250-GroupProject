USE ab0902082

GO

CREATE TABLE g_Patients(
	PatientNumber	INT			PRIMARY KEY		IDENTITY,
	FirstName		VARCHAR(60)	NOT NULL,
	LastName		VARCHAR(60) NOT NULL,
	StreetAddress	VARCHAR(60) NOT NULL,
	City			VARCHAR(60) NOT NULL,
	State			VARCHAR(2)	NOT NULL,
	ZipCode			VARCHAR(10) NOT NULL
)

CREATE TABLE g_CostCenters(
	CenterID		INT			PRIMARY KEY		IDENTITY,
	CostName		VARCHAR(60)	NOT NULL
)

CREATE TABLE g_PatientBills(
	BillingID		INT			PRIMARY KEY		IDENTITY,
	CenterID		INT			REFERENCES g_CostCenters(CenterID),
	PatientNumber	INT			REFERENCES g_Patients(PatientNumber),
	BillDate		DATE	NOT NULL,
	DateAdmitted	DATE	NOT NULL,
	DateDischarged	DATE	NOT NULL
)

CREATE TABLE g_Items(
	ItemID			INT			PRIMARY KEY		IDENTITY,
	ItemCode		VARCHAR		CHECK((ItemCode < 10000) AND (ItemCode >= 0)),
	CenterID		INT			REFERENCES g_CostCenters(CenterID),
	ItemDescription	VARCHAR(1000)	DEFAULT NULL
)

CREATE TABLE g_Charges(
	BillingID		INT			REFERENCES g_PatientBills(BillingID),
	ItemID			INT			REFERENCES g_Items(ItemID),
	CenterID		INT			REFERENCES g_CostCenters(CenterID),
	DateCharged		DATE		NOT NULL,
	ChargeAmount	MONEY		NOT NULL		CHECK(ChargeAmount >= 0)
)



