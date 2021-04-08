drop table TransactionEventDetail;
drop table TransactionEvent;

create table TransactionEvent (
 TransactionEvent_id int identity,
 plant varchar(40),
 filename varchar(500),
 type varchar(20),
 failedRecordCount int,
 successfulRecordCount int,
 errorMessage varchar(1000),
 createDate datetime default getdate(),
 CONSTRAINT [PK_TransactionEvent] PRIMARY KEY (TransactionEvent_id)
);
create table TransactionEventDetail (
 TransactionEventDetail_id int identity,
 TransactionEvent_id int,
 tag varchar(100),
 errorMessage varchar(1000),
 CONSTRAINT [PK_TransactionEventDetail] PRIMARY KEY (TransactionEventDetail_id),
 CONSTRAINT [FK_transactioneventdetail] FOREIGN KEY([transactionevent_id]) REFERENCES [dbo].[transactionevent] ([transactionevent_id]) 
);
go

drop table MaterialMovement;
drop table CustodyTicket;
CREATE TABLE [MaterialMovement](
	[MaterialMovement_id] int identity,
	materialDocument [varchar](50) NOT NULL,
	[Material] [int] NULL,
	[System] [varchar](50) NOT NULL,
	[MovementType] [varchar](30) NULL,
	[MovementTypeDesc] [varchar](800) NULL,
	[Plant] [varchar](30) NULL,
	HeaderText [varchar](1000) NULL,
	[Tag] [varchar](100) NOT NULL,
	[PostingDate] [datetime] NOT NULL,
	[ValuationType] [varchar](30) NULL,
	[Quantity] [decimal](18, 4) NULL,
	[UnitOfEntry] [varchar](10) NULL,
	UnitOfMeasure [varchar](10) NULL,
	[QuantityInUOE] [decimal](18, 4) NULL,
	[QuantityInL15] [decimal](18, 4) NULL,
	[BatchId] [varchar](50) NULL,
	EnteredOn [datetime] NOT NULL,
	EnteredAt [varchar](50) NOT NULL,
	 CONSTRAINT [PK_MaterialMovement] PRIMARY KEY CLUSTERED ([MaterialMovement_id] asc)
)
GO
ALTER TABLE [MaterialMovement]  WITH CHECK ADD  CONSTRAINT [FK_MaterialMovement_UnitOfEntry] FOREIGN KEY(UnitOfEntry)
REFERENCES [StandardUnit] ([Name])
GO
ALTER TABLE [MaterialMovement] CHECK CONSTRAINT [FK_MaterialMovement_UnitOfEntry]
GO
ALTER TABLE [MaterialMovement]  WITH CHECK ADD  CONSTRAINT [FK_MaterialMovement_UnitOfMeasure] FOREIGN KEY(UnitOfMeasure)
REFERENCES [StandardUnit] ([Name])
GO
ALTER TABLE [MaterialMovement] CHECK CONSTRAINT [FK_MaterialMovement_UnitOfMeasure]
GO
create table CustodyTicket (
	custodyTicket_id int identity,
	S4_Material_Document [varchar](50) NOT NULL,
	BOL_Number [varchar](50) NOT NULL,
	S4_Material [varchar](50) NOT NULL,
	Source_Data_Material_Code [varchar](50) NOT NULL,
	Sign [varchar](50) NOT NULL,
	Gross_Quantity_Size decimal(10,5) NOT NULL,
	Net_Quantity_Size decimal(10,5) NOT NULL,
	Unit_of_Measure [varchar](10) NOT NULL,
	Valuation_Type [varchar](10) NOT NULL,
	Density decimal(10,5) NOT NULL,
	Movement_Plant [varchar](50) NOT NULL,
	Sending_Plant [varchar](10) NOT NULL,
	Receiving_Plant [varchar](10) NOT NULL,
	Temperature [varchar](50) NOT NULL,
	Movement_Type [varchar](50) NOT NULL,
	Mode[varchar](10) NOT NULL,
	Load_Start_Date [varchar](50) NOT NULL,
	Load_Start_Time [varchar](50) NOT NULL,
	Load_End_DateTime Datetime NOT NULL,
	Entered_On_DateTime Datetime NOT NULL,
	Entered_by [varchar](50) NOT NULL,
	Document_DateTime Datetime NOT NULL,
	Posting_DateTime Datetime NOT NULL,
	CONSTRAINT CHK_Mode CHECK (Mode in ('Rail', 'Pipeline', 'Marine')),
	CONSTRAINT [PK_CustodyTicket] PRIMARY KEY CLUSTERED ([CustodyTicket_id] asc)
)
go
ALTER TABLE [CustodyTicket]  WITH CHECK ADD  CONSTRAINT [FK_CustodyTicket_Unit_of_Measure] FOREIGN KEY([Unit_of_Measure])
REFERENCES [StandardUnit] ([Name])
GO
ALTER TABLE [CustodyTicket] CHECK CONSTRAINT [FK_CustodyTicket_Unit_of_Measure]
GO

alter table tagbalance add OpeningInventory decimal(18,3)
alter table tagbalance add ClosingInventory decimal(18,3)
alter table tagbalance add Shipment decimal(18,3)
alter table tagbalance add Receipt decimal(18,3)
alter table tagbalance add Confidence decimal(18,3)
go
alter table materialmovement add OpeningInventory decimal(18,3)
alter table materialmovement add ClosingInventory decimal(18,3)
alter table materialmovement add Shipment decimal(18,3)
alter table materialmovement add Receipt decimal(18,3)
go
alter table transactionevent add type varchar(20)
alter table transactionevent add extra varchar(8000)
go
alter table conversion add material varchar(50)
go
alter table MaterialMovement alter column tag varchar(100)
alter table TransactionEventDetail alter column tag varchar(100)
go
ALTER TABLE [dbo].[TagMap] drop constraint [PK_TagMap]
alter table tagmap alter column tag varchar(100) not null
ALTER TABLE [dbo].[TagMap] add constraint [PK_TagMap]  primary key (	[Tag] ASC,	[Plant] ASC)
go
 drop table ProductHierarchy
 go
 CREATE TABLE [ProductHierarchy](
	[S4Material] [int] not NULL,
	[MaterialDescription] [varchar](100) NULL,
	[MaterialGroup] [varchar](50) NULL,
	[MaterialGroupText] [varchar](100) NULL,
	[ProductHierarchyLevel1Code] [varchar](50) NULL,
	[ProductHierarchyLevel1Text] [varchar](100) NULL,
	[ProductHierarchyLevel2Code] [varchar](50) NULL,
	[ProductHierarchyLevel2Text] [varchar](100) NULL,
	[ProductHierarchyLevel3Code] [varchar](50) NULL,
	[ProductHierarchyLevel3Text] [varchar](100) NULL,
	EnteredOn [datetime] NOT NULL default getdate(),
	EnteredAt [varchar](50) NULL,
	 CONSTRAINT [PK_ProductHierarchy] PRIMARY KEY CLUSTERED ([S4Material] asc)
)
GO

 drop table MaterialLedger
 go
 
  CREATE TABLE [MaterialLedger](
	[Plant] [varchar](20) not NULL,
	[CoCode] [varchar](20) not NULL,
	[PostingYear] int not NULL,
	[PostingPeriod] int NULL,
	[Status] [varchar](5) NULL,
	[PreviousPeriodOpen] [varchar](10) NULL,
	 CONSTRAINT [PK_MaterialLedger] PRIMARY KEY CLUSTERED (plant, CoCode)
)
go