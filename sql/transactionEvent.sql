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

select * from TransactionEvent
