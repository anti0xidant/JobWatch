--*****Build Database*****
USE master
CREATE DATABASE JobWatch
GO
--*************************
--****Destroy Existing Tables****
USE JobWatch
GO
DROP TABLE JobsxLanguage
DROP TABLE Jobs
DROP TABLE Language
DROP TABLE OfferPhase
DROP TABLE IntermediatePhase
DROP TABLE Location
DROP TABLE States
DROP TABLE Type
DROP TABLE Recruiter
DROP TABLE Company
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
TypeDescription			nchar(20)			not null
)

CREATE TABLE States
(
State					varchar(22)			not null,
StateCode				char(2)				not null		PRIMARY KEY
)

CREATE TABLE Cities
(
CityID					int					IDENTITY(1,1)	PRIMARY KEY,
City					varchar(50)			not null,
StateCode				char(2)				not null,

CONSTRAINT FK_StateAbrv				FOREIGN KEY (StateCode)				REFERENCES	States				(StateCode)
)


CREATE TABLE IntermediatePhase
(
IntermediatePhaseID		int					IDENTITY(1,1)	PRIMARY KEY,
Title					varchar(25)			not null
)

CREATE TABLE OfferPhase
(
OfferPhaseID			int					IDENTITY(1,1)	PRIMARY KEY,
Title					varchar(25)			not null,
)

CREATE TABLE Language
(
LanguageID				int					IDENTITY(1,1)	PRIMARY KEY,
Name					varchar(20)			not null
)

CREATE TABLE Jobs
(
JobID					int					IDENTITY(1,1)	PRIMARY KEY,
CompanyID				int,
RecruiterID				int,
Title					varchar(30)			not null,
TypeID					int					not null,	-- (0)-Front End, (1)-Middle, (2)-Database, (3)-Fullstack
Url						nvarchar(2083),					--Max allowed Url length == 2083
CityID					int					not null,
Summary					nvarchar(4000),
DateListed				datetime,
DateApplied				datetime			not null,
IsRecruiter				bit					not null,	-- (0)-Not recruiter job, (1)-Is recruiter job
IsActive				bit					not null,	-- (0)-Deleted, (1)-Not deleted
IntermediatePhaseID		int					not null,	-- (0)-Awaiting Callback, (1)-Interview Phase
InterviewCount			int					not null,
OfferPhaseID			int					not null,	-- (0)-Not yet reached, (1)-Offered but deciding, (2)-Offered but pass, (3)-Accepted offer 
OfferedSalary			smallmoney,
RejectionStatus			bit,							-- (0)-Not rejected, (1)-Rejected

CONSTRAINT FK_CompanyID				FOREIGN KEY (CompanyID)				REFERENCES	Company				(CompanyID),
CONSTRAINT FK_RecruiterID			FOREIGN KEY (RecruiterID)			REFERENCES	Recruiter			(RecruiterID),
CONSTRAINT FK_TypeID				FOREIGN KEY (TypeID)				REFERENCES	Type				(TypeID),
CONSTRAINT FK_LocationID			FOREIGN KEY (CityID)				REFERENCES	Cities				(CityID),
CONSTRAINT FK_IntermediatePhaseID	FOREIGN KEY (IntermediatePhaseID)	REFERENCES	IntermediatePhase	(IntermediatePhaseID),
CONSTRAINT FK_OfferPhaseID			FOREIGN KEY (OfferPhaseID)			REFERENCES	OfferPhase			(OfferPhaseID)
)

CREATE TABLE JobxLanguage
(
JobID					int					not null,
LanguageID				int					not null,	-- (0)-C#, (1)-Java, (2)-Python, (3)-JavaScript, (4)-jQuery, (5)-AngularJS, (6)-SQL

CONSTRAINT FK_JobID			 FOREIGN KEY (JobID)		REFERENCES	Jobs		(JobID),
CONSTRAINT FK_LanguageID	 FOREIGN KEY (LanguageID)	REFERENCES	Language	(LanguageID)
)

--*******************************