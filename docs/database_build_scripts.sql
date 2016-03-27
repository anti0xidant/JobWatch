--*****Build Database*****
USE master
CREATE DATABASE JobWatch
GO
--*************************
--****Destroy Existing Tables****
USE JobWatch
GO

DROP TABLE Company
DROP TABLE Recruiter
DROP TABLE Type
DROP TABLE States
DROP TABLE Location
DROP TABLE IntermediatePhase
DROP TABLE OfferPhase
DROP TABLE Language
DROP TABLE Jobs
DROP TABLE JobsxLanguage
GO
--*******************************

--****Build Tables***************
USE JobWatch

CREATE TABLE Company
(
CompanyID				int					IDENTITY(1,1)	PRIMARY KEY,
CompanyName				varchar(30)			not null,
CompanyUrl				nvarchar(2083)
)

CREATE TABLE Recruiter
(
RecruiterID				int					IDENTITY(1,1)	PRIMARY KEY,
RecruiterCompanyName	varchar(30)			not null,
RecruiterName			varchar(30),
RecruiterNumber			varchar(10),
RecruiterEmail			varchar(30)
)

CREATE TABLE Type
(
TypeID					int					IDENTITY(1,1)	PRIMARY KEY,
Type					nchar(20)			not null
)

CREATE TABLE States
(
StateAbrv				char(2)				not null		PRIMARY KEY,
State					varchar(22)			not null
)

CREATE TABLE Location
(
LocationID				int					IDENTITY(1,1)	PRIMARY KEY,
City					varchar(50)			not null,
StateAbrv				char(2)				not null,

CONSTRAINT FK_StateAbrv				FOREIGN KEY (StateAbrv)				REFERENCES	States				(StateAbrv)
)


CREATE TABLE IntermediatePhase
(
IntermediatePhaseID		int					IDENTITY(1,1)	PRIMARY KEY,
IntermediatePhase		varchar(25)			not null
)

CREATE TABLE OfferPhase
(
OfferPhaseID			int					IDENTITY(1,1)	PRIMARY KEY,
OfferPhase				varchar(25)			not null,
)

CREATE TABLE Language
(
LanguageID				int					IDENTITY(1,1)	PRIMARY KEY,
Language				varchar(20)			not null
)

CREATE TABLE Jobs
(
JobID					int					IDENTITY(1,1)	PRIMARY KEY,
CompanyID				int,
RecruiterID				int,
Title					varchar(30)			not null,
Url						nvarchar(2083),
LocationID				int					not null,
Description				nvarchar(4000),
DateListed				datetime,
DateApplied				datetime			not null,
IsRecruiter				bit					not null,
IsActive				bit					not null,
IntermediatePhaseID		int					not null,
InterviewCount			int					not null,
OfferPhaseID			int					not null,
OfferedSalary			smallmoney,
RejectionStatus			bit					not null,

CONSTRAINT FK_CompanyID				FOREIGN KEY (CompanyID)				REFERENCES	Company				(CompanyID),
CONSTRAINT FK_RecruiterID			FOREIGN KEY (RecruiterID)			REFERENCES	Recruiter			(RecruiterID),
CONSTRAINT FK_LocationID			FOREIGN KEY (LocationID)			REFERENCES	Location			(LocationID),
CONSTRAINT FK_IntermediatePhaseID	FOREIGN KEY (IntermediatePhaseID)	REFERENCES	IntermediatePhase	(IntermediatePhaseID),
CONSTRAINT FK_OfferPhaseID			FOREIGN KEY (OfferPhaseID)			REFERENCES	OfferPhase			(OfferPhaseID)
)

CREATE TABLE JobxLanguage
(
JobID					int					not null,
LanguageID				int					not null,

CONSTRAINT FK_JobID			 FOREIGN KEY (JobID)		REFERENCES	Jobs		(JobID),
CONSTRAINT FK_LanguageID	 FOREIGN KEY (LanguageID)	REFERENCES	Language	(LanguageID)
)

--*******************************