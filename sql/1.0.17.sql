/****** Object:  Table [dbo].[Batch]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Batch](
	[Id] [varchar](50) NOT NULL,
	[Status] [tinyint] NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[filename] [varchar](200) NULL,
 CONSTRAINT [PK_Batch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conversion]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conversion](
	[material] [varchar](50) NOT NULL,
	[StandardUnit] [varchar](10) NOT NULL,
	[ToUnit] [varchar](10) NOT NULL,
	[Factor] [decimal](18, 8) NULL,
 CONSTRAINT [PK_Conversion] PRIMARY KEY CLUSTERED 
(
	[material] ASC,
	[StandardUnit] ASC,
	[ToUnit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustodyTicket]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustodyTicket](
	[custodyTicket_id] [int] IDENTITY(1,1) NOT NULL,
	[S4_Material_Document] [varchar](50) NOT NULL,
	[BOL_Number] [varchar](50) NOT NULL,
	[S4_Material] [varchar](50) NOT NULL,
	[Source_Data_Material_Code] [varchar](50) NOT NULL,
	[Sign] [varchar](50) NOT NULL,
	[Gross_Quantity_Size] [decimal](10, 5) NOT NULL,
	[Net_Quantity_Size] [decimal](10, 5) NOT NULL,
	[Unit_of_Measure] [varchar](10) NOT NULL,
	[Valuation_Type] [varchar](10) NOT NULL,
	[Density] [decimal](10, 5) NOT NULL,
	[Movement_Plant] [varchar](50) NOT NULL,
	[Sending_Plant] [varchar](10) NOT NULL,
	[Receiving_Plant] [varchar](10) NOT NULL,
	[Temperature] [varchar](50) NOT NULL,
	[Movement_Type] [varchar](50) NOT NULL,
	[Mode] [varchar](10) NOT NULL,
	[Load_Start_Date] [varchar](50) NOT NULL,
	[Load_Start_Time] [varchar](50) NOT NULL,
	[Load_End_DateTime] [datetime] NOT NULL,
	[Entered_On_DateTime] [datetime] NOT NULL,
	[Entered_by] [varchar](50) NOT NULL,
	[Document_DateTime] [datetime] NOT NULL,
	[Posting_DateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_CustodyTicket] PRIMARY KEY CLUSTERED 
(
	[custodyTicket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventorySnapshot]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventorySnapshot](
	[Tag] [varchar](50) NOT NULL,
	[Tank] [varchar](30) NOT NULL,
	[System] [varchar](50) NOT NULL,
	[MovementType] [varchar](20) NULL,
	[Material] [varchar](20) NULL,
	[Plant] [varchar](30) NULL,
	[WorkCenter] [varchar](30) NULL,
	[ValType] [varchar](30) NOT NULL,
	[QuantityTimestamp] [datetime] NOT NULL,
	[Quantity] [decimal](18, 4) NULL,
	[StandardUnit] [varchar](10) NULL,
	[BatchId] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[Confidence] [decimal](18, 3) NULL,
	[lastUpdated] [datetime] NULL,
 CONSTRAINT [PK_InventorySnapshot] PRIMARY KEY CLUSTERED 
(
	[Tag] ASC,
	[ValType] ASC,
	[QuantityTimestamp] ASC,
	[Tank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaterialLedger]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialLedger](
	[Plant] [varchar](20) NOT NULL,
	[CoCode] [varchar](20) NOT NULL,
	[PostingYear] [int] NOT NULL,
	[PostingPeriod] [int] NULL,
	[Status] [varchar](5) NULL,
	[PreviousPeriodOpen] [varchar](10) NULL,
 CONSTRAINT [PK_MaterialLedger] PRIMARY KEY CLUSTERED 
(
	[Plant] ASC,
	[CoCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaterialMovement]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialMovement](
	[MaterialMovement_id] [int] IDENTITY(1,1) NOT NULL,
	[materialDocument] [varchar](50) NOT NULL,
	[Material] [int] NULL,
	[System] [varchar](50) NOT NULL,
	[MovementType] [varchar](30) NULL,
	[MovementTypeDesc] [varchar](800) NULL,
	[Plant] [varchar](30) NULL,
	[HeaderText] [varchar](1000) NULL,
	[Tag] [varchar](100) NULL,
	[PostingDate] [datetime] NOT NULL,
	[ValuationType] [varchar](30) NULL,
	[Quantity] [decimal](18, 4) NULL,
	[UnitOfEntry] [varchar](10) NULL,
	[UnitOfMeasure] [varchar](10) NULL,
	[QuantityInUOE] [decimal](18, 4) NULL,
	[QuantityInL15] [decimal](18, 4) NULL,
	[BatchId] [varchar](50) NULL,
	[EnteredOn] [datetime] NOT NULL,
	[EnteredAt] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MaterialMovement] PRIMARY KEY CLUSTERED 
(
	[MaterialMovement_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductHierarchy]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductHierarchy](
	[S4Material] [int] NOT NULL,
	[MaterialDescription] [varchar](100) NULL,
	[MaterialGroup] [varchar](50) NULL,
	[MaterialGroupText] [varchar](100) NULL,
	[ProductHierarchyLevel1Code] [varchar](50) NULL,
	[ProductHierarchyLevel1Text] [varchar](100) NULL,
	[ProductHierarchyLevel2Code] [varchar](50) NULL,
	[ProductHierarchyLevel2Text] [varchar](100) NULL,
	[ProductHierarchyLevel3Code] [varchar](50) NULL,
	[ProductHierarchyLevel3Text] [varchar](100) NULL,
	[EnteredOn] [datetime] NOT NULL,
	[EnteredAt] [varchar](50) NULL,
 CONSTRAINT [PK_ProductHierarchy] PRIMARY KEY CLUSTERED 
(
	[S4Material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SourceUnitMap]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceUnitMap](
	[Source] [varchar](20) NOT NULL,
	[SourceUnit] [varchar](20) NOT NULL,
	[StandardUnit] [varchar](10) NOT NULL,
 CONSTRAINT [PK_UomMap] PRIMARY KEY CLUSTERED 
(
	[Source] ASC,
	[SourceUnit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StandardUnit]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StandardUnit](
	[Name] [varchar](10) NOT NULL,
 CONSTRAINT [PK_StandardUnit] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TagBalance]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TagBalance](
	[Tag] [varchar](50) NOT NULL,
	[System] [varchar](50) NOT NULL,
	[MovementType] [varchar](20) NULL,
	[Material] [varchar](20) NULL,
	[Plant] [varchar](30) NULL,
	[WorkCenter] [varchar](30) NULL,
	[ValType] [varchar](30) NOT NULL,
	[Tank] [varchar](30) NULL,
	[BalanceDate] [datetime] NOT NULL,
	[Quantity] [decimal](18, 4) NULL,
	[StandardUnit] [varchar](10) NULL,
	[BatchId] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[OpeningInventory] [decimal](18, 3) NULL,
	[ClosingInventory] [decimal](18, 3) NULL,
	[Shipment] [decimal](18, 3) NULL,
	[Receipt] [decimal](18, 3) NULL,
	[consumption] [decimal](18, 3) NULL,
	[lastUpdated] [datetime] NULL,
 CONSTRAINT [PK_TagBalance] PRIMARY KEY CLUSTERED 
(
	[Tag] ASC,
	[BalanceDate] ASC,
	[ValType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TagMap]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TagMap](
	[Tag] [varchar](100) NOT NULL,
	[Plant] [varchar](4) NOT NULL,
	[WorkCenter] [varchar](10) NOT NULL,
	[MaterialNumber] [varchar](20) NULL,
	[DefaultValuationType] [varchar](10) NOT NULL,
	[DefaultUnit] [varchar](10) NULL,
 CONSTRAINT [PK_TagMap] PRIMARY KEY CLUSTERED 
(
	[Tag] ASC,
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionEvent]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionEvent](
	[TransactionEvent_id] [int] IDENTITY(1,1) NOT NULL,
	[plant] [varchar](40) NULL,
	[filename] [varchar](500) NULL,
	[failedRecordCount] [int] NULL,
	[successfulRecordCount] [int] NULL,
	[message] [varchar](3000) NULL,
	[createDate] [datetime] NULL,
	[type] [varchar](20) NULL,
	[extra] [varchar](8000) NULL,
 CONSTRAINT [PK_TransactionEvent] PRIMARY KEY CLUSTERED 
(
	[TransactionEvent_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionEventDetail]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionEventDetail](
	[TransactionEventDetail_id] [int] IDENTITY(1,1) NOT NULL,
	[TransactionEvent_id] [int] NOT NULL,
	[type] [varchar](10) NOT NULL,
	[message] [varchar](3000) NOT NULL,
	[tag] [varchar](100) NULL,
 CONSTRAINT [PK_TransactionEventDetail] PRIMARY KEY CLUSTERED 
(
	[TransactionEventDetail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductionMatDoc]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ProductionMatDoc] as
select * from MaterialMovement
where movementtype = 'Production';
GO
/****** Object:  View [dbo].[SiteProductionData]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[SiteProductionData] as
select * from tagBalance
where movementtype = 'Production';
GO
/****** Object:  View [dbo].[VarianceReport]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[VarianceReport] as 
select 
spd.tag as Tag, 
spd.system as System,
spd.material as Material,
spd.valtype as ValType, 
spd.BalanceDate as BalanceData,
spd.quantity as ProductionFromSiteProductionData, 
pmd.Quantity  as ProductionFromMatDoc,
pmd.Quantity - spd.quantity  as ProductionDifference
from SiteProductionData spd, ProductionMatDoc pmd
where
spd.tag = pmd.tag and 
spd.BalanceDate = pmd.PostingDate and 
spd.Quantity <> pmd.Quantity;
GO
/****** Object:  View [dbo].[CustodyTicketMatDoc]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CustodyTicketMatDoc] as
select * from MaterialMovement
where movementtype = 'CustodyTickets';
GO
/****** Object:  View [dbo].[LatestTransactions]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[LatestTransactions] as 
select
      [plant]
      ,[filename]
      ,[failedRecordCount]
      ,[successfulRecordCount]
      ,[errorMessage]
 ,[createDate] AT TIME ZONE 'UTC' AT TIME ZONE 'Mountain Standard Time' AS createDate
  FROM [dbo].[TransactionEvent]
GO
/****** Object:  View [dbo].[R2PTransactions]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[R2PTransactions] as 
select batchid, BalanceDate, plant, tag, System, movementtype, material, workcenter, valtype, StandardUnit, Quantity
  FROM [dbo].tagbalance
GO
/****** Object:  View [dbo].[S4Inventory]    Script Date: 4/7/2021 1:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[S4Inventory] as
select * from tagBalance
where movementtype = 'Inventory' and system <> 'S4';
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'001dec37-7913-4afc-a9d2-dd655274d7ee', 0, CAST(N'2021-02-12T22:13:00.400' AS DateTime), N'System', N'C:\local\Temp\tmpC88B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'004c0fdc-2e5e-48a2-8ea8-7f262b302d8d', 0, CAST(N'2021-01-28T14:10:02.537' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF627.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'01537c8f-27ba-4a92-bd78-4c7b582695e1', 0, CAST(N'2021-03-01T18:20:01.390' AS DateTime), N'System', N'C:\local\Temp\tmp336.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0153f245-0cf4-4c95-bf1b-71b5038ebbc0', 0, CAST(N'2021-02-25T01:54:28.003' AS DateTime), N'System', N'C:\local\Temp\tmpB293.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'015b94cd-8405-4836-8077-229c2a359aa6', 0, CAST(N'2021-02-26T23:14:00.343' AS DateTime), N'System', N'C:\local\Temp\tmp5825.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'017cdb8e-7115-4ebd-9e91-52d5f3fd2b35', 0, CAST(N'2021-01-06T19:45:02.663' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpAF47.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'01e83bb7-a82d-4ac1-adc3-88797fd0e8e1', 0, CAST(N'2021-02-25T01:54:24.187' AS DateTime), N'System', N'C:\local\Temp\tmpA3AE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0290e6b5-6d59-4558-81fa-b2fe9f6e7f0a', 0, CAST(N'2021-02-22T17:13:00.517' AS DateTime), N'System', N'C:\local\Temp\tmpC6A7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'02c80f73-7016-425e-94e1-bf847d7da16b', 0, CAST(N'2021-03-02T15:33:00.363' AS DateTime), N'System', N'C:\local\Temp\tmp66FB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'02c97106-ed71-426e-8fed-eed69691c5dc', 0, CAST(N'2021-02-25T01:26:19.833' AS DateTime), N'System', N'C:\local\Temp\tmpF07A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'02f1871b-d22e-4a19-84c2-1f62ed0e353c', 0, CAST(N'2021-03-02T16:17:00.427' AS DateTime), N'System', N'C:\local\Temp\tmpAEA7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'03640cdf-5958-4cf0-8e0e-e7e25ad73688', 0, CAST(N'2021-02-05T23:37:35.817' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'03c17410-5bbf-4d36-b97e-b4316960fe8f', 0, CAST(N'2021-02-25T01:28:20.010' AS DateTime), N'System', N'C:\local\Temp\tmpC4F7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'03e21aa0-a648-4d46-aa8a-3d4dbfa35a16', 0, CAST(N'2021-02-23T20:44:01.547' AS DateTime), N'System', N'C:\local\Temp\tmp3A96.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'04fd9598-834b-42cc-8ba3-d872eb93dc7e', 0, CAST(N'2021-02-04T18:05:14.463' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'050bb1aa-5995-46e0-b02b-73a8d5c64dce', 0, CAST(N'2021-02-04T17:56:12.760' AS DateTime), N'System', N'C:\local\Temp\tmpDB3C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'053f196f-ea87-4e00-a79b-499339e49cf9', 0, CAST(N'2021-02-25T01:30:28.483' AS DateTime), N'System', N'C:\local\Temp\tmpBA27.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'05d068ba-544e-4337-83a0-0b4a7a87309a', 0, CAST(N'2021-02-26T13:37:02.403' AS DateTime), N'System', N'C:\local\Temp\tmp1FA0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'05d35089-7197-4342-b8bc-c2a005b2e632', 0, CAST(N'2021-02-25T01:29:08.853' AS DateTime), N'System', N'C:\local\Temp\tmp83D2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'05e0f202-ae12-45cc-9b40-cdc6c21045c3', 0, CAST(N'2021-02-25T01:31:03.543' AS DateTime), N'System', N'C:\local\Temp\tmp42F9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'060b19a1-f87e-411d-b11b-05f20192a482', 0, CAST(N'2021-02-25T01:28:48.083' AS DateTime), N'System', N'C:\local\Temp\tmp3272.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'06538aa1-fd07-485e-b6ca-71e9762462b1', 0, CAST(N'2021-03-01T22:32:06.267' AS DateTime), N'System', N'C:\local\Temp\tmpCC82.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'06c5afb5-4cfb-4741-b41b-c6d56f9f89f2', 0, CAST(N'2021-01-07T12:15:00.200' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp4CDA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'06cc96ee-5e4e-49ab-b5d2-26256ccf6cb6', 0, CAST(N'2021-02-25T01:31:06.033' AS DateTime), N'System', N'C:\local\Temp\tmp4D6B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'06faa1d3-dc99-4ff9-a10b-1d5927626c77', 0, CAST(N'2021-02-25T01:27:43.847' AS DateTime), N'System', N'C:\local\Temp\tmp383D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0702dc59-879b-4bf5-b996-adccb0e4062f', 0, CAST(N'2021-03-23T20:45:01.827' AS DateTime), N'System', N'C:\local\Temp\tmp3975.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'074ad043-dbf7-416a-b9e4-4a94027ba62e', 0, CAST(N'2021-02-25T01:26:58.397' AS DateTime), N'System', N'C:\local\Temp\tmp86E3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'07bf2b32-1487-4207-962f-2570cf029dda', 0, CAST(N'2021-02-12T18:35:16.493' AS DateTime), N'System', N'C:\local\Temp\tmp72BF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'07e8bae3-a7a1-4d16-996c-732e3ca35c0c', 0, CAST(N'2021-01-21T16:57:05.243' AS DateTime), N'System', N'C:\local\Temp\tmp102B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'07f86495-afa5-4da8-8561-be0736963d1c', 0, CAST(N'2021-02-19T23:05:00.783' AS DateTime), N'System', N'C:\local\Temp\tmp3652.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0852bfe5-04a1-4eb2-915d-8d11299ae9b7', 0, CAST(N'2021-02-23T20:51:00.387' AS DateTime), N'System', N'C:\local\Temp\tmp9E64.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'08838eca-d9fb-4a32-b56a-0f14a8116f9e', 0, CAST(N'2021-02-25T01:32:22.790' AS DateTime), N'System', N'C:\local\Temp\tmp78A4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'089008dd-3c5d-4159-a5ec-7ef0777379dc', 0, CAST(N'2021-02-25T01:26:07.240' AS DateTime), N'System', N'C:\local\Temp\tmpBEFE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'08bda555-abd3-4427-b299-ddf568a32b0f', 0, CAST(N'2021-02-25T01:32:11.253' AS DateTime), N'System', N'C:\local\Temp\tmp4B14.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'08befdd1-6f5c-4f2b-bd0c-c6bf09e059db', 0, CAST(N'2021-02-12T21:25:14.423' AS DateTime), N'System', N'C:\local\Temp\tmpBA9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'08dbba21-9fe2-4372-bbbe-418b76411c36', 0, CAST(N'2021-02-25T01:30:41.337' AS DateTime), N'System', N'C:\local\Temp\tmpECBB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'091fae01-6eab-4516-a52b-39fb03f696f8', 0, CAST(N'2021-02-25T01:31:18.223' AS DateTime), N'System', N'C:\local\Temp\tmp7C83.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'09357620-8bd4-47e0-ac33-61f5937f8952', 0, CAST(N'2021-02-25T01:30:19.573' AS DateTime), N'System', N'C:\local\Temp\tmp9785.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0985a57e-6ef3-4963-909f-3bf7644e4ad7', 0, CAST(N'2021-01-13T14:29:00.270' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpDAFB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0991b594-5d38-4c31-bfb5-d884e472dbcf', 0, CAST(N'2021-03-30T02:07:17.627' AS DateTime), N'System', N'C:\local\Temp\tmpBA57.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'09a2ba25-2786-446a-a0d9-76d2494f378e', 0, CAST(N'2021-02-17T15:57:04.993' AS DateTime), N'System', N'C:\local\Temp\tmp52A9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'09bf95fe-fc1a-411c-a8fe-e708df55d105', 0, CAST(N'2021-02-25T01:28:16.073' AS DateTime), N'System', N'C:\local\Temp\tmpB60E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'09e30314-69bb-451e-9b37-6b32682b7aae', 0, CAST(N'2021-02-25T01:27:17.207' AS DateTime), N'System', N'C:\local\Temp\tmpCFDD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0a07cf59-f5f9-4b5e-b891-faa58629fd47', 0, CAST(N'2021-02-19T23:10:00.413' AS DateTime), N'System', N'C:\local\Temp\tmpC86F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0a458cdd-3f64-42a4-89f8-a50de5652af7', 0, CAST(N'2021-02-25T01:27:40.147' AS DateTime), N'System', N'C:\local\Temp\tmp29B3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0a51d9c0-4d78-4730-9735-014897eba6a7', 0, CAST(N'2021-02-25T01:32:54.960' AS DateTime), N'System', N'C:\local\Temp\tmpF626.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0a58c43a-ef2a-4b4a-ae33-68846cfcc02e', 0, CAST(N'2021-02-25T01:28:34.540' AS DateTime), N'System', N'C:\local\Temp\tmpFDE8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0aac7d12-200d-4085-8ef1-6b02307aefd6', 0, CAST(N'2021-01-13T12:39:00.320' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp261E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0afa0d93-a4cb-4dff-8d45-71d5bb527b1c', 0, CAST(N'2021-02-25T01:32:06.793' AS DateTime), N'System', N'C:\local\Temp\tmp3A09.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0b085932-72ca-461d-bb7c-dc35edfe4fe8', 0, CAST(N'2021-02-25T01:33:04.220' AS DateTime), N'System', N'C:\local\Temp\tmp1DA8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0b403c74-64a8-4e83-8a9c-1bc73e0c4071', 0, CAST(N'2021-02-25T01:28:32.627' AS DateTime), N'System', N'C:\local\Temp\tmpF655.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0bbaa16e-6622-4306-a422-6506bdc331e3', 0, CAST(N'2021-02-05T23:37:28.010' AS DateTime), N'System', N'C:\local\Temp\tmpA1FC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0bcc3978-da18-476e-96bc-856d4c038a64', 0, CAST(N'2021-01-19T20:50:04.660' AS DateTime), N'System', N'C:\local\Temp\tmpAB63.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0bd736b4-065b-42a7-8a62-cddc76f8c3bf', 0, CAST(N'2021-02-25T01:38:20.197' AS DateTime), N'System', N'C:\local\Temp\tmpF069.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0c6924a0-850b-4ac8-99de-d5fc92abaa1d', 0, CAST(N'2021-02-25T01:54:12.107' AS DateTime), N'System', N'C:\local\Temp\tmp74B8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0c8a2b96-8c04-4ae8-b3fc-54c13e7bc096', 0, CAST(N'2020-12-17T18:19:06.610' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp85ED.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0c961360-60c5-4193-9eb9-21e995aa8f72', 0, CAST(N'2021-01-07T15:48:00.863' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp4E62.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0cef441d-905e-4652-bd57-31e5921e5d8f', 0, CAST(N'2021-01-18T19:47:05.723' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF7F3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0d000c09-63ca-4d22-b023-741423202261', 0, CAST(N'2021-03-30T17:18:26.187' AS DateTime), N'System', N'C:\local\Temp\tmpD0DB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0d3bdabf-68d8-4fb8-86e4-eb8420a5b26f', 0, CAST(N'2021-02-22T17:23:00.457' AS DateTime), N'System', N'C:\local\Temp\tmpEE39.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0d9572fe-97d6-4a4e-aa67-476370d694c9', 0, CAST(N'2021-02-25T01:27:21.237' AS DateTime), N'System', N'C:\local\Temp\tmpDF91.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0da8901b-338b-4180-9e10-2d41f28b03b9', 0, CAST(N'2021-02-25T01:27:22.793' AS DateTime), N'System', N'C:\local\Temp\tmpE5EC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0db97169-33f4-4820-91db-24664d3bda8e', 0, CAST(N'2021-02-25T01:29:23.857' AS DateTime), N'System', N'C:\local\Temp\tmpBDDC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0de1bc51-0ae9-489a-adf1-dfa7eda03b36', 0, CAST(N'2021-01-28T21:25:01.400' AS DateTime), N'System', N'C:\local\Temp\tmpED52.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0deb0693-a3c4-4fce-b81b-e2fb274449fa', 0, CAST(N'2021-02-25T01:29:09.970' AS DateTime), N'System', N'C:\local\Temp\tmp87EA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0df57a18-6024-426c-beba-8384777ff303', 0, CAST(N'2021-02-25T01:31:36.173' AS DateTime), N'System', N'C:\local\Temp\tmpC273.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0e3b7866-0950-4a11-b178-b427c5e8bf62', 0, CAST(N'2021-02-25T01:29:33.480' AS DateTime), N'System', N'C:\local\Temp\tmpE3EB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0f1584a4-8ef9-4081-b768-fcf014a317a2', 0, CAST(N'2021-02-19T21:49:00.437' AS DateTime), N'System', N'C:\local\Temp\tmpA18C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0f9eb9fc-5a83-47a3-953a-fcaf77eb063d', 0, CAST(N'2021-02-09T19:45:08.103' AS DateTime), N'System', N'C:\local\Temp\tmp39F5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0fa964ac-bb78-4204-b14f-9c8436be93eb', 0, CAST(N'2021-02-25T01:27:13.307' AS DateTime), N'System', N'C:\local\Temp\tmpC132.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0ff07608-8fd1-4464-bc6f-62de2b35391f', 0, CAST(N'2021-01-19T03:15:07.963' AS DateTime), N'System', N'C:\local\Temp\tmpCAC9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'0ff91716-78b3-4a21-af53-b283ea4a4905', 0, CAST(N'2021-02-25T01:26:25.417' AS DateTime), N'System', N'C:\local\Temp\tmp65F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1051962f-d88a-4e81-93a6-12ea10c51f7c', 0, CAST(N'2021-02-06T17:44:07.280' AS DateTime), N'System', N'C:\local\Temp\tmp7E01.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1054199d-75ad-4bf4-9d6b-99e776480af2', 0, CAST(N'2021-02-05T20:55:08.343' AS DateTime), N'System', N'C:\local\Temp\tmpE5F9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'105a5cb0-b06b-46eb-b459-7e811441b607', 0, CAST(N'2021-03-23T03:34:24.640' AS DateTime), N'System', N'C:\local\Temp\tmpC238.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'10723bdf-560e-4a21-a140-4839e9f6b2a7', 0, CAST(N'2021-02-16T21:02:13.533' AS DateTime), N'System', N'C:\local\Temp\tmp65CF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'10746fbb-9368-4e02-a2ff-f7e4dc049a6e', 0, CAST(N'2021-02-25T01:32:25.547' AS DateTime), N'System', N'C:\local\Temp\tmp8364.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'109cb217-d325-40ff-bedc-48f74a024d74', 0, CAST(N'2021-02-25T01:27:06.247' AS DateTime), N'System', N'C:\local\Temp\tmpA5A2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'10b5e3a3-35a2-4f30-9240-6a46c5ab8ecf', 0, CAST(N'2021-02-12T21:25:15.247' AS DateTime), N'System', N'C:\local\Temp\tmpF63.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'10ee416d-f30c-49d2-9190-580dbe11b425', 0, CAST(N'2021-02-12T21:25:17.497' AS DateTime), N'System', N'C:\local\Temp\tmp19E7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1139bd0e-ec3b-4d76-813e-b9192d964bbc', 0, CAST(N'2021-01-13T12:43:00.653' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpCF90.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'113a162e-66ad-4d49-96f8-161b5f9821f7', 0, CAST(N'2021-02-05T23:37:19.933' AS DateTime), N'System', N'C:\local\Temp\tmp83C2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'116fa183-6a73-4803-9570-ef0b521b1181', 0, CAST(N'2021-03-02T16:04:00.297' AS DateTime), N'System', N'C:\local\Temp\tmpC7E5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'11b661da-9aaa-41ae-8f83-a094a3a535d2', 0, CAST(N'2021-02-25T01:28:55.027' AS DateTime), N'System', N'C:\local\Temp\tmp4D83.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'11be60f1-a1c8-47cc-9e1b-e39bdf7b84d7', 0, CAST(N'2021-02-25T01:30:30.957' AS DateTime), N'System', N'C:\local\Temp\tmpC44B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'11c72284-86ee-4e53-8cd1-97362b102ecd', 0, CAST(N'2020-12-17T17:30:53.720' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp629B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'11ec1061-fe78-4e40-9f1f-db205505b412', 0, CAST(N'2021-01-19T20:20:00.197' AS DateTime), N'System', N'C:\local\Temp\tmp3431.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'12167a0a-3d93-4cac-bc95-2522f7153014', 0, CAST(N'2020-12-17T17:41:07.817' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBFD3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'12213124-59ce-42e1-82d8-19b1d1543c08', 0, CAST(N'2021-02-25T01:27:31.443' AS DateTime), N'System', N'C:\local\Temp\tmp789.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'124cc826-5a39-4602-b5e4-b90932a9fb3f', 0, CAST(N'2021-03-02T18:16:00.333' AS DateTime), N'System', N'C:\local\Temp\tmp9F73.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'128115bb-0b80-49f6-b629-9edbeed3a4f0', 0, CAST(N'2021-02-25T01:28:09.730' AS DateTime), N'System', N'C:\local\Temp\tmp9CF1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'12fc3d94-5781-4b16-803c-300711e5a895', 0, CAST(N'2021-02-25T01:31:59.520' AS DateTime), N'System', N'C:\local\Temp\tmp1D06.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'13182337-41bc-497d-a555-30cc23981ac7', 0, CAST(N'2021-02-25T01:31:07.250' AS DateTime), N'System', N'C:\local\Temp\tmp5200.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'13ea2a94-5213-480f-be60-10201cce092c', 0, CAST(N'2021-01-21T17:18:04.110' AS DateTime), N'System', N'C:\local\Temp\tmp49DE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'142e63bf-8c6b-483a-ba99-ed77819dccc7', 0, CAST(N'2021-02-11T19:13:00.343' AS DateTime), N'System', N'C:\local\Temp\tmpA33C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'142ff1b0-5025-4b04-8418-434a2ed897dc', 0, CAST(N'2021-03-29T15:12:03.477' AS DateTime), N'System', N'C:\local\Temp\tmpDA23.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1457a1e7-8940-45c3-a249-25d7d931c833', 0, CAST(N'2021-02-25T01:27:47.310' AS DateTime), N'System', N'C:\local\Temp\tmp4590.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'14999771-6f2d-43eb-adc5-a1ee067343f2', 0, CAST(N'2021-02-19T23:33:00.593' AS DateTime), N'System', N'C:\local\Temp\tmpD6B3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'14a786eb-c08e-4618-b0e7-18377eeb069e', 0, CAST(N'2021-02-25T01:28:38.557' AS DateTime), N'System', N'C:\local\Temp\tmpD3E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'14e58686-a3d6-40f7-aef4-e67df94c8017', 0, CAST(N'2021-02-25T01:28:35.507' AS DateTime), N'System', N'C:\local\Temp\tmp1B2.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'15b59e20-95c2-45b3-932e-ab9b2b6c7789', 0, CAST(N'2021-02-05T23:15:00.677' AS DateTime), N'System', N'C:\local\Temp\tmp125A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'160fdc3d-8629-450e-a97c-05ece2c81fd3', 0, CAST(N'2021-02-23T20:21:00.633' AS DateTime), N'System', N'C:\local\Temp\tmp2797.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1694726d-d4ef-47e8-bd0c-ad287a6ba4d1', 0, CAST(N'2020-12-17T18:12:01.150' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpC58.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'16e19540-0849-4fee-8e19-80cb4ecc6ebd', 0, CAST(N'2021-02-25T01:27:28.260' AS DateTime), N'System', N'C:\local\Temp\tmpFB21.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'170f0377-20cc-466b-aa20-8ba3211a4860', 0, CAST(N'2021-02-25T01:30:20.710' AS DateTime), N'System', N'C:\local\Temp\tmp9C49.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1758344b-f7d0-4aff-9b34-adb5152df899', 0, CAST(N'2021-01-28T21:25:01.767' AS DateTime), N'System', N'C:\local\Temp\tmpEEBA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'178b6d19-f435-4733-aaa2-427f6755bb05', 0, CAST(N'2021-02-25T01:27:05.620' AS DateTime), N'System', N'C:\local\Temp\tmpA311.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'179766f7-e04a-4043-94d3-233a07ee76b8', 0, CAST(N'2021-02-25T01:26:12.310' AS DateTime), N'System', N'C:\local\Temp\tmpD30E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'17d46135-82a3-4978-adfd-56ae9405d122', 0, CAST(N'2021-03-08T16:11:00.620' AS DateTime), N'System', N'C:\local\Temp\tmpD138.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'17dd87c3-d7c0-48fd-9fad-b744a79b5109', 0, CAST(N'2020-12-17T17:27:57.930' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB4EA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'18146115-2111-461b-b633-d02c66312330', 0, CAST(N'2021-02-12T18:35:04.110' AS DateTime), N'System', N'C:\local\Temp\tmp423D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1863eaee-4616-40c8-a574-e7010e5c3e9a', 0, CAST(N'2021-02-25T01:27:03.050' AS DateTime), N'System', N'C:\local\Temp\tmp98DB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'18c0abb0-1893-491f-bca3-75e95b9a2f9e', 0, CAST(N'2021-02-25T01:26:27.973' AS DateTime), N'System', N'C:\local\Temp\tmp1076.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'18ddaef8-8491-492d-ae5a-8c78c9e6038e', 0, CAST(N'2021-01-08T11:32:00.667' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp4AC2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'19271948-aa62-407e-8377-d8fb339f0320', 0, CAST(N'2021-02-25T01:26:59.803' AS DateTime), N'System', N'C:\local\Temp\tmp8BF5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'196fc9f9-f87f-4d9c-b58d-9843dcf608c6', 0, CAST(N'2021-03-12T18:06:08.317' AS DateTime), N'System', N'C:\local\Temp\tmp9348.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1a175444-2b1b-4066-91cc-b9f606103ed7', 0, CAST(N'2021-02-05T20:55:14.317' AS DateTime), N'System', N'C:\local\Temp\tmp1D4F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1a6345ed-fd77-4dea-bfec-0b9e5553364d', 0, CAST(N'2021-02-04T18:05:09.710' AS DateTime), N'System', N'C:\local\Temp\tmpC92.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1ac7e2d0-81ee-4ff6-942c-34c146612b81', 0, CAST(N'2021-03-11T20:02:06.027' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp5C17.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1ae13795-3782-4909-81c1-fecfa3344eaa', 0, CAST(N'2021-02-25T01:54:23.767' AS DateTime), N'System', N'C:\local\Temp\tmpA274.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1c3ce4c4-5298-4b80-9c75-feddb4dac27b', 0, CAST(N'2021-02-19T15:21:00.300' AS DateTime), N'System', N'C:\local\Temp\tmp6DF7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1c49f949-bb65-4059-9f8f-349c4de0f30f', 0, CAST(N'2021-02-04T17:56:09.460' AS DateTime), N'System', N'C:\local\Temp\tmpCD89.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1c90c975-6709-47b4-a4f1-35ebcd3ec935', 0, CAST(N'2021-02-25T01:29:26.110' AS DateTime), N'System', N'C:\local\Temp\tmpC6D7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1cc82277-0bc5-4389-aa37-40dba39e1690', 0, CAST(N'2021-02-25T01:27:24.383' AS DateTime), N'System', N'C:\local\Temp\tmpEBF9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1d19d3a0-8e8c-4aec-aa5c-37519fddf5b3', 0, CAST(N'2021-02-25T01:30:29.777' AS DateTime), N'System', N'C:\local\Temp\tmpBF39.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1dcb5f93-eb76-4e51-8e74-c3b5514099ca', 0, CAST(N'2021-02-12T18:21:00.373' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1df019c4-a0ef-4386-8e87-28ea3012bad6', 0, CAST(N'2021-02-05T23:37:19.720' AS DateTime), N'System', N'C:\local\Temp\tmp82F6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1e2cb3a7-8b35-4566-9009-a2832b745a65', 0, CAST(N'2021-02-22T18:34:00.613' AS DateTime), N'System', N'C:\local\Temp\tmpEDC7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1ee24641-177d-4cf6-82f8-704ed686ab25', 0, CAST(N'2021-02-25T01:26:53.010' AS DateTime), N'System', N'C:\local\Temp\tmp71DC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1f4d594f-ba0e-4f57-bf90-2e76301f2a20', 0, CAST(N'2021-02-25T01:30:33.527' AS DateTime), N'System', N'C:\local\Temp\tmpCDF2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1fca98cc-78fd-47ee-a298-40489ec546cc', 0, CAST(N'2021-02-25T01:32:33.273' AS DateTime), N'System', N'C:\local\Temp\tmpA151.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1fe42bbf-6807-4def-9737-9861d19576f0', 0, CAST(N'2021-01-21T17:15:32.083' AS DateTime), N'System', N'C:\local\Temp\tmpE8CA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'1ffb4b08-1e32-4e2b-bca0-21e7cd5c1929', 0, CAST(N'2021-02-25T01:27:01.043' AS DateTime), N'System', N'C:\local\Temp\tmp9137.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'201402d6-bb76-4619-9510-8dee929f4fdf', 0, CAST(N'2021-02-22T17:01:00.703' AS DateTime), N'System', N'C:\local\Temp\tmpCB98.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'201ce783-f6e3-4cb9-a4f0-3e1db008b76b', 0, CAST(N'2021-02-25T01:28:51.030' AS DateTime), N'System', N'C:\local\Temp\tmp3E2D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'20224d80-0634-4c05-913d-18f5708a4424', 0, CAST(N'2021-02-25T01:30:17.040' AS DateTime), N'System', N'C:\local\Temp\tmp8DDE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'20608d8d-86dc-4fee-97ad-20fa981cf19a', 0, CAST(N'2021-02-02T21:41:00.967' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'207c3a60-0333-453c-b063-fa199c32322f', 0, CAST(N'2021-01-12T15:32:03.563' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'20873add-c09b-4ebf-ac39-eebfc2b93b50', 0, CAST(N'2021-02-05T20:55:14.007' AS DateTime), N'System', N'C:\local\Temp\tmp1966.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'20afee39-4a60-4fb5-964c-1d302d1fb3c8', 0, CAST(N'2021-02-25T01:26:10.963' AS DateTime), N'System', N'C:\local\Temp\tmpCDFB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'20d2d64b-7491-46ec-abb7-67ef02670358', 0, CAST(N'2021-02-25T01:28:56.060' AS DateTime), N'System', N'C:\local\Temp\tmp51BA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'214d0979-610c-4a9a-87ac-a7a237b8166d', 0, CAST(N'2021-03-20T16:14:00.987' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9C30.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'21692063-f6ec-4b70-bd9a-9ad452d016c1', 0, CAST(N'2021-02-02T22:16:00.773' AS DateTime), N'System', N'C:\local\Temp\tmp628E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'21694b2e-a9fc-4938-b9df-4619a8f11581', 0, CAST(N'2021-03-23T20:18:00.827' AS DateTime), N'System', N'C:\local\Temp\tmp81B2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'21beb11c-019a-430c-88ff-6c0ef1a97eb8', 0, CAST(N'2021-03-09T15:50:00.430' AS DateTime), N'System', N'C:\local\Temp\tmpDD0F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'22585172-0a39-4b0f-850e-91b2a4ca5734', 0, CAST(N'2021-03-29T15:17:01.030' AS DateTime), N'System', N'C:\local\Temp\tmp6DA6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'22ca053f-6f19-43eb-a536-772d24194484', 0, CAST(N'2021-01-12T13:38:23.443' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp24B9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2341689b-cd5f-41f0-9a16-f6ad7f8ddfc0', 0, CAST(N'2021-01-21T18:06:00.317' AS DateTime), N'System', N'C:\local\Temp\tmp3BF6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'23463ec0-e742-49f9-b822-3ec2c5364236', 0, CAST(N'2021-01-12T15:30:05.417' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'23592656-9fb5-48ac-af23-000de1e5750c', 0, CAST(N'2021-01-21T16:49:01.047' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'23e5b5f5-363c-4d73-93fc-016ee84628c4', 0, CAST(N'2021-02-25T01:29:39.913' AS DateTime), N'System', N'C:\local\Temp\tmpFD07.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'23eb8487-63b9-402b-be55-72b7c46dbc74', 0, CAST(N'2021-03-01T20:48:00.273' AS DateTime), N'System', N'C:\local\Temp\tmp802F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'23f8d3d9-55d1-4f43-8c45-c54a8490ea3e', 0, CAST(N'2020-12-17T17:24:08.600' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpFCF7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'24239f1d-b7c8-47c2-ad0b-624ce7303d70', 0, CAST(N'2021-02-25T01:32:18.450' AS DateTime), N'System', N'C:\local\Temp\tmp677A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'246a5b68-8bfe-479c-aaa3-c03a3e712bcb', 0, CAST(N'2021-02-25T01:30:25.860' AS DateTime), N'System', N'C:\local\Temp\tmpAFB5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'24db61b9-bf2b-482d-af52-b4ff16739bc9', 0, CAST(N'2021-02-19T23:07:00.580' AS DateTime), N'System', N'C:\local\Temp\tmpAF4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'24df7976-54f2-4bc0-a5f8-d01a9a77fc6f', 0, CAST(N'2021-01-12T15:24:00.543' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'253fb71d-c6ae-4b4d-87e6-6913320be77d', 0, CAST(N'2021-03-02T20:51:01.380' AS DateTime), N'System', N'C:\local\Temp\tmp8536.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2575bdbf-8ead-4ca8-ae15-5d66d3da5afa', 0, CAST(N'2021-02-25T01:28:01.937' AS DateTime), N'System', N'C:\local\Temp\tmp7EC2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2580ef9c-f9dd-4fd9-835e-8d7f64c8dc40', 0, CAST(N'2021-01-06T19:38:11.533' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp5CF0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'258a63c0-80b1-4c7e-8e68-e483304e94a1', 0, CAST(N'2021-01-17T12:01:00.460' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'25eed8fa-4bfe-4d07-8c0e-12f4774ffb5a', 0, CAST(N'2021-02-25T01:31:12.470' AS DateTime), N'System', N'C:\local\Temp\tmp6619.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'25fe2f6a-ba50-47cb-9171-c71dd30137c8', 0, CAST(N'2021-02-25T01:27:08.947' AS DateTime), N'System', N'C:\local\Temp\tmpAD75.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'269c3086-558e-4fae-a97b-2a6efe391da6', 0, CAST(N'2021-02-25T01:26:16.170' AS DateTime), N'System', N'C:\local\Temp\tmpE239.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'269fa4e2-7d67-498e-a530-6c473e30777a', 0, CAST(N'2021-02-22T16:45:00.317' AS DateTime), N'System', N'C:\local\Temp\tmp247A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'26ab63e2-9a4a-4f82-a05a-ee12b615f48e', 0, CAST(N'2021-03-05T22:14:01.327' AS DateTime), N'System', N'C:\local\Temp\tmp51D2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'26c6810e-fc74-49d4-9f9a-54ed47977ce7', 0, CAST(N'2021-01-13T12:57:00.980' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA102.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'26fd8197-8fe5-49f3-8542-e7945d828ed4', 0, CAST(N'2021-02-25T01:27:02.347' AS DateTime), N'System', N'C:\local\Temp\tmp964A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'27646d5e-f5c2-465a-855f-c232becc5bf4', 0, CAST(N'2021-01-21T17:46:00.233' AS DateTime), N'System', N'C:\local\Temp\tmpEC82.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'27a07790-51b9-46dd-b7f4-db76f9527b1a', 0, CAST(N'2021-02-25T01:27:15.570' AS DateTime), N'System', N'C:\local\Temp\tmpC9C0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'27abe883-2f4f-4c54-bf93-8bea78be0baf', 0, CAST(N'2021-02-23T20:53:00.823' AS DateTime), N'System', N'C:\local\Temp\tmp74FB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'28675d18-7afb-4c9c-a68c-2635cbfdf19d', 0, CAST(N'2021-02-25T01:27:36.237' AS DateTime), N'System', N'C:\local\Temp\tmp1A3C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'28709c1c-13b0-4273-baf9-47fdfd06975b', 0, CAST(N'2020-12-17T17:27:54.433' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA759.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2914ea95-71cb-4503-a575-82ee5f5865f7', 0, CAST(N'2021-03-30T22:29:01.180' AS DateTime), N'System', N'C:\local\Temp\tmp262B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2929ab96-24bb-4a91-90d7-a7542e4ae644', 0, CAST(N'2021-02-05T20:55:16.100' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2937875c-33b2-47fe-9bac-177c32be19db', 0, CAST(N'2021-02-12T18:35:11.933' AS DateTime), N'System', N'C:\local\Temp\tmp5F10.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'298a1d89-61da-4e88-ac42-403586720159', 0, CAST(N'2021-01-28T21:42:00.173' AS DateTime), N'System', N'C:\local\Temp\tmp795D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'29a1bc37-d42e-4009-9cf4-e416e2f7b309', 0, CAST(N'2021-02-25T01:29:57.547' AS DateTime), N'System', N'C:\local\Temp\tmp41C0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'29a26007-8dbb-4cea-a0a9-ddc9bff7d14d', 0, CAST(N'2021-02-23T23:22:00.673' AS DateTime), N'System', N'C:\local\Temp\tmpDAD5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'29a74885-78d8-4750-bcf9-9abd5dba9f66', 0, CAST(N'2021-02-25T01:31:19.563' AS DateTime), N'System', N'C:\local\Temp\tmp81C4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'29e3469d-67f1-416e-8bea-eb6c71b0b8a1', 0, CAST(N'2021-02-25T01:26:31.707' AS DateTime), N'System', N'C:\local\Temp\tmp1EB6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2a2244f9-dd39-4732-b6e6-a5fae87d0710', 0, CAST(N'2021-02-25T01:31:13.827' AS DateTime), N'System', N'C:\local\Temp\tmp6B69.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2a2331ab-0593-4092-9c03-415c95ada60a', 0, CAST(N'2021-03-02T05:25:00.370' AS DateTime), N'System', N'C:\local\Temp\tmpCC9E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2a4d3ea2-e7de-40f9-b442-68aed15b4fd2', 0, CAST(N'2021-02-26T17:47:01.610' AS DateTime), N'System', N'C:\local\Temp\tmpFCEE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2a5f173c-0e0f-48a6-ad4a-1971e77cdf98', 0, CAST(N'2021-02-25T01:29:42.377' AS DateTime), N'System', N'C:\local\Temp\tmp5D3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2a676f3d-9f8a-45c0-b0e0-a4bf4e85a16e', 0, CAST(N'2020-12-17T17:48:03.377' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpFA9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2ad094e0-e30f-4c4e-b720-e36f39351cb0', 0, CAST(N'2021-02-24T18:53:00.487' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2af4198d-ad90-4f8d-914f-dbcd06d9b5aa', 0, CAST(N'2021-02-19T06:04:00.877' AS DateTime), N'System', N'C:\local\Temp\tmp83CC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2afcc3b3-ce1c-4271-8857-18cedec3de7e', 0, CAST(N'2021-02-06T17:44:12.290' AS DateTime), N'System', N'C:\local\Temp\tmp928B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2b4758dc-9a41-46c7-ba8e-1fb4d4bff2fe', 0, CAST(N'2021-02-25T01:30:08.737' AS DateTime), N'System', N'C:\local\Temp\tmp6D5F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2bc779d0-0829-41b6-bd48-b6a9ea9fc646', 0, CAST(N'2021-02-12T18:35:18.777' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2bc8cd76-1d17-44bc-9e3a-a1f2fc669430', 0, CAST(N'2021-02-25T01:26:23.840' AS DateTime), N'System', N'C:\local\Temp\tmp22.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2be096b1-4bb7-4e22-b856-be54d9f71014', 0, CAST(N'2021-02-25T01:27:57.340' AS DateTime), N'System', N'C:\local\Temp\tmp6CAC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2c3fb24f-b4c7-470d-8d8d-3dbb07917079', 0, CAST(N'2020-12-17T17:17:40.280' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp14D2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2c4d0831-8a38-4f46-9613-6c944c34afc2', 0, CAST(N'2021-02-08T21:10:02.433' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2ca8237e-539f-481a-8368-03f9ad1b73d8', 0, CAST(N'2021-03-03T21:30:00.997' AS DateTime), N'System', N'C:\local\Temp\tmp7E96.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2cec6f27-45d9-4b2d-bb33-fab683e73486', 0, CAST(N'2021-03-02T15:41:00.453' AS DateTime), N'System', N'C:\local\Temp\tmpB9BE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2cf8f3c1-b6ba-4eb6-bf65-1dd6a1cb2e87', 0, CAST(N'2021-02-25T01:27:49.753' AS DateTime), N'System', N'C:\local\Temp\tmp4F18.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2d02318e-418d-4a97-9d37-7dbcf85c0c79', 0, CAST(N'2021-02-24T17:44:01.720' AS DateTime), N'System', N'C:\local\Temp\tmpB2D4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2d1eb624-e6ba-4b21-984b-27d116fee7b3', 0, CAST(N'2021-02-25T01:26:06.740' AS DateTime), N'System', N'C:\local\Temp\tmpBDC5.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2d298f1b-4117-43dc-ad6c-74d48fe8c5f5', 0, CAST(N'2021-02-12T18:35:13.507' AS DateTime), N'System', N'C:\local\Temp\tmp66A4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2d62c3ab-a713-4ba8-9237-6f914492e41a', 0, CAST(N'2021-02-25T01:27:26.697' AS DateTime), N'System', N'C:\local\Temp\tmpF524.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2d6dfc89-d04e-4a4a-828c-09592bb250e4', 0, CAST(N'2021-03-30T01:58:05.887' AS DateTime), N'System', N'C:\local\Temp\tmp3B03.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2d6f430d-0df3-4ac4-93fe-c34aa894a7a7', 0, CAST(N'2021-02-12T18:35:16.273' AS DateTime), N'System', N'C:\local\Temp\tmp6D30.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2db1e7ba-dba4-4c2c-a0df-a008d6e4b352', 0, CAST(N'2020-12-17T17:41:03.600' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA709.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2db4efd9-21bd-43de-b21b-e7ca0cedb298', 0, CAST(N'2021-02-02T22:01:00.183' AS DateTime), N'System', N'C:\local\Temp\tmpA4E3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2e0683d5-2539-4bed-8b4f-b91b7ccd9d0c', 0, CAST(N'2021-03-08T16:11:11.643' AS DateTime), N'System', N'C:\local\Temp\tmpFCBE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2e7667cb-e7f7-4c46-868b-6a038a5bf535', 0, CAST(N'2021-02-25T01:29:16.330' AS DateTime), N'System', N'C:\local\Temp\tmpA0C7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2fe37a27-ac6e-4103-9c23-9c08af02ea2e', 0, CAST(N'2021-01-12T15:29:56.747' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'2fe8c9f2-b523-4605-a66b-d98be9d7f8bf', 0, CAST(N'2021-02-25T16:14:00.427' AS DateTime), N'System', N'C:\local\Temp\tmp93E6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3001a5bf-97fb-45b7-be08-e0c6c8a0fb2f', 0, CAST(N'2021-01-28T21:30:00.123' AS DateTime), N'System', N'C:\local\Temp\tmp7CE7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'300c8fa6-4514-4af2-b0a9-903180569c4a', 0, CAST(N'2021-03-23T00:18:13.217' AS DateTime), N'System', N'C:\local\Temp\tmp28CB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'30290946-46c4-4805-bfce-9f6f4e24c52a', 0, CAST(N'2021-02-25T01:31:56.623' AS DateTime), N'System', N'C:\local\Temp\tmp11AA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'30c0df0e-de47-4b9b-9c08-09232ec91e98', 0, CAST(N'2020-12-17T17:26:59.570' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpC2ED.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'30c46aee-0da8-4ee2-9933-4218ba6e84a1', 0, CAST(N'2021-02-25T01:31:46.190' AS DateTime), N'System', N'C:\local\Temp\tmpE9A9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'30c6c1c0-4ba8-4937-918b-eb9af5e5692c', 0, CAST(N'2021-02-25T01:30:59.473' AS DateTime), N'System', N'C:\local\Temp\tmp3327.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'30cb9346-8420-4c46-9629-bcdcc7a778d6', 0, CAST(N'2021-02-25T01:26:17.960' AS DateTime), N'System', N'C:\local\Temp\tmpE942.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3100e5e0-4dfd-41df-a249-c0bceb371492', 0, CAST(N'2021-01-19T02:26:07.550' AS DateTime), N'System', N'C:\local\Temp\tmpEE59.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'31a4b1ec-d817-4a1e-aa5d-f49d6a97cb1f', 0, CAST(N'2021-02-12T21:25:13.210' AS DateTime), N'System', N'C:\local\Temp\tmpEA54.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'31f46436-6113-45e5-a50f-43d2500836a0', 0, CAST(N'2021-02-25T01:29:13.193' AS DateTime), N'System', N'C:\local\Temp\tmp948F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'321bd4c0-a718-4181-b7e5-72edaf0ac8b3', 0, CAST(N'2021-02-25T01:32:02.403' AS DateTime), N'System', N'C:\local\Temp\tmp28E0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3255ff73-2291-4b6a-9f62-7e1440925001', 0, CAST(N'2021-01-07T11:31:02.107' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp46F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'326da9b6-18a6-4732-8b03-5b21857fdc0a', 0, CAST(N'2021-03-30T22:27:07.747' AS DateTime), N'System', N'C:\local\Temp\tmp5513.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3278597d-b8f7-4dc3-87c3-20ae6e8b020d', 0, CAST(N'2020-12-17T03:11:48.700' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBAF2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3296d20c-a442-4bab-b512-a835f0f78173', 0, CAST(N'2021-02-05T23:15:04.267' AS DateTime), N'System', N'C:\local\Temp\tmp2268.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'32a63cae-3cda-4b21-8d3c-74d3ec45b690', 0, CAST(N'2021-01-21T09:49:41.660' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'32aa5da4-250d-4527-a0d5-0e87a1bd2ee9', 0, CAST(N'2021-02-16T21:02:09.773' AS DateTime), N'System', N'C:\local\Temp\tmp56D5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'32d8a58b-0a93-441c-ad5e-e9302a2ead25', 0, CAST(N'2021-02-22T17:23:01.027' AS DateTime), N'System', N'C:\local\Temp\tmpF08C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'32d9bdb0-33ee-4f15-892a-24ae1753e07f', 0, CAST(N'2021-02-25T01:27:41.000' AS DateTime), N'System', N'C:\local\Temp\tmp2D1F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'33134346-2693-4dfb-b1f2-bc090108eec9', 0, CAST(N'2021-03-02T05:03:06.903' AS DateTime), N'System', N'C:\local\Temp\tmpC17F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'337c1c73-901d-4416-b222-f3542310b0c9', 0, CAST(N'2021-01-21T20:43:00.377' AS DateTime), N'System', N'C:\local\Temp\tmpF8BE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'338045ef-91e0-4f99-9173-95e3a9f67c19', 0, CAST(N'2021-02-25T01:38:32.840' AS DateTime), N'System', N'C:\local\Temp\tmp2131.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'339b66ad-8ac8-4334-812d-00a423f93a92', 0, CAST(N'2020-12-17T16:35:03.863' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp1CF8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'33b9bfdb-ff20-4f82-88d6-e5b92cfb3bc4', 0, CAST(N'2021-02-10T07:36:00.653' AS DateTime), N'System', N'C:\local\Temp\tmp2B2A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'33ca00c1-5446-464b-92e0-c3cb274706e3', 0, CAST(N'2021-02-01T21:12:41.313' AS DateTime), N'System', N'C:\local\Temp\tmpF3BD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'34117b51-f675-4944-9465-96a00fa68cfc', 0, CAST(N'2021-02-25T01:26:37.827' AS DateTime), N'System', N'C:\local\Temp\tmp36AE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'345eae13-963b-414c-9c09-4b17777b3720', 0, CAST(N'2021-02-26T23:48:01.527' AS DateTime), N'System', N'C:\local\Temp\tmp789C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'34a8ec39-b45c-44e4-ac7b-ab30b25b2def', 0, CAST(N'2021-01-11T14:50:00.290' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp659F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'34ba65ca-2078-4da7-9217-d3bdfc5cac4c', 0, CAST(N'2021-02-25T01:54:35.817' AS DateTime), N'System', N'C:\local\Temp\tmpD11A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'34db76a5-2612-4862-851c-c7afa81e5315', 0, CAST(N'2021-01-21T18:11:00.297' AS DateTime), N'System', N'C:\local\Temp\tmpCFD7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'34f9ab11-c32f-485b-a6c4-3ad314e3ee03', 0, CAST(N'2021-02-25T01:26:38.397' AS DateTime), N'System', N'C:\local\Temp\tmp38E1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3526167f-6e42-4051-876a-f6737793978c', 0, CAST(N'2021-02-16T21:02:01.120' AS DateTime), N'System', N'C:\local\Temp\tmp3522.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'352aed6e-439f-434f-a974-5a1a2d1639f2', 0, CAST(N'2021-02-25T01:29:55.253' AS DateTime), N'System', N'C:\local\Temp\tmp3962.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3555f7af-61cc-4f5c-8386-1d20f12fc03c', 0, CAST(N'2021-02-25T01:28:58.170' AS DateTime), N'System', N'C:\local\Temp\tmp59E9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'357efcc1-bd02-4e2e-b8ed-0da8fe563968', 0, CAST(N'2021-02-24T18:30:01.987' AS DateTime), N'System', N'C:\local\Temp\tmpCF73.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3599ccbc-dead-4aef-a4c0-347503cc1d0c', 0, CAST(N'2021-03-22T23:46:11.430' AS DateTime), N'System', N'C:\local\Temp\tmpD533.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'35a5ada6-fc63-40e1-ab41-57bda736cc42', 0, CAST(N'2021-01-28T21:25:03.153' AS DateTime), N'System', N'C:\local\Temp\tmpF44C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'35b2acb5-09dc-44fa-b54f-73c40b2307df', 0, CAST(N'2021-02-19T22:00:00.620' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'35ef2485-27b2-4712-b19a-ef42ed34e571', 0, CAST(N'2021-02-23T20:44:00.450' AS DateTime), N'System', N'C:\local\Temp\tmp35E1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3636856c-efc5-4291-81b4-16b788480d7b', 0, CAST(N'2021-02-25T01:27:52.983' AS DateTime), N'System', N'C:\local\Temp\tmp5BAF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3656f1ab-9ac0-4a57-bb5f-25c9f04a53f7', 0, CAST(N'2021-02-02T22:16:01.150' AS DateTime), N'System', N'C:\local\Temp\tmp63F6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3659f1f4-6f7b-4403-aaf4-87f68daf5ce0', 0, CAST(N'2021-02-25T01:26:07.767' AS DateTime), N'System', N'C:\local\Temp\tmpC180.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'368a735e-c0c4-45c0-abe2-5597d4314f16', 0, CAST(N'2021-02-11T16:16:00.747' AS DateTime), N'System', N'C:\local\Temp\tmp97DF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3691bef1-50ae-48bd-b013-11523d665017', 0, CAST(N'2021-02-24T17:44:04.647' AS DateTime), N'System', N'C:\local\Temp\tmpBFB7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3699f210-7c99-4acd-81c7-2511054a54e3', 0, CAST(N'2021-02-25T01:28:46.017' AS DateTime), N'System', N'C:\local\Temp\tmp2A90.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'369c8531-b7eb-43de-883a-557bfc661aec', 0, CAST(N'2021-02-16T21:02:11.723' AS DateTime), N'System', N'C:\local\Temp\tmp5C17.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'36b56815-42c7-492d-bc6f-866d52e7bf8a', 0, CAST(N'2021-02-25T01:28:24.777' AS DateTime), N'System', N'C:\local\Temp\tmpD7A9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'36dc7b8e-6f90-4c48-b2a7-68ee619c6ddd', 0, CAST(N'2021-02-11T20:45:00.497' AS DateTime), N'System', N'C:\local\Temp\tmpDD60.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'370e460a-52b7-4de0-8d9b-463cdb4345ff', 0, CAST(N'2021-02-25T01:27:48.113' AS DateTime), N'System', N'C:\local\Temp\tmp48CD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3732cc72-c00b-4dfb-99b8-906615c43115', 0, CAST(N'2021-01-07T12:08:00.190' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE447.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'37658815-814f-4562-b3c0-631aa830722a', 0, CAST(N'2021-02-25T01:28:39.503' AS DateTime), N'System', N'C:\local\Temp\tmp1146.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'37796fd7-ff0f-4b99-8c25-da7b1b6cb996', 0, CAST(N'2021-02-25T01:27:09.667' AS DateTime), N'System', N'C:\local\Temp\tmpB2E5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3793c132-4953-49a3-a9df-c185683e455d', 0, CAST(N'2021-01-12T15:31:06.640' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'37abf876-9cb2-459c-8dc9-58441347fbae', 0, CAST(N'2021-03-03T23:24:00.427' AS DateTime), N'System', N'C:\local\Temp\tmpDBA9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'380ed226-0b5b-4f22-b79a-0a47c6405b62', 0, CAST(N'2021-01-06T16:53:02.527' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB233.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'38560140-1642-4924-a8c7-83671db32084', 0, CAST(N'2021-01-14T12:54:00.513' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp33CF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3928fcdd-839e-4848-933a-56fd3ff349c8', 0, CAST(N'2021-02-23T23:25:00.357' AS DateTime), N'System', N'C:\local\Temp\tmp99D8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3964af5f-1c02-4c9e-8905-f05c7125d8b9', 0, CAST(N'2021-01-07T12:01:00.223' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7BA6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'399c6755-4583-4864-a7f9-8c7a1f5b44d3', 0, CAST(N'2021-02-25T01:32:05.353' AS DateTime), N'System', N'C:\local\Temp\tmp345B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3a2647de-6178-4797-a34a-005f193d0b76', 0, CAST(N'2021-02-25T01:29:21.667' AS DateTime), N'System', N'C:\local\Temp\tmpB5BC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3a474300-35f7-48a2-8569-b021571f3d3f', 0, CAST(N'2021-02-18T20:52:04.850' AS DateTime), N'System', N'C:\local\Temp\tmp2D56.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3a4b8628-fdda-4edc-8d26-a6f419e5ee3f', 0, CAST(N'2021-02-25T01:28:25.807' AS DateTime), N'System', N'C:\local\Temp\tmpDB44.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3a7c678d-1f0b-43a9-b4ad-bb2f9dd3ea51', 0, CAST(N'2021-02-25T01:27:25.860' AS DateTime), N'System', N'C:\local\Temp\tmpF225.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3a84a146-3f35-43bd-852b-e55f7f7753fa', 0, CAST(N'2021-02-25T01:30:43.977' AS DateTime), N'System', N'C:\local\Temp\tmpF6CF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3acb8ea2-4597-4efb-af50-2d479febe5da', 0, CAST(N'2021-02-24T16:29:00.770' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3b00db47-b63a-4f11-aa6c-5c5e82a5612c', 0, CAST(N'2021-02-12T21:25:19.677' AS DateTime), N'System', N'C:\local\Temp\tmp1C5A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3b5eac15-06d4-4688-a4b6-9b908939ac6d', 0, CAST(N'2021-02-24T00:18:00.530' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3bc1c83c-e900-467e-8540-470ac5c05be4', 0, CAST(N'2021-03-30T02:07:01.023' AS DateTime), N'System', N'C:\local\Temp\tmp7865.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3bc1e4df-747b-4cf5-a630-ca21208834bb', 0, CAST(N'2021-02-25T01:27:32.240' AS DateTime), N'System', N'C:\local\Temp\tmpA97.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3c8c5271-4ee2-48ad-bbb0-76500e217c59', 0, CAST(N'2021-02-05T20:55:11.327' AS DateTime), N'System', N'C:\local\Temp\tmp1153.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3cd63f87-2c9e-499b-92c4-c8d67e1b4d14', 0, CAST(N'2021-02-25T01:26:41.767' AS DateTime), N'System', N'C:\local\Temp\tmp45C8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3ce15e59-091c-4dc1-85d5-5c1461f274ab', 0, CAST(N'2021-02-04T18:05:08.693' AS DateTime), N'System', N'C:\local\Temp\tmp85A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3cf243b4-0341-4bed-8697-1ef94bb92803', 0, CAST(N'2021-03-08T15:46:00.913' AS DateTime), N'System', N'C:\local\Temp\tmpEE04.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3d097ab9-f557-4877-b89b-84e9c64a6f1a', 0, CAST(N'2021-02-25T01:26:15.297' AS DateTime), N'System', N'C:\local\Temp\tmpDEDC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3d0efb3f-92e7-4852-94cd-f65657d00414', 0, CAST(N'2021-02-04T18:05:08.220' AS DateTime), N'System', N'C:\local\Temp\tmp711.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3d189f22-d3c5-4559-9bf3-0b06050e2997', 0, CAST(N'2021-03-15T11:48:37.310' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp8D7B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3d3ac536-356f-4b74-848d-e6b7966a1066', 0, CAST(N'2021-02-25T01:27:14.067' AS DateTime), N'System', N'C:\local\Temp\tmpC3C3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3d718fc0-c1d3-467f-bb36-9c28a867ca8e', 0, CAST(N'2021-01-06T19:38:13.000' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp6B78.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3db98ffc-e573-47f2-9a28-5ef7ef41b7be', 0, CAST(N'2021-02-25T01:32:24.157' AS DateTime), N'System', N'C:\local\Temp\tmp7E14.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3dcb4cb0-4430-4b96-b199-3c0b14af3d4a', 0, CAST(N'2021-02-17T15:59:00.240' AS DateTime), N'System', N'C:\local\Temp\tmp2527.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3e15971b-d93c-43a6-8918-50ffb0053efb', 0, CAST(N'2021-02-25T01:28:08.797' AS DateTime), N'System', N'C:\local\Temp\tmp9937.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3e7afd5c-b76e-4420-8fe3-c417edf94c54', 0, CAST(N'2021-03-12T01:15:52.553' AS DateTime), N'System', N'C:\local\Temp\tmpB45F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3ea688af-1bb7-4411-a7cd-ea63b81df034', 0, CAST(N'2021-02-25T01:29:31.330' AS DateTime), N'System', N'C:\local\Temp\tmpDBAC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3ec13ce5-6e14-41f9-adff-6e205a266b14', 0, CAST(N'2021-02-05T20:55:13.023' AS DateTime), N'System', N'C:\local\Temp\tmp17B0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3ef978ef-d560-4d10-a693-4982bb391d57', 0, CAST(N'2021-02-10T07:36:01.033' AS DateTime), N'System', N'C:\local\Temp\tmp2CA2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3effe283-f152-4735-b348-6cc93a8ef43e', 0, CAST(N'2021-02-08T23:32:00.477' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3f042205-4e76-4cae-9b92-c28e4348f197', 0, CAST(N'2021-01-23T14:42:45.857' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBA6A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3f430245-8abd-4e98-92e3-7f4f179f9959', 0, CAST(N'2021-02-25T01:27:18.053' AS DateTime), N'System', N'C:\local\Temp\tmpD349.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'3f9f8767-40e6-4666-9784-2007479d10e9', 0, CAST(N'2021-02-06T17:44:00.193' AS DateTime), N'System', N'C:\local\Temp\tmp62F2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'404935ef-094d-4a0d-8afe-76e1decdb565', 0, CAST(N'2021-01-06T19:45:02.100' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA592.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4061de2a-1871-4c5c-a11a-1673e62c0888', 0, CAST(N'2021-01-07T12:10:00.163' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB8F8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4079dd64-e9b3-40a8-851b-547025a94450', 0, CAST(N'2021-01-15T10:24:00.390' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp379D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'40ad7847-d738-4163-ba14-e7d343dfd8bb', 0, CAST(N'2021-03-23T00:06:01.013' AS DateTime), N'System', N'C:\local\Temp\tmpFBF6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'40b7b59f-7c80-4d90-8ed3-0f7ff4e21dd6', 0, CAST(N'2021-02-12T21:25:22.463' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'40be6500-56ee-4573-86c3-20fea8d84404', 0, CAST(N'2021-02-05T23:15:18.687' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'410dab36-3d6a-4b1f-9c32-49afedf21f32', 0, CAST(N'2020-12-17T03:11:34.103' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA610.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'413bb97b-ec4e-4ecd-9e23-1922df837b50', 0, CAST(N'2021-02-02T21:43:00.253' AS DateTime), N'System', N'C:\local\Temp\tmp2A0F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4141a551-6c9d-4036-971f-918e41d26419', 0, CAST(N'2021-02-25T01:31:41.667' AS DateTime), N'System', N'C:\local\Temp\tmpD802.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'418b4912-01cb-4b55-838a-5a48c5993319', 0, CAST(N'2021-02-25T01:28:49.107' AS DateTime), N'System', N'C:\local\Temp\tmp368A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'418c8a60-4a1b-4a99-a2d4-e1187508d050', 0, CAST(N'2021-02-25T01:30:04.180' AS DateTime), N'System', N'C:\local\Temp\tmp5C15.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'41d478e6-5e54-4e1b-9ee0-0316c4d21730', 0, CAST(N'2020-12-17T17:27:58.797' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB865.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4220e014-0958-419a-90c0-80747657e2a1', 0, CAST(N'2021-02-25T01:31:50.663' AS DateTime), N'System', N'C:\local\Temp\tmpFB6F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'42338958-87bf-4ed5-844d-37fd9de88bbb', 0, CAST(N'2021-02-25T01:30:32.263' AS DateTime), N'System', N'C:\local\Temp\tmpC8EF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'424b6eea-4e1f-4cec-b23f-772f43b6a0e7', 0, CAST(N'2020-12-17T17:27:55.287' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpAAB5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'428174ad-1a30-4223-a3f5-ac35cfa5951d', 0, CAST(N'2021-01-06T16:09:04.120' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7399.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'42b2667b-3158-42f9-8289-c70d81e15375', 0, CAST(N'2021-02-25T01:32:03.947' AS DateTime), N'System', N'C:\local\Temp\tmp2E8E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'436b8ea9-7fba-40a6-abcb-76a1b7400891', 0, CAST(N'2021-02-25T01:26:40.583' AS DateTime), N'System', N'C:\local\Temp\tmp4190.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'43720dcf-a1a8-4857-a3db-605c997df734', 0, CAST(N'2021-02-04T18:05:11.457' AS DateTime), N'System', N'C:\local\Temp\tmp108B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'43749392-aeae-47a2-8c73-3eab31d7bb25', 0, CAST(N'2020-12-17T18:19:15.027' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9C55.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'43849035-cab4-45d5-b7e3-c032802af634', 0, CAST(N'2021-02-12T18:35:10.873' AS DateTime), N'System', N'C:\local\Temp\tmp43B6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'43b4d807-52a8-4f44-9891-ecd453b214bf', 0, CAST(N'2021-02-25T01:26:26.970' AS DateTime), N'System', N'C:\local\Temp\tmpC6D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'43cf00a9-efd1-4213-8b58-d63aeff44a89', 0, CAST(N'2021-02-25T01:26:18.427' AS DateTime), N'System', N'C:\local\Temp\tmpEB08.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'441d0068-a110-4e63-a42d-40c61748e552', 0, CAST(N'2021-02-23T20:29:00.607' AS DateTime), N'System', N'C:\local\Temp\tmp7A8A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'44272839-3183-4c87-8279-b3004e80d0eb', 0, CAST(N'2021-02-25T01:30:06.433' AS DateTime), N'System', N'C:\local\Temp\tmp64B2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'444f2930-c06f-49d4-b838-a82a0e8af9cf', 0, CAST(N'2021-02-25T01:27:44.673' AS DateTime), N'System', N'C:\local\Temp\tmp3B2C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'449a6c68-e87f-40cb-aebb-47bac45f0bad', 0, CAST(N'2021-03-09T15:26:00.843' AS DateTime), N'System', N'C:\local\Temp\tmpE45A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'44afbc36-a366-4f40-ad99-4ff3dcc9887b', 0, CAST(N'2021-01-28T21:26:00.910' AS DateTime), N'System', N'C:\local\Temp\tmpD363.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'44b135cc-b291-4455-9368-bc6aa5ca3fa0', 0, CAST(N'2020-12-17T17:27:47.560' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7EAD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'44e2fdd3-125a-4391-91ad-12a26c0f64cc', 0, CAST(N'2021-02-06T17:44:09.333' AS DateTime), N'System', N'C:\local\Temp\tmp8622.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'44ec5966-6527-47c0-9c8d-e8b0ea88e9ee', 0, CAST(N'2021-03-08T17:53:01.407' AS DateTime), N'System', N'C:\local\Temp\tmp31D8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'44f168f6-dca1-4e9f-95e3-fcd8a3fdf999', 0, CAST(N'2021-02-25T01:26:51.817' AS DateTime), N'System', N'C:\local\Temp\tmp6D36.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'44f5583f-b721-4070-bf37-670986bd58d7', 0, CAST(N'2021-02-25T01:29:44.570' AS DateTime), N'System', N'C:\local\Temp\tmpF0D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'452d27ab-df58-486e-ae0c-1afdaae13168', 0, CAST(N'2021-02-04T17:56:15.930' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4545ab79-0564-4cca-8fb9-1776dde5aa51', 0, CAST(N'2021-02-25T01:29:24.957' AS DateTime), N'System', N'C:\local\Temp\tmpC2A0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'457c2b98-b447-4b47-91f7-b8b3726a2fc4', 0, CAST(N'2021-02-25T01:31:25.003' AS DateTime), N'System', N'C:\local\Temp\tmp96D6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'457d4b19-dae3-49a8-a727-9eccbcc5e529', 0, CAST(N'2021-03-30T02:07:12.240' AS DateTime), N'System', N'C:\local\Temp\tmpA507.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'45fe0e8f-fecf-4818-be69-f1a6be91308a', 0, CAST(N'2021-02-25T23:15:00.517' AS DateTime), N'System', N'C:\local\Temp\tmpFD21.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'460fa125-0d18-4bb7-ad7a-55cc23efa8b2', 0, CAST(N'2021-02-25T01:28:59.270' AS DateTime), N'System', N'C:\local\Temp\tmp5E30.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'46b5ac82-3008-4448-a879-594c8cf4612d', 0, CAST(N'2021-04-07T10:05:19.900' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF6DF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'46df4a20-4258-4df0-b85e-0d8693210fac', 0, CAST(N'2021-02-25T01:30:46.623' AS DateTime), N'System', N'C:\local\Temp\tmp14F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'470d0696-0458-4adc-92a4-5304ded71bc9', 0, CAST(N'2021-03-08T17:53:02.857' AS DateTime), N'System', N'C:\local\Temp\tmp3832.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'472a5894-8369-4b91-8e2b-34f01ddae3c2', 0, CAST(N'2021-02-25T01:30:15.863' AS DateTime), N'System', N'C:\local\Temp\tmp88FB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4794a805-9df3-4fbd-8f45-2600e959c72d', 0, CAST(N'2021-03-22T23:46:19.717' AS DateTime), N'System', N'C:\local\Temp\tmpF6B9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'48602797-79df-4efa-9438-b586d1682092', 0, CAST(N'2021-02-19T22:05:00.407' AS DateTime), N'System', N'C:\local\Temp\tmp4732.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'48b4bccb-d58d-46a6-b9fc-0d948a1e232a', 0, CAST(N'2021-02-25T01:30:49.237' AS DateTime), N'System', N'C:\local\Temp\tmpB83.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'491b4a3b-4651-4a94-a605-7b9f2cc63f57', 0, CAST(N'2021-02-22T17:11:00.783' AS DateTime), N'System', N'C:\local\Temp\tmpF1E6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'49750e76-9f39-40a8-a9c4-fbb2ab2596ed', 0, CAST(N'2021-03-09T15:34:00.687' AS DateTime), N'System', N'C:\local\Temp\tmp376A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'498909b9-2d37-4ce1-9b85-3815f90d75ab', 0, CAST(N'2021-02-25T01:29:37.730' AS DateTime), N'System', N'C:\local\Temp\tmpF4D7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'49a27768-6306-4062-a662-ea9debcf4cbe', 0, CAST(N'2021-02-24T05:34:00.343' AS DateTime), N'System', N'C:\local\Temp\tmp689E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4a29f209-6dbb-4905-ae4d-b3be29e8fc4d', 0, CAST(N'2021-01-26T15:19:31.877' AS DateTime), N'System', N'C:\local\Temp\tmp5B43.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4a49e9bd-8ec3-4b66-9e04-1db8d8649871', 0, CAST(N'2021-02-19T06:12:01.717' AS DateTime), N'System', N'C:\local\Temp\tmpD680.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4a6288b8-2650-434c-a54b-0b11ef946d5d', 0, CAST(N'2021-02-24T00:38:00.570' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4a821b03-1548-4053-8d4f-d8c8c00487ac', 0, CAST(N'2021-03-23T00:13:26.233' AS DateTime), N'System', N'C:\local\Temp\tmpB27D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4aa5567c-7e87-4f8e-8996-78090a1577c2', 0, CAST(N'2021-02-25T01:26:17.517' AS DateTime), N'System', N'C:\local\Temp\tmpE74D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4b14a14b-e90c-4cd5-9bff-5dc26158a224', 0, CAST(N'2021-02-05T23:37:29.170' AS DateTime), N'System', N'C:\local\Temp\tmpA71F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4b366878-80be-4414-8720-12a0028fe66a', 0, CAST(N'2021-03-01T22:38:00.497' AS DateTime), N'System', N'C:\local\Temp\tmp33E1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4b49f1e5-7d4c-4fe4-b3fe-4dccb7737e29', 0, CAST(N'2021-03-26T21:29:07.060' AS DateTime), N'System', N'C:\local\Temp\tmp4EB1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4b532946-3c59-4942-b662-00d22ec3fc52', 0, CAST(N'2021-02-05T20:55:12.263' AS DateTime), N'System', N'C:\local\Temp\tmp14CF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4b8ebade-5b9e-4eb3-946a-bab3123cff1c', 0, CAST(N'2021-03-01T16:00:00.537' AS DateTime), N'System', N'C:\local\Temp\tmpD8D7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4ba4a234-3e5b-4119-9ec6-95901d1a86b0', 0, CAST(N'2021-02-25T01:28:57.120' AS DateTime), N'System', N'C:\local\Temp\tmp55B2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4bb4b7b9-c0dd-49c8-9aa1-b9bb781c3eb9', 0, CAST(N'2021-02-25T01:33:10.133' AS DateTime), N'System', N'C:\local\Temp\tmp34DB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4bb6340c-8261-42da-8bc1-50ee7010612d', 0, CAST(N'2021-01-21T17:54:00.413' AS DateTime), N'System', N'C:\local\Temp\tmp3F74.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4be3e6a7-2732-4ae3-9c4b-44e602ee4bed', 0, CAST(N'2021-02-25T01:28:36.507' AS DateTime), N'System', N'C:\local\Temp\tmp57C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4c90374a-ccb4-4007-b1b3-023d34ee7c2d', 0, CAST(N'2021-03-22T18:11:09.547' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp6798.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4c9c6781-c27c-4027-b2b6-c7e7922ef841', 0, CAST(N'2021-01-11T13:45:00.330' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE37A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4cda59ef-c33d-43eb-88fe-14098bcdff0a', 0, CAST(N'2020-12-17T18:19:19.560' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpACF0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4d966669-7741-4a5f-98b5-5c1684fae6e8', 0, CAST(N'2021-02-25T01:33:23.013' AS DateTime), N'System', N'C:\local\Temp\tmp66FB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4da76e51-05e0-4622-9d88-9d70e35d86d8', 0, CAST(N'2021-02-05T23:37:29.927' AS DateTime), N'System', N'C:\local\Temp\tmpAA2D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4db9c7c2-8def-4ffc-9607-e0a22755024b', 0, CAST(N'2021-02-25T01:30:24.533' AS DateTime), N'System', N'C:\local\Temp\tmpAAF2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4dfa076c-928a-4246-b92c-819717271525', 0, CAST(N'2021-02-18T17:27:00.607' AS DateTime), N'System', N'C:\local\Temp\tmp81D6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4e8c24ed-49d3-4e4d-9c33-9857277a48ee', 0, CAST(N'2021-02-25T01:28:18.123' AS DateTime), N'System', N'C:\local\Temp\tmpBD54.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4e922506-d227-41b4-90b3-a996800b18cf', 0, CAST(N'2021-02-25T01:28:19.033' AS DateTime), N'System', N'C:\local\Temp\tmpC12D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4e92436a-36a6-4983-8169-9beb46ea5c6c', 0, CAST(N'2021-01-21T17:31:00.217' AS DateTime), N'System', N'C:\local\Temp\tmp30D1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4ea92efe-256b-4df9-870a-44e43a607879', 0, CAST(N'2021-02-17T20:47:17.420' AS DateTime), N'System', N'C:\local\Temp\tmp258.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4eae8de8-543e-43be-ae7f-5b97a91e283b', 0, CAST(N'2021-02-25T22:52:02.027' AS DateTime), N'System', N'C:\local\Temp\tmpEEEA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4ec9f7d3-ae8b-42f0-b05c-cab2b7015731', 0, CAST(N'2020-12-17T17:28:15.573' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF678.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4ef1b02f-764b-4cd8-a75c-ccc2c8cd3a6c', 0, CAST(N'2021-02-25T01:32:39.397' AS DateTime), N'System', N'C:\local\Temp\tmpB933.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4f0804d5-34d2-48d1-913a-a4c6d4d428e1', 0, CAST(N'2021-01-08T14:41:00.357' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp515F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4f0c32b5-91e7-40ec-b9dc-78657d1f24b7', 0, CAST(N'2021-02-19T17:58:00.780' AS DateTime), N'System', N'C:\local\Temp\tmp2852.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4f0d9670-4d88-4856-be63-f63f7cf2d0b7', 0, CAST(N'2021-02-24T16:44:00.543' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4f349549-6b7e-419f-9cef-bcd344aa1c10', 0, CAST(N'2021-02-23T20:36:01.050' AS DateTime), N'System', N'C:\local\Temp\tmpE58E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4f431852-81ff-4870-b169-2850c39ef484', 0, CAST(N'2021-02-25T01:32:45.247' AS DateTime), N'System', N'C:\local\Temp\tmpD039.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4f68d3cc-2625-4fa6-8380-df57dae411ab', 0, CAST(N'2021-02-25T01:29:50.113' AS DateTime), N'System', N'C:\local\Temp\tmp2539.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4f7bb0b6-7388-49f6-9b83-1fe17ccb7f27', 0, CAST(N'2021-02-25T01:28:22.810' AS DateTime), N'System', N'C:\local\Temp\tmpD035.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4f91cd4a-093a-4200-8748-613bb51f2e4b', 0, CAST(N'2021-01-13T13:02:00.843' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp3495.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'4fcc60e0-1498-40de-b5a0-88f4305eaea9', 0, CAST(N'2021-02-25T01:30:54.393' AS DateTime), N'System', N'C:\local\Temp\tmp1F5D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'501c8939-8ed8-47b1-bcd2-d11f1d9df007', 0, CAST(N'2021-02-06T17:44:08.247' AS DateTime), N'System', N'C:\local\Temp\tmp81EA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'504b3976-eefa-4c58-8344-b20f28bf4bc2', 0, CAST(N'2020-12-17T17:48:18.183' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp45A3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'50592b27-2b43-4e06-83b0-73298ae17c25', 0, CAST(N'2021-02-25T01:30:38.837' AS DateTime), N'System', N'C:\local\Temp\tmpE278.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5069684e-d8e8-40e5-88ab-ee79f4cc2e1a', 0, CAST(N'2021-02-25T01:28:52.987' AS DateTime), N'System', N'C:\local\Temp\tmp45C0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', 0, CAST(N'2021-03-26T10:42:30.397' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9500.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'50992a72-5e12-4626-a233-0f1b53384fd8', 0, CAST(N'2021-01-11T14:12:01.053' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9B8C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'50bc4409-f9db-4e2a-a015-fe90ed7d79c2', 0, CAST(N'2021-02-25T01:28:41.510' AS DateTime), N'System', N'C:\local\Temp\tmp18E9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'50c37dbc-2230-4f25-863f-c6ec89824def', 0, CAST(N'2021-02-25T01:30:53.113' AS DateTime), N'System', N'C:\local\Temp\tmp1A7A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'50ef5669-0aee-4d18-bd64-4e4c4d7b3b63', 0, CAST(N'2021-02-26T17:31:02.030' AS DateTime), N'System', N'C:\local\Temp\tmp572C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'512b66dc-c110-4309-a4eb-fd9fd8cb60fe', 0, CAST(N'2021-02-05T23:37:30.973' AS DateTime), N'System', N'C:\local\Temp\tmpAE26.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5133a9ae-a8b9-4b91-946d-ccc6f05884ac', 0, CAST(N'2021-02-10T07:37:01.800' AS DateTime), N'System', N'C:\local\Temp\tmp1434.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'514d6097-c6bf-49c5-b88f-3956694fb121', 0, CAST(N'2021-02-25T01:31:37.573' AS DateTime), N'System', N'C:\local\Temp\tmpC821.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'519ea527-00fe-4acd-b141-d69c13b34bf4', 0, CAST(N'2021-01-21T18:14:00.290' AS DateTime), N'System', N'C:\local\Temp\tmp8F17.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'51c8d4a3-09f8-4dc4-b0cc-093d1820ca3a', 0, CAST(N'2021-02-25T01:29:51.233' AS DateTime), N'System', N'C:\local\Temp\tmp2990.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'51effecb-ce3d-4a93-875f-73c4658f9728', 0, CAST(N'2021-02-25T01:29:56.403' AS DateTime), N'System', N'C:\local\Temp\tmp3D99.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5234484d-d4fd-4b67-8e1f-a93ad052805b', 0, CAST(N'2021-02-26T22:49:02.640' AS DateTime), N'System', N'C:\local\Temp\tmp756D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'52547639-5be9-404d-96f8-664d7513f105', 0, CAST(N'2021-02-25T01:26:09.047' AS DateTime), N'System', N'C:\local\Temp\tmpC675.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'52a06ee9-f715-4be1-a06c-da97e3d83d8d', 0, CAST(N'2021-03-08T16:59:07.043' AS DateTime), N'System', N'C:\local\Temp\tmpDBF5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'52a16e68-2d38-4650-9aff-844f6f92fc34', 0, CAST(N'2021-01-06T16:09:02.260' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp69C5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'52c83ef2-6f42-46c0-aa0f-f8feb0023d56', 0, CAST(N'2021-03-23T00:15:00.870' AS DateTime), N'System', N'C:\local\Temp\tmp38EF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'52f6f716-c688-480e-bd20-ee468e1e8e55', 0, CAST(N'2021-02-26T23:22:00.337' AS DateTime), N'System', N'C:\local\Temp\tmpAB36.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'531d6f5d-c69e-4236-a694-67f4873b9cbb', 0, CAST(N'2021-02-16T21:02:10.760' AS DateTime), N'System', N'C:\local\Temp\tmp586C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5321b551-83bc-499e-8bdb-e8b98043cd2c', 0, CAST(N'2021-02-25T01:27:03.683' AS DateTime), N'System', N'C:\local\Temp\tmp9B8C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'534246a0-38aa-4766-a8b0-f577d9466429', 0, CAST(N'2021-03-01T22:32:00.437' AS DateTime), N'System', N'C:\local\Temp\tmpB59E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'53650fa1-bfc5-4207-8925-708eecb76f1d', 0, CAST(N'2021-02-25T01:31:11.203' AS DateTime), N'System', N'C:\local\Temp\tmp6116.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'537bf3e7-396f-491a-802a-408811a4d315', 0, CAST(N'2021-02-25T01:38:28.793' AS DateTime), N'System', N'C:\local\Temp\tmp1190.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'538c2ffd-5505-4d5c-b0e4-170d7ceef8be', 0, CAST(N'2021-02-05T23:15:16.357' AS DateTime), N'System', N'C:\local\Temp\tmp4EA4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'53f1cf8a-c50f-4b0c-aee2-4150273da2b6', 0, CAST(N'2021-02-25T01:29:18.523' AS DateTime), N'System', N'C:\local\Temp\tmpA955.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'53fc8542-3366-4a83-a38f-18833637f304', 0, CAST(N'2021-01-07T12:21:00.220' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpCB1C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5416496c-595f-4306-b2a4-f803f2ecd255', 0, CAST(N'2021-03-02T05:17:00.210' AS DateTime), N'System', N'C:\local\Temp\tmp795E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'541e6cd6-6efd-4e7c-944e-d4b50daeee5a', 0, CAST(N'2021-01-28T21:38:00.750' AS DateTime), N'System', N'C:\local\Temp\tmpCFFB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5487780f-455d-4759-ae78-8ff7f34025fe', 0, CAST(N'2020-12-17T17:28:25.807' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp21B4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'54b219c8-8989-44aa-8fcf-b31ecb860d74', 0, CAST(N'2021-02-25T01:27:51.360' AS DateTime), N'System', N'C:\local\Temp\tmp5563.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5503692c-b442-4052-812e-dd387955464a', 0, CAST(N'2021-02-25T01:26:22.810' AS DateTime), N'System', N'C:\local\Temp\tmpFC28.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'55537216-99bb-4c1c-9dc6-50a8f0b2b52a', 0, CAST(N'2021-03-23T00:21:03.130' AS DateTime), N'System', N'C:\local\Temp\tmpBFD9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'55b0e380-1148-4e8c-a280-4da0fdbb1d07', 0, CAST(N'2021-02-25T01:29:04.633' AS DateTime), N'System', N'C:\local\Temp\tmp7305.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'55e32419-18b4-4b46-bfcc-a5570cd68a67', 0, CAST(N'2021-02-16T21:02:16.663' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'563f078d-96bb-454f-a9f7-a0017077d43b', 0, CAST(N'2021-03-04T17:10:02.513' AS DateTime), N'System', N'C:\local\Temp\tmpBE64.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5669f6a1-60fa-4c6c-9049-63548a9f8968', 0, CAST(N'2021-03-30T02:07:17.217' AS DateTime), N'System', N'C:\local\Temp\tmpB8C0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', 0, CAST(N'2021-03-29T15:19:01.097' AS DateTime), N'System', N'C:\local\Temp\tmp42A6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'56d9a3f8-5063-46b3-a40b-8af0145e4358', 0, CAST(N'2021-02-25T01:28:12.487' AS DateTime), N'System', N'C:\local\Temp\tmpA7B2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'57466631-f087-4f17-b357-ddf82cf8581f', 0, CAST(N'2021-02-06T17:44:15.237' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'57725809-939e-4ebd-914c-4e740d63112e', 0, CAST(N'2021-02-25T01:30:00.847' AS DateTime), N'System', N'C:\local\Temp\tmp4EA4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'57d22f1c-01f6-4be3-814b-171655e768f3', 0, CAST(N'2021-02-25T01:33:03.713' AS DateTime), N'System', N'C:\local\Temp\tmp7BD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'57e58df6-6f16-4912-b777-13e80952b1bb', 0, CAST(N'2021-02-26T23:05:00.463' AS DateTime), N'System', N'C:\local\Temp\tmp1AE1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'58259193-854c-4593-90f8-265aa7b17b2a', 0, CAST(N'2021-02-19T15:30:05.380' AS DateTime), N'System', N'C:\local\Temp\tmpAB6F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'586f4946-c8a4-48d0-9574-04437732d44c', 0, CAST(N'2021-03-12T18:06:11.880' AS DateTime), N'System', N'C:\local\Temp\tmpAF8B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'58960cc1-c486-47a7-8d00-2609ad1907a6', 0, CAST(N'2021-01-23T21:49:08.763' AS DateTime), N'System', N'C:\local\Temp\tmp1B39.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'58984d28-abca-4af7-92ff-789e5a244826', 0, CAST(N'2021-02-12T21:25:17.803' AS DateTime), N'System', N'C:\local\Temp\tmp1B30.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'58f1ac10-d5c4-4f2c-8056-774f9350f71b', 0, CAST(N'2021-02-22T17:23:01.803' AS DateTime), N'System', N'C:\local\Temp\tmpF417.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'58f2c541-7a74-4609-8fc5-1364f2c290b2', 0, CAST(N'2021-02-25T01:30:51.797' AS DateTime), N'System', N'C:\local\Temp\tmp1597.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'58f38699-db5b-4431-93b1-94ca6d7f4571', 0, CAST(N'2021-01-08T11:36:00.287' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF231.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5906e184-1874-400c-aeba-95560177c163', 0, CAST(N'2021-02-24T18:30:03.820' AS DateTime), N'System', N'C:\local\Temp\tmpD734.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'592a3eef-7fa5-43a4-a180-c348f43a1f15', 0, CAST(N'2021-02-25T01:26:33.367' AS DateTime), N'System', N'C:\local\Temp\tmp2531.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5950461b-c2ec-4c9f-a8a5-7ee5e8ad4aa9', 0, CAST(N'2021-02-11T19:05:00.513' AS DateTime), N'System', N'C:\local\Temp\tmp4FEC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'59b25234-00af-4029-93a0-fdb980da112b', 0, CAST(N'2021-01-21T17:15:46.533' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5a24fe09-ef6d-46c3-8ddf-e3eab9bce471', 0, CAST(N'2021-01-28T21:31:00.313' AS DateTime), N'System', N'C:\local\Temp\tmp6804.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5a91faec-dc20-4351-be2d-425bb1098a25', 0, CAST(N'2021-02-23T20:36:01.533' AS DateTime), N'System', N'C:\local\Temp\tmpE774.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5a9a2672-86c4-45ac-b60a-9e31b3d0ebcb', 0, CAST(N'2021-02-25T01:31:20.833' AS DateTime), N'System', N'C:\local\Temp\tmp86D6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5ac68bc2-6707-4892-b1a3-499c73fef71e', 0, CAST(N'2021-03-30T01:58:07.710' AS DateTime), N'System', N'C:\local\Temp\tmp54C6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5b23507c-3f88-4d3c-aedc-a2d7ccd22e5f', 0, CAST(N'2021-01-05T21:12:01.040' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp72F6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5b61cd60-1617-41ac-9dfe-8b3aa66fcd9d', 0, CAST(N'2021-01-07T12:13:00.187' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7829.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5b688832-70b4-4f9d-868d-ad2bdce0ccff', 0, CAST(N'2020-12-17T17:48:13.700' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp368F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5b84170f-b116-4e1a-b38a-b03c0b082699', 0, CAST(N'2021-02-25T01:28:21.913' AS DateTime), N'System', N'C:\local\Temp\tmpCC6B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5b9274b3-adb0-4c2c-b6d9-2928221670a0', 0, CAST(N'2021-01-14T11:17:06.597' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp70D6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5bc335d8-af8a-42f2-9d38-1020ca16678e', 0, CAST(N'2021-01-05T20:41:01.003' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp112E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5bf49bb0-29a3-4802-9207-b0aebe0c61b4', 0, CAST(N'2021-02-05T23:15:10.280' AS DateTime), N'System', N'C:\local\Temp\tmp23E1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5c02f81a-b7e4-4a89-94c7-498148feeb23', 0, CAST(N'2021-02-25T01:27:55.737' AS DateTime), N'System', N'C:\local\Temp\tmp6660.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5c0b0cfb-3563-4bd0-86b3-69318381218d', 0, CAST(N'2021-02-25T01:54:13.073' AS DateTime), N'System', N'C:\local\Temp\tmp77C8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5cdf35f1-456c-499e-90b1-951bff322f82', 0, CAST(N'2021-02-25T01:38:41.020' AS DateTime), N'System', N'C:\local\Temp\tmp41DD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5d076552-d79e-4719-adc4-efed280f16eb', 0, CAST(N'2021-02-05T23:37:27.183' AS DateTime), N'System', N'C:\local\Temp\tmp9F2C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5d15863e-6845-47cb-9fbb-428495ff694b', 0, CAST(N'2021-02-25T01:27:29.797' AS DateTime), N'System', N'C:\local\Temp\tmp13E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5d3bfa6c-e711-4f09-8ccc-5726e4b3b6e1', 0, CAST(N'2021-02-25T01:26:33.903' AS DateTime), N'System', N'C:\local\Temp\tmp2764.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5d420655-488b-424c-a8e6-ac3751d3319e', 0, CAST(N'2021-02-23T20:36:00.523' AS DateTime), N'System', N'C:\local\Temp\tmpE30D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5d6c9bdd-4c7b-4315-b630-407cf97ac12a', 0, CAST(N'2021-02-25T01:28:14.300' AS DateTime), N'System', N'C:\local\Temp\tmpAED8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5db09f66-d709-4dca-8798-4d59d4aff058', 0, CAST(N'2020-12-17T17:27:52.673' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA052.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5db95083-246f-4555-9096-fa873bef0411', 0, CAST(N'2021-02-04T18:05:16.010' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5de47ab0-c01e-4b32-bfce-af50ad430d61', 0, CAST(N'2021-02-25T01:27:04.993' AS DateTime), N'System', N'C:\local\Temp\tmpA060.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5e237da4-df1a-4e38-9934-abad0fb9a99c', 0, CAST(N'2021-04-07T09:57:25.897' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB960.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5e58a1ed-dee4-4e69-b4a2-0256ffb0f6c0', 0, CAST(N'2021-01-06T16:06:06.783' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBDCE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5e5f9a05-ac9d-4500-a97f-b312aedb4322', 0, CAST(N'2021-01-21T09:56:28.720' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5e66b4dd-f1aa-44bd-be7f-643e582b08ef', 0, CAST(N'2021-01-19T17:40:00.540' AS DateTime), N'System', N'C:\local\Temp\tmpB8DE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5eae41b1-31bb-4f58-b318-039bddf394bc', 0, CAST(N'2021-02-25T01:26:11.847' AS DateTime), N'System', N'C:\local\Temp\tmpD168.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5ef93e86-48af-4d36-8997-049e5c6dd2f9', 0, CAST(N'2021-02-02T22:16:01.423' AS DateTime), N'System', N'C:\local\Temp\tmp654F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5efd488a-d745-4503-ae3a-3ba4ca2cb0bf', 0, CAST(N'2021-03-23T00:20:01.197' AS DateTime), N'System', N'C:\local\Temp\tmpCCF7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5f139db6-a888-4f16-86d2-aa862076ed51', 0, CAST(N'2021-02-25T01:38:08.943' AS DateTime), N'System', N'C:\local\Temp\tmpC435.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5f2d8453-d122-471b-8475-91dcc31f97f2', 0, CAST(N'2021-03-04T19:08:00.557' AS DateTime), N'System', N'C:\local\Temp\tmpC4C7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5f34f9d1-037e-4179-9b19-728550f10e34', 0, CAST(N'2021-01-04T21:19:03.857' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp93D6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5f8d3b6a-4e5b-4142-9082-1bae2f5895b2', 0, CAST(N'2021-02-25T01:28:40.497' AS DateTime), N'System', N'C:\local\Temp\tmp1500.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5f9d3f3b-1c71-4d71-b54f-abd61952149c', 0, CAST(N'2021-03-02T17:12:00.380' AS DateTime), N'System', N'C:\local\Temp\tmp864.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5fa18641-b9ce-4882-ae3c-02453b473bd6', 0, CAST(N'2021-02-25T01:27:25.120' AS DateTime), N'System', N'C:\local\Temp\tmpEF08.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'5fb46119-e0fd-425c-a630-94fe2e97ba17', 0, CAST(N'2021-02-02T22:03:00.143' AS DateTime), N'System', N'C:\local\Temp\tmp7994.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'60068620-52b8-4d44-9025-0d1e93fd58a9', 0, CAST(N'2021-01-05T21:10:00.940' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9E26.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'60c8442e-ccd0-4625-9996-96dd10e9405b', 0, CAST(N'2020-12-17T18:20:00.897' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp5BA3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'61759bb1-e635-47d9-84bb-6654ed8d895e', 0, CAST(N'2021-01-21T17:48:00.237' AS DateTime), N'System', N'C:\local\Temp\tmpC152.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'61b6f857-2445-40dd-852e-2759322061f7', 0, CAST(N'2020-12-17T16:32:24.900' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA99C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'621546bc-5261-4ece-9941-f82eae7ace4b', 0, CAST(N'2021-01-07T16:22:00.947' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp6F25.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'62fdcb2e-8224-48f3-84f0-b9470189ebac', 0, CAST(N'2021-02-25T01:38:00.583' AS DateTime), N'System', N'C:\local\Temp\tmpA2A0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'630f32ec-83a9-4871-95db-b8a3daf7426c', 0, CAST(N'2021-01-21T17:00:04.387' AS DateTime), N'System', N'C:\local\Temp\tmpCF3C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6317b952-c45b-4fd5-9cf2-e5aab54fa4a4', 0, CAST(N'2021-01-19T02:30:49.523' AS DateTime), N'System', N'C:\local\Temp\tmp404E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'631a9992-91a5-420d-aa2f-a9cfe1b02916', 0, CAST(N'2021-02-25T01:30:07.593' AS DateTime), N'System', N'C:\local\Temp\tmp68D9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'632d4763-c29c-4e89-95c7-d8c0a494ffe3', 0, CAST(N'2021-02-25T01:26:45.497' AS DateTime), N'System', N'C:\local\Temp\tmp54B2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'633e6950-c83e-46b2-bda9-a56786b3fd83', 0, CAST(N'2021-02-16T21:02:00.267' AS DateTime), N'System', N'C:\local\Temp\tmp31D4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'63b2bfb4-9a94-4d1b-b46f-cb9f133bfe1c', 0, CAST(N'2020-12-17T17:27:57.033' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB17E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'63c47ec2-fac6-4fef-bee6-2cce7c0f55ed', 0, CAST(N'2021-01-19T20:15:00.420' AS DateTime), N'System', N'C:\local\Temp\tmpA05F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'644423af-e871-46d5-9e6b-ebfa79f1ff2d', 0, CAST(N'2021-02-25T01:29:43.490' AS DateTime), N'System', N'C:\local\Temp\tmpAB6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'645ecab0-d36c-4700-bbab-d88bc1412db1', 0, CAST(N'2021-02-04T17:56:14.067' AS DateTime), N'System', N'C:\local\Temp\tmpE0EB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'64cd750a-ead8-4dab-b838-6e2cbf1313da', 0, CAST(N'2021-02-24T17:44:06.043' AS DateTime), N'System', N'C:\local\Temp\tmpC507.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'64d9189e-d684-4b28-8870-077bedf88465', 0, CAST(N'2021-03-15T11:51:24.660' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpD77B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'65091bc4-d18d-45d0-af8f-4b3d31072c1b', 0, CAST(N'2021-02-25T01:29:28.177' AS DateTime), N'System', N'C:\local\Temp\tmpCF55.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'65101171-cb1a-4aae-bb35-565086fe9980', 0, CAST(N'2021-02-17T15:34:00.883' AS DateTime), N'System', N'C:\local\Temp\tmp41A8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'65165377-7fc7-4bec-9319-56aa8f385d28', 0, CAST(N'2021-02-25T01:27:23.577' AS DateTime), N'System', N'C:\local\Temp\tmpE92A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'656efbad-71a7-422e-ad0c-4eb14576c00f', 0, CAST(N'2021-01-13T14:52:00.347' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE990.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'657d310e-7b22-42f0-bbe0-83c8028cecd4', 0, CAST(N'2021-02-25T01:27:46.490' AS DateTime), N'System', N'C:\local\Temp\tmp4224.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'65b96be4-181a-4395-8df1-7c649955ddae', 0, CAST(N'2021-02-25T01:27:58.103' AS DateTime), N'System', N'C:\local\Temp\tmp6FE9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'65d62161-6742-4e9c-9a44-93c9a19b16c1', 0, CAST(N'2020-12-17T17:28:07.880' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpDBE5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6687daac-0ea1-43c1-bec3-183bab9e3afa', 0, CAST(N'2021-01-19T21:14:00.220' AS DateTime), N'System', N'C:\local\Temp\tmpA486.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'668faaff-1367-4f0d-8a2b-129b9aa057e8', 0, CAST(N'2021-02-04T17:56:17.020' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'66db5fef-79fd-4b0b-b8a5-80a74eca22c4', 0, CAST(N'2021-02-05T23:37:16.157' AS DateTime), N'System', N'C:\local\Temp\tmp7335.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'66ff8173-3b27-4f94-b8e6-829cbe1fb81e', 0, CAST(N'2021-02-25T01:26:23.277' AS DateTime), N'System', N'C:\local\Temp\tmpFDFE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'66ffaaf7-5bdc-4c6e-9ba1-9c0ca6bc84e2', 0, CAST(N'2021-02-25T01:33:33.640' AS DateTime), N'System', N'C:\local\Temp\tmp918B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'67282af4-3d63-405f-9fb5-40afcbb404ae', 0, CAST(N'2021-03-03T23:16:00.503' AS DateTime), N'System', N'C:\local\Temp\tmp88B4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'675c664b-12b3-418c-988e-b3c250a79e65', 0, CAST(N'2021-02-04T18:05:06.540' AS DateTime), N'System', N'C:\local\Temp\tmp86.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'67ad4d20-922d-4087-aacc-ce11058ac3a3', 0, CAST(N'2021-02-12T18:19:04.477' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'67d9c4a6-fa8e-47fb-96f6-2ae5d4c64c3c', 0, CAST(N'2021-02-25T01:26:08.230' AS DateTime), N'System', N'C:\local\Temp\tmpC327.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'67e86d69-91c3-462c-9eca-c97055576917', 0, CAST(N'2021-02-25T01:31:38.890' AS DateTime), N'System', N'C:\local\Temp\tmpCD61.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'67ea2014-8d67-4ace-a2e0-5f323436f7b4', 0, CAST(N'2021-02-11T19:14:00.300' AS DateTime), N'System', N'C:\local\Temp\tmp8D5E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'67efdfac-8917-466e-8bdc-e3a62a229e08', 0, CAST(N'2021-02-10T07:28:00.347' AS DateTime), N'System', N'C:\local\Temp\tmpD6DD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'686d5a0e-834e-43f3-8538-d9179dc86a5d', 0, CAST(N'2021-01-21T17:29:00.220' AS DateTime), N'System', N'C:\local\Temp\tmp5C10.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6874bedb-7a1a-4307-9171-efa0127a7046', 0, CAST(N'2021-02-02T22:03:00.447' AS DateTime), N'System', N'C:\local\Temp\tmp7ACE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'68819408-a1cc-4f56-a66d-1a946fd2f82e', 0, CAST(N'2021-03-19T18:05:37.630' AS DateTime), N'System', N'C:\local\Temp\tmpDBE9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'68851574-4dfa-4623-98f9-241f044aa4c5', 0, CAST(N'2021-02-25T01:29:52.410' AS DateTime), N'System', N'C:\local\Temp\tmp2DC7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'68ba0310-a078-4500-b19e-a60b79aba6fa', 0, CAST(N'2021-01-15T12:01:00.320' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6922ddc9-7e26-420a-8da3-6fd7f7a6653c', 0, CAST(N'2021-02-25T01:54:31.897' AS DateTime), N'System', N'C:\local\Temp\tmpC1B7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'692a79ea-7ffc-43a3-a902-2ea0766effad', 0, CAST(N'2020-12-17T17:27:59.693' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBBD1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'69d3d682-3378-44ee-83e1-db634c98fe54', 0, CAST(N'2021-02-25T01:26:54.260' AS DateTime), N'System', N'C:\local\Temp\tmp76C0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'69e70a24-7367-4ec0-a5d3-4a25a4c1d474', 0, CAST(N'2021-02-04T17:56:12.333' AS DateTime), N'System', N'C:\local\Temp\tmpD9A4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'69fbd982-86e2-42bd-a1bc-765009ba11ab', 0, CAST(N'2021-03-25T18:17:06.680' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9999.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6a2f2534-63e7-4bc8-8197-8698de00b64c', 0, CAST(N'2020-12-17T16:31:02.433' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7235.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6a38911f-d8ab-4353-a4d6-3056476b3e62', 0, CAST(N'2021-01-19T20:11:08.193' AS DateTime), N'System', N'C:\local\Temp\tmpF6BF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6a64e12d-5c7f-48c0-a0ac-4c6ad0bc6f83', 0, CAST(N'2021-02-05T20:55:10.200' AS DateTime), N'System', N'C:\local\Temp\tmpC4F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6a6f374d-7b4e-41c0-a757-962a1b58556b', 0, CAST(N'2021-02-25T01:27:27.473' AS DateTime), N'System', N'C:\local\Temp\tmpF803.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6a7586c7-cf5a-4756-9b61-a9ee0c96fbc1', 0, CAST(N'2021-02-25T01:26:17.027' AS DateTime), N'System', N'C:\local\Temp\tmpE597.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6a7e79db-60a2-4a3d-b5df-8093e63ce6dd', 0, CAST(N'2021-02-25T01:26:14.827' AS DateTime), N'System', N'C:\local\Temp\tmpDCD7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6a887e2d-5edf-403e-b78d-335f4bd38925', 0, CAST(N'2021-01-14T13:46:00.330' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpCF40.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6a8f65c5-7e25-41cb-83ea-277447874c59', 0, CAST(N'2021-02-25T01:27:52.140' AS DateTime), N'System', N'C:\local\Temp\tmp5881.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6a9a38f9-71a5-4db0-be16-e884c574e60f', 0, CAST(N'2021-02-24T15:26:01.277' AS DateTime), N'System', N'C:\local\Temp\tmp5D62.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6ac15201-c5dc-4256-957e-0467bf751474', 0, CAST(N'2021-01-19T03:46:37.323' AS DateTime), N'System', N'C:\local\Temp\tmpA1F6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6ac66f63-9929-4021-8942-64ce2d8e1c73', 0, CAST(N'2021-02-25T01:29:38.843' AS DateTime), N'System', N'C:\local\Temp\tmpF8A1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6ad422a5-0fd8-473f-a4ba-c402668ba77a', 0, CAST(N'2021-02-25T01:28:53.970' AS DateTime), N'System', N'C:\local\Temp\tmp49A9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6ad60773-8337-40f0-bc2b-bd2a80eb3b73', 0, CAST(N'2021-01-28T21:25:02.800' AS DateTime), N'System', N'C:\local\Temp\tmpF303.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6b22517c-8a58-482d-8b55-8f94a5347962', 0, CAST(N'2021-02-25T01:28:11.617' AS DateTime), N'System', N'C:\local\Temp\tmpA446.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6b296f17-39d7-4814-9921-4098c5ff9f6e', 0, CAST(N'2021-02-25T01:28:30.807' AS DateTime), N'System', N'C:\local\Temp\tmpEED1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6b31a5fa-22e0-41d1-bd1a-ab5b5d3568c0', 0, CAST(N'2021-02-25T01:26:15.733' AS DateTime), N'System', N'C:\local\Temp\tmpE083.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6b688e6a-c382-4208-b13b-6412461b85eb', 0, CAST(N'2021-02-25T01:26:32.817' AS DateTime), N'System', N'C:\local\Temp\tmp22EE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6bb1e200-49eb-4c8d-91ef-da915bcab822', 0, CAST(N'2021-02-17T19:37:05.823' AS DateTime), N'System', N'C:\local\Temp\tmpBD67.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6bc236c1-3449-46b0-b2c2-0821c6191b78', 0, CAST(N'2021-03-02T17:44:00.397' AS DateTime), N'System', N'C:\local\Temp\tmp540D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6bc4a7bf-e30a-4308-afcb-30befd645db3', 0, CAST(N'2021-03-08T16:59:00.593' AS DateTime), N'System', N'C:\local\Temp\tmpC242.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6c0bf2d5-6f77-4fa5-b6ae-2ec79f3e3fe0', 0, CAST(N'2021-03-02T16:49:00.287' AS DateTime), N'System', N'C:\local\Temp\tmpFA31.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6c141f23-0af3-4c38-a7fd-61fb61c4bec3', 0, CAST(N'2021-02-04T17:56:13.760' AS DateTime), N'System', N'C:\local\Temp\tmpDCF2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6c1cb261-ec32-491c-be98-f00c9a727fba', 0, CAST(N'2021-02-24T18:29:01.947' AS DateTime), N'System', N'C:\local\Temp\tmpE4F0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6c4a6259-aad7-437e-9571-3deb2242b2a9', 0, CAST(N'2021-02-25T01:26:29.590' AS DateTime), N'System', N'C:\local\Temp\tmp1674.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6c74ef62-c0f6-41e1-86b3-e64a004f8960', 0, CAST(N'2021-03-04T17:16:00.480' AS DateTime), N'System', N'C:\local\Temp\tmp3C77.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6c9f7c4e-26b9-40c4-a049-f760bb97692d', 0, CAST(N'2021-02-19T23:07:00.330' AS DateTime), N'System', N'C:\local\Temp\tmp95D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6cab4011-b0b4-4330-8035-dd853cda0f23', 0, CAST(N'2021-02-05T23:15:15.193' AS DateTime), N'System', N'C:\local\Temp\tmp4C8F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6e7c8d3f-a1cc-46a6-9105-7eeaf1a83fb1', 0, CAST(N'2021-02-25T01:32:08.210' AS DateTime), N'System', N'C:\local\Temp\tmp3F4A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6eec7cf5-01ab-4cfb-bc9c-291e09ba7dfb', 0, CAST(N'2021-02-25T01:38:24.690' AS DateTime), N'System', N'C:\local\Temp\tmp163.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6f0e47f6-90fe-4774-bf18-a7b6134cfe47', 0, CAST(N'2021-02-25T01:29:58.627' AS DateTime), N'System', N'C:\local\Temp\tmp45F7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6f18b22b-dc04-4c47-af47-5ce5a91a447f', 0, CAST(N'2021-02-24T05:18:00.217' AS DateTime), N'System', N'C:\local\Temp\tmpC29D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'6f960a8d-14d3-4904-85f6-897a3fc37031', 0, CAST(N'2021-02-25T01:31:49.260' AS DateTime), N'System', N'C:\local\Temp\tmpF592.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'701092ad-586a-4465-bccc-cdcb975648e8', 0, CAST(N'2021-02-25T01:26:20.820' AS DateTime), N'System', N'C:\local\Temp\tmpF445.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'701c61a8-91da-48a2-b415-57372ebbb281', 0, CAST(N'2021-03-01T14:37:00.780' AS DateTime), N'System', N'C:\local\Temp\tmpDCFA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'702ed3da-f4c3-4436-9b1c-7334b241a97e', 0, CAST(N'2020-12-17T16:32:43.673' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp1F2C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'702f191f-22ad-434f-beba-b96594bbf188', 0, CAST(N'2021-02-12T18:35:14.307' AS DateTime), N'System', N'C:\local\Temp\tmp69E1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'70597fb5-cc4e-41c9-a461-ca63d4b4374b', 0, CAST(N'2021-02-11T18:58:01.030' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7073f50e-04ae-489c-a2e4-01c63a00668b', 0, CAST(N'2020-12-17T03:12:42.013' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp96BD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'70e0596e-8e82-4099-8cdf-8a0c270df31a', 0, CAST(N'2021-02-02T22:17:01.127' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'70f2fae2-8fd9-4659-95fa-062a1cbc3d4e', 0, CAST(N'2021-03-12T01:25:04.190' AS DateTime), N'System', N'C:\local\Temp\tmp309E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'70f99275-a1c1-4b45-a6c5-5362b1a7c4fe', 0, CAST(N'2021-02-25T01:31:04.823' AS DateTime), N'System', N'C:\local\Temp\tmp484A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'711019bc-bcf4-4e40-81c7-b3d5601a273f', 0, CAST(N'2021-02-02T22:16:00.363' AS DateTime), N'System', N'C:\local\Temp\tmp606A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'711a7ac2-5ad4-4539-a03e-072dc42f0927', 0, CAST(N'2021-02-05T23:37:26.730' AS DateTime), N'System', N'C:\local\Temp\tmp9DB4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7142ceeb-2327-4c0c-974f-ba86e355b263', 0, CAST(N'2021-01-28T14:07:06.150' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp4791.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7154824f-1d8d-4ebf-87fb-868f3557afa8', 0, CAST(N'2021-02-04T17:56:10.607' AS DateTime), N'System', N'C:\local\Temp\tmpD26D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'718a0f29-7c52-40f1-81cb-bdf60b5815e3', 0, CAST(N'2021-02-25T01:27:36.953' AS DateTime), N'System', N'C:\local\Temp\tmp1D5A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'721ac660-3ed2-4e6f-b72e-9f11ec8f1fd1', 0, CAST(N'2021-01-06T16:57:00.207' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp5BA6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'721bdcd0-667c-478d-9521-866ebee616a2', 0, CAST(N'2021-02-25T01:30:14.487' AS DateTime), N'System', N'C:\local\Temp\tmp83E9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'722a5caf-748d-48e0-91a1-7c55e6eca6c9', 0, CAST(N'2021-01-21T17:23:00.283' AS DateTime), N'System', N'C:\local\Temp\tmpDDFE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'725fc3e3-ff88-4d74-9fc2-b83ba65f89e6', 0, CAST(N'2021-02-25T01:38:16.080' AS DateTime), N'System', N'C:\local\Temp\tmpDFBE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'72c9e780-e452-4a36-af34-1ea4c8ee2a95', 0, CAST(N'2021-02-25T01:28:10.687' AS DateTime), N'System', N'C:\local\Temp\tmpA07D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'72cf23e0-d38e-4c74-b1b9-8ce1fb589db2', 0, CAST(N'2021-03-09T16:17:00.513' AS DateTime), N'System', N'C:\local\Temp\tmp94C5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'72f09527-9ede-42c9-b010-0a058fa38809', 0, CAST(N'2021-01-15T10:40:00.840' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpDD9F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7368b440-d9b6-4e8a-b42a-afa443105110', 0, CAST(N'2020-12-17T17:41:19.130' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpDCC3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'736c6356-553f-45a2-b95b-8c42b8d8647b', 0, CAST(N'2021-02-25T01:26:48.020' AS DateTime), N'System', N'C:\local\Temp\tmp5E8A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'736da707-da8a-40e2-97bb-3600c52ccf10', 0, CAST(N'2021-02-12T18:35:13.150' AS DateTime), N'System', N'C:\local\Temp\tmp653C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'737f29a0-4e6c-4bd1-aa79-c16693565826', 0, CAST(N'2021-01-19T12:01:02.307' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'73a81b13-9708-4e4c-a0dd-7a9e4525fbed', 0, CAST(N'2021-02-25T01:29:30.317' AS DateTime), N'System', N'C:\local\Temp\tmpD775.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'74169646-cf8f-44b9-b0f2-29ac1329d500', 0, CAST(N'2021-01-21T10:05:28.850' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'744df12e-f056-44d7-9d06-3c9d80801b5b', 0, CAST(N'2021-01-07T12:17:00.170' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp219B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7470de1f-30c7-4819-aef1-0c52e2dc6213', 0, CAST(N'2021-02-24T00:10:00.390' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'74871dfa-0dde-43a4-a4b2-5f50701d91f2', 0, CAST(N'2020-12-17T17:28:00.630' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBF4D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'74bb2a7b-0d21-4b36-ad70-83cdaf9cd691', 0, CAST(N'2021-03-22T23:46:10.737' AS DateTime), N'System', N'C:\local\Temp\tmpD244.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'74ee8ec9-7469-4cf6-94c7-858cfb5a3de0', 0, CAST(N'2021-01-06T14:00:01.173' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp4F93.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'74fb4576-a4dd-4918-8dac-a50dee4faf61', 0, CAST(N'2021-03-12T17:34:06.230' AS DateTime), N'System', N'C:\local\Temp\tmp411D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7506e04e-718b-4193-b889-bbe0bbb0d63c', 0, CAST(N'2021-03-02T17:41:00.327' AS DateTime), N'System', N'C:\local\Temp\tmp94DC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'752a519d-cab0-49ab-9ecd-0b7220a6e6a6', 0, CAST(N'2021-02-25T01:32:21.397' AS DateTime), N'System', N'C:\local\Temp\tmp72C7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'755d4d3c-93fc-4dad-9943-b1ca8bf9b24b', 0, CAST(N'2021-02-25T01:26:09.537' AS DateTime), N'System', N'C:\local\Temp\tmpC85A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7632e154-83e4-41e8-98c5-99c4f8f55756', 0, CAST(N'2021-03-23T20:05:01.923' AS DateTime), N'System', N'C:\local\Temp\tmp9AFF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'766f1445-0a51-43b2-a461-f517e831d039', 0, CAST(N'2021-02-25T01:30:09.790' AS DateTime), N'System', N'C:\local\Temp\tmp71B5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'76776c04-8942-4f04-bda6-6eb8d3f51376', 0, CAST(N'2021-02-25T01:54:43.003' AS DateTime), N'System', N'C:\local\Temp\tmpE88C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'767c8caa-e4e1-483c-9a4a-736f248e75f7', 0, CAST(N'2020-12-17T17:41:06.247' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB7B4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'769a71de-155e-4711-bd11-6e4a51a9bc58', 0, CAST(N'2021-02-05T20:55:09.787' AS DateTime), N'System', N'C:\local\Temp\tmpA4B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'77463146-c4e3-4714-8ed5-07d3d81e08c6', 0, CAST(N'2021-02-05T23:15:14.663' AS DateTime), N'System', N'C:\local\Temp\tmp4A5C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7810ba01-f39c-4ec5-a729-56bda7e48999', 0, CAST(N'2021-02-08T23:24:01.867' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7817098b-2151-44a4-8c9e-91df54d961b3', 0, CAST(N'2021-02-12T18:35:11.227' AS DateTime), N'System', N'C:\local\Temp\tmp5DA7.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'786b6cb1-fd82-426e-91cf-7b578c68c8c0', 0, CAST(N'2021-02-25T01:28:50.067' AS DateTime), N'System', N'C:\local\Temp\tmp3A82.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'78a5eafe-531e-4ce0-b830-bbd70ae011e5', 0, CAST(N'2021-02-02T21:44:00.190' AS DateTime), N'System', N'C:\local\Temp\tmp1470.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'78a6ed6b-f122-4e90-a7dc-cf8d7a805724', 0, CAST(N'2021-02-25T01:27:54.087' AS DateTime), N'System', N'C:\local\Temp\tmp6024.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'78d3d98d-1c25-4acb-8be7-a6ae19546ebc', 0, CAST(N'2021-01-21T10:05:29.293' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpDA7C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'79139cd9-f23c-44aa-8e99-804f430d2945', 0, CAST(N'2021-02-25T01:26:16.577' AS DateTime), N'System', N'C:\local\Temp\tmpE3F0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'793cdf5b-2afe-43fa-bd5f-332794f3774a', 0, CAST(N'2021-02-22T16:42:01.443' AS DateTime), N'System', N'C:\local\Temp\tmp69DD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'79781cd6-9b5d-4320-9670-1df19644fd58', 0, CAST(N'2021-03-04T04:40:01.227' AS DateTime), N'System', N'C:\local\Temp\tmp253A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7978e9dc-2f9a-4d13-81c3-ea9915bf184f', 0, CAST(N'2021-02-25T01:26:54.923' AS DateTime), N'System', N'C:\local\Temp\tmp7922.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'798fdc8f-9182-418a-ae93-3d884e2f092f', 0, CAST(N'2021-01-21T08:52:50.570' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7a182783-bf5d-4dab-aa1e-2152aee40cbb', 0, CAST(N'2021-03-04T17:13:00.493' AS DateTime), N'System', N'C:\local\Temp\tmp7D56.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7a649399-187c-4ce1-8439-09fc9abb259e', 0, CAST(N'2021-03-04T04:50:00.503' AS DateTime), N'System', N'C:\local\Temp\tmp4CAD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7a692dfc-e7ba-47de-97d5-ed69ca29b47d', 0, CAST(N'2021-02-25T01:31:55.027' AS DateTime), N'System', N'C:\local\Temp\tmpBFC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7a9243e1-a50c-491a-aa64-f8fddddd7c3e', 0, CAST(N'2021-03-02T17:17:00.367' AS DateTime), N'System', N'C:\local\Temp\tmp9C45.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7b1cf9a6-9047-41e1-bb10-a3ce74d08dec', 0, CAST(N'2020-12-17T17:28:08.790' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpDF51.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7b586bcb-1eb0-4eec-a8f1-a3f0290c863a', 0, CAST(N'2021-02-25T01:38:39.953' AS DateTime), N'System', N'C:\local\Temp\tmp3806.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7b8e3bd4-5d36-4596-95b4-300c10815ab8', 0, CAST(N'2021-02-25T01:29:36.760' AS DateTime), N'System', N'C:\local\Temp\tmpF0EE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7c0afb97-18d2-4e92-9718-1a647a6522bb', 0, CAST(N'2021-01-19T21:02:00.190' AS DateTime), N'System', N'C:\local\Temp\tmpA7F5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7c41b5a2-e490-4d48-bb2c-3c081820ee4d', 0, CAST(N'2021-01-07T16:29:00.870' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpD7C7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7c52941a-96d5-406e-8f4a-9eae0142a89e', 0, CAST(N'2021-02-24T01:41:01.423' AS DateTime), N'System', N'C:\local\Temp\tmp1A97.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7ca4398e-8d89-476f-a8eb-f5cdb24bea15', 0, CAST(N'2021-02-22T17:29:01.027' AS DateTime), N'System', N'C:\local\Temp\tmp6EDE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7cdfebab-2ae9-4b0b-9c1c-b1e17514b01d', 0, CAST(N'2021-02-25T01:32:09.770' AS DateTime), N'System', N'C:\local\Temp\tmp4594.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7ce31701-a8c7-454c-ba06-a6106c831b9f', 0, CAST(N'2021-02-24T01:39:00.700' AS DateTime), N'System', N'C:\local\Temp\tmp4604.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7cead029-8a12-45af-b29b-898590f83720', 0, CAST(N'2021-03-22T23:46:16.593' AS DateTime), N'System', N'C:\local\Temp\tmpEA06.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7cf81146-0b8c-4475-be03-eb83f30d9505', 0, CAST(N'2020-12-17T18:12:01.447' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpD91.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7d712cc0-2111-45f5-a364-d668b5be0a16', 0, CAST(N'2021-02-05T23:37:32.157' AS DateTime), N'System', N'C:\local\Temp\tmpB079.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7dc06201-0002-4433-9fe6-304434de337c', 0, CAST(N'2021-03-30T00:46:08.850' AS DateTime), N'System', N'C:\local\Temp\tmp6FD1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7e0d4a47-a8a4-4cc1-8876-aa20a8e05de3', 0, CAST(N'2021-02-25T01:26:18.873' AS DateTime), N'System', N'C:\local\Temp\tmpECDE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7e5fadfa-3562-41b4-9620-a1c851e3e2fe', 0, CAST(N'2021-03-23T00:21:01.670' AS DateTime), N'System', N'C:\local\Temp\tmpB70C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7e7124e7-d787-4551-bd0c-d267b04e009f', 0, CAST(N'2021-02-12T18:35:04.287' AS DateTime), N'System', N'C:\local\Temp\tmp4318.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7f233544-004e-4130-b14b-1e2a1d71e60c', 0, CAST(N'2021-02-25T01:29:27.137' AS DateTime), N'System', N'C:\local\Temp\tmpCB4C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7f3fc855-448d-4e33-97b8-bf6b140ae380', 0, CAST(N'2021-02-05T20:55:10.800' AS DateTime), N'System', N'C:\local\Temp\tmpEA2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'7fe78607-aee0-4071-a87e-323031530aa6', 0, CAST(N'2021-01-21T18:04:00.447' AS DateTime), N'System', N'C:\local\Temp\tmp6735.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'80199172-9e07-41f2-a288-3494a7c7f414', 0, CAST(N'2020-12-17T18:19:20.323' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBFED.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'803d2911-84bd-4eff-a9b4-25885cb801d6', 0, CAST(N'2021-01-06T16:14:06.960' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpFDA3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8129901e-bad7-4c03-b5a7-f4b006f223d5', 0, CAST(N'2021-02-10T07:05:00.420' AS DateTime), N'System', N'C:\local\Temp\tmpC83C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'813cb7fb-5720-4c74-892b-55a706b71337', 0, CAST(N'2021-01-07T11:43:00.260' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'81434ab8-ad33-47c7-a6d0-1c35e4946cf8', 0, CAST(N'2021-02-25T01:26:40.037' AS DateTime), N'System', N'C:\local\Temp\tmp3F6C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'81503f9a-f45a-4d17-aece-60232ef1f7e3', 0, CAST(N'2021-01-12T15:22:11.740' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'81d42b15-ed11-4c28-b830-c0eebcb8a339', 0, CAST(N'2021-01-12T15:23:01.230' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'81e990d8-e1e6-4c18-9dd0-eac0f5b0d75a', 0, CAST(N'2021-03-02T17:20:01.513' AS DateTime), N'System', N'C:\local\Temp\tmp5FFB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'81fca9e5-8cb6-4eeb-a778-6c21534f07a1', 0, CAST(N'2021-02-06T17:44:10.827' AS DateTime), N'System', N'C:\local\Temp\tmp8C30.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'82775f33-240b-4c61-b2ab-35e96cf38a73', 0, CAST(N'2021-02-25T01:26:13.647' AS DateTime), N'System', N'C:\local\Temp\tmpD842.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8295cdd7-85ae-40b7-b187-a5a9169e7319', 0, CAST(N'2021-01-19T20:24:00.227' AS DateTime), N'System', N'C:\local\Temp\tmpDDB2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'82aa62d7-d712-4ba9-b12a-cfb3bd5ffd75', 0, CAST(N'2021-02-05T23:15:11.907' AS DateTime), N'System', N'C:\local\Temp\tmp3F5A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'82c6cd85-fe6e-4f79-a0d4-065bd4660f45', 0, CAST(N'2021-02-12T21:25:17.203' AS DateTime), N'System', N'C:\local\Temp\tmp189E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'82c8b69a-0f1f-4141-be42-74bf9a055a26', 0, CAST(N'2021-01-05T21:07:01.143' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpDF04.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'82e31a51-295e-48fb-b491-84b7e1c69565', 0, CAST(N'2021-02-05T20:55:17.213' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'82ec372b-a755-41d0-9591-d61949c19a06', 0, CAST(N'2021-02-25T01:33:27.170' AS DateTime), N'System', N'C:\local\Temp\tmp770A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'834db6e1-7809-4294-89e6-c132f094bc55', 0, CAST(N'2021-02-02T21:58:00.163' AS DateTime), N'System', N'C:\local\Temp\tmpE5C2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'83ccbdac-a698-45b7-8ccc-4a9cbee5b95d', 0, CAST(N'2021-01-28T21:31:00.093' AS DateTime), N'System', N'C:\local\Temp\tmp6719.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8438e2cd-7217-4ba5-8780-0b41d153b9cf', 0, CAST(N'2021-02-25T01:28:37.477' AS DateTime), N'System', N'C:\local\Temp\tmp955.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8508f44c-feca-45a0-aa3b-9e1b9327905b', 0, CAST(N'2021-01-28T21:25:01.053' AS DateTime), N'System', N'C:\local\Temp\tmpEC09.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'851e0d4a-8a94-4754-b09d-e30853494c0f', 0, CAST(N'2021-02-25T01:26:22.320' AS DateTime), N'System', N'C:\local\Temp\tmpFA33.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'856042c7-f990-4138-a775-2715879e73ea', 0, CAST(N'2021-02-25T01:32:27.017' AS DateTime), N'System', N'C:\local\Temp\tmp8912.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'85a9f44c-38e4-45d2-9df3-ede79cf5feaa', 0, CAST(N'2021-02-05T23:15:16.793' AS DateTime), N'System', N'C:\local\Temp\tmp5348.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'85e48422-b050-479b-9816-e5167ffc85b6', 0, CAST(N'2021-02-12T21:25:15.573' AS DateTime), N'System', N'C:\local\Temp\tmp1252.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'85ff528e-44e1-4117-a669-d480eea50290', 0, CAST(N'2021-02-26T23:35:02.463' AS DateTime), N'System', N'C:\local\Temp\tmp91F9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'86115d30-9a68-4de1-a5e9-83c1fb9b50c2', 0, CAST(N'2021-03-02T18:09:00.527' AS DateTime), N'System', N'C:\local\Temp\tmp3700.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'86630a27-0336-454a-8e49-14a4b2ca37de', 0, CAST(N'2021-03-30T17:33:02.987' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp996E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'86cb19f9-cea8-4a11-89fb-d1f1c1a38c76', 0, CAST(N'2021-02-25T01:30:47.973' AS DateTime), N'System', N'C:\local\Temp\tmp661.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'86f24f9d-3c57-4828-b59b-e647e5d4a9d6', 0, CAST(N'2021-02-25T01:31:53.617' AS DateTime), N'System', N'C:\local\Temp\tmp67D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8720b696-e798-45cf-b5c5-7b475f3e8e9c', 0, CAST(N'2021-02-25T01:33:04.833' AS DateTime), N'System', N'C:\local\Temp\tmp1F8D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8736a9e4-0f9d-45e4-9eaf-e743b9e6f333', 0, CAST(N'2021-02-06T17:44:05.920' AS DateTime), N'System', N'C:\local\Temp\tmp669E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8765602a-629c-4aef-b3ee-813f4ead070e', 0, CAST(N'2021-02-25T01:32:42.343' AS DateTime), N'System', N'C:\local\Temp\tmpC4ED.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'876a0eda-d990-4077-9262-5be2b3d9b098', 0, CAST(N'2021-02-25T01:31:27.750' AS DateTime), N'System', N'C:\local\Temp\tmpA196.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8786872d-c7dc-4ba2-baaf-152f85dc47be', 0, CAST(N'2020-12-17T18:19:10.843' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp8B4D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'87a5127b-ca3e-45e8-a736-e42ebd6afef4', 0, CAST(N'2021-03-02T15:30:00.373' AS DateTime), N'System', N'C:\local\Temp\tmpA7BB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'88110424-fe50-4e1f-abe1-8d543caecff3', 0, CAST(N'2021-02-12T21:25:19.907' AS DateTime), N'System', N'C:\local\Temp\tmp23BE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'88863c4c-12b7-4c12-9ccd-da45943b6175', 0, CAST(N'2021-03-23T03:34:23.777' AS DateTime), N'System', N'C:\local\Temp\tmpBAF3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'88ac2eab-ff9e-41ed-a938-e0ab5540089b', 0, CAST(N'2021-03-01T18:48:00.480' AS DateTime), N'System', N'C:\local\Temp\tmpA52F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'88c97120-18e4-4c11-983b-3d1e759d2cd0', 0, CAST(N'2021-02-24T17:44:10.383' AS DateTime), N'System', N'C:\local\Temp\tmpD5D3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'890703ed-45f0-4c60-89c8-4dce394d9e53', 0, CAST(N'2021-02-17T15:27:00.367' AS DateTime), N'System', N'C:\local\Temp\tmpD955.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'89337f8b-5fd7-49d5-bb13-f8bae16fe971', 0, CAST(N'2021-03-02T05:18:00.333' AS DateTime), N'System', N'C:\local\Temp\tmp63CE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8951b3e8-784d-489e-9ceb-0bd55b957b18', 0, CAST(N'2021-03-23T00:18:08.927' AS DateTime), N'System', N'C:\local\Temp\tmp17FF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'89878332-dee0-42cf-8290-68f736c4562c', 0, CAST(N'2021-02-25T01:33:14.560' AS DateTime), N'System', N'C:\local\Temp\tmp4613.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'89fb48d5-28cb-4611-a436-187339b76a6c', 0, CAST(N'2021-02-25T01:27:19.550' AS DateTime), N'System', N'C:\local\Temp\tmpD965.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'89fc8d4b-c235-4fa4-ae56-132054c46eed', 0, CAST(N'2021-02-25T01:30:21.953' AS DateTime), N'System', N'C:\local\Temp\tmpA0ED.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8a13d618-cdc8-4713-a9ad-50a7e1af865d', 0, CAST(N'2021-01-06T16:06:04.533' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpAAA3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8a38a079-a533-41a6-b142-a7c2f3cfa002', 0, CAST(N'2021-02-24T18:29:05.800' AS DateTime), N'System', N'C:\local\Temp\tmpF453.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8a7ae6df-f629-4ecb-b50a-7201abfa0122', 0, CAST(N'2021-02-19T17:51:01.223' AS DateTime), N'System', N'C:\local\Temp\tmpC33B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8a95b49d-47e5-4cc2-938e-3ebe050c0287', 0, CAST(N'2021-02-19T23:04:00.367' AS DateTime), N'System', N'C:\local\Temp\tmp4A79.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8aa929ff-e790-485f-b60a-7a2b57570a53', 0, CAST(N'2021-02-25T01:27:22.023' AS DateTime), N'System', N'C:\local\Temp\tmpE30D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8abd5df2-704f-462f-9e78-8e64a8e478a0', 0, CAST(N'2021-02-25T01:26:08.640' AS DateTime), N'System', N'C:\local\Temp\tmpC4DD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8b94bc6d-5dbe-48ec-9a12-8988841f58f4', 0, CAST(N'2021-02-05T23:15:13.233' AS DateTime), N'System', N'C:\local\Temp\tmp4519.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8bba00c1-ecaa-4ee6-b156-2e52719b1424', 0, CAST(N'2021-02-25T01:26:42.960' AS DateTime), N'System', N'C:\local\Temp\tmp4A7D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8bc83106-4bcc-497d-9bc4-7f1feb5f7733', 0, CAST(N'2021-02-25T01:30:50.520' AS DateTime), N'System', N'C:\local\Temp\tmp1056.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8bdb7f80-96f8-45fa-a0e5-6f43e3b90eca', 0, CAST(N'2021-03-04T17:25:12.203' AS DateTime), N'System', N'C:\local\Temp\tmpA7CF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8be04585-6e1d-4d96-ae10-ee821646387e', 0, CAST(N'2020-12-17T03:11:36.463' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpAF39.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8d35420d-dcd5-4592-ba91-8efbb9530ddc', 0, CAST(N'2021-02-25T01:54:19.953' AS DateTime), N'System', N'C:\local\Temp\tmp9322.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8d509492-f2c0-4e74-9c13-1110de7931c8', 0, CAST(N'2021-03-30T17:25:13.760' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp465F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8e00cf1a-b4bb-4507-be1b-2b873ee99154', 0, CAST(N'2021-01-19T21:14:00.750' AS DateTime), N'System', N'C:\local\Temp\tmpA66C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8e2b7aab-7f94-4d5e-8829-1e9c28591d38', 0, CAST(N'2021-02-25T01:26:43.637' AS DateTime), N'System', N'C:\local\Temp\tmp4D2E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8e6ab63e-5c74-4f8d-a300-fad7db934dfa', 0, CAST(N'2021-03-23T00:18:12.870' AS DateTime), N'System', N'C:\local\Temp\tmp2753.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8e92fa32-bb8a-47c5-b950-567c74299b28', 0, CAST(N'2021-02-26T23:09:00.177' AS DateTime), N'System', N'C:\local\Temp\tmpC453.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8e95979f-b91b-43fe-9701-56d29775d8c4', 0, CAST(N'2021-02-25T01:30:12.143' AS DateTime), N'System', N'C:\local\Temp\tmp7AA0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8e97b6cc-de3c-497e-bb66-a16fb80ef3c0', 0, CAST(N'2021-02-25T01:27:56.513' AS DateTime), N'System', N'C:\local\Temp\tmp699D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8eb62335-17f7-4502-a124-a84b6b896165', 0, CAST(N'2021-02-25T01:26:13.180' AS DateTime), N'System', N'C:\local\Temp\tmpD68B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8f0d53ae-4a54-4ac4-9751-0d6c05b9ea5f', 0, CAST(N'2021-02-25T01:31:15.207' AS DateTime), N'System', N'C:\local\Temp\tmp70C9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8fc34c99-d086-4887-8d95-17d50441f3fc', 0, CAST(N'2021-02-25T01:27:20.407' AS DateTime), N'System', N'C:\local\Temp\tmpDC54.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8fdd7d95-6695-4d33-ad1b-41a6fae57338', 0, CAST(N'2021-02-25T01:27:10.423' AS DateTime), N'System', N'C:\local\Temp\tmpB5A5.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'8ff68500-8f9a-4039-a081-d27d7547260f', 0, CAST(N'2021-03-03T23:09:01.613' AS DateTime), N'System', N'C:\local\Temp\tmp2023.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9022c104-ca1b-4d49-85fc-8a5a27535a50', 0, CAST(N'2021-02-19T17:13:05.530' AS DateTime), N'System', N'C:\local\Temp\tmpF7E0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'90237d71-ed35-4106-8102-6ff2aed0a515', 0, CAST(N'2021-02-22T16:42:00.703' AS DateTime), N'System', N'C:\local\Temp\tmp65A6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9034f3d8-fdbf-43ab-9410-40722d2d8f58', 0, CAST(N'2021-03-19T22:04:46.997' AS DateTime), N'System', N'C:\local\Temp\tmpDD14.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'904ecec6-0285-4723-acfa-093a14791593', 0, CAST(N'2021-02-25T01:31:02.187' AS DateTime), N'System', N'C:\local\Temp\tmp3E16.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'906b8c00-194e-4aa0-92cf-cc95e94d1c44', 0, CAST(N'2020-12-17T17:27:50.863' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp993C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'90a88910-50b6-4732-a534-03fd0b19ec12', 0, CAST(N'2021-02-25T01:31:43.260' AS DateTime), N'System', N'C:\local\Temp\tmpDD62.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'90adeeec-d736-4011-8e76-3d3c17158c8c', 0, CAST(N'2021-03-26T21:25:03.787' AS DateTime), N'System', N'C:\local\Temp\tmp9406.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'90e40a92-5ca7-4bfa-8d8e-c127dd46f8aa', 0, CAST(N'2021-03-15T12:53:00.603' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9386.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'91045732-72af-4d56-a521-6dc8ed7d9385', 0, CAST(N'2021-02-25T01:28:46.970' AS DateTime), N'System', N'C:\local\Temp\tmp2E4A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'91312e32-ea8c-4467-8890-7090178ba77f', 0, CAST(N'2021-03-02T15:46:00.240' AS DateTime), N'System', N'C:\local\Temp\tmp4D70.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'91892826-82c5-473f-9392-03927a3fec5a', 0, CAST(N'2021-03-09T16:00:00.520' AS DateTime), N'System', N'C:\local\Temp\tmp4B1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'91c42350-e806-4216-bd4a-bc36349af2c3', 0, CAST(N'2021-02-16T21:02:16.190' AS DateTime), N'System', N'C:\local\Temp\tmp7071.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'91f93401-4cdb-4947-a0b7-fef546a9e749', 0, CAST(N'2021-02-25T01:27:43.023' AS DateTime), N'System', N'C:\local\Temp\tmp3500.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'92202859-5266-45dc-848c-f0ae245c58d7', 0, CAST(N'2021-01-12T15:29:59.100' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'923714f3-7308-4041-82d1-8a972d8cf1c2', 0, CAST(N'2021-02-24T17:44:03.287' AS DateTime), N'System', N'C:\local\Temp\tmpB9CA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'924a4829-048f-4b01-bd65-89e5ecae1ccc', 0, CAST(N'2021-02-04T18:05:07.727' AS DateTime), N'System', N'C:\local\Temp\tmp4BE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9254c524-2e75-46e7-a634-6bebd4488296', 0, CAST(N'2021-02-25T14:15:00.307' AS DateTime), N'System', N'C:\local\Temp\tmpA319.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'925f0b76-40d8-489b-a3b1-b9e2f4bad784', 0, CAST(N'2021-02-25T01:31:00.813' AS DateTime), N'System', N'C:\local\Temp\tmp3849.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9268274b-917f-4dc1-bc23-bb200723b85c', 0, CAST(N'2021-02-04T18:05:06.073' AS DateTime), N'System', N'C:\local\Temp\tmpE7BD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'92de54f8-6ef5-41cc-9edf-026668041cad', 0, CAST(N'2021-02-22T17:01:00.313' AS DateTime), N'System', N'C:\local\Temp\tmpCA3F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9340f3cc-3907-4b01-9ed1-57f891832847', 0, CAST(N'2021-03-08T16:53:00.560' AS DateTime), N'System', N'C:\local\Temp\tmp4401.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'934db2e4-da4c-4fba-8590-278da8a51a75', 0, CAST(N'2021-02-25T01:32:43.787' AS DateTime), N'System', N'C:\local\Temp\tmpCA6C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'935b9f04-d9fb-4710-a7f9-76c437604b46', 0, CAST(N'2021-02-25T01:27:11.127' AS DateTime), N'System', N'C:\local\Temp\tmpB884.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'93637311-d52e-4c64-a50e-e8aab1231200', 0, CAST(N'2021-02-25T01:30:27.207' AS DateTime), N'System', N'C:\local\Temp\tmpB525.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'93868d44-6468-4bfd-a550-43ebb43409fc', 0, CAST(N'2021-02-12T22:18:01.943' AS DateTime), N'System', N'C:\local\Temp\tmp5C8B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'93b298fb-a188-4776-ab0d-1758aecc5ec6', 0, CAST(N'2021-02-23T23:38:00.233' AS DateTime), N'System', N'C:\local\Temp\tmp809A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'93c73ea2-f48a-4a2f-8140-305511989860', 0, CAST(N'2021-02-25T01:31:57.977' AS DateTime), N'System', N'C:\local\Temp\tmp17C6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'942b497b-6d49-45ff-ab4a-50086ded0a3f', 0, CAST(N'2021-02-10T07:35:08.027' AS DateTime), N'System', N'C:\local\Temp\tmp3F70.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'94532cae-f255-474e-8669-a928d0f5a011', 0, CAST(N'2021-02-25T01:29:45.660' AS DateTime), N'System', N'C:\local\Temp\tmp1373.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'956cd000-3dc3-4c93-b922-4016e102b992', 0, CAST(N'2021-03-05T22:14:07.630' AS DateTime), N'System', N'C:\local\Temp\tmp6D0C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9581fcb8-1edb-4e1c-9671-dce7ae1d0083', 0, CAST(N'2021-03-08T17:53:08.223' AS DateTime), N'System', N'C:\local\Temp\tmp3CE6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'95cb9fd2-e0f9-4549-a577-da6cd3da645a', 0, CAST(N'2021-01-15T10:20:00.270' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp8E2C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'95d6f29c-2444-466d-9aac-e26139916783', 0, CAST(N'2021-02-25T01:29:05.697' AS DateTime), N'System', N'C:\local\Temp\tmp774C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'95de0d88-6145-4da0-9f4e-6896d53f4b14', 0, CAST(N'2021-02-25T01:28:44.057' AS DateTime), N'System', N'C:\local\Temp\tmp1D21.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'95f36cc2-b81e-416c-82b3-b9f7c1d77557', 0, CAST(N'2021-02-25T01:29:54.210' AS DateTime), N'System', N'C:\local\Temp\tmp324C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'961ba4e9-658f-4632-9294-d2cc20ab7b7e', 0, CAST(N'2021-02-25T01:29:46.770' AS DateTime), N'System', N'C:\local\Temp\tmp177B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'961e1651-d5e9-4b99-9a46-4f5cd35cbb5b', 0, CAST(N'2021-02-25T01:28:20.923' AS DateTime), N'System', N'C:\local\Temp\tmpC8A1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'962325f6-6a05-4283-9153-a32175b9f0f8', 0, CAST(N'2021-03-03T23:19:00.583' AS DateTime), N'System', N'C:\local\Temp\tmp47B6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'963088ba-db6d-460b-96fe-20392765e9aa', 0, CAST(N'2021-02-25T01:32:53.483' AS DateTime), N'System', N'C:\local\Temp\tmpEF20.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'963913e0-41f1-4abf-addd-c64c869b1a8d', 0, CAST(N'2021-01-12T15:23:00.563' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'963ad9d1-2aea-4b9e-9b85-4b832792c173', 0, CAST(N'2021-02-25T01:26:25.923' AS DateTime), N'System', N'C:\local\Temp\tmp844.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'96572b28-a85f-482d-be8a-86364712e87e', 0, CAST(N'2021-01-28T14:00:06.053' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpDF20.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'966b9ac1-d129-4ab5-a91b-4ef87fca832d', 0, CAST(N'2021-02-25T01:32:34.877' AS DateTime), N'System', N'C:\local\Temp\tmpA71F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'96794fb8-429b-4f00-a624-c1ad42639394', 0, CAST(N'2020-12-17T17:48:06.133' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp22E5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'969f6b15-5ad9-4bf8-9ed3-045947020fed', 0, CAST(N'2021-03-26T21:27:02.360' AS DateTime), N'System', N'C:\local\Temp\tmp68E8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'97595830-ebc7-4f7c-8b76-e81c86a71184', 0, CAST(N'2021-03-04T18:55:00.523' AS DateTime), N'System', N'C:\local\Temp\tmpDE06.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'97b00b93-94b9-464c-b197-636e028a0ce9', 0, CAST(N'2021-03-20T10:52:00.480' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpCD6D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'97bfa846-a89c-49d2-9773-f99b60fd0b28', 0, CAST(N'2021-03-08T16:08:08.010' AS DateTime), N'System', N'C:\local\Temp\tmp2F73.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'97cfe6f1-423c-4a36-8579-3c281ef11e89', 0, CAST(N'2021-02-25T01:32:50.333' AS DateTime), N'System', N'C:\local\Temp\tmpE403.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'98597d2c-1e71-4530-a5d4-53cf74f93b8c', 0, CAST(N'2021-01-06T16:54:06.453' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA436.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'986bff1f-da91-4a2a-a38b-b6d0b7929ff8', 0, CAST(N'2021-02-25T01:27:38.590' AS DateTime), N'System', N'C:\local\Temp\tmp2396.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'98b43fae-cd02-4cfd-8332-c9246d16a4ad', 0, CAST(N'2021-02-06T17:44:10.327' AS DateTime), N'System', N'C:\local\Temp\tmp8A5A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'98b6ab6e-8e27-4f1e-8736-54ebc9720ff6', 0, CAST(N'2021-03-22T23:46:20.207' AS DateTime), N'System', N'C:\local\Temp\tmpF831.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'98b70961-3e43-40b3-9cc5-f1551c879090', 0, CAST(N'2021-02-25T01:29:47.887' AS DateTime), N'System', N'C:\local\Temp\tmp1BF0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'98b9c1bf-2160-4869-8423-4ea9d0188674', 0, CAST(N'2020-12-17T17:28:12.820' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpEF04.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'98b9e451-ff02-4d76-8e82-52fc27fc9121', 0, CAST(N'2021-02-25T01:26:37.297' AS DateTime), N'System', N'C:\local\Temp\tmp348A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'98dae91f-46cd-481a-8cef-25af6294ac78', 0, CAST(N'2021-02-25T01:31:23.620' AS DateTime), N'System', N'C:\local\Temp\tmp9128.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9905f895-8bca-4a86-8e14-1e6dffa54d96', 0, CAST(N'2021-02-19T23:34:00.527' AS DateTime), N'System', N'C:\local\Temp\tmpC104.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'99092000-2ba0-45ad-9030-1cf1861fa95a', 0, CAST(N'2021-03-02T16:01:00.347' AS DateTime), N'System', N'C:\local\Temp\tmp8F3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'990a2968-ebcd-4720-b06a-3926d6ec41c8', 0, CAST(N'2021-01-14T12:01:02.283' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9942cd6f-a4c2-4d51-90fe-6eddd4a20429', 0, CAST(N'2021-02-25T01:28:45.027' AS DateTime), N'System', N'C:\local\Temp\tmp26C6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9960a05b-b78c-4723-8903-3baecda1478b', 0, CAST(N'2021-02-25T01:29:59.723' AS DateTime), N'System', N'C:\local\Temp\tmp4A4E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'996afdf6-be83-4318-8867-014006bb9c33', 0, CAST(N'2021-02-25T01:31:09.877' AS DateTime), N'System', N'C:\local\Temp\tmp5BC6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'997da5e6-1ce8-4936-9ccb-3ade974c6b95', 0, CAST(N'2021-02-25T01:29:06.737' AS DateTime), N'System', N'C:\local\Temp\tmp7B64.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9983dc51-51c0-419a-8f24-1f5568f57d24', 0, CAST(N'2021-03-01T18:29:00.570' AS DateTime), N'System', N'C:\local\Temp\tmp408B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9a2aa380-8fc9-4a4d-9213-2899529bb90a', 0, CAST(N'2021-02-25T01:32:56.473' AS DateTime), N'System', N'C:\local\Temp\tmpFC03.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9a6702a2-341b-4417-b498-9de160e879a6', 0, CAST(N'2021-01-21T17:00:04.837' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9aa23dfc-a7c0-4912-9659-d0213d791464', 0, CAST(N'2021-02-16T21:02:13.217' AS DateTime), N'System', N'C:\local\Temp\tmp6486.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9b03a5e2-fec0-41d2-980a-9d91d1576036', 0, CAST(N'2021-01-15T10:17:00.220' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpCF0B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9b43014e-4b83-4440-a248-186b6038c39a', 0, CAST(N'2021-02-26T23:18:00.283' AS DateTime), N'System', N'C:\local\Temp\tmp1B5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9b627722-bc86-4df4-9a4f-671f3e98684e', 0, CAST(N'2021-01-12T15:24:01.223' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9b67fb35-9f25-4f88-83b0-0f938704b29e', 0, CAST(N'2020-12-17T17:28:11.910' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpEB98.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9b951a91-86f6-4e1b-ab45-fabc45df29a9', 0, CAST(N'2021-01-12T15:32:01.417' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9c03b463-5e18-4125-bb81-ec25ff75b57b', 0, CAST(N'2021-02-25T01:26:48.647' AS DateTime), N'System', N'C:\local\Temp\tmp609E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9c3f0f87-20e8-441d-a92c-c1fc64efb6d5', 0, CAST(N'2021-03-02T17:31:00.313' AS DateTime), N'System', N'C:\local\Temp\tmp6D2B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9c4ace51-76ce-42c6-9e16-8099a7ba0984', 0, CAST(N'2021-02-25T01:26:49.847' AS DateTime), N'System', N'C:\local\Temp\tmp6544.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9c72feda-fe8f-40bd-a36b-70f8421f8afe', 0, CAST(N'2021-02-25T01:28:29.793' AS DateTime), N'System', N'C:\local\Temp\tmpEAE8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9cb3337d-82e0-4e6f-8c3c-79424d1d46c9', 0, CAST(N'2021-02-25T01:26:52.400' AS DateTime), N'System', N'C:\local\Temp\tmp6F89.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9cb6a9cc-c450-4795-9f24-0f4bccc533c9', 0, CAST(N'2021-01-15T12:01:02.103' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9cd43086-47ff-492f-a977-3b256a26177f', 0, CAST(N'2021-01-19T03:50:03.877' AS DateTime), N'System', N'C:\local\Temp\tmpD5DA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9cd94ed5-fee0-4eb1-8f88-0a8ba8317375', 0, CAST(N'2021-01-21T20:12:00.487' AS DateTime), N'System', N'C:\local\Temp\tmp971D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9ce92131-0553-44d7-8a85-2c24d1c1f264', 0, CAST(N'2021-02-25T01:54:11.773' AS DateTime), N'System', N'C:\local\Temp\tmp714C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9d2b24a1-5573-463e-9821-ab4a9716529a', 0, CAST(N'2021-01-14T12:42:01.210' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp376D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9d38ff5f-e70c-420c-a958-248bb40091d7', 0, CAST(N'2021-02-25T01:26:05.647' AS DateTime), N'System', N'C:\local\Temp\tmpA48F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9ddf0609-7d3f-47fe-81fa-b85bc1824fe3', 0, CAST(N'2021-02-12T18:35:17.033' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9e81300f-7424-4f1b-8da2-b380b5e13018', 0, CAST(N'2021-02-25T01:27:59.357' AS DateTime), N'System', N'C:\local\Temp\tmp74AC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9ebece21-3014-4735-9f9f-ebb92439e2d6', 0, CAST(N'2021-02-25T01:38:08.523' AS DateTime), N'System', N'C:\local\Temp\tmpAD80.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9f7ddad3-a250-425d-b63a-71afaeb82f6e', 0, CAST(N'2020-12-17T17:28:24.870' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp1E29.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9fb7ca36-e8be-48ce-9430-e03986d173a6', 0, CAST(N'2020-12-17T17:28:03.967' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpCB47.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'9fc34ab2-3c2e-428e-9684-7593755249e8', 0, CAST(N'2021-02-25T01:28:04.510' AS DateTime), N'System', N'C:\local\Temp\tmp88B7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a001d7ed-2b67-44e5-abaf-500dffc019ac', 0, CAST(N'2021-01-08T12:12:40.037' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp77A7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a06906ae-72b5-4409-82ee-c01e0032942c', 0, CAST(N'2021-02-16T21:02:09.370' AS DateTime), N'System', N'C:\local\Temp\tmp366B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a0855c9e-d51a-498e-9d6c-f964995116fc', 0, CAST(N'2021-02-25T01:30:37.470' AS DateTime), N'System', N'C:\local\Temp\tmpDD37.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a0918a42-e613-489c-9133-fcba5df9804c', 0, CAST(N'2021-02-25T01:27:00.437' AS DateTime), N'System', N'C:\local\Temp\tmp8EC5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a09f7b09-7044-4946-8b49-430be550e154', 0, CAST(N'2020-12-17T17:28:04.847' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpCFFB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a0bc6ae4-818d-4b17-b7fe-4822d46135a5', 0, CAST(N'2021-02-25T01:26:21.833' AS DateTime), N'System', N'C:\local\Temp\tmpF85E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a10e7008-bc11-4c9c-8848-2d6bc61e251d', 0, CAST(N'2021-02-12T18:35:12.823' AS DateTime), N'System', N'C:\local\Temp\tmp628B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a119f8f1-9746-4c55-8ecc-c0ad938d464a', 0, CAST(N'2021-02-25T01:26:30.623' AS DateTime), N'System', N'C:\local\Temp\tmp1A7D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a13d6f50-9c1d-40ca-81ec-e19c1c8c5792', 0, CAST(N'2021-03-22T23:46:23.813' AS DateTime), N'System', N'C:\local\Temp\tmp6B9.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a16b7dd2-e175-4db0-a0c3-b64ec39abe86', 0, CAST(N'2021-02-25T19:31:06.397' AS DateTime), N'System', N'C:\local\Temp\tmpECB6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a1a99d6f-78cc-4ccb-95e5-4896423242a4', 0, CAST(N'2021-03-30T00:46:06.133' AS DateTime), N'System', N'C:\local\Temp\tmp51B9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a1b03a6d-f68a-4aac-9b17-52003d8c2817', 0, CAST(N'2021-02-25T01:26:39.503' AS DateTime), N'System', N'C:\local\Temp\tmp3D38.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a1c8b8a8-ad3e-485a-b298-1960448e52d6', 0, CAST(N'2021-01-06T13:43:01.970' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBF42.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a1fecc18-12a3-4946-977b-1fb80db0910f', 0, CAST(N'2021-01-11T10:27:03.140' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB393.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a26ff884-ded6-45cb-a4e9-a7e7d8040f08', 0, CAST(N'2021-02-25T01:54:41.340' AS DateTime), N'System', N'C:\local\Temp\tmpE09C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a2900ded-746b-4547-bca8-7009b109f628', 0, CAST(N'2021-02-23T20:33:01.310' AS DateTime), N'System', N'C:\local\Temp\tmp2708.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a2da67fd-be1e-4035-b9e6-e4ddea906703', 0, CAST(N'2020-12-17T18:19:20.627' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpC117.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a2df6f83-7654-4645-8c2a-ae99a00cc506', 0, CAST(N'2021-02-25T01:28:13.343' AS DateTime), N'System', N'C:\local\Temp\tmpAB4D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a341165e-9b45-469f-bcd8-94a2ea8d3b98', 0, CAST(N'2021-02-25T01:28:00.173' AS DateTime), N'System', N'C:\local\Temp\tmp77F9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a3413581-ca7f-40ad-8cee-3aac8271c98e', 0, CAST(N'2021-02-04T18:05:09.253' AS DateTime), N'System', N'C:\local\Temp\tmpAEB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a3428bf2-5266-4f94-a96b-d273dd4d8c1c', 0, CAST(N'2021-02-09T19:50:08.077' AS DateTime), N'System', N'C:\local\Temp\tmpCDD6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a371fa53-41a4-43e7-94e4-b49c32548baf', 0, CAST(N'2021-02-16T21:02:12.433' AS DateTime), N'System', N'C:\local\Temp\tmp611A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a3a66bb1-a0af-4aa8-a43a-14715edfe7ce', 0, CAST(N'2021-02-18T14:06:06.160' AS DateTime), N'System', N'C:\local\Temp\tmp7FFB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a3ad24eb-3b58-478a-860b-832d83825c38', 0, CAST(N'2021-02-18T20:55:00.497' AS DateTime), N'System', N'C:\local\Temp\tmpECA5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a3ced9de-49de-4ebe-a0a2-2f73fab4cfa7', 0, CAST(N'2021-02-25T01:32:30.287' AS DateTime), N'System', N'C:\local\Temp\tmp952A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a3e84c94-047c-42b7-8be7-ae07f5af4d2e', 0, CAST(N'2021-01-08T11:32:00.373' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp48BD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a3fd0254-3d81-400f-9f16-0242af539138', 0, CAST(N'2021-02-25T01:54:19.330' AS DateTime), N'System', N'C:\local\Temp\tmp8D25.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a47e3e58-daf9-4d78-9057-dac0fb60913d', 0, CAST(N'2021-02-25T01:27:35.450' AS DateTime), N'System', N'C:\local\Temp\tmp172E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a48199a1-6676-4347-9c72-22dee1b4bf45', 0, CAST(N'2021-02-10T07:34:00.427' AS DateTime), N'System', N'C:\local\Temp\tmp552E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a508b57e-1db0-4305-8a2d-7950a8fea189', 0, CAST(N'2021-01-12T15:30:03.360' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a52c619b-2150-4cb9-baf2-fb4ebc9fa081', 0, CAST(N'2021-02-25T01:28:26.730' AS DateTime), N'System', N'C:\local\Temp\tmpDF2D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a54ce30d-51fe-47bd-a0da-fa0afe134c16', 0, CAST(N'2021-02-24T17:44:07.400' AS DateTime), N'System', N'C:\local\Temp\tmpCA67.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a55ee822-a2f6-4063-8cd4-a2d590722c3e', 0, CAST(N'2021-03-30T02:07:16.843' AS DateTime), N'System', N'C:\local\Temp\tmpB748.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a564780e-3a03-4713-8e2a-0af7edcb6371', 0, CAST(N'2020-12-17T17:27:49.960' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp95D0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a5e697ce-a366-4f6b-93b0-fd48f1a0cc94', 0, CAST(N'2021-02-05T23:15:19.957' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a5fcc446-2fa5-4232-b4a6-9aebab2bd34a', 0, CAST(N'2021-02-25T01:27:50.570' AS DateTime), N'System', N'C:\local\Temp\tmp5236.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a623a193-bec5-4169-b3bc-67b3e6846d8a', 0, CAST(N'2021-02-25T01:32:12.797' AS DateTime), N'System', N'C:\local\Temp\tmp50F1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a69d7daf-4c19-4690-9412-2cec15b36469', 0, CAST(N'2021-02-25T01:27:01.640' AS DateTime), N'System', N'C:\local\Temp\tmp93A9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a6f760b2-b52a-47cd-bf48-3e1610d6d48b', 0, CAST(N'2020-12-17T17:28:10.997' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE6C5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a6f927df-5e8b-4a1a-8656-1ded0aca5437', 0, CAST(N'2021-02-06T17:44:09.997' AS DateTime), N'System', N'C:\local\Temp\tmp8911.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a724aebf-e1cd-4163-96cf-0c3438767419', 0, CAST(N'2021-02-25T01:31:30.347' AS DateTime), N'System', N'C:\local\Temp\tmpABD9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a738496f-82f4-4c39-b988-4ed5c0be7b8f', 0, CAST(N'2021-01-06T16:14:08.727' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp1A34.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a79ee901-d93a-4681-a6ea-e76e1ef96ae4', 0, CAST(N'2021-01-07T11:59:00.223' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA6E5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a811b719-2598-46ac-81ad-cf9af306e886', 0, CAST(N'2021-02-04T18:05:10.193' AS DateTime), N'System', N'C:\local\Temp\tmpE96.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a879be1d-b961-47b5-97c7-46ada85fbe4b', 0, CAST(N'2021-02-04T18:05:07.080' AS DateTime), N'System', N'C:\local\Temp\tmp1EE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a87eb876-68e9-42dc-af20-b8b478d6d587', 0, CAST(N'2021-01-21T16:09:48.880' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a912bcb0-ccbf-4ed0-961b-f083068ab47b', 0, CAST(N'2021-02-25T01:32:14.197' AS DateTime), N'System', N'C:\local\Temp\tmp56BE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a950d693-6269-4e73-9271-17ce2acbb151', 0, CAST(N'2021-03-04T17:08:14.113' AS DateTime), N'System', N'C:\local\Temp\tmp1EDB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a9586d1a-2ecf-44e4-a2b7-88a0cc4368be', 0, CAST(N'2021-01-14T14:08:00.447' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF362.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a9a747a4-9af4-4dbd-a9a0-4a1fecab9bff', 0, CAST(N'2021-03-01T18:26:05.410' AS DateTime), N'System', N'C:\local\Temp\tmp94E2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a9c33dd9-c9d0-4f9e-ace6-35adb03c267a', 0, CAST(N'2021-03-05T22:14:12.693' AS DateTime), N'System', N'C:\local\Temp\tmp80D3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a9d810fe-89fd-45f0-ac6e-04d3a91b8a88', 0, CAST(N'2021-02-22T17:29:00.530' AS DateTime), N'System', N'C:\local\Temp\tmp6C5D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'a9fb0355-887d-40f3-8e8e-d0d3df7f5c74', 0, CAST(N'2021-01-28T21:25:02.467' AS DateTime), N'System', N'C:\local\Temp\tmpF19B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'aa683a86-e276-4619-bad6-72aa761873bc', 0, CAST(N'2021-02-23T20:10:06.253' AS DateTime), N'System', N'C:\local\Temp\tmp1596.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'aa9edf46-c85b-40c3-94d2-a802812d9448', 0, CAST(N'2021-02-25T01:28:01.050' AS DateTime), N'System', N'C:\local\Temp\tmp7B65.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'aaafc913-bbd2-4b66-a3ef-9318c004d629', 0, CAST(N'2021-02-25T01:29:01.400' AS DateTime), N'System', N'C:\local\Temp\tmp6631.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'aae241a2-b768-4849-be95-bdd574613ebd', 0, CAST(N'2021-01-07T16:33:00.850' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp8148.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'aae733d1-2a0b-4256-9b19-a080ab45e78c', 0, CAST(N'2021-02-19T21:36:00.777' AS DateTime), N'System', N'C:\local\Temp\tmpBA99.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'aaf72a8c-b105-45a2-b4eb-bab84f3bc25d', 0, CAST(N'2021-01-06T17:09:01.897' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpD353.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ab1104dd-85d0-402c-ad99-3c0628d1d277', 0, CAST(N'2021-02-25T01:26:30.063' AS DateTime), N'System', N'C:\local\Temp\tmp1888.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ab3902b1-d1df-4f23-a636-62b41420696c', 0, CAST(N'2021-02-25T01:30:05.257' AS DateTime), N'System', N'C:\local\Temp\tmp604C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ab5f8afb-65a2-43cd-94c8-f04280bce2eb', 0, CAST(N'2021-02-25T01:30:58.147' AS DateTime), N'System', N'C:\local\Temp\tmp2E83.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ab9bf2b7-209a-4bbd-9d5d-3ba70d7971e6', 0, CAST(N'2021-01-16T12:01:00.697' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ac13aaba-8c2f-441c-9e93-5ec6bd0fcefe', 0, CAST(N'2021-01-12T15:27:05.677' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ac9b61a4-34aa-4dcd-aa45-783b9db2809f', 0, CAST(N'2021-02-25T01:28:02.813' AS DateTime), N'System', N'C:\local\Temp\tmp81F0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'acae7c92-3d11-4a2d-a20b-47b162cef65e', 0, CAST(N'2020-12-17T17:28:13.787' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF29F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ad1c23a1-aced-41f2-b78f-059f3f602e41', 0, CAST(N'2021-02-25T01:26:44.310' AS DateTime), N'System', N'C:\local\Temp\tmp4FAF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ad2c6f51-4135-4bbe-a894-7909afdaaf23', 0, CAST(N'2021-03-11T16:35:18.463' AS DateTime), N'System', N'C:\local\Temp\tmp2AE7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ad5ff650-3ea6-41cf-922e-bb9c450f7153', 0, CAST(N'2021-02-04T18:05:11.890' AS DateTime), N'System', N'C:\local\Temp\tmp15AD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ad6df9c0-e87f-4279-a7ec-0b9662fab98b', 0, CAST(N'2021-02-25T01:38:01.093' AS DateTime), N'System', N'C:\local\Temp\tmpA521.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'adaa952f-8969-43e3-b58e-cae3297da241', 0, CAST(N'2021-02-25T01:31:47.813' AS DateTime), N'System', N'C:\local\Temp\tmpEF47.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'adb0540c-097c-46a0-91b2-1ba11902740d', 0, CAST(N'2020-12-17T17:28:07.000' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpD6E2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ae1ad74b-a58d-4205-b2fc-4b4b81fd389a', 0, CAST(N'2021-02-25T01:28:28.717' AS DateTime), N'System', N'C:\local\Temp\tmpE6E0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ae9d243d-6aaf-41f1-a896-7a83ff9359df', 0, CAST(N'2021-02-12T21:25:15.900' AS DateTime), N'System', N'C:\local\Temp\tmp139C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ae9f1c6c-f6ef-46ad-a27f-0e31fb33a6f2', 0, CAST(N'2021-03-02T19:07:00.437' AS DateTime), N'System', N'C:\local\Temp\tmp4FBC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'af419c43-a946-4094-8318-6c10d08534a6', 0, CAST(N'2021-02-24T17:44:08.937' AS DateTime), N'System', N'C:\local\Temp\tmpCFD7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'af52059e-d1fb-46b8-8581-b56c0c5d6e4e', 0, CAST(N'2021-03-23T00:18:09.390' AS DateTime), N'System', N'C:\local\Temp\tmp1958.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'af6cf38e-7014-433c-9064-fc06bafeb947', 0, CAST(N'2021-03-08T16:11:18.040' AS DateTime), N'System', N'C:\local\Temp\tmp1596.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'afa2ee14-6676-4e51-bdbe-158e8e7e8c86', 0, CAST(N'2021-02-23T20:25:00.517' AS DateTime), N'System', N'C:\local\Temp\tmpD118.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'afbdd9b3-eb19-4e09-8fe6-ddad9fd21782', 0, CAST(N'2021-02-25T01:28:23.823' AS DateTime), N'System', N'C:\local\Temp\tmpD3C0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b031f0ab-0552-418d-a8bb-c92fa32d5646', 0, CAST(N'2021-02-09T15:36:01.527' AS DateTime), N'System', N'C:\local\Temp\tmp42E1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b06f17fa-2aab-41ee-aa41-1d19deab80c8', 0, CAST(N'2021-01-08T15:19:38.030' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp985E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b0bd9887-4ecd-4b0a-9bea-ed82a5d80c79', 0, CAST(N'2020-12-17T03:20:56.277' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB376.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b0c00a8f-4550-44b1-b3bd-02389a7f8a60', 0, CAST(N'2021-03-01T15:42:00.507' AS DateTime), N'System', N'C:\local\Temp\tmp5E61.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b0c8eca0-7b3e-4d62-b1b3-9e7338a46669', 0, CAST(N'2020-12-17T17:28:02.753' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpC7BB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b0e7d958-d6e3-4895-9f23-5fc1b451a515', 0, CAST(N'2021-01-13T12:35:00.477' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7C8E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b0ea0457-d864-40c2-bd58-0ae2241cb211', 0, CAST(N'2021-02-25T01:27:54.873' AS DateTime), N'System', N'C:\local\Temp\tmp6381.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b18d20e9-73c5-416a-ba68-320787b489c9', 0, CAST(N'2021-02-25T01:31:34.810' AS DateTime), N'System', N'C:\local\Temp\tmpBD32.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b1914c52-a0d4-4342-9267-c358ce5303cb', 0, CAST(N'2021-02-04T17:56:08.053' AS DateTime), N'System', N'C:\local\Temp\tmpAA6F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b195547f-c4c3-4378-afa7-64e28a68a97a', 0, CAST(N'2021-02-25T01:26:14.337' AS DateTime), N'System', N'C:\local\Temp\tmpDA27.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b1bbb319-bbeb-4bc4-82d4-e7eff1b39495', 0, CAST(N'2021-02-24T01:39:05.697' AS DateTime), N'System', N'C:\local\Temp\tmp599D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b1c56270-c2eb-4e70-bb28-51c4cb738958', 0, CAST(N'2021-02-25T01:27:07.587' AS DateTime), N'System', N'C:\local\Temp\tmpAAB5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b1d761ab-02dd-42aa-bd2e-a8134a4dea9a', 0, CAST(N'2021-03-23T00:18:01.227' AS DateTime), N'System', N'C:\local\Temp\tmpF94A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b2210a4f-9944-4c80-986c-67a2f234370d', 0, CAST(N'2021-02-22T17:05:01.353' AS DateTime), N'System', N'C:\local\Temp\tmp77DA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b24c9db2-ec6a-4424-9741-6c18b70a9d96', 0, CAST(N'2021-02-25T01:30:56.837' AS DateTime), N'System', N'C:\local\Temp\tmp2971.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b26ee67a-40cc-43be-82d1-dc8318744e4d', 0, CAST(N'2021-02-25T01:54:45.193' AS DateTime), N'System', N'C:\local\Temp\tmpEF73.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b2b10ccf-2935-42d7-a3da-06a926a16746', 0, CAST(N'2021-02-18T14:27:00.407' AS DateTime), N'System', N'C:\local\Temp\tmpB911.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b2f23d2a-e921-4d6a-92ab-68c57f1adb47', 0, CAST(N'2021-02-05T23:37:25.793' AS DateTime), N'System', N'C:\local\Temp\tmp847E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b31e94f4-5a6f-4a78-8405-1d5d77b70362', 0, CAST(N'2021-03-30T17:24:01.400' AS DateTime), N'System', N'C:\local\Temp\tmpEFD5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b33df359-89d2-45dc-a3d0-6261a20ea73e', 0, CAST(N'2021-03-03T23:23:05.907' AS DateTime), N'System', N'C:\local\Temp\tmp6A5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b37eb782-447b-45ad-ad88-a6fa1f90c543', 0, CAST(N'2021-01-28T21:25:02.147' AS DateTime), N'System', N'C:\local\Temp\tmpF052.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b3abae5a-26b8-44ce-af0b-018671dfdbe8', 0, CAST(N'2021-03-02T18:12:00.230' AS DateTime), N'System', N'C:\local\Temp\tmpF5E3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b3ee3a54-e144-43e5-ad2c-cc4497c2e80e', 0, CAST(N'2021-02-25T01:26:34.973' AS DateTime), N'System', N'C:\local\Temp\tmp2B8D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b42b7b21-c143-447a-9d16-0bbb96879e25', 0, CAST(N'2021-02-25T01:38:09.427' AS DateTime), N'System', N'C:\local\Temp\tmpC5DC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b438fb63-e36b-4ceb-a183-9565bddad56f', 0, CAST(N'2021-02-25T01:29:19.567' AS DateTime), N'System', N'C:\local\Temp\tmpADAB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b4459be6-a6eb-4efe-9ed4-3a221af702d6', 0, CAST(N'2021-02-25T01:26:49.203' AS DateTime), N'System', N'C:\local\Temp\tmp6320.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b4c4ab3f-8001-4428-b879-de06f906b24d', 0, CAST(N'2021-01-21T18:18:00.373' AS DateTime), N'System', N'C:\local\Temp\tmp3869.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b4d41a14-32b3-4fac-a6cd-19a1c8bc2882', 0, CAST(N'2021-03-04T17:08:05.993' AS DateTime), N'System', N'C:\local\Temp\tmpE981.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b4e84031-70b9-44f5-8327-ccfd87c58359', 0, CAST(N'2021-02-19T21:53:00.317' AS DateTime), N'System', N'C:\local\Temp\tmp4ADE.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b50abaf7-ec96-4b44-aaf9-2ccddaec9751', 0, CAST(N'2021-02-23T23:23:00.227' AS DateTime), N'System', N'C:\local\Temp\tmpC536.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b571d6f9-491d-4a3a-bf98-7f2be25fc295', 0, CAST(N'2021-01-17T12:01:02.337' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b58111e6-ef95-45e0-826c-f3d81127cce1', 0, CAST(N'2021-03-20T16:14:01.243' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9E05.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b5a53818-c441-496a-b58e-0b4d90458168', 0, CAST(N'2021-02-06T17:44:08.927' AS DateTime), N'System', N'C:\local\Temp\tmp846B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b5a589e9-1fbe-4d0c-9382-091b227cfcd8', 0, CAST(N'2021-02-25T01:27:48.920' AS DateTime), N'System', N'C:\local\Temp\tmp4BFA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b5d5b02b-cf5f-4d94-92a7-8e835db7fd9a', 0, CAST(N'2021-02-08T23:25:02.980' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b642e481-d768-491d-99c7-df5549f5f87f', 0, CAST(N'2021-03-03T23:23:00.533' AS DateTime), N'System', N'C:\local\Temp\tmpF147.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b6e21e2b-b344-4ed7-a857-8d47d463ce02', 0, CAST(N'2021-01-21T16:55:12.360' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b731286e-e230-4be2-808e-9c98352f8c2a', 0, CAST(N'2021-02-02T01:26:16.777' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b760b396-a82a-4bf0-9ad9-1fd6fd53f019', 0, CAST(N'2021-02-26T23:51:01.400' AS DateTime), N'System', N'C:\local\Temp\tmp37AD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b78b3091-0c30-4081-8fb6-f6d1af9fb6b2', 0, CAST(N'2021-02-25T01:27:39.350' AS DateTime), N'System', N'C:\local\Temp\tmp2695.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b7f01219-fcc0-4cca-9c3e-f7186baf3bed', 0, CAST(N'2021-02-25T01:31:26.420' AS DateTime), N'System', N'C:\local\Temp\tmp9C65.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b7f9825d-46d9-4f66-b56a-18edfa6eac54', 0, CAST(N'2021-02-24T00:07:00.707' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b7fb5a76-15f4-491b-a808-151372229a71', 0, CAST(N'2021-03-02T05:03:00.597' AS DateTime), N'System', N'C:\local\Temp\tmpA877.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b80a0679-018b-4c10-95f2-994237837284', 0, CAST(N'2021-01-12T15:25:01.293' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b86ece66-8199-411d-acd6-023ca8f2f3c5', 0, CAST(N'2021-01-21T17:15:33.023' AS DateTime), N'System', N'C:\local\Temp\tmpA4D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b89bd832-c5bb-4789-9684-c021fa252e85', 0, CAST(N'2021-02-10T07:36:00.290' AS DateTime), N'System', N'C:\local\Temp\tmp29D1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b8c23e1a-2360-4f96-9699-c78f2a439bf9', 0, CAST(N'2021-02-10T07:40:00.327' AS DateTime), N'System', N'C:\local\Temp\tmpD365.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b8fd906b-2353-4989-a99f-4c439d2f0a9c', 0, CAST(N'2021-02-25T01:30:01.970' AS DateTime), N'System', N'C:\local\Temp\tmp530A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b95437fc-7675-4d2c-b007-6895e20289e0', 0, CAST(N'2021-01-08T11:29:06.443' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp89AC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b9817366-227c-4ab1-84fa-053b5565e3b1', 0, CAST(N'2020-12-17T18:19:05.240' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp80BC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b98327d8-e9ca-4382-aacc-a047b97a9e90', 0, CAST(N'2021-02-25T01:29:07.803' AS DateTime), N'System', N'C:\local\Temp\tmp7FBA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b9bf2e58-f788-4f47-a346-bca7ddc082cd', 0, CAST(N'2021-02-25T01:30:34.823' AS DateTime), N'System', N'C:\local\Temp\tmpD2E4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'b9f4d89e-5f37-4a16-b90a-8478619596d0', 0, CAST(N'2021-02-25T01:29:11.033' AS DateTime), N'System', N'C:\local\Temp\tmp8C31.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ba390286-bae1-4436-9cc8-918d321482ea', 0, CAST(N'2021-03-26T10:23:24.617' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpEFD9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ba996119-9cca-4ffb-971f-d9d2d99088f1', 0, CAST(N'2021-02-25T01:31:08.537' AS DateTime), N'System', N'C:\local\Temp\tmp56C4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'baa19319-b462-42b4-ab36-c24d27aba842', 0, CAST(N'2021-01-18T16:40:05.190' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7A1E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bac6bfb9-e0ba-4d9a-975e-89c8f15f80b3', 0, CAST(N'2021-02-18T20:34:00.550' AS DateTime), N'System', N'C:\local\Temp\tmpB2FC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bacc5587-d087-4277-87ee-c00bb934d516', 0, CAST(N'2021-02-25T01:54:45.483' AS DateTime), N'System', N'C:\local\Temp\tmpF7B1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bbc902f8-3671-4f06-a70b-553cc936b096', 0, CAST(N'2021-02-25T01:26:44.953' AS DateTime), N'System', N'C:\local\Temp\tmp526F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bbfa737a-a04d-43e1-b0fa-6c9ac4dc6d9f', 0, CAST(N'2021-03-04T19:14:00.617' AS DateTime), N'System', N'C:\local\Temp\tmp42D9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bc10aab8-5456-43ca-8224-8c9e9e03d7da', 0, CAST(N'2021-02-25T01:31:40.250' AS DateTime), N'System', N'C:\local\Temp\tmpD273.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bc15d2c4-b106-41ec-a1c1-91749527dde9', 0, CAST(N'2021-03-09T16:09:00.593' AS DateTime), N'System', N'C:\local\Temp\tmp41D4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bc4ac77d-de36-4b82-9763-c8a0372be3ed', 0, CAST(N'2021-02-25T01:29:49.017' AS DateTime), N'System', N'C:\local\Temp\tmp2066.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bc7effce-56df-4410-80d4-8dfdeb393bd4', 0, CAST(N'2020-12-17T17:41:13.537' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpC5EF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bc9833ed-208b-4a19-9afc-17e2a4924b2f', 0, CAST(N'2021-02-25T01:27:42.233' AS DateTime), N'System', N'C:\local\Temp\tmp300E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bcb290c4-0c12-448e-918e-d5e6c961546d', 0, CAST(N'2021-02-04T17:56:09.913' AS DateTime), N'System', N'C:\local\Temp\tmpCFDB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bcb3e86c-9a28-4ded-abed-d6e5d25bf92a', 0, CAST(N'2021-03-30T17:13:04.513' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp751E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bcc20407-9ac7-4f0c-9ab6-dc69e7f66f4f', 0, CAST(N'2021-02-18T17:30:00.373' AS DateTime), N'System', N'C:\local\Temp\tmp40C9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bcca0323-4e79-440f-9fe2-52afc510b81a', 0, CAST(N'2021-02-23T20:44:01.053' AS DateTime), N'System', N'C:\local\Temp\tmp3853.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bcdc85cb-79df-4eed-a187-a93a13196461', 0, CAST(N'2021-02-22T16:45:01.080' AS DateTime), N'System', N'C:\local\Temp\tmp273C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bcfd6044-9409-426b-a9ae-270abe5f5660', 0, CAST(N'2021-02-25T01:32:47.360' AS DateTime), N'System', N'C:\local\Temp\tmpD5A9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bd6ace0c-ec56-43e6-8466-079e5879a97f', 0, CAST(N'2021-01-11T14:55:00.217' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF980.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'be757003-5c7a-4dd7-a1e2-9283ed4662e1', 0, CAST(N'2021-03-04T17:25:07.440' AS DateTime), N'System', N'C:\local\Temp\tmp9512.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'be7bb439-89b7-48f2-9bd7-32771cf75f07', 0, CAST(N'2021-02-25T01:29:14.193' AS DateTime), N'System', N'C:\local\Temp\tmp9898.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bed80064-c5df-41cb-9899-7b91dc505eb7', 0, CAST(N'2021-03-30T17:30:50.523' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp5813.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bf34c657-a4b1-432d-babc-3d72038b49be', 0, CAST(N'2021-01-06T16:35:06.230' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF371.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bf8a5dc4-e6b7-4b30-9e53-b10c73f535f3', 0, CAST(N'2020-12-17T17:30:50.870' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp5089.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bfb8056d-9f8e-4970-bf44-31de699b2700', 0, CAST(N'2021-01-13T14:56:00.277' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9311.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bfc5d8be-c06d-4174-959f-a3854e41776e', 0, CAST(N'2021-03-03T21:39:00.607' AS DateTime), N'System', N'C:\local\Temp\tmpBBC8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bfcaa740-b15c-4b37-9b04-57307bbda98e', 0, CAST(N'2021-03-23T00:21:02.257' AS DateTime), N'System', N'C:\local\Temp\tmpBC4D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'bfd2984e-4d47-404b-9894-54311c0ad51a', 0, CAST(N'2021-02-24T18:29:07.713' AS DateTime), N'System', N'C:\local\Temp\tmpFBB7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c0120f8b-2448-4e0f-afac-819dc419062c', 0, CAST(N'2020-12-17T17:27:51.763' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9CC7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c01cb184-b0fd-4d86-9ff0-770c57043303', 0, CAST(N'2021-03-22T23:46:24.183' AS DateTime), N'System', N'C:\local\Temp\tmp831.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c04ae5b9-238e-4fd2-9fdc-bf5de4ecf70e', 0, CAST(N'2021-02-12T18:35:14.847' AS DateTime), N'System', N'C:\local\Temp\tmp6C16.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c06e8448-8edc-4ba2-8ece-13a6b378f829', 0, CAST(N'2021-03-22T23:46:11.953' AS DateTime), N'System', N'C:\local\Temp\tmpD7D4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c0a1bac6-45a5-466f-9b04-f98019df286c', 0, CAST(N'2021-02-16T21:02:15.943' AS DateTime), N'System', N'C:\local\Temp\tmp6A36.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c0bd579e-46af-4452-820c-baa06937cc8c', 0, CAST(N'2021-03-08T16:08:00.750' AS DateTime), N'System', N'C:\local\Temp\tmp11C8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c1141064-4433-4b04-a6f0-72e8e2714fc6', 0, CAST(N'2021-03-09T17:18:00.477' AS DateTime), N'System', N'C:\local\Temp\tmp6C9D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c1464362-347a-4536-b068-7f6988e1ec39', 0, CAST(N'2021-02-25T01:31:22.227' AS DateTime), N'System', N'C:\local\Temp\tmp8BA9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c15e9c38-a6cb-45e2-8aa5-5c3a4b1da92f', 0, CAST(N'2021-02-16T21:02:12.027' AS DateTime), N'System', N'C:\local\Temp\tmp5FF0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c166d6ce-fbe5-4ab5-99bf-624bcd07d7ce', 0, CAST(N'2021-03-23T00:18:13.623' AS DateTime), N'System', N'C:\local\Temp\tmp2A24.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c1830d35-e934-413d-adac-d846497adf0d', 0, CAST(N'2021-02-19T06:16:00.440' AS DateTime), N'System', N'C:\local\Temp\tmp8011.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c1aca9e2-a776-426f-8701-fb283827f93e', 0, CAST(N'2021-02-25T01:38:20.603' AS DateTime), N'System', N'C:\local\Temp\tmpF1A2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c1be3d1b-e8d5-421f-89fb-fab0ab2d7141', 0, CAST(N'2021-02-25T01:29:02.483' AS DateTime), N'System', N'C:\local\Temp\tmp6A68.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c1f0193c-582a-4d79-98e2-524949813197', 0, CAST(N'2021-03-02T15:52:00.403' AS DateTime), N'System', N'C:\local\Temp\tmpCB92.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c203e3b6-258b-4e14-8486-61c71b17de08', 0, CAST(N'2021-02-25T01:27:37.797' AS DateTime), N'System', N'C:\local\Temp\tmp20A7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c27a8efc-1d49-4270-9b3e-44631f521281', 0, CAST(N'2021-02-25T01:26:24.890' AS DateTime), N'System', N'C:\local\Temp\tmp43B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c28faa64-2e38-43bf-a43a-2ad9db804fc7', 0, CAST(N'2021-02-25T01:26:29.053' AS DateTime), N'System', N'C:\local\Temp\tmp14AE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c29226fa-f9e8-4dd4-bbfa-145888f13914', 0, CAST(N'2021-02-25T01:29:03.600' AS DateTime), N'System', N'C:\local\Temp\tmp6EAF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c2b8a6f7-d415-4456-b2a6-e67a76cfb96f', 0, CAST(N'2021-02-25T01:31:52.223' AS DateTime), N'System', N'C:\local\Temp\tmpDE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c2e12802-9e57-43ca-aea6-e49b7786de1d', 0, CAST(N'2021-02-02T21:22:02.493' AS DateTime), N'System', N'C:\local\Temp\tmpD7B3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c2e85237-e839-49fe-899e-fc2204c87d36', 0, CAST(N'2021-03-04T19:22:00.563' AS DateTime), N'System', N'C:\local\Temp\tmp95BB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c3001f99-d6dc-4ce7-aac8-9ee70727a85f', 0, CAST(N'2021-01-15T10:52:00.533' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpDA10.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c30a4092-bd36-49dd-931d-0389f66a5c12', 0, CAST(N'2021-02-16T21:02:14.320' AS DateTime), N'System', N'C:\local\Temp\tmp68DE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c33f5206-756a-4c68-8a06-3faae21e9bc9', 0, CAST(N'2021-03-02T18:52:00.360' AS DateTime), N'System', N'C:\local\Temp\tmp9459.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c3b824c8-e603-4c27-9301-88c57ca8f479', 0, CAST(N'2021-02-25T01:26:46.163' AS DateTime), N'System', N'C:\local\Temp\tmp5724.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c3fa7db2-8a2c-45d9-8462-edebd9b28e17', 0, CAST(N'2021-02-25T01:32:51.737' AS DateTime), N'System', N'C:\local\Temp\tmpE982.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c40bb3be-4e7d-4286-beca-ea755dac6953', 0, CAST(N'2021-02-25T01:28:15.193' AS DateTime), N'System', N'C:\local\Temp\tmpB273.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c4c08c36-db48-4a18-a88f-aa75ae10058c', 0, CAST(N'2021-02-25T01:29:35.637' AS DateTime), N'System', N'C:\local\Temp\tmpEC2B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c4c73c26-8eec-4a6d-b754-f7a32831c5dc', 0, CAST(N'2021-02-06T17:44:13.967' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c4ffa7a9-6817-4cbe-9db0-939ee1a37507', 0, CAST(N'2021-02-25T01:26:34.433' AS DateTime), N'System', N'C:\local\Temp\tmp2959.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c51b081a-3dd2-42b1-a683-ab27e1a070a6', 0, CAST(N'2021-01-13T19:15:01.277' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB174.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c5394ee0-cda7-4f0e-905b-c2cbafeb0bb4', 0, CAST(N'2020-12-17T18:19:03.673' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp712A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c57e8e03-eb72-486d-9bfb-debbc061f11c', 0, CAST(N'2021-02-25T01:26:19.360' AS DateTime), N'System', N'C:\local\Temp\tmpEEC4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c63dec5e-190e-435a-9967-734b282d7e21', 0, CAST(N'2021-03-02T16:43:00.357' AS DateTime), N'System', N'C:\local\Temp\tmp7BFE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c6429f6b-2eae-4317-8f12-8ffd343a7fd3', 0, CAST(N'2021-02-24T07:25:00.350' AS DateTime), N'System', N'C:\local\Temp\tmp64C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c65c4811-32f1-4632-b854-a80107548bac', 0, CAST(N'2021-03-01T15:49:00.367' AS DateTime), N'System', N'C:\local\Temp\tmpC6F4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c6f3ac49-01f2-42ec-b1da-c916daffd32e', 0, CAST(N'2021-02-12T21:25:04.820' AS DateTime), N'System', N'C:\local\Temp\tmpE7E1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c77ec099-afdd-4fc9-aaa1-ade2adbb6f4c', 0, CAST(N'2021-02-24T07:13:00.260' AS DateTime), N'System', N'C:\local\Temp\tmpA19.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c79120a4-86e6-4598-8f17-c12708b42b6e', 0, CAST(N'2021-02-05T20:55:12.613' AS DateTime), N'System', N'C:\local\Temp\tmp1609.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c798c431-8079-49bc-8a8d-4a13b8bff501', 0, CAST(N'2021-01-07T15:52:00.260' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF7F4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c7ef5d67-af69-4a6c-9c2a-139ccc519f4f', 0, CAST(N'2021-02-25T01:26:50.493' AS DateTime), N'System', N'C:\local\Temp\tmp67C5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c8614d1e-f31a-46fd-a88c-aebd7e26c0bf', 0, CAST(N'2021-02-06T17:44:00.593' AS DateTime), N'System', N'C:\local\Temp\tmp64B8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c88e29b1-7e28-4f51-b604-eea1881373b8', 0, CAST(N'2021-01-19T17:34:00.787' AS DateTime), N'System', N'C:\local\Temp\tmp3A5E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c8c07108-94b6-417b-b70d-42a08efe0bc7', 0, CAST(N'2021-03-09T15:42:00.417' AS DateTime), N'System', N'C:\local\Temp\tmp8A1D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c916a6db-84d0-4218-8a38-e18bfc656cb8', 0, CAST(N'2021-02-26T23:58:01.757' AS DateTime), N'System', N'C:\local\Temp\tmpA1D5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c990c827-c90c-4786-8ded-d95548f570cb', 0, CAST(N'2021-02-12T17:58:05.233' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c9a36a2e-f242-44dc-a033-7d55eb8d562d', 0, CAST(N'2021-03-23T00:18:05.453' AS DateTime), N'System', N'C:\local\Temp\tmpA14.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'c9f5e634-f612-4ff8-be21-4c9c82da8ea2', 0, CAST(N'2021-01-06T16:54:01.883' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9C94.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ca5fa3ab-3d08-4450-b497-82bd18e4f3c2', 0, CAST(N'2020-12-17T18:17:02.927' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9C89.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ca7674cf-c884-4232-a6c4-1a5556e1db05', 0, CAST(N'2021-02-25T01:32:28.657' AS DateTime), N'System', N'C:\local\Temp\tmp8E82.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cacb04c2-2b45-4f6b-87d6-404725542acd', 0, CAST(N'2021-02-08T21:00:02.717' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cbb8bcae-0019-4a5b-a16a-46dbfc9fa2a5', 0, CAST(N'2021-01-06T18:02:03.373' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp5930.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cca75b51-f3fd-4fad-a22a-1eb23958b258', 0, CAST(N'2021-02-16T17:56:00.490' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ccc5a7d0-bec2-464e-a8f6-d9b230fff115', 0, CAST(N'2021-02-18T17:27:07.783' AS DateTime), N'System', N'C:\local\Temp\tmp9EA6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ccd563da-f7e6-4885-ab4a-4d9cccc6fc1e', 0, CAST(N'2021-02-25T01:26:10.560' AS DateTime), N'System', N'C:\local\Temp\tmpCC25.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ccf9205a-6b0d-4b5b-b4d3-df693f356a58', 0, CAST(N'2021-03-02T16:32:00.317' AS DateTime), N'System', N'C:\local\Temp\tmp69FB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cd9802a8-01ad-4083-b1c0-e535eb58c703', 0, CAST(N'2021-02-25T01:26:10.043' AS DateTime), N'System', N'C:\local\Temp\tmpCA3F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cdcb0dfa-d41e-4f95-acbb-8112d150c506', 0, CAST(N'2021-02-25T01:26:47.453' AS DateTime), N'System', N'C:\local\Temp\tmp5BCA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cdd2e41c-dbe0-4029-b1c1-a5982274daf6', 0, CAST(N'2021-02-25T01:26:12.737' AS DateTime), N'System', N'C:\local\Temp\tmpD4F4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cdfd10d2-d838-447a-90e0-ff8ca879ee41', 0, CAST(N'2021-02-05T23:37:34.517' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ce1c9b6a-cc41-4edb-961d-664c7bb99df4', 0, CAST(N'2021-03-16T14:59:05.447' AS DateTime), N'System', N'C:\local\Temp\tmp4EEB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ce6388fc-fdf5-426e-835b-3d1184a4dd6c', 0, CAST(N'2021-02-02T21:40:02.133' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ceb9b983-8626-42de-bd4b-e9bdba997f88', 0, CAST(N'2021-03-01T22:36:00.643' AS DateTime), N'System', N'C:\local\Temp\tmp5F10.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cee73c61-45ee-4695-ac99-521ef96516e6', 0, CAST(N'2021-02-25T01:54:12.513' AS DateTime), N'System', N'C:\local\Temp\tmp7621.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cf389ecd-6c4c-4856-8d12-f47cb1d1592c', 0, CAST(N'2021-03-02T04:45:00.507' AS DateTime), N'System', N'C:\local\Temp\tmp2DC6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cf708207-8216-4d84-b763-e20b59e6c5a5', 0, CAST(N'2020-12-17T18:12:00.250' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp89E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'cfc526aa-1e9d-4d6c-a6ee-d42c0b1f54b6', 0, CAST(N'2021-03-09T12:43:04.473' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp77A3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd03c8a7a-2dc7-4473-82f4-9b7f3fabeb97', 0, CAST(N'2021-03-04T17:25:00.630' AS DateTime), N'System', N'C:\local\Temp\tmp79E7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd0606ce7-4aa6-4851-81d9-599f49af0748', 0, CAST(N'2021-02-25T01:29:41.083' AS DateTime), N'System', N'C:\local\Temp\tmp12F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd07765f6-a579-4bc5-be51-1b90d8d6df9b', 0, CAST(N'2021-02-22T17:05:00.610' AS DateTime), N'System', N'C:\local\Temp\tmp73C2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd08d55e0-32ea-4297-bc37-a187721507cd', 0, CAST(N'2021-02-25T01:28:05.340' AS DateTime), N'System', N'C:\local\Temp\tmp8BE5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd093dfb6-0c9f-48b7-8bbb-ea40eb138cad', 0, CAST(N'2021-03-30T23:09:06.590' AS DateTime), N'System', N'C:\local\Temp\tmpC430.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd1534566-e7a7-447d-8245-9f4beb6af64a', 0, CAST(N'2021-03-02T17:19:00.267' AS DateTime), N'System', N'C:\local\Temp\tmp7106.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd19ca6d6-1a47-4515-ab55-ef388b2d7edc', 0, CAST(N'2021-02-25T01:31:33.417' AS DateTime), N'System', N'C:\local\Temp\tmpB745.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd223fa53-4bb2-4ae8-a5f4-3c78b101e295', 0, CAST(N'2021-02-25T01:28:17.023' AS DateTime), N'System', N'C:\local\Temp\tmpB96B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd266f852-24f6-4f52-9259-a3db24387b8d', 0, CAST(N'2021-01-19T11:13:07.170' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB1C5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd27331c5-dbd9-47d2-b6e2-9acf43db819c', 0, CAST(N'2021-01-14T12:01:00.383' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd2d972dd-4bc2-4c52-9232-7747fcf06444', 0, CAST(N'2020-12-17T17:28:09.780' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE2DC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd302187d-ca3f-41c8-a084-b73f37813322', 0, CAST(N'2021-03-04T17:08:18.973' AS DateTime), N'System', N'C:\local\Temp\tmp3206.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd3ad7fb3-0161-4e73-82a7-404501b7683c', 0, CAST(N'2021-02-25T01:27:18.793' AS DateTime), N'System', N'C:\local\Temp\tmpD676.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd3d8aca3-d44f-4b84-a936-7e2e82fb4234', 0, CAST(N'2021-02-25T01:32:31.857' AS DateTime), N'System', N'C:\local\Temp\tmp9B55.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd3ebae77-766f-4153-a1cd-d0d331ed74e6', 0, CAST(N'2021-03-22T23:46:09.037' AS DateTime), N'System', N'C:\local\Temp\tmpACCA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd3f3d43d-71fa-4cee-bee1-b01af08e281c', 0, CAST(N'2020-12-17T16:33:22.027' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA882.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd4106d94-70d5-460f-88f0-8bafa336c089', 0, CAST(N'2021-02-25T01:31:28.980' AS DateTime), N'System', N'C:\local\Temp\tmpA6B8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd4150a50-767b-46b2-8633-1e62414269d0', 0, CAST(N'2020-12-17T17:28:01.850' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpC317.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd45613d6-4a20-4968-84a1-f6173d4b3ba7', 0, CAST(N'2021-02-22T16:42:01.793' AS DateTime), N'System', N'C:\local\Temp\tmp6B16.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd45ba048-938f-48ea-ae7d-fa2ae39b17dc', 0, CAST(N'2021-03-26T08:43:44.983' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA608.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd47fbaa3-59a4-49ac-a67a-ce3af1cbbee7', 0, CAST(N'2021-01-11T14:35:00.367' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpAA1D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd494c48a-92cf-4569-adcf-01a95a91e935', 0, CAST(N'2021-03-01T18:13:01.353' AS DateTime), N'System', N'C:\local\Temp\tmp9AB5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd497f545-8b22-4eda-a37d-56024da04d7c', 0, CAST(N'2021-03-02T05:16:00.300' AS DateTime), N'System', N'C:\local\Temp\tmp8F0C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd4f2a83a-6e66-4828-8c1e-2e33fe555d19', 0, CAST(N'2021-02-22T17:01:01.047' AS DateTime), N'System', N'C:\local\Temp\tmpCD2F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd4f2b7e4-baf0-435d-9d37-ddaba3a3b5bc', 0, CAST(N'2021-01-19T17:58:05.007' AS DateTime), N'System', N'C:\local\Temp\tmp338F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd517def0-8c0f-4d4d-ad49-3347fb594aed', 0, CAST(N'2021-02-25T01:30:10.963' AS DateTime), N'System', N'C:\local\Temp\tmp760B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd5885401-ddd8-4bcf-8523-ad251fb22476', 0, CAST(N'2021-01-06T17:07:31.830' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE62A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd60e9575-7ca4-41c7-b713-35412dfaab11', 0, CAST(N'2021-01-28T21:33:00.127' AS DateTime), N'System', N'C:\local\Temp\tmp3BFB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd6216328-6d47-4580-b563-9687eaeec894', 0, CAST(N'2021-02-25T01:32:57.913' AS DateTime), N'System', N'C:\local\Temp\tmp183.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd6229950-6043-435c-8843-22044e2c2ee6', 0, CAST(N'2021-02-25T01:30:18.297' AS DateTime), N'System', N'C:\local\Temp\tmp9273.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd63ede3f-d6dd-4ff8-9683-67ef489017a1', 0, CAST(N'2021-02-26T23:29:00.507' AS DateTime), N'System', N'C:\local\Temp\tmp13B8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', 0, CAST(N'2021-03-30T02:07:01.753' AS DateTime), N'System', N'C:\local\Temp\tmp7B64.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd683b15b-eff7-4160-a4c3-e631c64d719e', 0, CAST(N'2021-02-25T01:29:20.650' AS DateTime), N'System', N'C:\local\Temp\tmpB175.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd6841956-c514-4b70-acec-9023c4104e83', 0, CAST(N'2021-03-01T22:24:00.450' AS DateTime), N'System', N'C:\local\Temp\tmp62BA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd689a3eb-57fa-4e7c-b4a8-981dc3105dbe', 0, CAST(N'2021-02-25T01:31:44.810' AS DateTime), N'System', N'C:\local\Temp\tmpE3DB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd6d2edef-c3a2-4b28-9512-3b481b76428b', 0, CAST(N'2021-02-25T01:28:03.657' AS DateTime), N'System', N'C:\local\Temp\tmp857A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd704b875-f1fd-478b-b923-5e89e9ceedd5', 0, CAST(N'2021-02-25T15:22:00.520' AS DateTime), N'System', N'C:\local\Temp\tmpF940.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd719e33e-04ae-4f19-809f-3df37d2b6538', 0, CAST(N'2021-02-23T23:40:00.467' AS DateTime), N'System', N'C:\local\Temp\tmp554C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd72c7b42-4593-4c0c-b08c-77140f66e815', 0, CAST(N'2021-02-05T23:15:13.703' AS DateTime), N'System', N'C:\local\Temp\tmp4643.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd75c6f2e-6592-41c3-9aab-22ac77a052d0', 0, CAST(N'2021-03-18T21:55:16.863' AS DateTime), N'System', N'C:\local\Temp\tmpDB5A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd7853b48-5ba2-4b7f-b7d7-c94862b006e0', 0, CAST(N'2021-02-04T17:56:11.950' AS DateTime), N'System', N'C:\local\Temp\tmpD83C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd7b10d8a-54ea-44c1-b4c6-446d80037b90', 0, CAST(N'2021-01-04T21:20:05.330' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7E27.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd80cbe03-0aa1-4165-ae07-92dd46064243', 0, CAST(N'2021-02-25T01:29:00.283' AS DateTime), N'System', N'C:\local\Temp\tmp6219.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd838c880-ac77-44b6-ad9c-8a0ee44cf2e9', 0, CAST(N'2021-03-04T17:31:00.547' AS DateTime), N'System', N'C:\local\Temp\tmpF7BD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd9238d5b-f175-4c42-9964-349731796682', 0, CAST(N'2021-03-01T22:27:02.990' AS DateTime), N'System', N'C:\local\Temp\tmp2806.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd92e251d-0a3c-4638-8957-da8e641dabbd', 0, CAST(N'2021-03-01T15:43:00.203' AS DateTime), N'System', N'C:\local\Temp\tmp48C2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd94591af-d27c-47bf-ab07-ee331646f144', 0, CAST(N'2020-12-17T17:28:05.723' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpD376.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd94b9d97-32c4-4c04-a35d-80d00f6d2c75', 0, CAST(N'2021-02-25T01:26:55.603' AS DateTime), N'System', N'C:\local\Temp\tmp7BB3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd96e1b9f-d75e-41f3-be57-9c204d059f97', 0, CAST(N'2021-01-05T21:08:01.000' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpC955.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd987da6e-334b-41d1-a05d-52e21c0b873d', 0, CAST(N'2021-01-28T21:24:10.650' AS DateTime), N'System', N'C:\local\Temp\tmpFE8A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd9c0cb04-d0a5-4d7e-9289-d2f877d7cedb', 0, CAST(N'2021-02-25T01:27:11.873' AS DateTime), N'System', N'C:\local\Temp\tmpBB54.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'd9e3d1be-6cfa-4833-9b9b-fdf2b71a3579', 0, CAST(N'2021-01-18T12:01:00.343' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'da34ebed-c1c4-4ccd-b159-63fce6715f4f', 0, CAST(N'2021-02-25T01:27:06.913' AS DateTime), N'System', N'C:\local\Temp\tmpA7F5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'da3dc992-b6b9-4bb6-9794-58e34b1176b1', 0, CAST(N'2021-02-25T01:26:38.983' AS DateTime), N'System', N'C:\local\Temp\tmp3B34.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'da5e7586-8570-4563-9c4b-596057b7b3d1', 0, CAST(N'2021-03-15T11:46:04.210' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp592C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'da8d83b2-75b6-4528-ab74-ddb6ba8d3a90', 0, CAST(N'2021-03-08T21:41:00.563' AS DateTime), N'System', N'C:\local\Temp\tmpEBB2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'daa3f184-efaf-4346-a93c-e728d8b717ef', 0, CAST(N'2021-02-05T20:55:11.757' AS DateTime), N'System', N'C:\local\Temp\tmp125D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dac39195-9f25-488b-a3b5-377d20dc0102', 0, CAST(N'2021-01-19T21:11:00.203' AS DateTime), N'System', N'C:\local\Temp\tmpE546.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dad8469f-25dc-4894-8540-2b08f49baaad', 0, CAST(N'2021-02-22T18:26:00.307' AS DateTime), N'System', N'C:\local\Temp\tmp9AD5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'db4a967a-2c77-4369-bafc-c30f2b083b03', 0, CAST(N'2021-03-23T00:21:03.567' AS DateTime), N'System', N'C:\local\Temp\tmpC21C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'db72c765-cd17-43c8-b742-facf84cef74e', 0, CAST(N'2021-02-19T23:05:00.380' AS DateTime), N'System', N'C:\local\Temp\tmp349B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'db7c2061-6791-445b-8c97-849dd7728afe', 0, CAST(N'2021-02-25T01:27:30.657' AS DateTime), N'System', N'C:\local\Temp\tmp44C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dba1eb21-8b63-4e2d-93c6-c8827516845a', 0, CAST(N'2021-02-25T01:32:48.883' AS DateTime), N'System', N'C:\local\Temp\tmpDE16.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dbdcdc95-cb13-421a-9ca8-5c15c96bad1d', 0, CAST(N'2021-02-05T23:37:32.573' AS DateTime), N'System', N'C:\local\Temp\tmpB52D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dbed1d33-fa6d-4b38-a679-38e32608c6b3', 0, CAST(N'2021-02-05T23:15:14.287' AS DateTime), N'System', N'C:\local\Temp\tmp4903.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dbf772a6-e358-448a-8ad0-70fa1687dd2a', 0, CAST(N'2021-02-12T21:25:20.513' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dc22e5ac-ebb9-4561-949a-d3d420905f16', 0, CAST(N'2021-01-19T12:01:00.683' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dc25c678-6ece-43e2-a9ad-c039ddaf3bfd', 0, CAST(N'2021-02-25T01:26:21.360' AS DateTime), N'System', N'C:\local\Temp\tmpF649.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dc9a853e-2f52-4eb3-8e40-e636f2a6e936', 0, CAST(N'2021-02-19T21:39:01.140' AS DateTime), N'System', N'C:\local\Temp\tmp79F9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'de984d5a-b7e9-49c7-b1b7-6800b5782367', 0, CAST(N'2021-03-01T22:27:01.517' AS DateTime), N'System', N'C:\local\Temp\tmp21DB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'deb0293b-56ac-4f47-b098-9ec49b5cbd41', 0, CAST(N'2021-02-25T01:27:45.477' AS DateTime), N'System', N'C:\local\Temp\tmp3E89.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'df536035-cbfa-41c0-b065-31529de4522d', 0, CAST(N'2021-01-28T21:25:00.523' AS DateTime), N'System', N'C:\local\Temp\tmpE8EB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'df6904ce-1759-4bea-a32a-ab3b3ddafdfc', 0, CAST(N'2021-02-25T01:26:28.570' AS DateTime), N'System', N'C:\local\Temp\tmp125B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dfba38ed-122d-4ba4-9a7e-a0675b3db78b', 0, CAST(N'2021-02-25T01:27:29.050' AS DateTime), N'System', N'C:\local\Temp\tmpFE30.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'dfd85fd3-546b-4602-a7c7-c62be586be14', 0, CAST(N'2021-03-02T18:21:00.213' AS DateTime), N'System', N'C:\local\Temp\tmp3345.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e06bd851-e40c-4655-b2ff-f46184526fc9', 0, CAST(N'2021-02-25T01:26:31.160' AS DateTime), N'System', N'C:\local\Temp\tmp1C92.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e0bbc7f0-df4b-4746-b2cc-d7dde4c43f7e', 0, CAST(N'2021-02-12T18:35:00.637' AS DateTime), N'System', N'C:\local\Temp\tmp32DA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e0c064d8-099f-44cd-aea9-e53774811205', 0, CAST(N'2021-02-25T01:27:32.973' AS DateTime), N'System', N'C:\local\Temp\tmpDB5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e0e401f6-aecf-4d0e-ae92-db143d0955e8', 0, CAST(N'2020-12-17T16:32:40.323' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp1140.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e10c9acc-a285-40ee-bb37-135ba4c04f7f', 0, CAST(N'2021-02-02T22:09:00.260' AS DateTime), N'System', N'C:\local\Temp\tmpF7D6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e1340b82-0c15-477b-96dd-8a23553d0b80', 0, CAST(N'2021-02-25T01:28:06.150' AS DateTime), N'System', N'C:\local\Temp\tmp8F61.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e16f3239-5c6e-441e-bcae-e65e0912c2a5', 0, CAST(N'2021-02-25T01:30:23.270' AS DateTime), N'System', N'C:\local\Temp\tmpA5A1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e17d5599-7fae-46fe-827f-63712c9982ca', 0, CAST(N'2021-02-25T01:32:17.010' AS DateTime), N'System', N'C:\local\Temp\tmp623A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e1852de9-fa5d-4452-8ea4-c824f45afea6', 0, CAST(N'2021-02-25T01:26:32.243' AS DateTime), N'System', N'C:\local\Temp\tmp20D9.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e190bb1c-09d4-40e0-b134-1bf20a468955', 0, CAST(N'2021-01-12T15:26:00.617' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e1dac81b-44d3-40e4-9117-47aaa94fa51a', 0, CAST(N'2021-01-06T16:23:00.183' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp3B04.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e21d7056-0af4-4890-8989-844a873357b0', 0, CAST(N'2021-03-09T12:50:04.427' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE053.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e2439c4e-d048-470c-b713-61b3f271437e', 0, CAST(N'2021-02-12T21:25:13.537' AS DateTime), N'System', N'C:\local\Temp\tmpA41.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e24ed874-50e8-4555-a1f9-260cdca76988', 0, CAST(N'2021-01-05T20:37:01.173' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp67AD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e2bce993-4d51-4e81-9cd0-dbb2170b2061', 0, CAST(N'2021-02-19T17:51:00.643' AS DateTime), N'System', N'C:\local\Temp\tmpBFCF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e2d89ae8-5e54-4f59-9897-25deecb4b3a9', 0, CAST(N'2021-02-25T01:30:13.263' AS DateTime), N'System', N'C:\local\Temp\tmp7F64.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e2ecd7cd-f4b2-4b8e-b96a-0074644e1fa0', 0, CAST(N'2021-02-11T16:20:00.273' AS DateTime), N'System', N'C:\local\Temp\tmp4037.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e3072485-d0c5-4d41-80da-ee6b18e8b6e2', 0, CAST(N'2021-03-30T02:07:07.473' AS DateTime), N'System', N'C:\local\Temp\tmp9267.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e3137588-13f3-436e-a923-8774b6fc22db', 0, CAST(N'2021-02-25T01:54:09.863' AS DateTime), N'System', N'C:\local\Temp\tmp46B1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e36099f1-bac4-4044-93ac-270b995125b7', 0, CAST(N'2021-01-28T21:31:00.530' AS DateTime), N'System', N'C:\local\Temp\tmp68D0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e379fa58-9065-442c-987c-93655c5bf2e1', 0, CAST(N'2021-01-06T16:15:00.347' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE814.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e38d9340-e055-4639-8075-a3a345acaaee', 0, CAST(N'2021-02-18T17:09:00.437' AS DateTime), N'System', N'C:\local\Temp\tmp744.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e3bd1b34-4b29-4fe9-87f6-15bb114f467e', 0, CAST(N'2021-01-13T14:25:00.297' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp3189.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e3c5a564-2b0d-47c2-b8ad-08c2c2ac2d0d', 0, CAST(N'2021-02-25T01:30:36.137' AS DateTime), N'System', N'C:\local\Temp\tmpD7E7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e3e495a1-8ac1-46c5-8098-9f1b5af72478', 0, CAST(N'2021-01-13T12:46:00.297' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp8EA1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e3f6214b-e6c0-43e8-8471-0cb5969f6139', 0, CAST(N'2021-02-25T01:26:20.323' AS DateTime), N'System', N'C:\local\Temp\tmpF25F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e3f6cc16-eca3-4001-a318-710536b415fc', 0, CAST(N'2021-01-13T14:36:00.263' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp43AC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e430edeb-51f2-4db0-a700-14bf446ea45c', 0, CAST(N'2021-01-12T15:22:10.763' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e4774011-ce5c-45e1-9287-5abebe2df770', 0, CAST(N'2021-03-01T15:50:00.173' AS DateTime), N'System', N'C:\local\Temp\tmpB126.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e48dd3fd-088b-4bc5-8562-14a82b743dd5', 0, CAST(N'2021-03-01T22:20:00.593' AS DateTime), N'System', N'C:\local\Temp\tmpB958.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e48f8783-8615-49e7-bd2d-0777123c4eef', 0, CAST(N'2021-02-12T18:35:14.563' AS DateTime), N'System', N'C:\local\Temp\tmp6AFC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e4a19817-01ee-4589-99e1-954df59519a2', 0, CAST(N'2021-03-09T12:53:05.263' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9F65.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e4a8793e-c7d4-465d-a981-3200a23311d1', 0, CAST(N'2021-02-25T23:08:00.403' AS DateTime), N'System', N'C:\local\Temp\tmp949F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e564d307-0ac2-4e43-a852-1611cd4c883d', 0, CAST(N'2021-02-04T17:56:11.043' AS DateTime), N'System', N'C:\local\Temp\tmpD4CF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e5b7c052-a461-4c60-890a-33ab3fc1b9b3', 0, CAST(N'2021-02-25T01:26:11.427' AS DateTime), N'System', N'C:\local\Temp\tmpCFA1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e5c7a931-4f35-429c-8ea0-c285da1be686', 0, CAST(N'2021-02-25T01:29:17.427' AS DateTime), N'System', N'C:\local\Temp\tmpA4D0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e5ecd16f-29ee-43c0-9273-e97b47c5d360', 0, CAST(N'2021-02-09T19:36:07.147' AS DateTime), N'System', N'C:\local\Temp\tmpFCB4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e5fc3c44-fba3-4d8a-9378-fa827cc947f6', 0, CAST(N'2021-02-25T01:29:15.283' AS DateTime), N'System', N'C:\local\Temp\tmp9CCF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e69e31b0-2ff6-464f-bdcb-8cb52ef82e22', 0, CAST(N'2021-02-04T17:56:11.487' AS DateTime), N'System', N'C:\local\Temp\tmpD618.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e6c81d0b-9a14-498a-9d5b-2e9009c1c055', 0, CAST(N'2021-02-25T01:26:56.500' AS DateTime), N'System', N'C:\local\Temp\tmp7E73.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e76d0cab-d468-450f-bc02-a329d9365e3d', 0, CAST(N'2021-03-23T15:35:14.187' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7D11.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e7958fd4-cef2-4c0b-8a2b-41c14dbd4912', 0, CAST(N'2021-02-22T17:05:01.673' AS DateTime), N'System', N'C:\local\Temp\tmp7923.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e79889ad-eaaf-43cd-a3bb-3dc801db9ddd', 0, CAST(N'2021-03-02T16:34:00.247' AS DateTime), N'System', N'C:\local\Temp\tmp3EAC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e7b78151-f44c-4771-a34e-0fe4cee4aa0e', 0, CAST(N'2021-02-25T01:32:36.340' AS DateTime), N'System', N'C:\local\Temp\tmpAD79.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e82e6e7a-c0a6-41c1-9ff9-c7f07c0697be', 0, CAST(N'2021-02-25T01:31:31.973' AS DateTime), N'System', N'C:\local\Temp\tmpB159.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e8a9c642-5da1-4e7b-9d69-3b40351abe56', 0, CAST(N'2021-01-13T14:26:00.907' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp1BDA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e8ace954-329f-4684-a873-e66b30819621', 0, CAST(N'2021-02-25T01:29:32.407' AS DateTime), N'System', N'C:\local\Temp\tmpDFA5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e8cfeaf5-c208-4241-8536-ed478554ca2a', 0, CAST(N'2021-03-01T19:13:00.480' AS DateTime), N'System', N'C:\local\Temp\tmp8863.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e8d35c8f-482b-45c9-8bb7-a9c5989e22b5', 0, CAST(N'2021-03-03T23:28:00.387' AS DateTime), N'System', N'C:\local\Temp\tmp84EC.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e8d5f25a-c95f-403e-825f-954c2e2ebacf', 0, CAST(N'2021-01-28T21:28:02.097' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e8f2c2ed-715d-4b59-98ae-e8e865b0f483', 0, CAST(N'2021-01-06T18:03:03.307' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp444B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e93ffc8e-3af8-4de6-9d4d-e361fe897cf7', 0, CAST(N'2021-03-01T18:26:01.253' AS DateTime), N'System', N'C:\local\Temp\tmp8159.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e96962fb-45d7-4c67-b3c1-3b165b3bfaaf', 0, CAST(N'2021-03-03T23:21:00.410' AS DateTime), N'System', N'C:\local\Temp\tmp1C77.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e985861e-2f25-4858-984c-a92fda08b72f', 0, CAST(N'2021-02-06T17:44:00.753' AS DateTime), N'System', N'C:\local\Temp\tmp6575.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e9c57477-fb7b-4bf1-b057-263f0dd2537a', 0, CAST(N'2021-03-23T00:18:00.707' AS DateTime), N'System', N'C:\local\Temp\tmpF7C2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'e9f5144f-8ef2-44b9-b76c-76be4bcddfe5', 0, CAST(N'2021-02-16T21:02:18.377' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ea045b99-2c8a-405c-b448-10ccc4c4b8ee', 0, CAST(N'2021-02-25T01:29:29.240' AS DateTime), N'System', N'C:\local\Temp\tmpD34D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ea4bb41b-8d45-4cb9-8ca9-d26596015a68', 0, CAST(N'2021-01-28T21:28:03.390' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ea873af8-4610-4fb7-b401-a70662bd90bc', 0, CAST(N'2021-02-12T21:25:00.767' AS DateTime), N'System', N'C:\local\Temp\tmpD66B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ea92eb7c-d4e1-4a70-bee8-0cb63d489bdf', 0, CAST(N'2021-02-19T06:07:00.230' AS DateTime), N'System', N'C:\local\Temp\tmp42ED.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ead327cd-6a4e-4d74-92f3-5d82fae4c151', 0, CAST(N'2021-02-16T21:02:00.770' AS DateTime), N'System', N'C:\local\Temp\tmp338B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'eaf68b7d-c9fb-4389-b237-1848ec80805b', 0, CAST(N'2020-12-17T17:48:04.860' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp1E02.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'eaf6b440-53a3-4552-8bf1-7e0295142168', 0, CAST(N'2021-02-25T01:26:42.307' AS DateTime), N'System', N'C:\local\Temp\tmp483A.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'eb395c93-aa93-47c5-a486-e3ded2cc6e2b', 0, CAST(N'2021-01-19T01:20:27.893' AS DateTime), N'System', N'C:\local\Temp\tmpD44D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'eb860c2f-27bd-443f-be0c-399ef166f1c9', 0, CAST(N'2021-02-25T01:27:34.643' AS DateTime), N'System', N'C:\local\Temp\tmp13C2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ebabdc0f-33db-46de-a1c8-35ac2491bd40', 0, CAST(N'2021-02-05T23:15:12.643' AS DateTime), N'System', N'C:\local\Temp\tmp41FB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ebb30b1b-72b1-4fbe-9be8-35c6f83bcf2e', 0, CAST(N'2021-03-02T16:46:00.327' AS DateTime), N'System', N'C:\local\Temp\tmp3B10.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ec145df5-3590-4bd2-88a3-9636bd64beda', 0, CAST(N'2021-01-12T15:27:06.597' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ec1ba985-62e7-460e-a9e6-da304d702cf3', 0, CAST(N'2021-03-02T16:28:00.347' AS DateTime), N'System', N'C:\local\Temp\tmpC0C8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ec6262b9-c2a0-44de-bad3-56e16b47e170', 0, CAST(N'2021-02-25T01:32:15.537' AS DateTime), N'System', N'C:\local\Temp\tmp5C5D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ec693a7c-9ca5-4605-945d-cf4cd1ccaa29', 0, CAST(N'2021-02-25T01:26:57.787' AS DateTime), N'System', N'C:\local\Temp\tmp8471.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ec747042-6335-49a9-af29-53168bbb65bc', 0, CAST(N'2021-01-18T08:47:04.423' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7041.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ec7d90eb-e6f5-4158-856f-d5e72928f73f', 0, CAST(N'2021-02-25T01:28:27.753' AS DateTime), N'System', N'C:\local\Temp\tmpE306.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ec8fd2fd-5226-4155-a7b0-5b68e1ae59c5', 0, CAST(N'2021-02-25T01:33:14.093' AS DateTime), N'System', N'C:\local\Temp\tmp44AB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ecbd35ad-801f-4308-b78d-81fd9f51e3f6', 0, CAST(N'2021-01-06T19:45:02.960' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpB081.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ecc6c049-bc33-40ec-addf-7ad630026a6b', 0, CAST(N'2021-02-25T01:28:07.867' AS DateTime), N'System', N'C:\local\Temp\tmp95CB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ece312ce-4ac2-465c-88a1-4c2c535ec2c9', 0, CAST(N'2021-03-30T18:45:00.787' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp847F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ecf3ee27-f245-4886-a3ae-737c90de75f5', 0, CAST(N'2021-02-25T01:33:32.640' AS DateTime), N'System', N'C:\local\Temp\tmp87A5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ed3c0557-f8c4-4d6c-9d5d-9a2294034cae', 0, CAST(N'2021-02-10T07:44:00.320' AS DateTime), N'System', N'C:\local\Temp\tmp7CE7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ed670297-4438-4e5b-ab84-cfd69b3e2217', 0, CAST(N'2021-03-03T21:57:00.600' AS DateTime), N'System', N'C:\local\Temp\tmp363B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ed6b2daf-9669-4cee-a26c-0a436948d3dd', 0, CAST(N'2021-01-12T15:26:01.310' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ed7efff3-d350-46fd-8c81-d9aa5481ea2b', 0, CAST(N'2021-01-08T11:36:01.557' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpF771.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ee238b55-505e-4520-aa5c-02095c029fba', 0, CAST(N'2021-02-25T01:28:06.973' AS DateTime), N'System', N'C:\local\Temp\tmp927E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ee76e484-65cc-4672-8aa2-7366f924ff9e', 0, CAST(N'2021-03-22T23:46:23.430' AS DateTime), N'System', N'C:\local\Temp\tmp522.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'eea52ce9-af99-4e75-84cd-4c2b4eeaebf1', 0, CAST(N'2021-02-25T01:26:57.160' AS DateTime), N'System', N'C:\local\Temp\tmp81EF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'eeb98431-523f-46bb-81da-3c5e5c31edf3', 0, CAST(N'2021-01-15T10:11:00.407' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp50BA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ef035033-2aa0-49b1-989e-276cafa8911e', 0, CAST(N'2021-03-20T12:57:27.837' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA89F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ef552092-9d55-41a3-9bf8-421a75c01a3c', 0, CAST(N'2021-03-30T02:07:11.770' AS DateTime), N'System', N'C:\local\Temp\tmpA39F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ef5a2d08-dabb-4e02-a1a8-89fb2c6d86c2', 0, CAST(N'2021-02-16T17:52:00.673' AS DateTime), N'System', N'C:\local\Temp\tmp4019.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'efb1184f-1ae9-42cc-bd3b-170af6f33bb4', 0, CAST(N'2021-02-19T21:56:00.397' AS DateTime), N'System', N'C:\local\Temp\tmp9FF.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'eff14507-420f-4994-84ca-38587e373fdd', 0, CAST(N'2021-02-25T01:27:14.790' AS DateTime), N'System', N'C:\local\Temp\tmpC6C2.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f009105e-e871-4b4d-8b7e-ed089128c6ab', 0, CAST(N'2021-02-25T01:30:42.733' AS DateTime), N'System', N'C:\local\Temp\tmpF17E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f00a7cf2-31cf-4ee8-a4a6-f051662caf3c', 0, CAST(N'2021-02-05T23:37:30.303' AS DateTime), N'System', N'C:\local\Temp\tmpABD4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f014f68a-106a-4ad6-a918-cfefb07b80bf', 0, CAST(N'2021-02-24T18:29:03.893' AS DateTime), N'System', N'C:\local\Temp\tmpECE0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f026e280-81fc-4970-bb20-ce63c7299260', 0, CAST(N'2021-02-25T01:27:33.800' AS DateTime), N'System', N'C:\local\Temp\tmp10C4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f09d96cb-e1be-4e8c-888f-93a726d2d48b', 0, CAST(N'2021-02-27T03:39:00.740' AS DateTime), N'System', N'C:\local\Temp\tmpF1B4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f0b5ed27-7249-4b68-8035-5601e6bb34c1', 0, CAST(N'2021-03-12T06:10:29.323' AS DateTime), N'System', N'C:\local\Temp\tmp6F95.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f0c1d62a-0039-4b82-b808-7cd924ebea5e', 0, CAST(N'2021-01-12T15:31:04.397' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f0e5c99d-28c3-47ff-9ceb-e4a513e36d91', 0, CAST(N'2020-12-17T17:48:09.827' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp27D8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f11dc202-6eb3-416c-a956-5cfbe6f41302', 0, CAST(N'2021-02-06T17:44:11.907' AS DateTime), N'System', N'C:\local\Temp\tmp8E44.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f1349973-5f3b-44b1-8b46-6ba3a2bdc71e', 0, CAST(N'2021-01-12T15:25:00.547' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f14b5e77-454a-4d3c-9aee-f95c1a6d18cf', 0, CAST(N'2021-02-25T01:33:18.747' AS DateTime), N'System', N'C:\local\Temp\tmp5670.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f16461a7-6707-4929-aa6f-d445587e6d8e', 0, CAST(N'2021-02-25T01:32:37.907' AS DateTime), N'System', N'C:\local\Temp\tmpB307.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f18e4896-fff7-403c-8de8-4e436bab8674', 0, CAST(N'2021-02-22T16:45:00.680' AS DateTime), N'System', N'C:\local\Temp\tmp2602.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f1b05f0b-a735-4262-9dcb-e5ed9fa5330b', 0, CAST(N'2021-02-25T01:26:53.637' AS DateTime), N'System', N'C:\local\Temp\tmp745D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f1bb38e9-dd6c-49e9-a90f-08280880e432', 0, CAST(N'2021-02-25T01:28:31.657' AS DateTime), N'System', N'C:\local\Temp\tmpF2BA.tmp')
GO
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f1c74148-5a1a-4431-89e0-d5cb7b068574', 0, CAST(N'2021-02-25T01:28:51.970' AS DateTime), N'System', N'C:\local\Temp\tmp4216.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f1da4bec-e7cb-41da-a943-04517124ffd7', 0, CAST(N'2021-01-07T11:49:00.180' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7F24.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f2042efe-4d16-4a9a-aa28-07c8aaa6e032', 0, CAST(N'2021-02-25T01:32:19.917' AS DateTime), N'System', N'C:\local\Temp\tmp6D48.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f35aef73-ddea-461e-9c7a-91e491cbfe78', 0, CAST(N'2021-02-25T01:29:12.117' AS DateTime), N'System', N'C:\local\Temp\tmp9049.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f37e6a55-6dcb-45e4-bbe3-598c813b1b16', 0, CAST(N'2021-02-25T01:26:59.073' AS DateTime), N'System', N'C:\local\Temp\tmp8945.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f3de55af-6e80-4429-81ec-f84a1032cd2b', 0, CAST(N'2021-02-25T01:26:24.330' AS DateTime), N'System', N'C:\local\Temp\tmp217.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f3ff664a-a2c0-45f4-8ee6-64e1725be42a', 0, CAST(N'2020-12-17T03:11:31.287' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9343.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f436cb0d-b08a-4324-928c-8537d8ce70df', 0, CAST(N'2021-01-16T12:01:02.123' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f4486bcf-6b04-4d5f-8bf3-4f8241b9554b', 0, CAST(N'2021-02-10T07:31:01.810' AS DateTime), N'System', N'C:\local\Temp\tmp962D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f469cf78-f33c-49db-b570-c9810627e361', 0, CAST(N'2021-02-22T17:29:01.520' AS DateTime), N'System', N'C:\local\Temp\tmp70E3.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f4772825-cfc4-4924-ac74-8e6006dae2b7', 0, CAST(N'2021-02-17T17:45:04.150' AS DateTime), N'System', N'C:\local\Temp\tmp30C7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f50fec85-7751-4a23-90bb-f59b983c2d99', 0, CAST(N'2021-03-09T12:57:02.757' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp48E6.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f5128086-d0b8-41fe-ad0c-5228b3a427e9', 0, CAST(N'2021-02-25T01:26:36.713' AS DateTime), N'System', N'C:\local\Temp\tmp3256.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f5194c72-422a-43e9-8cee-422452b1df1e', 0, CAST(N'2021-01-18T12:01:02.367' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f5724883-b6a0-477e-b41c-d94bcfe0c52d', 0, CAST(N'2021-01-07T16:24:00.773' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp43D7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f59cb8de-b3b4-4e44-9c6a-2e1b1cfbb714', 0, CAST(N'2021-01-07T15:51:00.313' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpD83.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f5af3fb3-03eb-4d7b-aa92-441b465ff1e2', 0, CAST(N'2021-02-06T17:44:06.847' AS DateTime), N'System', N'C:\local\Temp\tmp7CD7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f5dfc251-49cf-42ee-b525-750f19177127', 0, CAST(N'2021-01-28T21:26:02.110' AS DateTime), N'System', N'C:\local\Temp\tmpD855.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f6046759-5417-4ae3-ad44-081e4506cd83', 0, CAST(N'2021-03-02T16:35:00.303' AS DateTime), N'System', N'C:\local\Temp\tmp291D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f60e5fa7-ee91-455a-914c-cc21efd9ee72', 0, CAST(N'2021-02-04T22:50:02.283' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f658e29b-e771-450b-8c59-d4f113202f0c', 0, CAST(N'2021-02-25T01:27:12.630' AS DateTime), N'System', N'C:\local\Temp\tmpBE24.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f69346ea-23b6-49f3-9b3c-81be58db8316', 0, CAST(N'2021-02-25T01:32:40.847' AS DateTime), N'System', N'C:\local\Temp\tmpBED1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f6a10298-f51b-4d24-acdb-ba0c8ef5a081', 0, CAST(N'2021-01-19T21:00:00.230' AS DateTime), N'System', N'C:\local\Temp\tmpD324.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f6ad3712-5413-4088-97d1-88dfa0c9bd47', 0, CAST(N'2021-02-19T21:45:00.207' AS DateTime), N'System', N'C:\local\Temp\tmpF7FB.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f6e30995-14fb-4a51-b1f3-b76367800d3f', 0, CAST(N'2021-01-13T12:55:00.963' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpCC02.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f6f11e8e-eead-4794-b005-c7797f47ce3b', 0, CAST(N'2021-03-11T15:12:21.637' AS DateTime), N'System', N'C:\local\Temp\tmp3E52.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f6f90f5e-ba78-48ad-9323-7cf8d27f53ca', 0, CAST(N'2021-03-01T18:23:00.663' AS DateTime), N'System', N'C:\local\Temp\tmpC257.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f7426df4-cf3a-4a47-805f-0297291f74d2', 0, CAST(N'2021-02-26T23:06:00.250' AS DateTime), N'System', N'C:\local\Temp\tmp581.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f7a9469e-8bb1-47fe-b626-72ed5d89ceea', 0, CAST(N'2021-03-09T15:45:00.337' AS DateTime), N'System', N'C:\local\Temp\tmp492E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f803fc29-a0c1-450b-9964-471ee25c5c71', 0, CAST(N'2021-02-25T01:26:35.583' AS DateTime), N'System', N'C:\local\Temp\tmp2DA1.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f887a1c1-8e95-4381-a72e-eb96127b9ebc', 0, CAST(N'2021-02-26T13:42:00.640' AS DateTime), N'System', N'C:\local\Temp\tmpB2D5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f9214ffd-80f8-4468-aedb-73c5504fd1bd', 0, CAST(N'2021-02-12T21:25:05.033' AS DateTime), N'System', N'C:\local\Temp\tmpE978.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f93a60a1-8e7d-4324-9721-18e458918e8c', 0, CAST(N'2021-02-25T01:26:36.113' AS DateTime), N'System', N'C:\local\Temp\tmp3023.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f9841e53-d705-470c-805e-20106b89075e', 0, CAST(N'2021-02-25T01:30:55.647' AS DateTime), N'System', N'C:\local\Temp\tmp246F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f9bc655b-fe33-491a-b9cf-291298fb1d13', 0, CAST(N'2021-02-25T01:26:26.487' AS DateTime), N'System', N'C:\local\Temp\tmpA87.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f9d14355-630d-4814-833a-abbafb03efee', 0, CAST(N'2021-02-11T16:21:00.420' AS DateTime), N'System', N'C:\local\Temp\tmp2AA8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f9d910bc-29d3-4b89-b43f-83a563d38558', 0, CAST(N'2021-02-25T01:30:40.073' AS DateTime), N'System', N'C:\local\Temp\tmpE799.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'f9f93deb-9159-4f41-a69e-48ca7065d163', 0, CAST(N'2020-12-17T16:33:10.297' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp2F0B.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fa4184ee-5747-470a-b18c-81467904a859', 0, CAST(N'2020-12-17T17:28:22.710' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp501.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fa4a54ed-c2b6-4779-9405-11833ac3a267', 0, CAST(N'2021-02-25T01:27:16.343' AS DateTime), N'System', N'C:\local\Temp\tmpCCDE.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fa6f4890-f0e2-4feb-95c1-3d320e5fa57d', 0, CAST(N'2021-01-07T17:45:47.953' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp2337.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fa95cfce-5651-400d-b3ec-63e6f66272ec', 0, CAST(N'2021-02-25T01:28:33.563' AS DateTime), N'System', N'C:\local\Temp\tmpF9F0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'faa640a0-e60a-4966-a8e3-a36c4225e1b5', 0, CAST(N'2021-03-30T18:44:03.000' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp9A4C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'faffac4b-c273-4715-aa53-c24c491d427d', 0, CAST(N'2021-02-25T01:26:46.763' AS DateTime), N'System', N'C:\local\Temp\tmp5968.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fb673974-3e0a-4d3c-a7bb-9f9edfa3a727', 0, CAST(N'2021-02-05T23:37:28.743' AS DateTime), N'System', N'C:\local\Temp\tmpA568.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fb6d182b-8568-4400-a849-ea98b8a8cacb', 0, CAST(N'2020-12-17T17:28:23.943' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp1955.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fb71db2f-a1bc-4215-8e90-c9912372a924', 0, CAST(N'2021-02-11T19:02:00.453' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fb91eea9-8471-4a0f-9906-ab31f7962f60', 0, CAST(N'2020-12-17T17:27:53.567' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpA3DD.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fbc259d5-df70-4bc2-9c23-9cd9c6a338dc', 0, CAST(N'2020-12-17T18:19:20.030' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBE18.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fbd72214-f69f-4f59-a18e-248fe6b75819', 0, CAST(N'2021-02-25T01:38:02.607' AS DateTime), N'System', N'C:\local\Temp\tmpA726.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fc31dde4-fbbd-4416-b62e-4f95414d3fe6', 0, CAST(N'2021-02-25T01:29:22.703' AS DateTime), N'System', N'C:\local\Temp\tmpB9B4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fc3ec9d7-525f-4e8d-a3fa-8549ea6a18b2', 0, CAST(N'2021-03-26T21:34:53.780' AS DateTime), N'System', N'C:\local\Temp\tmp84D7.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fc623911-6485-4265-959a-6a5c12e3e077', 0, CAST(N'2021-02-25T01:26:27.507' AS DateTime), N'System', N'C:\local\Temp\tmpE52.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fc7fa776-c247-4124-9d80-d35f7117509c', 0, CAST(N'2021-01-21T18:22:00.287' AS DateTime), N'System', N'C:\local\Temp\tmpE1FA.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fcc29032-9520-491e-b8f5-3059927cba2b', 0, CAST(N'2021-03-23T00:21:02.623' AS DateTime), N'System', N'C:\local\Temp\tmpBE81.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fcd0dd80-8e56-414e-bb73-13a9a9bc5295', 0, CAST(N'2021-03-02T04:39:01.037' AS DateTime), N'System', N'C:\local\Temp\tmpAFC4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fd0e0240-1510-44fe-b6f9-7d31607edfd8', 0, CAST(N'2021-02-25T01:30:03.090' AS DateTime), N'System', N'C:\local\Temp\tmp5780.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fd12093f-830b-4272-b417-ecbf8fa97d56', 0, CAST(N'2020-12-17T17:27:56.167' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpAE12.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fd1564e0-421b-4b6a-9c5e-bb8221e27ee0', 0, CAST(N'2021-03-20T10:50:30.850' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp51D8.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fd678877-072c-4154-9baf-489309b96f99', 0, CAST(N'2021-01-07T17:45:46.717' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp21A0.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fd68a7b2-6b22-4ac3-9e00-fa780dec0417', 0, CAST(N'2021-03-25T18:11:58.700' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp7206.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fd8b1917-9537-4620-96a3-aed7a695d720', 0, CAST(N'2021-01-07T13:07:07.427' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpE84F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fd8f4b56-dbcd-4f71-bce5-37e85e37294e', 0, CAST(N'2021-02-05T23:15:11.457' AS DateTime), N'System', N'C:\local\Temp\tmp3DA4.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fdd1a667-0672-41f8-b3ce-243d6160277b', 0, CAST(N'2021-01-13T12:32:04.533' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpBD7C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fdeab2a7-37f6-4b6f-9716-2b10c21a7ebf', 0, CAST(N'2021-02-10T07:43:00.343' AS DateTime), N'System', N'C:\local\Temp\tmp9286.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fdf2c180-09ef-40a5-9242-448d019bcc27', 0, CAST(N'2021-02-25T01:26:51.093' AS DateTime), N'System', N'C:\local\Temp\tmp6A76.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fe024704-526a-433e-b51e-39ff2bec1902', 0, CAST(N'2021-02-25T01:31:16.803' AS DateTime), N'System', N'C:\local\Temp\tmp7742.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fe32d18e-fc32-4fa7-a549-414b533dd15e', 0, CAST(N'2021-02-25T01:32:00.890' AS DateTime), N'System', N'C:\local\Temp\tmp2322.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fe5be9a2-bbc1-4524-acda-74a3570e23a5', 0, CAST(N'2020-12-17T17:28:17.513' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpFD5F.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'feb8797f-911e-4f56-b190-0c50ab61407a', 0, CAST(N'2021-01-15T10:37:00.907' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmp1E7E.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', 0, CAST(N'2021-03-29T15:24:01.200' AS DateTime), N'System', N'C:\local\Temp\tmpD6C5.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ff202991-fef6-4cfa-b755-2a9b48dd7b33', 0, CAST(N'2021-01-05T20:10:02.963' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpAF8C.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ff438632-4d83-4bd7-afcb-ed571332d27f', 0, CAST(N'2021-02-25T01:29:34.523' AS DateTime), N'System', N'C:\local\Temp\tmpE813.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ff8dfe7d-a9d4-4159-90ae-51c4ddeef243', 0, CAST(N'2021-01-18T11:29:01.237' AS DateTime), N'System', N'C:\Users\localadmin\AppData\Local\Temp\tmpC085.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ff938865-cb66-4707-a301-338839fdc88a', 0, CAST(N'2021-02-25T01:27:04.307' AS DateTime), N'System', N'C:\local\Temp\tmp9E0D.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ffbc1db9-0375-45dc-87c7-2f6835178cc3', 0, CAST(N'2021-02-05T23:15:04.437' AS DateTime), N'System', N'C:\local\Temp\tmp2315.tmp')
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ffc53fca-17bc-44d6-9c2c-49e3f8b5593f', 0, CAST(N'2021-02-23T23:59:00.587' AS DateTime), N'System', NULL)
INSERT [dbo].[Batch] ([Id], [Status], [Created], [CreatedBy], [filename]) VALUES (N'ffcfaafb-0077-4381-a8c0-3d3dbc77f6e3', 0, CAST(N'2021-02-25T01:26:41.127' AS DateTime), N'System', N'C:\local\Temp\tmp4394.tmp')
GO
INSERT [dbo].[Conversion] ([material], [StandardUnit], [ToUnit], [Factor]) VALUES (N'1', N'BBL', N'M3', CAST(0.00378541 AS Decimal(18, 8)))
INSERT [dbo].[Conversion] ([material], [StandardUnit], [ToUnit], [Factor]) VALUES (N'2', N'L15', N'M3', CAST(0.00100000 AS Decimal(18, 8)))
INSERT [dbo].[Conversion] ([material], [StandardUnit], [ToUnit], [Factor]) VALUES (N'3', N'M3', N'BBL', CAST(264.17205300 AS Decimal(18, 8)))
INSERT [dbo].[Conversion] ([material], [StandardUnit], [ToUnit], [Factor]) VALUES (N'4', N'M3', N'BBL', CAST(264.17205300 AS Decimal(18, 8)))
GO
INSERT [dbo].[InventorySnapshot] ([Tag], [Tank], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [QuantityTimestamp], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [Confidence], [lastUpdated]) VALUES (N'ASPH_SOUR', N'TK776', N'Sigmafine', N'Inventory Snapshot', N'10727', N'GP01', N'PRODGP01', N'SUNCOR', CAST(N'2021-03-10T23:59:59.000' AS DateTime), CAST(80874.5780 AS Decimal(18, 4)), N'L15', N'faa640a0-e60a-4966-a8e3-a36c4225e1b5', N'R2PLoader', CAST(100.000 AS Decimal(18, 3)), CAST(N'2021-04-07T10:05:19.997' AS DateTime))
INSERT [dbo].[InventorySnapshot] ([Tag], [Tank], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [QuantityTimestamp], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [Confidence], [lastUpdated]) VALUES (N'ASPH_SOUR', N'TK776Hold', N'Sigmafine', N'Inventory Snapshot', N'10727', N'GP01', N'PRODGP01', N'SUNCOR', CAST(N'2021-03-10T23:59:59.000' AS DateTime), CAST(0.0000 AS Decimal(18, 4)), N'L15', N'faa640a0-e60a-4966-a8e3-a36c4225e1b5', N'R2PLoader', CAST(100.000 AS Decimal(18, 3)), CAST(N'2021-04-07T10:05:20.000' AS DateTime))
GO
INSERT [dbo].[MaterialLedger] ([Plant], [CoCode], [PostingYear], [PostingPeriod], [Status], [PreviousPeriodOpen]) VALUES (N'CP01', N'1060', 2021, NULL, N'X', N'X')
GO
SET IDENTITY_INSERT [dbo].[MaterialMovement] ON 

INSERT [dbo].[MaterialMovement] ([MaterialMovement_id], [materialDocument], [Material], [System], [MovementType], [MovementTypeDesc], [Plant], [HeaderText], [Tag], [PostingDate], [ValuationType], [Quantity], [UnitOfEntry], [UnitOfMeasure], [QuantityInUOE], [QuantityInL15], [BatchId], [EnteredOn], [EnteredAt]) VALUES (81, N'5500006761', 11241, N'S/4 HANA', N'101', N'Production', N'EP01', NULL, N'OIL3', CAST(N'2019-10-01T00:00:00.000' AS DateTime), N'RTFTest2', CAST(-5555.0000 AS Decimal(18, 4)), NULL, N'M3', NULL, NULL, NULL, CAST(N'2021-03-15T15:21:23.957' AS DateTime), N'R2PLoader')
INSERT [dbo].[MaterialMovement] ([MaterialMovement_id], [materialDocument], [Material], [System], [MovementType], [MovementTypeDesc], [Plant], [HeaderText], [Tag], [PostingDate], [ValuationType], [Quantity], [UnitOfEntry], [UnitOfMeasure], [QuantityInUOE], [QuantityInL15], [BatchId], [EnteredOn], [EnteredAt]) VALUES (82, N'5500006762', 11221, N'S/4 HANA', N'101', N'Production', N'EP01', NULL, N'OIL4', CAST(N'2019-10-01T00:00:00.000' AS DateTime), N'RTFTest2', CAST(-4444.0000 AS Decimal(18, 4)), NULL, N'M3', NULL, NULL, NULL, CAST(N'2021-03-15T15:21:23.960' AS DateTime), N'R2PLoader')
INSERT [dbo].[MaterialMovement] ([MaterialMovement_id], [materialDocument], [Material], [System], [MovementType], [MovementTypeDesc], [Plant], [HeaderText], [Tag], [PostingDate], [ValuationType], [Quantity], [UnitOfEntry], [UnitOfMeasure], [QuantityInUOE], [QuantityInL15], [BatchId], [EnteredOn], [EnteredAt]) VALUES (195, N'4900006761', 11241, N'S/4 HANA', N'101', N'Production', N'EP01', NULL, N'OIL3', CAST(N'2019-10-01T00:00:00.000' AS DateTime), N'RTFTest2', CAST(-7075.0000 AS Decimal(18, 4)), NULL, N'M3', NULL, NULL, NULL, CAST(N'2021-04-07T11:49:50.473' AS DateTime), N'R2PLoader')
INSERT [dbo].[MaterialMovement] ([MaterialMovement_id], [materialDocument], [Material], [System], [MovementType], [MovementTypeDesc], [Plant], [HeaderText], [Tag], [PostingDate], [ValuationType], [Quantity], [UnitOfEntry], [UnitOfMeasure], [QuantityInUOE], [QuantityInL15], [BatchId], [EnteredOn], [EnteredAt]) VALUES (196, N'4900006762', 11221, N'S/4 HANA', N'101', N'Production', N'EP01', NULL, N'OIL4', CAST(N'2019-10-01T00:00:00.000' AS DateTime), N'RTFTest2', CAST(-7075.0000 AS Decimal(18, 4)), NULL, N'M3', NULL, NULL, NULL, CAST(N'2021-04-07T11:49:52.110' AS DateTime), N'R2PLoader')
SET IDENTITY_INSERT [dbo].[MaterialMovement] OFF
GO
INSERT [dbo].[ProductHierarchy] ([S4Material], [MaterialDescription], [MaterialGroup], [MaterialGroupText], [ProductHierarchyLevel1Code], [ProductHierarchyLevel1Text], [ProductHierarchyLevel2Code], [ProductHierarchyLevel2Text], [ProductHierarchyLevel3Code], [ProductHierarchyLevel3Text], [EnteredOn], [EnteredAt]) VALUES (10025, N'CSL', N'121200002', N'Fuels', N'10001', N'Condensates', N'10001', N'Condensate Sour', N'10000008', N'Condensate Sour Light', CAST(N'2021-04-06T15:26:44.923' AS DateTime), NULL)
INSERT [dbo].[ProductHierarchy] ([S4Material], [MaterialDescription], [MaterialGroup], [MaterialGroupText], [ProductHierarchyLevel1Code], [ProductHierarchyLevel1Text], [ProductHierarchyLevel2Code], [ProductHierarchyLevel2Text], [ProductHierarchyLevel3Code], [ProductHierarchyLevel3Text], [EnteredOn], [EnteredAt]) VALUES (10026, N'CSH', N'121200002', N'Fuels', N'10001', N'Condensates', N'10001', N'Condensate Sour', N'10000008', N'Condensate Sour Heavy', CAST(N'2021-04-06T15:26:44.930' AS DateTime), NULL)
GO
INSERT [dbo].[SourceUnitMap] ([Source], [SourceUnit], [StandardUnit]) VALUES (N'L', N'L', N'L15')
INSERT [dbo].[SourceUnitMap] ([Source], [SourceUnit], [StandardUnit]) VALUES (N'M3', N'M3', N'M15')
GO
INSERT [dbo].[StandardUnit] ([Name]) VALUES (N'BBL')
INSERT [dbo].[StandardUnit] ([Name]) VALUES (N'KG')
INSERT [dbo].[StandardUnit] ([Name]) VALUES (N'L15')
INSERT [dbo].[StandardUnit] ([Name]) VALUES (N'M15')
INSERT [dbo].[StandardUnit] ([Name]) VALUES (N'M3')
INSERT [dbo].[StandardUnit] ([Name]) VALUES (N'MT')
INSERT [dbo].[StandardUnit] ([Name]) VALUES (N'UG6')
GO
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON 

INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Full', 1, 1, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000003A00000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF3E000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F00000030000000310000003200000033000000340000003500000036000000370000003800000039000000FEFFFFFFFEFFFFFF3C0000003D000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF02000000000000000000000000000000000000000000000000000000000000006049337E2DAED6013B000000800400000000000044006400730058004D004C00530074007200650061006D00000000000000000000000000000000000000000000000000000000000000000000000000000000001A000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000002000000616F00000000000053006300680065006D00610020005500440056002000440065006600610075006C00740000000000000000000000000000000000000000000000000000000000260002010100000003000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C000201FFFFFFFF04000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000001000000FC030000000000003C6464733E3C6469616772616D20666F6E74636C7369643D227B37374432433932442D373737392D313144382D393037302D3030303635423834304439437D22206D6F75736569636F6E636C7369643D227B30424533353230342D384639312D313143452D394445332D3030414130303442423835317D222064656661756C746C61796F75743D224D534444532E52656374696C696E656172222064656661756C746C696E65726F7574653D224D534444532E52656374696C696E656172222076657273696F6E3D223722206E6578746F626A6563743D22333922207363616C653D22313030222070616765627265616B616E63686F72783D2230222070616765627265616B616E63686F72793D2230222070616765627265616B73697A65783D2230222070616765627265616B73697A65793D223022207363726F6C6C6C6566743D222D3530303022207363726F6C6C746F703D222D32363139222067726964783D22313530222067726964793D2231353022206D617267696E783D223530303022206D617267696E793D223530303022207A6F6F6D3D223130302220783D2233313338302220793D22323332383322206261636B636F6C6F723D222D32313437343833363433222064656661756C7470657273697374656E63653D223322205072696E74506167654E756D626572734D6F64653D223322205072696E744D617267696E546F703D223022205072696E744D617267696E426F74746F6D3D2236333522205072696E744D617267696E4C6566743D223022205072696E744D617267696E52696768743D223022206D61727175656573656C656374696F6E6D6F64653D223122206D6F757365706F696E7465723D22302220736E6170746F677269643D223122206175746F74797065616E6E6F746174696F6E3D2231222073686F777363726F6C6C626172733D223122207669657770616765627265616B733D22302220646F6E6F74666F726365636F6E6E6563746F7273626568696E647368617065733D223122206261636B70696374757265636C7369643D227B30303030303030302D303030302D303030302D303030302D3030303030303030303030307D223E3C666F6E743E3C646473786D6C6F626A65637473747265616D777261707065722062696E6172793D22303030303038303033303030303030303030303230303030222F3E3C2F666F6E743E3C6D6F75736569636F6E3E3C646473786D6C6F626A65637473747265616D777261707065722062696E6172793D2236633734303030303030303030303030222F3E3C2F6D6F75736569636F6E3E3C2F6469616772616D3E3C6C61796F75746D616E616765723E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D227363685F6C6162656C735F76697369626C65222076616C75653D22302220766172747970653D223131222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746D616E616765723E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D224261746368202864626F2922206C6566743D2231373535302220746F703D223022206C6F676963616C69643D22312220636F6E74726F6C69643D223122206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223337333122206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2232313433333431323038303030303030383831363030303039333065303030303738353633343132303730303030303031343031303030303432303036313030373430303633303036383030323030303238303036343030363230303666303032393030303030303030303030303030303030303030303030303030303030303030303038303366303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030313030303030303035303030303030353430303030303032633030303030303263303030303030326330303030303033343030303030303030303030303030303030303030303032323239303030303635313530303030303030303030303032643031303030303037303030303030306330303030303030373030303030303163303130303030303630393030303036323037303030303438303330303030316130343030303064663032303030306563303430303030323730363030303062313033303030303237303630303030636230373030303035353035303030303030303030303030303130303030303038383136303030303933306530303030303030303030303030343030303030303034303030303030303230303030303030323030303030303163303130303030663530613030303030303030303030303031303030303030333931333030303037613035303030303030303030303030303130303030303030313030303030303032303030303030303230303030303031633031303030303036303930303030303130303030303030303030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303030303030303030303030303030303064313331303030303039323330303030303030303030303030303030303030303064303030303030303430303030303030343030303030303163303130303030303630393030303061613061303030303930303630303030373835363334313230343030303030303534303030303030303130303030303030313030303030303062303030303030303030303030303030313030303030303032303030303030303330303030303030343030303030303035303030303030303630303030303030373030303030303038303030303030303930303030303030613030303030303034303030303030363430303632303036663030303030303036303030303030343230303631303037343030363330303638303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D2254616742616C616E6365202864626F2922206C6566743D22383730302220746F703D223022206C6F676963616C69643D22332220636F6E74726F6C69643D223222206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D22313037313622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22323134333334313230383030303030303838313630303030646332393030303037383536333431323037303030303030313430313030303035343030363130303637303034323030363130303663303036313030366530303633303036353030323030303238303036343030363230303666303032393030303030303665363733313634343334393336343936643734366534643662373835613633376134613535346434353465353536313662366336643631366135323739363434343561346235333538366337353561353733343761346634333439373334393664373437303561343334393336343936643734366534643662373835613633376134613535346434353465353536313662366336643631366135323739363434343561346235333538366337353561353733343761346634333461333932653635373934613638363435373531363934663639346136663634343835323737363337613666373634633332353236383634343734363639353935383465366334633665363437303632366435323736363433333464373536323664353633303463373934393733343936643663376136333739343933363439366436383330363434383432376134663639333837363633333335323761346336653634373036323664353237363634333334643735363236643536333034633761343636383539353435353738346434343539333434633534343537383030303030303030303030303030303030303030303130303030303030353030303030303534303030303030326330303030303032633030303030303263303030303030333430303030303030303030303030303030303030303030323232393030303030393233303030303030303030303030326430313030303030643030303030303063303030303030303730303030303031633031303030303036303930303030363230373030303034383033303030303161303430303030646630323030303065633034303030303237303630303030623130333030303032373036303030306362303730303030353530353030303030303030303030303031303030303030383831363030303064633239303030303030303030303030306630303030303030633030303030303032303030303030303230303030303031633031303030306635306130303030303030303030303030313030303030303339313330303030633030373030303030303030303030303032303030303030303230303030303030323030303030303032303030303030316330313030303030363039303030303031303030303030303030303030303033393133303030303334303330303030303030303030303030303030303030303030303030303030303230303030303030323030303030303163303130303030303630393030303030303030303030303030303030303030643133313030303030393233303030303030303030303030303030303030303030643030303030303034303030303030303430303030303031633031303030303036303930303030616130613030303039303036303030303738353633343132303430303030303035653030303030303031303030303030303130303030303030623030303030303030303030303030303130303030303030323030303030303033303030303030303430303030303030353030303030303036303030303030303730303030303030383030303030303039303030303030306130303030303030343030303030303634303036323030366630303030303030623030303030303534303036313030363730303432303036313030366330303631303036653030363330303635303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303130303030303030313030303030303634303036323030366630303030303034363030346230303566303035343030363130303637303034323030363130303663303036313030366530303633303036353030356630303432303036313030373430303633303036383030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F54616742616C616E63655F4261746368202864626F2927206265747765656E20274261746368202864626F292720616E64202754616742616C616E6365202864626F292722206C6566743D2231343136382220746F703D222D32353722206C6F676963616C69643D22342220636F6E74726F6C69643D223322206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223336383222206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2234372E393838333139323733313939322220636F6E74726F6C69643D2234222077696474683D223330353722206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D223134373922206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D2231343438312220793D222D333639222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223122206465737469643D22322220736F75726365617474616368706F696E743D223734222064657374617474616368706F696E743D22373522207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D2231373535302220793D22313530222F3E3C706F696E7420783D2231343436382220793D22313530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303131383935323266383138393532322220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D2231343438312220746F703D222D33363922206C6F676963616C69643D22352220636F6E74726F6C69643D223422206D617374657269643D2233222068696E74313D2230222068696E74323D2230222077696474683D223330353722206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22303030323030303066313062303030303538303130303030303330303030303030303030303530303030383030383030303038303031303030303030313530303031303030303030393030313434343230313030303635343631363836663664363131333030343630303462303035663030353430303631303036373030343230303631303036633030363130303665303036333030363530303566303034323030363130303734303036333030363830303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D22436F6E76657273696F6E202864626F2922206C6566743D222D313035302220746F703D223436353022206C6F676963616C69643D2232302220636F6E74726F6C69643D223522206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223330393622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22323134333334313230383030303030303838313630303030313830633030303037383536333431323037303030303030313430313030303034333030366630303665303037363030363530303732303037333030363930303666303036653030323030303238303036343030363230303666303032393030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303130303030303030353030303030303534303030303030326330303030303032633030303030303263303030303030333430303030303030303030303030303030303030303030323232393030303036353135303030303030303030303030326430313030303030373030303030303063303030303030303730303030303031633031303030303036303930303030363230373030303034383033303030303161303430303030646630323030303065633034303030303237303630303030623130333030303032373036303030306362303730303030353530353030303030303030303030303031303030303030383831363030303031383063303030303030303030303030303330303030303030333030303030303032303030303030303230303030303031633031303030306635306130303030303030303030303030313030303030303339313330303030633030373030303030303030303030303032303030303030303230303030303030323030303030303032303030303030316330313030303030363039303030303031303030303030303030303030303033393133303030303334303330303030303030303030303030303030303030303030303030303030303230303030303030323030303030303163303130303030303630393030303030303030303030303030303030303030643133313030303030393233303030303030303030303030303030303030303030643030303030303034303030303030303430303030303031633031303030303036303930303030616130613030303039303036303030303738353633343132303430303030303035653030303030303031303030303030303130303030303030623030303030303030303030303030303130303030303030323030303030303033303030303030303430303030303030353030303030303036303030303030303730303030303030383030303030303039303030303030306130303030303030343030303030303634303036323030366630303030303030623030303030303433303036663030366530303736303036353030373230303733303036393030366630303665303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D22536F75726365556E69744D6170202864626F2922206C6566743D222D3930302220746F703D22313231353022206C6F676963616C69643D2232352220636F6E74726F6C69643D223622206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223330393622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22323134333334313230383030303030303838313630303030313830633030303037383536333431323037303030303030313430313030303035333030366630303735303037323030363330303635303035353030366530303639303037343030346430303631303037303030323030303238303036343030363230303666303032393030303030303336343936643734366534643662373835613633376134613535346434353465353536313662366336643631366135323739363434343561346235333538366337353561353733343761346634333439373334393664373437303561343334393336343936643734366534643662373835613633376134613535346434353465353536313662366336643631366135323739363434343561346235333538366337353561353733343761346634333461333932653635373934613638363435373531363934663639346136663634343835323737363337613666373634633332353236383634343734363639353935383465366334633665363437303632366435323736363433333464373536323664353633303463373934393733343936643663376136333739343933363439366436383330363434383432376134663639333837363633333335323761346336653634373036323664353237363634333334643735363236643536333034633761343636383539353435353738346434343539333434633534343537383030303030303030303030303030303030303030303130303030303030353030303030303534303030303030326330303030303032633030303030303263303030303030333430303030303030303030303030303030303030303030323232393030303036353135303030303030303030303030326430313030303030373030303030303063303030303030303730303030303031633031303030303036303930303030363230373030303034383033303030303161303430303030646630323030303065633034303030303237303630303030623130333030303032373036303030306362303730303030353530353030303030303030303030303031303030303030383831363030303031383063303030303030303030303030303330303030303030333030303030303032303030303030303230303030303031633031303030306635306130303030303030303030303030313030303030303339313330303030303630613030303030303030303030303033303030303030303330303030303030323030303030303032303030303030316330313030303030363039303030303031303030303030303030303030303033393133303030303334303330303030303030303030303030303030303030303030303030303030303230303030303030323030303030303163303130303030303630393030303030303030303030303030303030303030643133313030303030393233303030303030303030303030303030303030303030643030303030303034303030303030303430303030303031633031303030303036303930303030616130613030303039303036303030303738353633343132303430303030303036343030303030303031303030303030303130303030303030623030303030303030303030303030303130303030303030323030303030303033303030303030303430303030303030353030303030303036303030303030303730303030303030383030303030303039303030303030306130303030303030343030303030303634303036323030366630303030303030653030303030303533303036663030373530303732303036333030363530303535303036653030363930303734303034643030363130303730303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D225374616E64617264556E6974202864626F2922206C6566743D222D3930302220746F703D223837303022206C6F676963616C69643D2232362220636F6E74726F6C69643D223722206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223533313822206865696768743D223138323622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223231343333343132303830303030303063363134303030303232303730303030373835363334313230373030303030303134303130303030353330303734303036313030366530303634303036313030373230303634303035353030366530303639303037343030323030303238303036343030363230303666303032393030303030303666303036373030366630303665303032653030366430303639303036333030373230303666303037333030366630303636303037343030363130303761303037353030373230303635303036313030363430303264303037333030373330303666303032653030363330303666303036643030326630303733303037353030366530303633303036663030373230303265303036333030366630303664303032663030373730303639303036653030363130303735303037343030363830303266303037343030373230303735303037333030373430303266303033323030333030303330303033353030326630303737303036393030366530303634303036663030373730303733303037343030373230303631303036653030373330303730303036663030373230303734303033663030363330303663303036393030363530303665303037343030326430303732303036353030373130303735303036353030373330303734303032643030363930303634303033643030333730303337303033303030333830303635303030303030303030303030303030303030303030303031303030303030303530303030303035343030303030303263303030303030326330303030303032633030303030303334303030303030303030303030303030303030303030303232323930303030363531353030303030303030303030303264303130303030303730303030303030633030303030303037303030303030316330313030303030363039303030303632303730303030343830333030303031613034303030306466303230303030656330343030303032373036303030306231303330303030323730363030303063623037303030303535303530303030303030303030303030313030303030306336313430303030323230373030303030303030303030303031303030303030303130303030303030323030303030303032303030303030316330313030303066363039303030303030303030303030303130303030303033393133303030303761303530303030303030303030303030313030303030303031303030303030303230303030303030323030303030303163303130303030303630393030303030313030303030303030303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303030303030303030303030303030306431333130303030303932333030303030303030303030303030303030303030306430303030303030343030303030303034303030303030316330313030303030363039303030306161306130303030393030363030303037383536333431323034303030303030363230303030303030313030303030303031303030303030306230303030303030303030303030303031303030303030303230303030303030333030303030303034303030303030303530303030303030363030303030303037303030303030303830303030303030393030303030303061303030303030303430303030303036343030363230303666303030303030306430303030303035333030373430303631303036653030363430303631303037323030363430303535303036653030363930303734303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323535302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D2230313030303030303031303030303030363430303632303036663030303030303436303034623030356630303533303037343030363130303665303036343030363130303732303036343030353530303665303036393030373430303566303034653030363130303664303036353030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F5374616E64617264556E69745F4E616D65202864626F2927206265747765656E20275374616E64617264556E6974202864626F292720616E642027536F75726365556E69744D6170202864626F292722206C6566743D222D3430372220746F703D223938333122206C6F676963616C69643D2232372220636F6E74726F6C69643D223822206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D2238313522206865696768743D223330313922206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2234392E313236383033333430393236342220636F6E74726F6C69643D2239222077696474683D223332383722206865696768743D223334342220736964653D223122206265686176696F723D2233222068696D65747269633D2237393722206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D223137352220793D223131313534222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223722206465737469643D22362220736F75726365617474616368706F696E743D223131222064657374617474616368706F696E743D22313022207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22302220793D223130353236222F3E3C706F696E7420783D22302220793D223132313530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303131383935323262383138393532322220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D223137352220746F703D22313131353422206C6F676963616C69643D2232382220636F6E74726F6C69643D223922206D617374657269643D2238222068696E74313D2230222068696E74323D2230222077696474683D223332383722206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2230303032303030306437306330303030353830313030303030333030303030303030303030353030303038303038303030303830303130303030303031353030303130303030303039303031343434323031303030363534363136383666366436313134303034363030346230303566303035333030373430303631303036653030363430303631303037323030363430303535303036653030363930303734303035663030346530303631303036643030363530303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D225461674D6170202864626F2922206C6566743D222D313230302220746F703D222D3138303022206C6F676963616C69643D2232392220636F6E74726F6C69643D22313022206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223530303122206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223231343333343132303830303030303038383136303030303839313330303030373835363334313230373030303030303134303130303030353430303631303036373030346430303631303037303030323030303238303036343030363230303666303032393030303030303266303036313030373530303734303036663030366330303666303036373030366630303665303032653030366430303639303036333030373230303666303037333030366630303636303037343030363130303761303037353030373230303635303036313030363430303264303037333030373330303666303032653030363330303666303036643030326630303733303037353030366530303633303036663030373230303265303036333030366630303664303032663030373730303639303036653030363130303735303037343030363830303266303037343030373230303735303037333030373430303266303033323030333030303330303033353030326630303737303036393030366530303634303036663030373730303733303037343030373230303631303036653030373330303730303036663030373230303734303033663030363330303663303036393030363530303665303037343030326430303732303036353030373130303735303036353030373330303734303032643030363930303634303033643030333430303633303033393030333730303336303030303030303030303030303030303030303030303031303030303030303530303030303035343030303030303263303030303030326330303030303032633030303030303334303030303030303030303030303030303030303030303232323930303030616231373030303030303030303030303264303130303030303830303030303030633030303030303037303030303030316330313030303030363039303030303632303730303030343830333030303031613034303030306466303230303030656330343030303032373036303030306231303330303030323730363030303063623037303030303535303530303030303030303030303030313030303030303838313630303030383931333030303030303030303030303036303030303030303630303030303030323030303030303032303030303030316330313030303066353061303030303030303030303030303130303030303033393133303030306330303730303030303030303030303030323030303030303032303030303030303230303030303030323030303030303163303130303030303630393030303030313030303030303030303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303030303030303030303030303030306431333130303030303932333030303030303030303030303030303030303030306430303030303030343030303030303034303030303030316330313030303030363039303030306161306130303030393030363030303037383536333431323034303030303030353630303030303030313030303030303031303030303030306230303030303030303030303030303031303030303030303230303030303030333030303030303034303030303030303530303030303030363030303030303037303030303030303830303030303030393030303030303061303030303030303430303030303036343030363230303666303030303030303730303030303035343030363130303637303034643030363130303730303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303130303030303030313030303030303634303036323030366630303030303034363030346230303566303035343030363130303637303034643030363130303730303035663030353330303734303036313030366530303634303036313030373230303634303035353030366530303639303037343030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F5461674D61705F5374616E64617264556E6974202864626F2927206265747765656E20275374616E64617264556E6974202864626F292720616E6420275461674D6170202864626F292722206C6566743D22343131382220746F703D223236323122206C6F676963616C69643D2233302220636F6E74726F6C69643D22313122206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223230343722206865696768743D223636333722206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2235352E303535303535303535303535312220636F6E74726F6C69643D223132222077696474683D223336303422206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D223437333122206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D22363034302220793D2235333531222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223722206465737469643D2231302220736F75726365617474616368706F696E743D223639222064657374617474616368706F696E743D2231333722207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22343431382220793D2238383530222F3E3C706F696E7420783D22353836352220793D2238383530222F3E3C706F696E7420783D22353836352220793D2233303030222F3E3C706F696E7420783D22343536382220793D2233303030222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303131353935323266383135393532322220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D22363034302220746F703D223533353122206C6F676963616C69643D2233312220636F6E74726F6C69643D22313222206D617374657269643D223131222068696E74313D2230222068696E74323D2230222077696474683D223336303422206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22303030323030303031343065303030303538303130303030303330303030303030303030303530303030383030383030303038303031303030303030313530303031303030303030393030313434343230313030303635343631363836663664363131363030343630303462303035663030353430303631303036373030346430303631303037303030356630303533303037343030363130303665303036343030363130303732303036343030353530303665303036393030373430303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D2230313030353830303031303030303030363430303632303036663030303030303436303034623030356630303433303036663030366530303736303036353030373230303733303036393030366630303665303035663030353330303734303036313030366530303634303036313030373230303634303035353030366530303639303037343030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F436F6E76657273696F6E5F5374616E64617264556E6974202864626F2927206265747765656E20275374616E64617264556E6974202864626F292720616E642027436F6E76657273696F6E202864626F292722206C6566743D222D323437392220746F703D223437323122206C6F676963616C69643D2233332220636F6E74726F6C69643D22313422206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223138373922206865696768743D223436383722206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2235312E303333393132333234323334392220636F6E74726F6C69643D223135222077696474683D223430363622206865696768743D223334342220736964653D223122206265686176696F723D2233222068696D65747269633D223332313922206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D222D363432302220793D2236383839222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223722206465737469643D22352220736F75726365617474616368706F696E743D223730222064657374617474616368706F696E743D22373822207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D222D3930302220793D2239303030222F3E3C706F696E7420783D222D323137392220793D2239303030222F3E3C706F696E7420783D222D323137392220793D2235313030222F3E3C706F696E7420783D222D313035302220793D2235313030222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303132663334323236383266333432322220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D222D363432302220746F703D223638383922206C6F676963616C69643D2233342220636F6E74726F6C69643D22313522206D617374657269643D223134222068696E74313D2230222068696E74323D2230222077696474683D223430363622206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2230303032303030306532306630303030353830313030303030333030303030303030303066666666666630303038303030303830303130303030303031353030303130303030303039303031343434323031303030363534363136383666366436313161303034363030346230303566303034333030366630303665303037363030363530303732303037333030363930303666303036653030356630303533303037343030363130303665303036343030363130303732303036343030353530303665303036393030373430303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D223031303035383030303130303030303036343030363230303666303030303030343630303462303035663030343330303666303036653030373630303635303037323030373330303639303036663030366530303566303035333030373430303631303036653030363430303631303037323030363430303535303036653030363930303734303033313030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F436F6E76657273696F6E5F5374616E64617264556E697431202864626F2927206265747765656E20275374616E64617264556E6974202864626F292720616E642027436F6E76657273696F6E202864626F292722206C6566743D222D323639312220746F703D223435373122206C6F676963616C69643D2233352220636F6E74726F6C69643D22313622206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223230393122206865696768743D223439383722206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2235312E303333393132333234323334392220636F6E74726F6C69643D223137222077696474683D223432333922206865696768743D223334342220736964653D223122206265686176696F723D2233222068696D65747269633D223335383822206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D222D363830352220793D2236383831222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223722206465737469643D22352220736F75726365617474616368706F696E743D223732222064657374617474616368706F696E743D22373622207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D222D3930302220793D2239313530222F3E3C706F696E7420783D222D323339312220793D2239313530222F3E3C706F696E7420783D222D323339312220793D2234393530222F3E3C706F696E7420783D222D313035302220793D2234393530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303132373334323265383237333432322220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D222D363830352220746F703D223638383122206C6F676963616C69643D2233362220636F6E74726F6C69643D22313722206D617374657269643D223136222068696E74313D2230222068696E74323D2230222077696474683D223432333922206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223030303230303030386631303030303035383031303030303033303030303030303030306666666666663030303830303030383030313030303030303135303030313030303030303930303134343432303130303036353436313638366636643631316230303436303034623030356630303433303036663030366530303736303036353030373230303733303036393030366630303665303035663030353330303734303036313030366530303634303036313030373230303634303035353030366530303639303037343030333130303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D2230313030353830303031303030303030363430303632303036663030303030303436303034623030356630303534303036313030363730303432303036313030366330303631303036653030363330303635303035663030353330303734303036313030366530303634303036313030373230303634303035353030366530303639303037343030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F54616742616C616E63655F5374616E64617264556E6974202864626F2927206265747765656E20275374616E64617264556E6974202864626F292720616E64202754616742616C616E6365202864626F292722206C6566743D22343131382220746F703D223930343322206C6F676963616C69643D2233372220636F6E74726F6C69643D22313822206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223438383222206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2231372E383931393732393933323438332220636F6E74726F6C69643D223139222077696474683D223430393522206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D2237363622206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D22343435312220793D2239363235222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223722206465737469643D22322220736F75726365617474616368706F696E743D223737222064657374617474616368706F696E743D2231393822207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22343431382220793D2239343530222F3E3C706F696E7420783D22383730302220793D2239343530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303138353935323233383835393532322220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D22343435312220746F703D223936323522206C6F676963616C69643D2233382220636F6E74726F6C69643D22313922206D617374657269643D223138222068696E74313D2230222068696E74323D2230222077696474683D223430393522206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2230303032303030306666306630303030353830313030303030333030303030303030303066666666666630303038303030303830303130303030303031353030303130303030303039303031343434323031303030363534363136383666366436313161303034363030346230303566303035343030363130303637303034323030363130303663303036313030366530303633303036353030356630303533303037343030363130303665303036343030363130303732303036343030353530303665303036393030373430303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C2F6464733E0D0A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FEFFFFFF02000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F00000010000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F573900000200701D2C7E2DAED601020200001048450000000000000000000000000000000000560200004400610074006100200053006F0075007200630065003D0069006E006D00640065007600610072006D007300760072007500770032003000300031002E00640061007400610062006100730065002E00770069006E0064006F00770073002E006E00650074003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0069006E006D00640065007600610072006D00730071006C007500770032003000300031003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B0045006E00630072007900700074003D0054007200750065003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B00410075007400680065006E007400690063006100740069006F006E003D00220041006300740069007600650020004400690072006500630074006F0072007900200049006E007400650067007200610074006500640022003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F0022000000008005000A000000460075006C006C000000000226000E0000005400610067004D0061007000000008000000640062006F000000000226001A0000005300740061006E00640061007200640055006E0069007400000008000000640062006F000000000226001C00000053006F00750072006300650055006E00690074004D0061007000000008000000640062006F000000000226001600000043006F006E00760065007200730069006F006E00000008000000640062006F0000000002260016000000540061006700420061006C0061006E0063006500000008000000640062006F000000000224000C00000042006100740063006800000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D00000000000000010003000000000000000C0000000B0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000001100000012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
GO
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-01T00:00:00.000' AS DateTime), CAST(17.8280 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(502.550 AS Decimal(18, 3)), CAST(489.400 AS Decimal(18, 3)), CAST(22.825 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-02T00:00:00.000' AS DateTime), CAST(17.9190 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(489.400 AS Decimal(18, 3)), CAST(456.427 AS Decimal(18, 3)), CAST(30.449 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-03T00:00:00.000' AS DateTime), CAST(21.6760 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(456.427 AS Decimal(18, 3)), CAST(438.139 AS Decimal(18, 3)), CAST(28.626 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-04T00:00:00.000' AS DateTime), CAST(27.8780 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(438.139 AS Decimal(18, 3)), CAST(379.187 AS Decimal(18, 3)), CAST(50.280 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(27.0350 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(379.187 AS Decimal(18, 3)), CAST(304.044 AS Decimal(18, 3)), CAST(55.590 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(27.1870 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(304.044 AS Decimal(18, 3)), CAST(289.389 AS Decimal(18, 3)), CAST(32.756 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-07T00:00:00.000' AS DateTime), CAST(29.2950 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(289.389 AS Decimal(18, 3)), CAST(366.480 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-08T00:00:00.000' AS DateTime), CAST(26.0430 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(366.480 AS Decimal(18, 3)), CAST(385.438 AS Decimal(18, 3)), CAST(18.839 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-09T00:00:00.000' AS DateTime), CAST(26.9660 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(385.438 AS Decimal(18, 3)), CAST(313.088 AS Decimal(18, 3)), CAST(54.459 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-10T00:00:00.000' AS DateTime), CAST(19.2220 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(313.088 AS Decimal(18, 3)), CAST(242.411 AS Decimal(18, 3)), CAST(46.079 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-11T00:00:00.000' AS DateTime), CAST(17.7890 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(242.411 AS Decimal(18, 3)), CAST(209.105 AS Decimal(18, 3)), CAST(30.445 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-12T00:00:00.000' AS DateTime), CAST(18.1960 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(209.105 AS Decimal(18, 3)), CAST(196.930 AS Decimal(18, 3)), CAST(22.823 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(19.9720 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(196.930 AS Decimal(18, 3)), CAST(223.449 AS Decimal(18, 3)), CAST(9.894 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-14T00:00:00.000' AS DateTime), CAST(19.2690 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(223.449 AS Decimal(18, 3)), CAST(274.156 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-15T00:00:00.000' AS DateTime), CAST(19.2640 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(274.156 AS Decimal(18, 3)), CAST(280.308 AS Decimal(18, 3)), CAST(16.926 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(17.2820 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(280.308 AS Decimal(18, 3)), CAST(325.787 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-17T00:00:00.000' AS DateTime), CAST(16.9930 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(325.787 AS Decimal(18, 3)), CAST(292.224 AS Decimal(18, 3)), CAST(29.746 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-18T00:00:00.000' AS DateTime), CAST(16.0290 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(292.224 AS Decimal(18, 3)), CAST(299.267 AS Decimal(18, 3)), CAST(13.353 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-19T00:00:00.000' AS DateTime), CAST(17.3050 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(299.267 AS Decimal(18, 3)), CAST(192.490 AS Decimal(18, 3)), CAST(57.881 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-20T00:00:00.000' AS DateTime), CAST(17.7870 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(192.490 AS Decimal(18, 3)), CAST(239.298 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-21T00:00:00.000' AS DateTime), CAST(17.5450 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(239.298 AS Decimal(18, 3)), CAST(245.436 AS Decimal(18, 3)), CAST(15.212 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-22T00:00:00.000' AS DateTime), CAST(17.4770 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(245.436 AS Decimal(18, 3)), CAST(251.384 AS Decimal(18, 3)), CAST(15.217 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-23T00:00:00.000' AS DateTime), CAST(21.3740 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(251.384 AS Decimal(18, 3)), CAST(247.577 AS Decimal(18, 3)), CAST(22.821 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-24T00:00:00.000' AS DateTime), CAST(24.5300 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(247.577 AS Decimal(18, 3)), CAST(225.904 AS Decimal(18, 3)), CAST(32.766 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-25T00:00:00.000' AS DateTime), CAST(23.0480 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(225.904 AS Decimal(18, 3)), CAST(266.536 AS Decimal(18, 3)), CAST(7.608 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-26T00:00:00.000' AS DateTime), CAST(19.1020 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(266.536 AS Decimal(18, 3)), CAST(163.516 AS Decimal(18, 3)), CAST(58.249 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-27T00:00:00.000' AS DateTime), CAST(17.5910 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(163.516 AS Decimal(18, 3)), CAST(209.807 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-28T00:00:00.000' AS DateTime), CAST(17.2220 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(209.807 AS Decimal(18, 3)), CAST(255.127 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-29T00:00:00.000' AS DateTime), CAST(16.8860 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(255.127 AS Decimal(18, 3)), CAST(261.020 AS Decimal(18, 3)), CAST(14.646 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'2', N'Production', N'MTL SP', N'10784', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-30T00:00:00.000' AS DateTime), CAST(17.8980 AS Decimal(18, 4)), N'M15', N'd63feef1-52ba-4d32-a6c8-8580688e3bdf', N'R2PLoader', CAST(261.020 AS Decimal(18, 3)), CAST(288.099 AS Decimal(18, 3)), CAST(7.608 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-01T00:00:00.000' AS DateTime), CAST(34.7590 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(841.292 AS Decimal(18, 3)), CAST(876.303 AS Decimal(18, 3)), CAST(32.048 AS Decimal(18, 3)), CAST(32.300 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-02T00:00:00.000' AS DateTime), CAST(31.7050 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(876.303 AS Decimal(18, 3)), CAST(940.238 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(32.230 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-03T00:00:00.000' AS DateTime), CAST(54.2830 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(940.238 AS Decimal(18, 3)), CAST(930.585 AS Decimal(18, 3)), CAST(96.017 AS Decimal(18, 3)), CAST(32.080 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-04T00:00:00.000' AS DateTime), CAST(82.0360 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(930.585 AS Decimal(18, 3)), CAST(948.679 AS Decimal(18, 3)), CAST(96.022 AS Decimal(18, 3)), CAST(32.080 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(70.2020 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(948.679 AS Decimal(18, 3)), CAST(826.748 AS Decimal(18, 3)), CAST(224.092 AS Decimal(18, 3)), CAST(31.960 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(74.4530 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(826.748 AS Decimal(18, 3)), CAST(837.326 AS Decimal(18, 3)), CAST(96.025 AS Decimal(18, 3)), CAST(32.150 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-07T00:00:00.000' AS DateTime), CAST(75.3780 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(837.326 AS Decimal(18, 3)), CAST(912.705 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-08T00:00:00.000' AS DateTime), CAST(59.4640 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(912.705 AS Decimal(18, 3)), CAST(966.379 AS Decimal(18, 3)), CAST(38.049 AS Decimal(18, 3)), CAST(32.260 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-09T00:00:00.000' AS DateTime), CAST(75.7140 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(966.379 AS Decimal(18, 3)), CAST(1022.130 AS Decimal(18, 3)), CAST(19.963 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-10T00:00:00.000' AS DateTime), CAST(37.5750 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(1022.130 AS Decimal(18, 3)), CAST(958.174 AS Decimal(18, 3)), CAST(127.072 AS Decimal(18, 3)), CAST(25.540 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-11T00:00:00.000' AS DateTime), CAST(36.2440 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(958.174 AS Decimal(18, 3)), CAST(1020.478 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(26.060 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-12T00:00:00.000' AS DateTime), CAST(30.8890 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(1020.478 AS Decimal(18, 3)), CAST(976.370 AS Decimal(18, 3)), CAST(127.567 AS Decimal(18, 3)), CAST(52.570 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(28.9650 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(976.370 AS Decimal(18, 3)), CAST(909.436 AS Decimal(18, 3)), CAST(122.059 AS Decimal(18, 3)), CAST(26.160 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-14T00:00:00.000' AS DateTime), CAST(34.8260 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(909.436 AS Decimal(18, 3)), CAST(857.379 AS Decimal(18, 3)), CAST(113.053 AS Decimal(18, 3)), CAST(26.170 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-15T00:00:00.000' AS DateTime), CAST(28.4770 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(857.379 AS Decimal(18, 3)), CAST(911.577 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(25.720 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(31.4150 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(911.577 AS Decimal(18, 3)), CAST(968.692 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(25.700 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-17T00:00:00.000' AS DateTime), CAST(30.1910 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(968.692 AS Decimal(18, 3)), CAST(806.625 AS Decimal(18, 3)), CAST(218.097 AS Decimal(18, 3)), CAST(25.840 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-18T00:00:00.000' AS DateTime), CAST(29.6550 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(806.625 AS Decimal(18, 3)), CAST(792.075 AS Decimal(18, 3)), CAST(96.025 AS Decimal(18, 3)), CAST(51.820 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-19T00:00:00.000' AS DateTime), CAST(30.0790 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(792.075 AS Decimal(18, 3)), CAST(629.791 AS Decimal(18, 3)), CAST(218.083 AS Decimal(18, 3)), CAST(25.720 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-20T00:00:00.000' AS DateTime), CAST(31.5860 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(629.791 AS Decimal(18, 3)), CAST(591.243 AS Decimal(18, 3)), CAST(96.024 AS Decimal(18, 3)), CAST(25.890 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-21T00:00:00.000' AS DateTime), CAST(31.4920 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(591.243 AS Decimal(18, 3)), CAST(561.074 AS Decimal(18, 3)), CAST(113.081 AS Decimal(18, 3)), CAST(51.420 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-22T00:00:00.000' AS DateTime), CAST(29.1050 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(561.074 AS Decimal(18, 3)), CAST(590.178 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-23T00:00:00.000' AS DateTime), CAST(50.2720 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(590.178 AS Decimal(18, 3)), CAST(635.080 AS Decimal(18, 3)), CAST(31.050 AS Decimal(18, 3)), CAST(25.680 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-24T00:00:00.000' AS DateTime), CAST(61.5890 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(635.080 AS Decimal(18, 3)), CAST(691.277 AS Decimal(18, 3)), CAST(31.063 AS Decimal(18, 3)), CAST(25.670 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-25T00:00:00.000' AS DateTime), CAST(54.5790 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(691.277 AS Decimal(18, 3)), CAST(658.458 AS Decimal(18, 3)), CAST(113.077 AS Decimal(18, 3)), CAST(25.680 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-26T00:00:00.000' AS DateTime), CAST(46.1530 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(658.458 AS Decimal(18, 3)), CAST(730.471 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(25.860 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-27T00:00:00.000' AS DateTime), CAST(22.1320 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(730.471 AS Decimal(18, 3)), CAST(778.573 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(25.970 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-28T00:00:00.000' AS DateTime), CAST(17.7230 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(778.573 AS Decimal(18, 3)), CAST(795.984 AS Decimal(18, 3)), CAST(26.061 AS Decimal(18, 3)), CAST(25.750 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-29T00:00:00.000' AS DateTime), CAST(13.6010 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(795.984 AS Decimal(18, 3)), CAST(809.585 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'3', N'Production', N'MTL SP', N'10783', N'CP02', N'PRO1CP02', N'SUNCOR', NULL, CAST(N'2021-03-30T00:00:00.000' AS DateTime), CAST(20.9320 AS Decimal(18, 4)), N'M15', N'457d4b19-dae3-49a8-a727-9eccbcc5e529', N'R2PLoader', CAST(809.585 AS Decimal(18, 3)), CAST(825.303 AS Decimal(18, 3)), CAST(31.054 AS Decimal(18, 3)), CAST(25.840 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'DIESEL', N'Production', N'Honeywell PB', N'10240', N'CP03', N'PRODCP03', N'Presplit', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(100.0000 AS Decimal(18, 4)), N'L15', N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', N'R2PLoader', CAST(21766022.000 AS Decimal(18, 3)), CAST(21766122.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(1.000 AS Decimal(18, 3)), NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'DIESEL', N'Production', N'Honeywell PB', N'10240', N'CP03', N'PRODCP03', N'Shell', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(-2787.2190 AS Decimal(18, 4)), N'L15', N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', N'R2PLoader', CAST(21766022.000 AS Decimal(18, 3)), CAST(21766122.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(1.000 AS Decimal(18, 3)), NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'DIESEL', N'Production', N'Honeywell PB', N'10240', N'CP03', N'PRODCP03', N'SUNCOR', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(2887.2190 AS Decimal(18, 4)), N'L15', N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', N'R2PLoader', CAST(21766022.000 AS Decimal(18, 3)), CAST(21766122.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(1.000 AS Decimal(18, 3)), NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'KERO', N'Production', N'Honeywell PB', N'10038', N'CP03', N'PRODCP03', N'Presplit', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(-1005.0000 AS Decimal(18, 4)), N'L15', N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', N'R2PLoader', CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(1005.000 AS Decimal(18, 3)), CAST(1.000 AS Decimal(18, 3)), NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'KERO', N'Production', N'Honeywell PB', N'10038', N'CP03', N'PRODCP03', N'Shell', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(-745.2010 AS Decimal(18, 4)), N'L15', N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', N'R2PLoader', CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(1005.000 AS Decimal(18, 3)), CAST(1.000 AS Decimal(18, 3)), NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'KERO', N'Production', N'Honeywell PB', N'10038', N'CP03', N'PRODCP03', N'SUNCOR', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(-259.7990 AS Decimal(18, 4)), N'L15', N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', N'R2PLoader', CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(1005.000 AS Decimal(18, 3)), CAST(1.000 AS Decimal(18, 3)), NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'NATGAS', N'Production', N'Honeywell PB', N'10184', N'CP03', N'PRODCP03', N'Presplit', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(162.0000 AS Decimal(18, 4)), N'L15', N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', N'R2PLoader', CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(162.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.100 AS Decimal(18, 3)), NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'NATGAS', N'Production', N'Honeywell PB', N'10184', N'CP03', N'PRODCP03', N'Shell', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(745.2010 AS Decimal(18, 4)), N'L15', N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', N'R2PLoader', CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(162.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.100 AS Decimal(18, 3)), NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'NATGAS', N'Production', N'Honeywell PB', N'10184', N'CP03', N'PRODCP03', N'SUNCOR', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(-583.2010 AS Decimal(18, 4)), N'L15', N'5080bc24-114a-4d41-8f2d-bda9b28a4df7', N'R2PLoader', CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(162.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.100 AS Decimal(18, 3)), NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-01T00:00:00.000' AS DateTime), CAST(79.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(3530.905 AS Decimal(18, 3)), CAST(3540.636 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-02T00:00:00.000' AS DateTime), CAST(-10.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(3327.405 AS Decimal(18, 3)), CAST(3498.983 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-03T00:00:00.000' AS DateTime), CAST(85.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(3123.906 AS Decimal(18, 3)), CAST(3457.331 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-04T00:00:00.000' AS DateTime), CAST(-9.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(2920.406 AS Decimal(18, 3)), CAST(3415.678 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(47.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(2716.906 AS Decimal(18, 3)), CAST(3374.025 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(-8.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(2513.406 AS Decimal(18, 3)), CAST(3332.373 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-07T00:00:00.000' AS DateTime), CAST(-26.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(2309.906 AS Decimal(18, 3)), CAST(3290.720 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-08T00:00:00.000' AS DateTime), CAST(-7.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(2106.406 AS Decimal(18, 3)), CAST(3249.067 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-09T00:00:00.000' AS DateTime), CAST(36.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(1902.906 AS Decimal(18, 3)), CAST(3207.415 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-10T00:00:00.000' AS DateTime), CAST(-6.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(1699.406 AS Decimal(18, 3)), CAST(3165.762 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-11T00:00:00.000' AS DateTime), CAST(-52.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(1495.906 AS Decimal(18, 3)), CAST(3124.109 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-12T00:00:00.000' AS DateTime), CAST(-5.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(1292.406 AS Decimal(18, 3)), CAST(3082.457 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(-100.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(1088.907 AS Decimal(18, 3)), CAST(3040.804 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-14T00:00:00.000' AS DateTime), CAST(-4.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(885.407 AS Decimal(18, 3)), CAST(2999.151 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-15T00:00:00.000' AS DateTime), CAST(33.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(681.907 AS Decimal(18, 3)), CAST(2957.499 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(-3.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(478.407 AS Decimal(18, 3)), CAST(2915.846 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-17T00:00:00.000' AS DateTime), CAST(-7.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(274.907 AS Decimal(18, 3)), CAST(2874.193 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-18T00:00:00.000' AS DateTime), CAST(-2.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(71.407 AS Decimal(18, 3)), CAST(2832.541 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-19T00:00:00.000' AS DateTime), CAST(-18.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-132.093 AS Decimal(18, 3)), CAST(2790.888 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-20T00:00:00.000' AS DateTime), CAST(-1.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-335.593 AS Decimal(18, 3)), CAST(2749.235 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-21T00:00:00.000' AS DateTime), CAST(32.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-539.093 AS Decimal(18, 3)), CAST(2707.583 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-22T00:00:00.000' AS DateTime), CAST(0.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-742.593 AS Decimal(18, 3)), CAST(2665.930 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-23T00:00:00.000' AS DateTime), CAST(-22.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-946.092 AS Decimal(18, 3)), CAST(2624.277 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-24T00:00:00.000' AS DateTime), CAST(1.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-1149.592 AS Decimal(18, 3)), CAST(2582.625 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-25T00:00:00.000' AS DateTime), CAST(81.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-1353.092 AS Decimal(18, 3)), CAST(2540.972 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-26T00:00:00.000' AS DateTime), CAST(2.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-1556.592 AS Decimal(18, 3)), CAST(2499.319 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-27T00:00:00.000' AS DateTime), CAST(21.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-1760.092 AS Decimal(18, 3)), CAST(2457.667 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Diluted Bitumen', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-28T00:00:00.000' AS DateTime), CAST(3.0000 AS Decimal(18, 4)), N'L15', N'56a6f33a-d2fd-49ce-aa2c-6dee9089eb77', N'R2PLoader', CAST(-1963.592 AS Decimal(18, 3)), CAST(2416.014 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), CAST(0.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-01T00:00:00.000' AS DateTime), CAST(79.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(3530.905 AS Decimal(18, 3)), CAST(3540.636 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-02T00:00:00.000' AS DateTime), CAST(-10.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(3327.405 AS Decimal(18, 3)), CAST(3498.983 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-03T00:00:00.000' AS DateTime), CAST(85.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(3123.906 AS Decimal(18, 3)), CAST(3457.331 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
GO
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-04T00:00:00.000' AS DateTime), CAST(-9.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(2920.406 AS Decimal(18, 3)), CAST(3415.678 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(47.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(2716.906 AS Decimal(18, 3)), CAST(3374.025 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(-8.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(2513.406 AS Decimal(18, 3)), CAST(3332.373 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-07T00:00:00.000' AS DateTime), CAST(-26.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(2309.906 AS Decimal(18, 3)), CAST(3290.720 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-08T00:00:00.000' AS DateTime), CAST(-7.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(2106.406 AS Decimal(18, 3)), CAST(3249.067 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-09T00:00:00.000' AS DateTime), CAST(36.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(1902.906 AS Decimal(18, 3)), CAST(3207.415 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-10T00:00:00.000' AS DateTime), CAST(-6.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(1699.406 AS Decimal(18, 3)), CAST(3165.762 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-11T00:00:00.000' AS DateTime), CAST(-52.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(1495.906 AS Decimal(18, 3)), CAST(3124.109 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-12T00:00:00.000' AS DateTime), CAST(-5.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(1292.406 AS Decimal(18, 3)), CAST(3082.457 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(-100.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(1088.907 AS Decimal(18, 3)), CAST(3040.804 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-14T00:00:00.000' AS DateTime), CAST(-4.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(885.407 AS Decimal(18, 3)), CAST(2999.151 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-15T00:00:00.000' AS DateTime), CAST(33.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(681.907 AS Decimal(18, 3)), CAST(2957.499 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(-3.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(478.407 AS Decimal(18, 3)), CAST(2915.846 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-17T00:00:00.000' AS DateTime), CAST(-7.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(274.907 AS Decimal(18, 3)), CAST(2874.193 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-18T00:00:00.000' AS DateTime), CAST(-2.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(71.407 AS Decimal(18, 3)), CAST(2832.541 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-19T00:00:00.000' AS DateTime), CAST(-18.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-132.093 AS Decimal(18, 3)), CAST(2790.888 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-20T00:00:00.000' AS DateTime), CAST(-1.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-335.593 AS Decimal(18, 3)), CAST(2749.235 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-21T00:00:00.000' AS DateTime), CAST(32.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-539.093 AS Decimal(18, 3)), CAST(2707.583 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-22T00:00:00.000' AS DateTime), CAST(0.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-742.593 AS Decimal(18, 3)), CAST(2665.930 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-23T00:00:00.000' AS DateTime), CAST(-22.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-946.092 AS Decimal(18, 3)), CAST(2624.277 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-24T00:00:00.000' AS DateTime), CAST(1.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-1149.592 AS Decimal(18, 3)), CAST(2582.625 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-25T00:00:00.000' AS DateTime), CAST(81.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-1353.092 AS Decimal(18, 3)), CAST(2540.972 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-26T00:00:00.000' AS DateTime), CAST(2.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-1556.592 AS Decimal(18, 3)), CAST(2499.319 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-27T00:00:00.000' AS DateTime), CAST(21.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-1760.092 AS Decimal(18, 3)), CAST(2457.667 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
INSERT [dbo].[TagBalance] ([Tag], [System], [MovementType], [Material], [Plant], [WorkCenter], [ValType], [Tank], [BalanceDate], [Quantity], [StandardUnit], [BatchId], [CreatedBy], [OpeningInventory], [ClosingInventory], [Shipment], [Receipt], [consumption], [lastUpdated]) VALUES (N'Upgrader_Test', N'Production', N'DPS', N'10271', N'AP01', N'PRO3AP01', N'SUNCOR', NULL, CAST(N'2021-03-28T00:00:00.000' AS DateTime), CAST(3.0000 AS Decimal(18, 4)), N'L15', N'fefe61fb-cced-428b-a1f5-0cb7591ca78d', N'R2PLoader', CAST(-1963.592 AS Decimal(18, 3)), CAST(2416.014 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), NULL, NULL)
GO
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'#1 low benzene HS reformate', N'GP02', N'PRODGP02', N'10136', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'#1 low benzene LS reformate', N'GP02', N'PRODGP02', N'10137', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'#2 low benzene LS reformate', N'GP02', N'PRODGP02', N'10132', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'14BUT_CONS', N'CP01', N'PRODCP01', N'10015', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'2', N'CP02', N'PRO1CP02', N'10784', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'3', N'CP02', N'PRO1CP02', N'10783', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'5', N'CP02', N'PRO1CP02', N'10785', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_ATB - Syncrude Bitumen Atmospheric Tower Bottoms', N'AP01', N'PRO1AP01', N'10019', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_CGO - Coker Gas Oil', N'AP01', N'PRO1AP01', N'10024', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_CK - Coker Kerosene', N'AP01', N'PRO1AP01', N'10023', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_CN - Coker Naphtha', N'AP01', N'PRO1AP01', N'10022', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_Coke', N'AP01', N'PRO1AP01', N'10034', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_Diluent - AP01 De-Hexanizer Naphtha Diluent >75% hydrotreated', N'AP01', N'PRO1AP01', N'10020', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_Diluent - CP04 LVP Naptha Diluent ', N'AP01', N'PRO1AP01', N'10021', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_FDB - Firebag Diluted Bitumen', N'AP01', N'PRO1AP01', N'10017', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_FHB - Firebag Bitumen', N'AP01', N'PRO1AP01', N'10016', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_Fuel Gas', N'AP01', N'PRO1AP01', N'10033', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_Gypsum', N'AP01', N'PRO1AP01', N'10036', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_Limestone', N'AP01', N'PRO1AP01', N'10037', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_MKB - Mackay Bitumen', N'AP01', N'PRO1AP01', N'10018', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_Natural Gas - Hydrogen Feedstock', N'AP01', N'PRO1AP01', N'10032', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_NFT - Mined Diluted Bitumen', N'AP01', N'PRO1AP01', N'10015', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_OSX - Ultra Low Sulphur Diesel ', N'AP01', N'PRO1AP01', N'10027', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_PC4 - Hydrotreated Butane', N'AP01', N'PRO1AP01', N'10028', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_PGO - Hydrotreated Gas Oil', N'AP01', N'PRO1AP01', N'10031', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_PK - Hydrotreated Kerosene', N'AP01', N'PRO1AP01', N'10030', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_PN -  Hydrotreated Coker Naphtha', N'AP01', N'PRO1AP01', N'10029', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_Sulphur Molten', N'AP01', N'PRO1AP01', N'10035', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_VGO - Heavy Vacuum Gas Oil (HVGO)', N'AP01', N'PRO1AP01', N'10026', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'AP01_VK - Light Vacuum Gas Oil (LVGO)', N'AP01', N'PRO1AP01', N'10025', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'ASPH_SOUR', N'GP01', N'PRODGP01', N'10727', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Asphalt Cement 300/400', N'GP02', N'PRODGP02', N'10155', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Asphalt PG 58-28', N'GP02', N'PRODGP02', N'10153', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Asphalt PG 64-22', N'GP02', N'PRODGP02', N'10154', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Asphalt Slop', N'GP02', N'PRODGP02', N'10158', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Asphalt Unit Crude', N'GP02', N'PRODGP02', N'10127', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Crude Sour OSH', N'GP01', N'PRODGP01', N'10727', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'DIESEL', N'CP03', N'PRODCP03', N'10240', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'DIESEL', N'CP04', N'PRODCP04', N'10027', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP #1 Ultra Low Sulfur Diesel', N'GP02', N'PRODGP02', N'10185', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP Crude Unit Diesel', N'GP02', N'PRODGP02', N'10160', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP FCC Charge', N'GP02', N'PRODGP02', N'10162', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP FCC Gasoline', N'GP02', N'PRODGP02', N'10131', N'', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP Iso Butane', N'GP02', N'PRODGP02', N'10141', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP Light Cycle Oil', N'GP02', N'PRODGP02', N'10161', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP Misc. Fuel Gas', N'GP02', N'PRODGP02', N'10172', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP NG Purchased for fuel', N'GP02', N'PRODGP02', N'10173', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP Normal Butane', N'GP02', N'PRODGP02', N'10142', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP Reformate', N'GP02', N'PRODGP02', N'10133', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'EP Reformer Hydrogen', N'GP02', N'PRODGP02', N'10159', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Extraction_Bitumen_SU', N'AP01', N'PRO1AP01', N'10237', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Extraction_Intermediate Kerosene', N'AP01', N'PRO1AP01', N'10137', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Firebag_Bitumen_SU', N'AP02', N'PRODAP02', N'10015', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Firebag_Diluent', N'AP02', N'PRODAP02', N'10016', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Firebag_Intermediate Kerosene', N'AP02', N'PRODAP02', N'10017', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'KERO', N'CP03', N'PRODCP03', N'10038', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'KERO', N'CP04', N'PRODCP04', N'10038', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'NATGAS', N'CP03', N'PRODCP03', N'10184', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'NATGAS', N'CP04', N'PRODCP04', N'10184', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'OIL-STORAGE-CORR-LD', N'EP01', N'PRODEP01', N'10326', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'OIL3', N'EP01', N'PRODEP01', N'11241', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'OIL4', N'EP01', N'PRODEP01', N'11221', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Upgrader_Bitumen_SU', N'AP01', N'PRO1AP01', N'10037', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Upgrader_Crude Oil - OSA', N'AP01', N'PRO1AP01', N'10737', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Upgrader_Crude Oil - OSB', N'AP01', N'PRO1AP01', N'10537', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Upgrader_Crude Oil - OSN', N'AP01', N'PRO1AP01', N'10637', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Upgrader_Diluent', N'AP01', N'PRO1AP01', N'10037', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Upgrader_Heavy Vacum Gas Oil (HVGO)', N'AP01', N'PRO1AP01', N'10337', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'Upgrader_Light Vacuum Gas Oil (LVGO)', N'AP01', N'PRO1AP01', N'10437', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP #1 Ultra Low Sulfur Diesel', N'GP02', N'PRODGP02', N'10145', N'SUNCOR', N'M15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP #2 Ultra Low Sulfur Diesel', N'GP02', N'PRODGP02', N'10146', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP #3 HDS Ultra Low Sulfur Diesel', N'GP02', N'PRODGP02', N'10144', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Carbon Black Oil', N'GP02', N'PRODGP02', N'10151', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP CO2 from SRU', N'GP02', N'PRODGP02', N'10180', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Conv. >9.0 RVP SubPUL', N'GP02', N'PRODGP02', N'10129', N'SUNCORTN', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Conv. >9.0 RVP SubRUL', N'GP02', N'PRODGP02', N'10130', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Debut FCC/Poly Gasoline', N'GP02', N'PRODGP02', N'10135', N'SHELL', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Ethanol', N'GP02', N'PRODGP02', N'10134', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP FCC Coke Consumed', N'GP02', N'PRODGP02', N'10171', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Fuel Gas Consumed', N'GP02', N'PRODGP02', N'10174', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP GOHDS/Crude Unit Sweet Gas Oil', N'GP02', N'PRODGP02', N'10170', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP H2 Plant CO2', N'GP02', N'PRODGP02', N'10179', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP H2 Plant Hydrogen', N'GP02', N'PRODGP02', N'10178', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP H2O from SRU', N'GP02', N'PRODGP02', N'10181', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Hydrogen Sulfide Gas', N'GP02', N'PRODGP02', N'10156', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Jet and #1 Ultra Low Sulfur Deisel', N'GP02', N'PRODGP02', N'10147', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Light Straight Run Gasoline', N'GP02', N'PRODGP02', N'10138', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Misc. Gasoline Components', N'GP02', N'PRODGP02', N'10139', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP N2 from SRU', N'GP02', N'PRODGP02', N'10182', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP NG Purchased as H2 Plant Feed', N'GP02', N'PRODGP02', N'10176', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP NG Purchased for fuel', N'GP02', N'PRODGP02', N'10175', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP NH3 from SRU2', N'GP02', N'PRODGP02', N'10183', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Normal Butane', N'GP02', N'PRODGP02', N'10143', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP O2 to SRU', N'GP02', N'PRODGP02', N'10184', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Propane', N'GP02', N'PRODGP02', N'10140', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Propane/Butane Mix', N'GP02', N'PRODGP02', N'10164', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Raw Biodiesel (truck rack)', N'GP02', N'PRODGP02', N'10149', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Raw Biodiesel by Rail Receipts', N'GP02', N'PRODGP02', N'10150', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Refinery Slop', N'GP02', N'PRODGP02', N'10165', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP SCTU Crude', N'GP02', N'PRODGP02', N'10128', N'', N'L15')
GO
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Sour Diesel', N'GP02', N'PRODGP02', N'10168', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Sour Gas Oil', N'GP02', N'PRODGP02', N'10169', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Sour Gas Oil (#4 HDS Feed)', N'GP02', N'PRODGP02', N'10166', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Sour LSR/Naph/Kero (#2 HDS Feed)', N'GP02', N'PRODGP02', N'10167', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Sour Naphtha', N'GP02', N'PRODGP02', N'10163', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Sulfur', N'GP02', N'PRODGP02', N'10157', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Sweet Resid', N'GP02', N'PRODGP02', N'10152', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Ultra Low Sulfur Kerosine', N'GP02', N'PRODGP02', N'10148', N'SUNCOR', N'L15')
INSERT [dbo].[TagMap] ([Tag], [Plant], [WorkCenter], [MaterialNumber], [DefaultValuationType], [DefaultUnit]) VALUES (N'WP Water/Steam', N'GP02', N'PRODGP02', N'10177', N'SUNCOR', N'L15')
GO
SET IDENTITY_INSERT [dbo].[TransactionEvent] ON 

INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (50, N'COMMERCECITY', N'CommerceCity/immediateScan/031021 INVENTORY (with material codes).xls', 126, 2, N'126 records with no tag mappings', CAST(N'2021-03-30T18:44:14.010' AS DateTime), N'Inventory', NULL)
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (51, N'COMMERCECITY', N'CommerceCity/immediateScan/031021 INVENTORY (with material codes).xls', 126, 2, N'126 records with no tag mappings', CAST(N'2021-03-30T18:45:10.627' AS DateTime), N'Inventory', NULL)
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (52, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-01T13:53:49.097' AS DateTime), N'Material Movement', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",

  "materialMovement": [
    
    {
      "materialDocument": "4900006761",
      "material": "11241",
	  "system" : "S/4 HANA",
	  "movementType": "101",
	  "movementTypeDesc": "Production",
      "plant": "EP01",
	  "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
	  "enteredOn" : "",
	  "enteredAt" : "",
	  "uoe" : "",
	  "quantityUoe": "",
	  "quantityL15": ""	  
    },
	{
      "materialDocument": "4900006762",
      "material": "11221",
	  "system" : "S/4 HANA",
	  "movementType": "101",
	  "movementTypeDesc": "Production",
      "plant": "EP01",
	  "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
	  "enteredOn" : "",
	  "enteredAt" : "",
	  "uoe" : "",
	  "quantityUoe": "",
	  "quantityL15": ""	  
    }
  ]
}
')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (53, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-05T05:38:25.847' AS DateTime), N'Material Movement', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "materialMovement": [
    {
      "materialDocument": "4900006761",
      "material": "11241",
      "system": "S/4 HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "EP01",
      "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
      "enteredOn": "",
      "enteredAt": "",
      "uoe": "",
      "quantityUoe": "",
      "quantityL15": ""
    },
    {
      "materialDocument": "4900006762",
      "material": "11221",
      "system": "S/4 HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "EP01",
      "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
      "enteredOn": "",
      "enteredAt": "",
      "uoe": "",
      "quantityUoe": "",
      "quantityL15": ""
    }
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (54, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-05T05:46:11.837' AS DateTime), N'Material Movement', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "materialMovement": [
    {
      "materialDocument": "4900006761",
      "material": "11241",
	    "system" : "S/4 HANA",
	    "movementType": "101",
	    "movementTypeDesc": "Production",
      "plant": "EP01",
	    "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
	    "enteredOn" : "",
	    "enteredAt" : "",
	    "uoe" : "",
	    "quantityUoe": "",
	    "quantityL15": ""	  
    },
	  {
      "materialDocument": "4900006762",
      "material": "11221",
	    "system" : "S/4 HANA",
	    "movementType": "101",
	    "movementTypeDesc": "Production",
      "plant": "EP01",
	    "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
	    "enteredOn" : "",
	    "enteredAt" : "",
	    "uoe" : "",
	    "quantityUoe": "",
	    "quantityL15": ""	  
    }
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (55, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-05T06:08:09.447' AS DateTime), N'Material Movement', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "materialMovement": [
    {
      "materialDocument": "4900006761",
      "material": "11241",
	    "system" : "S/4 HANA",
	    "movementType": "101",
	    "movementTypeDesc": "Production",
      "plant": "EP01",
	    "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
	    "enteredOn" : "",
	    "enteredAt" : "",
	    "uoe" : "",
	    "quantityUoe": "",
	    "quantityL15": ""	  
    },
	  {
      "materialDocument": "4900006762",
      "material": "11221",
	    "system" : "S/4 HANA",
	    "movementType": "101",
	    "movementTypeDesc": "Production",
      "plant": "EP01",
	    "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
	    "enteredOn" : "",
	    "enteredAt" : "",
	    "uoe" : "",
	    "quantityUoe": "",
	    "quantityL15": ""	  
    }
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (56, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-05T06:24:56.367' AS DateTime), N'Material Movement', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",

  "materialMovement": [
    
    {
      "materialDocument": "4900006761",
      "material": "11241",
	  "system" : "S/4 HANA",
	  "movementType": "101",
	  "movementTypeDesc": "Production",
      "plant": "EP01",
	  "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
	  "enteredOn" : "",
	  "enteredAt" : "",
	  "uoe" : "",
	  "quantityUoe": "",
	  "quantityL15": ""	  
    },
	{
      "materialDocument": "4900006762",
      "material": "11221",
	  "system" : "S/4 HANA",
	  "movementType": "101",
	  "movementTypeDesc": "Production",
      "plant": "EP01",
	  "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
	  "enteredOn" : "",
	  "enteredAt" : "",
	  "uoe" : "",
	  "quantityUoe": "",
	  "quantityL15": ""	  
    }
  ]
}
')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (57, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-05T06:25:04.520' AS DateTime), N'Material Movement', N'{
  "batchId": "d6308f0d-69de-4305-aaeb-07122aabb048",
  "materialMovement": [
    {
      "materialDocument": "4900006761",
      "material": "11241",
      "system": "S/4 HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "EP01",
      "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
      "enteredOn": "",
      "enteredAt": "",
      "uoe": "",
      "quantityUoe": "",
      "quantityL15": ""
    },
    {
      "materialDocument": "4900006762",
      "material": "11221",
      "system": "S/4 HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "EP01",
      "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
      "enteredOn": "",
      "enteredAt": "",
      "uoe": "",
      "quantityUoe": "",
      "quantityL15": ""
    }
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (58, NULL, NULL, NULL, NULL, N'String '''' was not recognized as a valid DateTime. ', CAST(N'2021-04-05T06:27:13.890' AS DateTime), N'MaterialMovement', N'{
  "batchId": "0678fa2a-9086-4123-b80c-0b31c82f1a69",
  "materialMovement": [
    {
      "materialDocument": "5000001316",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "120.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "09:36:26",
      "uoe": "L15",
      "quantityUoe": "120.000",
      "quantityL15": "120.000"
    },
    {
      "materialDocument": "5000001317",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "150.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "09:41:41",
      "uoe": "L15",
      "quantityUoe": "150.000",
      "quantityL15": "150.000"
    },
    {
      "materialDocument": "5000001318",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "120000.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "09:45:29",
      "uoe": "L15",
      "quantityUoe": "120000.000",
      "quantityL15": "120000.000"
    },
    {
      "materialDocument": "5000001319",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "200.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:04:26",
      "uoe": "L15",
      "quantityUoe": "200.000",
      "quantityL15": "200.000"
    },
    {
      "materialDocument": "5000001320",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "250.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:05:40",
      "uoe": "L15",
      "quantityUoe": "250.000",
      "quantityL15": "250.000"
    },
    {
      "materialDocument": "5000001321",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "270.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:07:13",
      "uoe": "L15",
      "quantityUoe": "270.000",
      "quantityL15": "270.000"
    },
    {
      "materialDocument": "5000001322",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "250.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:24:46",
      "uoe": "L15",
      "quantityUoe": "250.000",
      "quantityL15": "250.000"
    },
    {
      "materialDocument": "5000001323",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "170.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:30:46",
      "uoe": "L15",
      "quantityUoe": "170.000",
      "quantityL15": "170.000"
    },
    {
      "materialDocument": "5000001324",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "1000.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:32:17",
      "uoe": "L15",
      "quantityUoe": "1000.000",
      "quantityL15": "1000.000"
    },
    {
      "materialDocument": "4900003083",
      "material": "000000000000010310",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CP04",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "1000.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "12:23:16",
      "uoe": "L15",
      "quantityUoe": "1000.000",
      "quantityL15": "1000.000"
    },
    {
      "materialDocument": "5000001334",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "120.000",
      "uom": "L15",
      "enteredOn": "2020-11-04",
      "enteredAt": "08:08:06",
      "uoe": "L15",
      "quantityUoe": "120.000",
      "quantityL15": "120.000"
    },
    {
      "materialDocument": "5000001334",
      "material": "000000000000010037",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "20668.348",
      "uom": "L15",
      "enteredOn": "2020-11-04",
      "enteredAt": "08:08:06",
      "uoe": "BBL",
      "quantityUoe": "130.000",
      "quantityL15": "20668.348"
    },
    {
      ')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (59, NULL, NULL, NULL, NULL, N'String '''' was not recognized as a valid DateTime. ', CAST(N'2021-04-05T06:40:05.493' AS DateTime), N'MaterialMovement', N'{
  "batchId": "6e0968cb-7cf0-4659-a184-775f93ae70b8",
  "materialMovement": [
    {
      "materialDocument": "5000001316",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "120.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "09:36:26",
      "uoe": "L15",
      "quantityUoe": "120.000",
      "quantityL15": "120.000"
    },
    {
      "materialDocument": "5000001317",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "150.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "09:41:41",
      "uoe": "L15",
      "quantityUoe": "150.000",
      "quantityL15": "150.000"
    },
    {
      "materialDocument": "5000001318",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "120000.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "09:45:29",
      "uoe": "L15",
      "quantityUoe": "120000.000",
      "quantityL15": "120000.000"
    },
    {
      "materialDocument": "5000001319",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "200.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:04:26",
      "uoe": "L15",
      "quantityUoe": "200.000",
      "quantityL15": "200.000"
    },
    {
      "materialDocument": "5000001320",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "250.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:05:40",
      "uoe": "L15",
      "quantityUoe": "250.000",
      "quantityL15": "250.000"
    },
    {
      "materialDocument": "5000001321",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "270.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:07:13",
      "uoe": "L15",
      "quantityUoe": "270.000",
      "quantityL15": "270.000"
    },
    {
      "materialDocument": "5000001322",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "250.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:24:46",
      "uoe": "L15",
      "quantityUoe": "250.000",
      "quantityL15": "250.000"
    },
    {
      "materialDocument": "5000001323",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "170.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:30:46",
      "uoe": "L15",
      "quantityUoe": "170.000",
      "quantityL15": "170.000"
    },
    {
      "materialDocument": "5000001324",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "1000.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "10:32:17",
      "uoe": "L15",
      "quantityUoe": "1000.000",
      "quantityL15": "1000.000"
    },
    {
      "materialDocument": "4900003083",
      "material": "000000000000010310",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CP04",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "1000.000",
      "uom": "L15",
      "enteredOn": "2020-11-03",
      "enteredAt": "12:23:16",
      "uoe": "L15",
      "quantityUoe": "1000.000",
      "quantityL15": "1000.000"
    },
    {
      "materialDocument": "5000001334",
      "material": "000000000000010018",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "120.000",
      "uom": "L15",
      "enteredOn": "2020-11-04",
      "enteredAt": "08:08:06",
      "uoe": "L15",
      "quantityUoe": "120.000",
      "quantityL15": "120.000"
    },
    {
      "materialDocument": "5000001334",
      "material": "000000000000010037",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "20668.348",
      "uom": "L15",
      "enteredOn": "2020-11-04",
      "enteredAt": "08:08:06",
      "uoe": "BBL",
      "quantityUoe": "130.000",
      "quantityL15": "20668.348"
    },
    {
      ')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (60, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-05T07:41:12.033' AS DateTime), N'Material Movement', N'{
  "batchId": "8c9b392b-8592-445a-866d-8299872a0655",
  "materialMovement": [
    {
      "materialDocument": "4900006761",
      "material": "11241",
      "system": "S/4 HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "EP01",
      "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
      "enteredOn": "",
      "enteredAt": "",
      "uoe": "",
      "quantityUoe": "",
      "quantityL15": ""
    },
    {
      "materialDocument": "4900006762",
      "material": "11221",
      "system": "S/4 HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "EP01",
      "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
      "enteredOn": "",
      "enteredAt": "",
      "uoe": "",
      "quantityUoe": "",
      "quantityL15": ""
    }
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (61, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-05T07:53:42.080' AS DateTime), N'Material Movement', N'{
  "batchId": "2d61e8f9-a932-4acc-aec3-0cad2ff36341",
  "materialMovement": [
    {
      "materialDocument": "4900006761",
      "material": "11241",
      "system": "S/4 HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "EP01",
      "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
      "enteredOn": "",
      "enteredAt": "",
      "uoe": "",
      "quantityUoe": "",
      "quantityL15": ""
    },
    {
      "materialDocument": "4900006762",
      "material": "11221",
      "system": "S/4 HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "EP01",
      "headerText": "",
      "postingDate": "2019-10-01T00:00:00",
      "valuationType": "RTFTest2",
      "quantity": "-7075",
      "uom": "M3",
      "enteredOn": "",
      "enteredAt": "",
      "uoe": "",
      "quantityUoe": "",
      "quantityL15": ""
    }
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (62, NULL, NULL, NULL, NULL, N'String '''' was not recognized as a valid DateTime. ', CAST(N'2021-04-05T08:28:12.827' AS DateTime), N'MaterialMovement', N'{
  "batchId": "eb1cbf05-69cd-4676-8df8-fabca12d5299",
  "materialMovement": [
    {
      "materialDocument": "4900004324",
      "material": "000000000000010377",
      "system": "S/4HANA",
      "movementType": "261",
      "movementTypeDesc": "Consumption",
      "plant": "CP03",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "1105000.000",
      "uom": "L15",
      "enteredOn": "2021-01-05",
      "enteredAt": "07:38:05",
      "uoe": "M15",
      "quantityUoe": "1105.000",
      "quantityL15": "1105000.000"
    },
    {
      "materialDocument": "5000001899",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "10.000",
      "uom": "L15",
      "enteredOn": "2021-01-06",
      "enteredAt": "12:30:26",
      "uoe": "L15",
      "quantityUoe": "10.000",
      "quantityL15": "10.000"
    },
    {
      "materialDocument": "5000001900",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "1000.000",
      "uom": "L15",
      "enteredOn": "2021-01-06",
      "enteredAt": "17:57:27",
      "uoe": "L15",
      "quantityUoe": "1000.000",
      "quantityL15": "1000.000"
    },
    {
      "materialDocument": "5000001901",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "1000.000",
      "uom": "L15",
      "enteredOn": "2021-01-06",
      "enteredAt": "18:03:47",
      "uoe": "L15",
      "quantityUoe": "1000.000",
      "quantityL15": "1000.000"
    },
    {
      "materialDocument": "5000001902",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "1000.000",
      "uom": "L15",
      "enteredOn": "2021-01-06",
      "enteredAt": "18:21:36",
      "uoe": "L15",
      "quantityUoe": "1000.000",
      "quantityL15": "1000.000"
    },
    {
      "materialDocument": "5000001903",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "500.000",
      "uom": "L15",
      "enteredOn": "2021-01-06",
      "enteredAt": "18:39:54",
      "uoe": "L15",
      "quantityUoe": "500.000",
      "quantityL15": "500.000"
    },
    {
      "materialDocument": "5000001904",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "100.000",
      "uom": "L15",
      "enteredOn": "2021-01-06",
      "enteredAt": "19:56:21",
      "uoe": "L15",
      "quantityUoe": "100.000",
      "quantityL15": "100.000"
    },
    {
      "materialDocument": "5000001907",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "100.000",
      "uom": "L15",
      "enteredOn": "2021-01-07",
      "enteredAt": "17:15:18",
      "uoe": "L15",
      "quantityUoe": "100.000",
      "quantityL15": "100.000"
    },
    {
      "materialDocument": "5000001908",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "100.000",
      "uom": "L15",
      "enteredOn": "2021-01-07",
      "enteredAt": "17:32:41",
      "uoe": "L15",
      "quantityUoe": "100.000",
      "quantityL15": "100.000"
    },
    {
      "materialDocument": "5000001909",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "100.000",
      "uom": "L15",
      "enteredOn": "2021-01-07",
      "enteredAt": "18:17:00",
      "uoe": "L15",
      "quantityUoe": "100.000",
      "quantityL15": "100.000"
    },
    {
      "materialDocument": "5000001910",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "100.000",
      "uom": "L15",
      "enteredOn": "2021-01-07",
      "enteredAt": "18:35:45",
      "uoe": "L15",
      "quantityUoe": "100.000",
      "quantityL15": "100.000"
    },
    {
      "materialDocument": "5000001918",
      "material": "000000000000010662",
      "system": "S/4HANA",
      "movementType": "101",
      "movementTypeDesc": "Production",
      "plant": "CS08",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "100.000",
      "uom": "L15",
      "enteredOn": "2021-01-08",
      "enteredAt": "10:51:09",
      "uoe": "L15",
      "quantityUoe": "100.000",
      "quantityL15": "100.000"
    },
    {
      "ma')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (63, NULL, NULL, NULL, NULL, N'String '''' was not recognized as a valid DateTime. ', CAST(N'2021-04-05T08:44:31.773' AS DateTime), N'MaterialMovement', N'{
  "batchId": "d7ca974f-a085-49bf-aeec-3ef61aad6fbb",
  "materialMovement": [
    {
      "materialDocument": "4900008067",
      "material": "000000000000010700",
      "system": "S/4HANA",
      "movementType": "531",
      "movementTypeDesc": "Byproduct Production",
      "plant": "GP01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "98.000",
      "uom": "L15",
      "enteredOn": "2021-03-10",
      "enteredAt": "11:46:40",
      "uoe": "L15",
      "quantityUoe": "98.000",
      "quantityL15": "98.000"
    },
    {
      "materialDocument": "4900008214",
      "material": "000000000000010026",
      "system": "S/4HANA",
      "movementType": "261",
      "movementTypeDesc": "Consumption",
      "plant": "AP01",
      "headerText": "",
      "postingDate": "",
      "valuationType": "SUNCOR",
      "quantity": "794.936",
      "uom": "L15",
      "enteredOn": "2021-03-11",
      "enteredAt": "09:39:05",
      "uoe": "BBL",
      "quantityUoe": "5.000",
      "quantityL15": "794.936"
    }
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (64, N'GP01', N'CommerceCity/immediateScan/031021 INVENTORY (with material codes)_WP.xls', 0, 0, N'String '''' was not recognized as a valid DateTime.', CAST(N'2021-04-06T09:51:02.077' AS DateTime), N'R2PLoad', NULL)
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (65, N'GP01', N'CommerceCity/immediateScan/031021 INVENTORY (with material codes)_WP.xls', 0, 0, N'String '''' was not recognized as a valid DateTime.', CAST(N'2021-04-06T09:53:00.863' AS DateTime), N'R2PLoad', NULL)
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (66, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T13:34:27.693' AS DateTime), N'Material Movement', N'{
  "batchId": "07c324e0-095d-45a3-adf1-8367423ab069",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (67, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T13:36:38.237' AS DateTime), N'Material Movement', N'{
  "batchId": "e7de3d27-5f26-4d50-ab41-90e54e670585",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (68, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T13:37:57.053' AS DateTime), N'Material Movement', N'{
  "batchId": "7dd2543f-22cf-4022-907c-5fc5b31b9b07",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (69, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T13:38:14.490' AS DateTime), N'Material Movement', N'{
  "batchId": "43946514-b5c5-4a63-a689-3245868859f3",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (70, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T13:38:26.840' AS DateTime), N'Material Movement', N'{
  "batchId": "919519c0-ca12-41cf-aff9-96f4e0e27bc6",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (71, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T13:41:43.190' AS DateTime), N'Material Movement', N'{
  "batchId": "2e8d0482-88a4-4df2-8e72-60198d66bde7",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (72, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T13:45:08.913' AS DateTime), N'Material Movement', N'{
  "batchId": "7720b0db-8212-4916-b5b5-d1287189538a",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (73, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T13:45:16.293' AS DateTime), N'Material Movement', N'{
  "batchId": "7949a9fa-1e12-4a58-82bb-8ea4d8f8e926",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (74, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T13:45:59.747' AS DateTime), N'Material Movement', N'{
  "batchId": "273cccd3-9f5d-4b9a-87e3-c174d140aedc",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (75, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T14:18:29.910' AS DateTime), N'Material Movement', N'{
  "batchId": "63b7cc79-916a-454e-95e5-e0d3ab538068",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (76, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T14:26:51.247' AS DateTime), N'Material Movement', N'{
  "batchId": "4103cb24-a5b4-4ae0-8bc8-c8412ad5ad21",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (77, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T14:29:37.433' AS DateTime), N'Material Movement', N'{
  "batchId": "975017cb-56ea-4a37-8707-7b6c06381a53",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (78, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T14:30:07.570' AS DateTime), N'Material Movement', N'{
  "batchId": "05eb7464-2270-4277-b2f9-1dc9ace5500e",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (79, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T14:36:20.617' AS DateTime), N'Material Movement', N'{
  "batchId": "b88795e8-8486-449f-9e29-5eb75e787863",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (80, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T14:37:39.897' AS DateTime), N'Material Movement', N'{
  "batchId": "8070d9f0-f060-43ed-a283-f7d46ba9bf41",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (81, NULL, NULL, 0, 0, N'File rejected due to no successfuly records', CAST(N'2021-04-06T14:39:38.243' AS DateTime), N'Material Movement', N'{
  "batchId": "a039e894-df9e-457b-a934-8710ce72a6d4",
  "materialMovement": [
    
  ]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (82, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T09:26:43.767' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (83, NULL, NULL, NULL, NULL, N'Service request failed.
Status: 400 (The requested URI does not represent any resource on the server.)
ErrorCode: InvalidUri

Headers:
Transfer-Encoding: chunked
Server: Microsoft-HTTPAPI/2.0
x-ms-request-id: 73ba5066-c01a-002f-3bf9-2aeb1b000000
x-ms-client-request-id: c73d565d-85a5-483b-92f5-f181771a20bc
x-ms-error-code: InvalidUri
Date: Tue, 06 Apr 2021 15:26:43 GMT
 ', CAST(N'2021-04-06T15:26:44.473' AS DateTime), N'CustodyTicket', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "CustodyTicket":[
  {
    "S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "18A40",
    "BOL Number": "Ticket 190",
    "S/4 Material": "12300",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "400",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021",
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (84, NULL, NULL, 0, 2, N'File completed successfully', CAST(N'2021-04-06T15:26:44.947' AS DateTime), N'ProductHierarchy', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "hierarchy": [
  {
    "S/4 Material": "10025",
    "Material Description": "CSL",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Light"
  },
  {
    "S/4 Material": "10026",
    "Material Description": "CSH",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Heavy"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (85, NULL, NULL, 0, 1, N'File completed successfully', CAST(N'2021-04-06T15:26:45.047' AS DateTime), N'MaterialLedger', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "MaterialLedger":[
  {
    "Plant": "CP01",
    "CoCode": "1060",
    "Posting Year": "2021",
    "Posting Period": "4",
    "Status": "X",
    "Previous Period Open?": "X"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (86, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T15:26:45.137' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (87, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T13:45:02.050' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (88, NULL, NULL, NULL, NULL, N'Service request failed.
Status: 400 (The requested URI does not represent any resource on the server.)
ErrorCode: InvalidUri

Headers:
Transfer-Encoding: chunked
Server: Microsoft-HTTPAPI/2.0
x-ms-request-id: 83f8149f-001a-0052-531d-2b9a38000000
x-ms-client-request-id: 78113d5d-d724-497a-9211-c58c5f7fc1ec
x-ms-error-code: InvalidUri
Date: Tue, 06 Apr 2021 19:45:01 GMT
 ', CAST(N'2021-04-06T19:45:02.333' AS DateTime), N'CustodyTicket', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "CustodyTicket":[
  {
    "S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "18A40",
    "BOL Number": "Ticket 190",
    "S/4 Material": "12300",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "400",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021",
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (89, NULL, NULL, 0, 2, N'File completed successfully', CAST(N'2021-04-06T19:45:02.533' AS DateTime), N'ProductHierarchy', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "hierarchy": [
  {
    "S/4 Material": "10025",
    "Material Description": "CSL",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Light"
  },
  {
    "S/4 Material": "10026",
    "Material Description": "CSH",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Heavy"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (90, NULL, NULL, 0, 1, N'File completed successfully', CAST(N'2021-04-06T19:45:02.590' AS DateTime), N'MaterialLedger', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "MaterialLedger":[
  {
    "Plant": "CP01",
    "CoCode": "1060",
    "Posting Year": "2021",
    "Posting Period": "4",
    "Status": "X",
    "Previous Period Open?": "X"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (91, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T19:45:02.653' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (92, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T14:17:36.887' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (93, NULL, NULL, NULL, NULL, N'Service request failed.
Status: 400 (The requested URI does not represent any resource on the server.)
ErrorCode: InvalidUri

Headers:
Transfer-Encoding: chunked
Server: Microsoft-HTTPAPI/2.0
x-ms-request-id: 83f82b1c-001a-0052-6821-2b9a38000000
x-ms-client-request-id: 82d24779-ce51-4244-85cd-a7a140f43a08
x-ms-error-code: InvalidUri
Date: Tue, 06 Apr 2021 20:17:36 GMT
 ', CAST(N'2021-04-06T20:17:37.150' AS DateTime), N'CustodyTicket', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "CustodyTicket":[
  {
    "S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "18A40",
    "BOL Number": "Ticket 190",
    "S/4 Material": "12300",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "400",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021",
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (94, NULL, NULL, 0, 2, N'File completed successfully', CAST(N'2021-04-06T20:17:37.317' AS DateTime), N'ProductHierarchy', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "hierarchy": [
  {
    "S/4 Material": "10025",
    "Material Description": "CSL",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Light"
  },
  {
    "S/4 Material": "10026",
    "Material Description": "CSH",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Heavy"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (95, NULL, NULL, 0, 1, N'File completed successfully', CAST(N'2021-04-06T20:17:37.360' AS DateTime), N'MaterialLedger', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "MaterialLedger":[
  {
    "Plant": "CP01",
    "CoCode": "1060",
    "Posting Year": "2021",
    "Posting Period": "4",
    "Status": "X",
    "Previous Period Open?": "X"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (96, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T20:17:37.433' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (97, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T14:22:00.363' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (98, NULL, NULL, NULL, NULL, N'Service request failed.
Status: 400 (The requested URI does not represent any resource on the server.)
ErrorCode: InvalidUri

Headers:
Transfer-Encoding: chunked
Server: Microsoft-HTTPAPI/2.0
x-ms-request-id: 83f82e3d-001a-0052-2022-2b9a38000000
x-ms-client-request-id: 3ee849d1-d524-455d-bc73-1fbe25a452b9
x-ms-error-code: InvalidUri
Date: Tue, 06 Apr 2021 20:21:59 GMT
 ', CAST(N'2021-04-06T20:22:00.680' AS DateTime), N'CustodyTicket', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "CustodyTicket":[
  {
    "S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "18A40",
    "BOL Number": "Ticket 190",
    "S/4 Material": "12300",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "400",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021",
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (99, NULL, NULL, 0, 2, N'File completed successfully', CAST(N'2021-04-06T20:22:00.790' AS DateTime), N'ProductHierarchy', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "hierarchy": [
  {
    "S/4 Material": "10025",
    "Material Description": "CSL",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Light"
  },
  {
    "S/4 Material": "10026",
    "Material Description": "CSH",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Heavy"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (100, NULL, NULL, 0, 1, N'File completed successfully', CAST(N'2021-04-06T20:22:00.827' AS DateTime), N'MaterialLedger', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "MaterialLedger":[
  {
    "Plant": "CP01",
    "CoCode": "1060",
    "Posting Year": "2021",
    "Posting Period": "4",
    "Status": "X",
    "Previous Period Open?": "X"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (101, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T20:22:00.887' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (102, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T14:29:25.923' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (103, NULL, NULL, NULL, NULL, N'Service request failed.
Status: 400 (The requested URI does not represent any resource on the server.)
ErrorCode: InvalidUri

Headers:
Transfer-Encoding: chunked
Server: Microsoft-HTTPAPI/2.0
x-ms-request-id: 4cabf124-c01a-005d-1123-2bec54000000
x-ms-client-request-id: f700447d-30b1-4633-959a-f29e5fc9ccb1
x-ms-error-code: InvalidUri
Date: Tue, 06 Apr 2021 20:29:25 GMT
 ', CAST(N'2021-04-06T20:29:26.157' AS DateTime), N'CustodyTicket', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "CustodyTicket":[
  {
    "S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "18A40",
    "BOL Number": "Ticket 190",
    "S/4 Material": "12300",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "400",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021",
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (104, NULL, NULL, 0, 2, N'File completed successfully', CAST(N'2021-04-06T20:29:26.340' AS DateTime), N'ProductHierarchy', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "hierarchy": [
  {
    "S/4 Material": "10025",
    "Material Description": "CSL",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Light"
  },
  {
    "S/4 Material": "10026",
    "Material Description": "CSH",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Heavy"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (105, NULL, NULL, 0, 1, N'File completed successfully', CAST(N'2021-04-06T20:29:26.373' AS DateTime), N'MaterialLedger', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "MaterialLedger":[
  {
    "Plant": "CP01",
    "CoCode": "1060",
    "Posting Year": "2021",
    "Posting Period": "4",
    "Status": "X",
    "Previous Period Open?": "X"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (106, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T20:29:26.437' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (107, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T14:32:04.183' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (108, NULL, NULL, NULL, NULL, N'Service request failed.
Status: 400 (The requested URI does not represent any resource on the server.)
ErrorCode: InvalidUri

Headers:
Transfer-Encoding: chunked
Server: Microsoft-HTTPAPI/2.0
x-ms-request-id: 4cabf319-c01a-005d-3623-2bec54000000
x-ms-client-request-id: 1425db60-dfce-47db-b8f1-125acc984fc7
x-ms-error-code: InvalidUri
Date: Tue, 06 Apr 2021 20:32:03 GMT
 ', CAST(N'2021-04-06T20:32:04.413' AS DateTime), N'CustodyTicket', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "CustodyTicket":[
  {
    "S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "18A40",
    "BOL Number": "Ticket 190",
    "S/4 Material": "12300",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "400",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021",
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (109, NULL, NULL, 0, 2, N'File completed successfully', CAST(N'2021-04-06T20:32:04.507' AS DateTime), N'ProductHierarchy', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "hierarchy": [
  {
    "S/4 Material": "10025",
    "Material Description": "CSL",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Light"
  },
  {
    "S/4 Material": "10026",
    "Material Description": "CSH",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Heavy"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (110, NULL, NULL, 0, 1, N'File completed successfully', CAST(N'2021-04-06T20:32:04.543' AS DateTime), N'MaterialLedger', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "MaterialLedger":[
  {
    "Plant": "CP01",
    "CoCode": "1060",
    "Posting Year": "2021",
    "Posting Period": "4",
    "Status": "X",
    "Previous Period Open?": "X"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (111, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T20:32:04.597' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (112, NULL, NULL, NULL, NULL, N'Service request failed.
Status: 400 (The requested URI does not represent any resource on the server.)
ErrorCode: InvalidUri

Headers:
Transfer-Encoding: chunked
Server: Microsoft-HTTPAPI/2.0
x-ms-request-id: 4cabf583-c01a-005d-7224-2bec54000000
x-ms-client-request-id: 28ed4ad8-b06d-4b71-9b03-43eacb61a81e
x-ms-error-code: InvalidUri
Date: Tue, 06 Apr 2021 20:35:43 GMT
 ', CAST(N'2021-04-06T20:35:44.107' AS DateTime), N'CustodyTicket', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "CustodyTicket":[
  {
    "S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "18A40",
    "BOL Number": "Ticket 190",
    "S/4 Material": "12300",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "400",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021",
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (113, NULL, NULL, NULL, NULL, N'Service request failed.
Status: 400 (The requested URI does not represent any resource on the server.)
ErrorCode: InvalidUri

Headers:
Transfer-Encoding: chunked
Server: Microsoft-HTTPAPI/2.0
x-ms-request-id: 48c75c68-801a-0001-7c25-2bb90c000000
x-ms-client-request-id: 571e6e34-ef9b-407b-b4fd-43f72bb2bcac
x-ms-error-code: InvalidUri
Date: Tue, 06 Apr 2021 20:41:23 GMT
 ', CAST(N'2021-04-06T20:41:24.210' AS DateTime), N'CustodyTicket', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "CustodyTicket":[
  {
    "S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "18A40",
    "BOL Number": "Ticket 190",
    "S/4 Material": "12300",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "400",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021",
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (114, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T14:42:42.830' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (115, NULL, NULL, NULL, NULL, N'Service request failed.
Status: 400 (The requested URI does not represent any resource on the server.)
ErrorCode: InvalidUri

Headers:
Transfer-Encoding: chunked
Server: Microsoft-HTTPAPI/2.0
x-ms-request-id: 48c75d3f-801a-0001-6e25-2bb90c000000
x-ms-client-request-id: b36d31a9-b4d6-44de-a9ca-42c23dedbcda
x-ms-error-code: InvalidUri
Date: Tue, 06 Apr 2021 20:42:42 GMT
 ', CAST(N'2021-04-06T20:42:43.153' AS DateTime), N'CustodyTicket', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "CustodyTicket":[
  {
    "S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "1010101018",
    "BOL Number": "100009_",
    "S/4 Material": "12345",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "600",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021"
  },
  {
	"S4MaterialDocument": "45000010101",
    "Version": "1",
    "Batch ID": "18A40",
    "BOL Number": "Ticket 190",
    "S/4 Material": "12300",
    "System": "S4HANA",
    "Movement Type Description": "Custody Ticket",
    "Sign": "+",
    "Gross Quantity Size": "600",
    "Net Quantity Size": "400",
    "Mass (Kilos / lbs etc.)": "",
    "Net Quantity Size in UoE": "600",
    "Quantity in L15": "",
    "Quantity in BB6": "",
    "Quantity in MT": "",
    "BaseUoM": "L15",
    "UoE": "L15",
    "Valuation Type": "Suncor",
    "Density": "0.98",
    "Origin": "FP01",
    "Destination": "FT01",
    "Plant": "FT01",
    "Temperature": "",
    "Temperature Unit of Measure": "",
    "S/4 Movement Type": "602",
    "Mode (will be a number - confirm translation)": "Rail",
    "Ship": "",
    "RailCar": "CTCX01010",
    "Tender": "",
    "Transportation Details": "",
    "Load Start Date": "",
    "Load Start Time": "",
    "Load End Date": "",
    "Load End Time": "",
    "Entered On": "",
    "Entered At": "",
    "Document Date": "",
    "HeaderText": "",
    "Posting Date+Time": "2/13/2021",
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (116, NULL, NULL, 0, 2, N'File completed successfully', CAST(N'2021-04-06T20:42:43.900' AS DateTime), N'ProductHierarchy', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "hierarchy": [
  {
    "S/4 Material": "10025",
    "Material Description": "CSL",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Light"
  },
  {
    "S/4 Material": "10026",
    "Material Description": "CSH",
    "Material Group": "121200002",
    "Material Group Text": "Fuels",
    "Product Hierarchy Level 1": "10001",
    "Product Hierarchy Level 2": "10001",
    "Product Hierarchy Level 3": "10000008",
    "Product Hierarchy Text Level 1": "Condensates",
    "Product Hierarchy Text Level 2": "Condensate Sour",
    "Product Hierarchy Text Level 3": "Condensate Sour Heavy"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (117, NULL, NULL, 0, 1, N'File completed successfully', CAST(N'2021-04-06T20:42:44.057' AS DateTime), N'MaterialLedger', N'{
  "batchId": "98347512-0c9e-47f5-9123-b9266218404b",
  "MaterialLedger":[
  {
    "Plant": "CP01",
    "CoCode": "1060",
    "Posting Year": "2021",
    "Posting Period": "4",
    "Status": "X",
    "Previous Period Open?": "X"
  }
]
}')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (118, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-06T20:42:44.853' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (119, N'GP01', N'CommerceCity/immediateScan/031021 INVENTORY (with material codes)_WP.xls', 0, 0, N'String '''' was not recognized as a valid DateTime.', CAST(N'2021-04-07T15:09:01.893' AS DateTime), N'R2PLoad', NULL)
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (120, N'GP01', N'CommerceCity/immediateScan/031021 INVENTORY (with material codes)_WP.xls', 0, 0, N'String '''' was not recognized as a valid DateTime.', CAST(N'2021-04-07T09:48:01.277' AS DateTime), N'R2PLoad', NULL)
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (121, N'GP01', N'CommerceCity/immediateScan/031021 INVENTORY (with material codes)_WP.xls', 0, 0, N'String '''' was not recognized as a valid DateTime.', CAST(N'2021-04-07T09:51:26.430' AS DateTime), N'R2PLoad', NULL)
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (122, N'COMMERCECITY', N'CommerceCity/immediateScan/031021 INVENTORY (with material codes).b.xls', 126, 2, N'126 records with no tag mappings', CAST(N'2021-04-07T09:57:26.253' AS DateTime), N'Inventory', NULL)
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (123, N'COMMERCECITY', N'CommerceCity/immediateScan/031021 INVENTORY (with material codes)_WP.xls', 126, 2, N'126 records with no tag mappings', CAST(N'2021-04-07T10:05:20.280' AS DateTime), N'Inventory', NULL)
INSERT [dbo].[TransactionEvent] ([TransactionEvent_id], [plant], [filename], [failedRecordCount], [successfulRecordCount], [message], [createDate], [type], [extra]) VALUES (124, N'EP01', NULL, 0, 2, N'Load completed successfully', CAST(N'2021-04-07T11:49:52.483' AS DateTime), N'Material Movement', N'{    "batchId": "98347512-0c9e-47f5-9123-b9266218404b",    "materialMovement": [
 {
   "materialDocument": "4900006761",
   "material": "11241",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 },
 {
   "materialDocument": "4900006762",
   "material": "11221",
   "system": "S/4 HANA",
   "movementType": "101",
   "movementTypeDesc": "Production",
   "plant": "EP01",
   "headerText": "",
   "postingDate": "2019-10-01T00:00:00",
   "valuationType": "RTFTest2",
   "quantity": "-7075",
   "uom": "M3",
   "enteredOn": "",
   "enteredAt": "",
   "uoe": "",
   "quantityUoe": "",
   "quantityL15": ""
 }    ]  }')
SET IDENTITY_INSERT [dbo].[TransactionEvent] OFF
GO
SET IDENTITY_INSERT [dbo].[TransactionEventDetail] ON 

INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (645, 50, N'Error', N'No TagMapping', N'DOM_SWT_CD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (646, 50, N'Error', N'No TagMapping', N'E_ULTRA#1LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (647, 50, N'Error', N'No TagMapping', N'E_ULTRA#2LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (648, 50, N'Error', N'No TagMapping', N'HDS#3LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (649, 50, N'Error', N'No TagMapping', N'ULTRA#2LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (650, 50, N'Error', N'No TagMapping', N'RAWBIODSRAIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (651, 50, N'Error', N'No TagMapping', N'E_SWTGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (652, 50, N'Error', N'No TagMapping', N'SOURGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (653, 50, N'Error', N'No TagMapping', N'SRGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (654, 50, N'Error', N'No TagMapping', N'SWTGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (655, 50, N'Error', N'No TagMapping', N'C3')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (656, 50, N'Error', N'No TagMapping', N'E_C3_W_ODOR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (657, 50, N'Error', N'No TagMapping', N'E_IC4_SALES')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (658, 50, N'Error', N'No TagMapping', N'E_NC4')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (659, 50, N'Error', N'No TagMapping', N'NC4')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (660, 50, N'Error', N'No TagMapping', N'AC10')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (661, 50, N'Error', N'No TagMapping', N'AC20')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (662, 50, N'Error', N'No TagMapping', N'PB300/400')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (663, 50, N'Error', N'No TagMapping', N'E_SWTRESID')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (664, 50, N'Error', N'No TagMapping', N'SWTRESID')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (665, 50, N'Error', N'No TagMapping', N'CARBBLKOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (666, 50, N'Error', N'No TagMapping', N'E_CARBBLKOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (667, 50, N'Error', N'No TagMapping', N'ASPHSLOP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (668, 50, N'Error', N'No TagMapping', N'E_SLOP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (669, 50, N'Error', N'No TagMapping', N'E_LTCYCOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (670, 50, N'Error', N'No TagMapping', N'E_LSDDYEDAD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (671, 50, N'Error', N'No TagMapping', N'E_KJ**L05U')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (672, 50, N'Error', N'No TagMapping', N'ULTRAKERO')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (673, 50, N'Error', N'No TagMapping', N'E_COLO_SWEET')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (674, 50, N'Error', N'No TagMapping', N'CP890H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (675, 50, N'Error', N'No TagMapping', N'CR830H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (676, 50, N'Error', N'No TagMapping', N'E_CP890H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (677, 50, N'Error', N'No TagMapping', N'E_CP890L******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (678, 50, N'Error', N'No TagMapping', N'E_CR820H')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (679, 50, N'Error', N'No TagMapping', N'E_TRANSMIX')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (680, 50, N'Error', N'No TagMapping', N'ETHANOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (681, 50, N'Error', N'No TagMapping', N'E_ETHANOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (682, 50, N'Error', N'No TagMapping', N'E_FCCGASOLN')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (683, 50, N'Error', N'No TagMapping', N'E_LBLSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (684, 50, N'Error', N'No TagMapping', N'E_SULFUR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (685, 50, N'Error', N'No TagMapping', N'FCCPOLYC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (686, 50, N'Error', N'No TagMapping', N'LSRC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (687, 50, N'Error', N'No TagMapping', N'E_LSRC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (688, 50, N'Error', N'No TagMapping', N'LBLSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (689, 50, N'Error', N'No TagMapping', N'MISCGASOLINE')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (690, 50, N'Error', N'No TagMapping', N'E_NAP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (691, 50, N'Error', N'No TagMapping', N'')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (692, 50, N'Error', N'No TagMapping', N'NAPSR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (693, 50, N'Error', N'No TagMapping', N'PB')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (694, 50, N'Error', N'No TagMapping', N'SOURKERO')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (695, 50, N'Error', N'No TagMapping', N'SRDIESEL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (696, 50, N'Error', N'No TagMapping', N'ULTRAJET#1')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (697, 50, N'Error', N'No TagMapping', N'LBHSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (698, 50, N'Error', N'No TagMapping', N'SULFUR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (699, 51, N'Error', N'No TagMapping', N'DOM_SWT_CD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (700, 51, N'Error', N'No TagMapping', N'E_ULTRA#1LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (701, 51, N'Error', N'No TagMapping', N'E_ULTRA#2LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (702, 51, N'Error', N'No TagMapping', N'HDS#3LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (703, 51, N'Error', N'No TagMapping', N'ULTRA#2LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (704, 51, N'Error', N'No TagMapping', N'RAWBIODSRAIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (705, 51, N'Error', N'No TagMapping', N'E_SWTGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (706, 51, N'Error', N'No TagMapping', N'SOURGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (707, 51, N'Error', N'No TagMapping', N'SRGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (708, 51, N'Error', N'No TagMapping', N'SWTGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (709, 51, N'Error', N'No TagMapping', N'C3')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (710, 51, N'Error', N'No TagMapping', N'E_C3_W_ODOR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (711, 51, N'Error', N'No TagMapping', N'E_IC4_SALES')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (712, 51, N'Error', N'No TagMapping', N'E_NC4')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (713, 51, N'Error', N'No TagMapping', N'NC4')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (714, 51, N'Error', N'No TagMapping', N'AC10')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (715, 51, N'Error', N'No TagMapping', N'AC20')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (716, 51, N'Error', N'No TagMapping', N'PB300/400')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (717, 51, N'Error', N'No TagMapping', N'E_SWTRESID')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (718, 51, N'Error', N'No TagMapping', N'SWTRESID')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (719, 51, N'Error', N'No TagMapping', N'CARBBLKOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (720, 51, N'Error', N'No TagMapping', N'E_CARBBLKOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (721, 51, N'Error', N'No TagMapping', N'ASPHSLOP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (722, 51, N'Error', N'No TagMapping', N'E_SLOP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (723, 51, N'Error', N'No TagMapping', N'E_LTCYCOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (724, 51, N'Error', N'No TagMapping', N'E_LSDDYEDAD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (725, 51, N'Error', N'No TagMapping', N'E_KJ**L05U')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (726, 51, N'Error', N'No TagMapping', N'ULTRAKERO')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (727, 51, N'Error', N'No TagMapping', N'E_COLO_SWEET')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (728, 51, N'Error', N'No TagMapping', N'CP890H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (729, 51, N'Error', N'No TagMapping', N'CR830H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (730, 51, N'Error', N'No TagMapping', N'E_CP890H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (731, 51, N'Error', N'No TagMapping', N'E_CP890L******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (732, 51, N'Error', N'No TagMapping', N'E_CR820H')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (733, 51, N'Error', N'No TagMapping', N'E_TRANSMIX')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (734, 51, N'Error', N'No TagMapping', N'ETHANOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (735, 51, N'Error', N'No TagMapping', N'E_ETHANOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (736, 51, N'Error', N'No TagMapping', N'E_FCCGASOLN')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (737, 51, N'Error', N'No TagMapping', N'E_LBLSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (738, 51, N'Error', N'No TagMapping', N'E_SULFUR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (739, 51, N'Error', N'No TagMapping', N'FCCPOLYC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (740, 51, N'Error', N'No TagMapping', N'LSRC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (741, 51, N'Error', N'No TagMapping', N'E_LSRC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (742, 51, N'Error', N'No TagMapping', N'LBLSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (743, 51, N'Error', N'No TagMapping', N'MISCGASOLINE')
GO
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (744, 51, N'Error', N'No TagMapping', N'E_NAP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (745, 51, N'Error', N'No TagMapping', N'')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (746, 51, N'Error', N'No TagMapping', N'NAPSR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (747, 51, N'Error', N'No TagMapping', N'PB')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (748, 51, N'Error', N'No TagMapping', N'SOURKERO')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (749, 51, N'Error', N'No TagMapping', N'SRDIESEL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (750, 51, N'Error', N'No TagMapping', N'ULTRAJET#1')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (751, 51, N'Error', N'No TagMapping', N'LBHSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (752, 51, N'Error', N'No TagMapping', N'SULFUR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (753, 122, N'Error', N'No TagMapping', N'DOM_SWT_CD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (754, 122, N'Error', N'No TagMapping', N'E_ULTRA#1LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (755, 122, N'Error', N'No TagMapping', N'E_ULTRA#2LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (756, 122, N'Error', N'No TagMapping', N'HDS#3LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (757, 122, N'Error', N'No TagMapping', N'ULTRA#2LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (758, 122, N'Error', N'No TagMapping', N'RAWBIODSRAIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (759, 122, N'Error', N'No TagMapping', N'E_SWTGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (760, 122, N'Error', N'No TagMapping', N'SOURGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (761, 122, N'Error', N'No TagMapping', N'SRGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (762, 122, N'Error', N'No TagMapping', N'SWTGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (763, 122, N'Error', N'No TagMapping', N'C3')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (764, 122, N'Error', N'No TagMapping', N'E_C3_W_ODOR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (765, 122, N'Error', N'No TagMapping', N'E_IC4_SALES')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (766, 122, N'Error', N'No TagMapping', N'E_NC4')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (767, 122, N'Error', N'No TagMapping', N'NC4')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (768, 122, N'Error', N'No TagMapping', N'AC10')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (769, 122, N'Error', N'No TagMapping', N'AC20')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (770, 122, N'Error', N'No TagMapping', N'PB300/400')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (771, 122, N'Error', N'No TagMapping', N'E_SWTRESID')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (772, 122, N'Error', N'No TagMapping', N'SWTRESID')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (773, 122, N'Error', N'No TagMapping', N'CARBBLKOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (774, 122, N'Error', N'No TagMapping', N'E_CARBBLKOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (775, 122, N'Error', N'No TagMapping', N'ASPHSLOP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (776, 122, N'Error', N'No TagMapping', N'E_SLOP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (777, 122, N'Error', N'No TagMapping', N'E_LTCYCOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (778, 122, N'Error', N'No TagMapping', N'E_LSDDYEDAD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (779, 122, N'Error', N'No TagMapping', N'E_KJ**L05U')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (780, 122, N'Error', N'No TagMapping', N'ULTRAKERO')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (781, 122, N'Error', N'No TagMapping', N'E_COLO_SWEET')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (782, 122, N'Error', N'No TagMapping', N'CP890H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (783, 122, N'Error', N'No TagMapping', N'CR830H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (784, 122, N'Error', N'No TagMapping', N'E_CP890H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (785, 122, N'Error', N'No TagMapping', N'E_CP890L******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (786, 122, N'Error', N'No TagMapping', N'E_CR820H')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (787, 122, N'Error', N'No TagMapping', N'E_TRANSMIX')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (788, 122, N'Error', N'No TagMapping', N'ETHANOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (789, 122, N'Error', N'No TagMapping', N'E_ETHANOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (790, 122, N'Error', N'No TagMapping', N'E_FCCGASOLN')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (791, 122, N'Error', N'No TagMapping', N'E_LBLSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (792, 122, N'Error', N'No TagMapping', N'E_SULFUR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (793, 122, N'Error', N'No TagMapping', N'FCCPOLYC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (794, 122, N'Error', N'No TagMapping', N'LSRC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (795, 122, N'Error', N'No TagMapping', N'E_LSRC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (796, 122, N'Error', N'No TagMapping', N'LBLSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (797, 122, N'Error', N'No TagMapping', N'MISCGASOLINE')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (798, 122, N'Error', N'No TagMapping', N'E_NAP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (799, 122, N'Error', N'No TagMapping', N'')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (800, 122, N'Error', N'No TagMapping', N'NAPSR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (801, 122, N'Error', N'No TagMapping', N'PB')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (802, 122, N'Error', N'No TagMapping', N'SOURKERO')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (803, 122, N'Error', N'No TagMapping', N'SRDIESEL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (804, 122, N'Error', N'No TagMapping', N'ULTRAJET#1')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (805, 122, N'Error', N'No TagMapping', N'LBHSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (806, 122, N'Error', N'No TagMapping', N'SULFUR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (807, 123, N'Error', N'No TagMapping', N'DOM_SWT_CD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (808, 123, N'Error', N'No TagMapping', N'E_ULTRA#1LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (809, 123, N'Error', N'No TagMapping', N'E_ULTRA#2LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (810, 123, N'Error', N'No TagMapping', N'HDS#3LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (811, 123, N'Error', N'No TagMapping', N'ULTRA#2LSD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (812, 123, N'Error', N'No TagMapping', N'RAWBIODSRAIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (813, 123, N'Error', N'No TagMapping', N'E_SWTGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (814, 123, N'Error', N'No TagMapping', N'SOURGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (815, 123, N'Error', N'No TagMapping', N'SRGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (816, 123, N'Error', N'No TagMapping', N'SWTGASOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (817, 123, N'Error', N'No TagMapping', N'C3')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (818, 123, N'Error', N'No TagMapping', N'E_C3_W_ODOR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (819, 123, N'Error', N'No TagMapping', N'E_IC4_SALES')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (820, 123, N'Error', N'No TagMapping', N'E_NC4')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (821, 123, N'Error', N'No TagMapping', N'NC4')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (822, 123, N'Error', N'No TagMapping', N'AC10')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (823, 123, N'Error', N'No TagMapping', N'AC20')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (824, 123, N'Error', N'No TagMapping', N'PB300/400')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (825, 123, N'Error', N'No TagMapping', N'E_SWTRESID')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (826, 123, N'Error', N'No TagMapping', N'SWTRESID')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (827, 123, N'Error', N'No TagMapping', N'CARBBLKOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (828, 123, N'Error', N'No TagMapping', N'E_CARBBLKOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (829, 123, N'Error', N'No TagMapping', N'ASPHSLOP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (830, 123, N'Error', N'No TagMapping', N'E_SLOP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (831, 123, N'Error', N'No TagMapping', N'E_LTCYCOIL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (832, 123, N'Error', N'No TagMapping', N'E_LSDDYEDAD')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (833, 123, N'Error', N'No TagMapping', N'E_KJ**L05U')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (834, 123, N'Error', N'No TagMapping', N'ULTRAKERO')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (835, 123, N'Error', N'No TagMapping', N'E_COLO_SWEET')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (836, 123, N'Error', N'No TagMapping', N'CP890H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (837, 123, N'Error', N'No TagMapping', N'CR830H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (838, 123, N'Error', N'No TagMapping', N'E_CP890H******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (839, 123, N'Error', N'No TagMapping', N'E_CP890L******')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (840, 123, N'Error', N'No TagMapping', N'E_CR820H')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (841, 123, N'Error', N'No TagMapping', N'E_TRANSMIX')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (842, 123, N'Error', N'No TagMapping', N'ETHANOL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (843, 123, N'Error', N'No TagMapping', N'E_ETHANOL')
GO
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (844, 123, N'Error', N'No TagMapping', N'E_FCCGASOLN')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (845, 123, N'Error', N'No TagMapping', N'E_LBLSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (846, 123, N'Error', N'No TagMapping', N'E_SULFUR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (847, 123, N'Error', N'No TagMapping', N'FCCPOLYC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (848, 123, N'Error', N'No TagMapping', N'LSRC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (849, 123, N'Error', N'No TagMapping', N'E_LSRC5')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (850, 123, N'Error', N'No TagMapping', N'LBLSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (851, 123, N'Error', N'No TagMapping', N'MISCGASOLINE')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (852, 123, N'Error', N'No TagMapping', N'E_NAP')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (853, 123, N'Error', N'No TagMapping', N'')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (854, 123, N'Error', N'No TagMapping', N'NAPSR')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (855, 123, N'Error', N'No TagMapping', N'PB')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (856, 123, N'Error', N'No TagMapping', N'SOURKERO')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (857, 123, N'Error', N'No TagMapping', N'SRDIESEL')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (858, 123, N'Error', N'No TagMapping', N'ULTRAJET#1')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (859, 123, N'Error', N'No TagMapping', N'LBHSREF')
INSERT [dbo].[TransactionEventDetail] ([TransactionEventDetail_id], [TransactionEvent_id], [type], [message], [tag]) VALUES (860, 123, N'Error', N'No TagMapping', N'SULFUR')
SET IDENTITY_INSERT [dbo].[TransactionEventDetail] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 4/7/2021 1:27:25 PM ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventorySnapshot] ADD  DEFAULT (getdate()) FOR [lastUpdated]
GO
ALTER TABLE [dbo].[ProductHierarchy] ADD  DEFAULT (getdate()) FOR [EnteredOn]
GO
ALTER TABLE [dbo].[TagBalance] ADD  DEFAULT (getdate()) FOR [lastUpdated]
GO
ALTER TABLE [dbo].[TransactionEvent] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[Conversion]  WITH CHECK ADD  CONSTRAINT [FK_Conversion_StandardUnit] FOREIGN KEY([ToUnit])
REFERENCES [dbo].[StandardUnit] ([Name])
GO
ALTER TABLE [dbo].[Conversion] CHECK CONSTRAINT [FK_Conversion_StandardUnit]
GO
ALTER TABLE [dbo].[Conversion]  WITH CHECK ADD  CONSTRAINT [FK_Conversion_StandardUnit1] FOREIGN KEY([StandardUnit])
REFERENCES [dbo].[StandardUnit] ([Name])
GO
ALTER TABLE [dbo].[Conversion] CHECK CONSTRAINT [FK_Conversion_StandardUnit1]
GO
ALTER TABLE [dbo].[CustodyTicket]  WITH CHECK ADD  CONSTRAINT [FK_CustodyTicket_Unit_of_Measure] FOREIGN KEY([Unit_of_Measure])
REFERENCES [dbo].[StandardUnit] ([Name])
GO
ALTER TABLE [dbo].[CustodyTicket] CHECK CONSTRAINT [FK_CustodyTicket_Unit_of_Measure]
GO
ALTER TABLE [dbo].[InventorySnapshot]  WITH CHECK ADD  CONSTRAINT [FK_InventorySnapshot_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([Id])
GO
ALTER TABLE [dbo].[InventorySnapshot] CHECK CONSTRAINT [FK_InventorySnapshot_Batch]
GO
ALTER TABLE [dbo].[InventorySnapshot]  WITH CHECK ADD  CONSTRAINT [FK_InventorySnapshot_StandardUnit] FOREIGN KEY([StandardUnit])
REFERENCES [dbo].[StandardUnit] ([Name])
GO
ALTER TABLE [dbo].[InventorySnapshot] CHECK CONSTRAINT [FK_InventorySnapshot_StandardUnit]
GO
ALTER TABLE [dbo].[MaterialMovement]  WITH CHECK ADD  CONSTRAINT [FK_MaterialMovement_UnitOfEntry] FOREIGN KEY([UnitOfEntry])
REFERENCES [dbo].[StandardUnit] ([Name])
GO
ALTER TABLE [dbo].[MaterialMovement] CHECK CONSTRAINT [FK_MaterialMovement_UnitOfEntry]
GO
ALTER TABLE [dbo].[MaterialMovement]  WITH CHECK ADD  CONSTRAINT [FK_MaterialMovement_UnitOfMeasure] FOREIGN KEY([UnitOfMeasure])
REFERENCES [dbo].[StandardUnit] ([Name])
GO
ALTER TABLE [dbo].[MaterialMovement] CHECK CONSTRAINT [FK_MaterialMovement_UnitOfMeasure]
GO
ALTER TABLE [dbo].[SourceUnitMap]  WITH CHECK ADD  CONSTRAINT [FK_StandardUnit_Name] FOREIGN KEY([StandardUnit])
REFERENCES [dbo].[StandardUnit] ([Name])
GO
ALTER TABLE [dbo].[SourceUnitMap] CHECK CONSTRAINT [FK_StandardUnit_Name]
GO
ALTER TABLE [dbo].[TagBalance]  WITH CHECK ADD  CONSTRAINT [FK_TagBalance_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([Id])
GO
ALTER TABLE [dbo].[TagBalance] CHECK CONSTRAINT [FK_TagBalance_Batch]
GO
ALTER TABLE [dbo].[TagBalance]  WITH CHECK ADD  CONSTRAINT [FK_TagBalance_StandardUnit] FOREIGN KEY([StandardUnit])
REFERENCES [dbo].[StandardUnit] ([Name])
GO
ALTER TABLE [dbo].[TagBalance] CHECK CONSTRAINT [FK_TagBalance_StandardUnit]
GO
ALTER TABLE [dbo].[TagMap]  WITH CHECK ADD  CONSTRAINT [FK_TagMap_StandardUnit] FOREIGN KEY([DefaultUnit])
REFERENCES [dbo].[StandardUnit] ([Name])
GO
ALTER TABLE [dbo].[TagMap] CHECK CONSTRAINT [FK_TagMap_StandardUnit]
GO
ALTER TABLE [dbo].[TransactionEventDetail]  WITH CHECK ADD  CONSTRAINT [FK_transactioneventdetail] FOREIGN KEY([TransactionEvent_id])
REFERENCES [dbo].[TransactionEvent] ([TransactionEvent_id])
GO
ALTER TABLE [dbo].[TransactionEventDetail] CHECK CONSTRAINT [FK_transactioneventdetail]
GO
ALTER TABLE [dbo].[CustodyTicket]  WITH CHECK ADD  CONSTRAINT [CHK_Mode] CHECK  (([Mode]='Marine' OR [Mode]='Pipeline' OR [Mode]='Rail'))
GO
ALTER TABLE [dbo].[CustodyTicket] CHECK CONSTRAINT [CHK_Mode]
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
