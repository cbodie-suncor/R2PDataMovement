drop table TransactionEventDetail;
drop table TransactionEvent;

create table TransactionEvent (
 TransactionEvent_id int identity,
 plant varchar(40),
 filename varchar(500),
 failedRecordCount int,
 successfulRecordCount int,
 errorMessage varchar(1000),
 createDate datetime default getdate(),
 CONSTRAINT [PK_TransactionEvent] PRIMARY KEY (TransactionEvent_id)
);
create table TransactionEventDetail (
 TransactionEventDetail_id int identity,
 TransactionEvent_id int,
 tag varchar(40),
 errorMessage varchar(1000),
 CONSTRAINT [PK_TransactionEventDetail] PRIMARY KEY (TransactionEventDetail_id),
 CONSTRAINT [FK_transactioneventdetail] FOREIGN KEY([transactionevent_id]) REFERENCES [dbo].[transactionevent] ([transactionevent_id]) 
);
go

drop table MaterialMovement;
drop table CustodyTicket;
CREATE TABLE [MaterialMovement](
	[MaterialMovement_id] int identity,
	[reference] [varchar](50) NOT NULL,
	[Tag] [varchar](50) NOT NULL,
	[System] [varchar](50) NOT NULL,
	[MovementType] [varchar](20) NULL,
	[Material] [int] NULL,
	[Plant] [varchar](30) NULL,
	[WorkCenter] [varchar](30) NULL,
	[ValType] [varchar](30) NULL,
	[Tank] [varchar](30) NULL,
	[QuantityTimestamp] [datetime] NOT NULL,
	[BalanceDate] [datetime] NOT NULL,
	[QuantityInUnitOfEntry] [decimal](18, 4) NULL,
	[UnitOfEntry] [varchar](10) NULL,
	[QuantityInBaseUnit] [decimal](18, 4) NULL,
	[BaseUnit] [varchar](10) NULL,
	[BatchId] [varchar](50) NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
)
GO
ALTER TABLE [MaterialMovement]  WITH CHECK ADD  CONSTRAINT [FK_MaterialMovement_BasedUnit] FOREIGN KEY([BaseUnit])
REFERENCES [StandardUnit] ([Name])
GO
ALTER TABLE [MaterialMovement] CHECK CONSTRAINT [FK_MaterialMovement_BasedUnit]
GO
ALTER TABLE [MaterialMovement]  WITH CHECK ADD  CONSTRAINT [FK_MaterialMovement_UnitOfEntry] FOREIGN KEY([UnitOfEntry])
REFERENCES [StandardUnit] ([Name])
GO
ALTER TABLE [MaterialMovement] CHECK CONSTRAINT [FK_MaterialMovement_UnitOfEntry]
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
	CONSTRAINT CHK_Mode CHECK (Mode in ('Rail', 'Pipeline', 'Marine'))
)
go
ALTER TABLE [CustodyTicket]  WITH CHECK ADD  CONSTRAINT [FK_CustodyTicket_Unit_of_Measure] FOREIGN KEY([Unit_of_Measure])
REFERENCES [StandardUnit] ([Name])
GO
ALTER TABLE [CustodyTicket] CHECK CONSTRAINT [FK_CustodyTicket_Unit_of_Measure]
GO

