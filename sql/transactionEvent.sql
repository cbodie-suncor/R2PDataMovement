drop table TransactionEvent;
create table TransactionEvent (
TransactionEvent_id int identity,
plant varchar(40),
filename varchar(500),
failedRecordCount int,
successfulRecordCount int,
errorMessage varchar(1000),
createDate datetime default getdate()
)

drop table TransactionEventDetail;
create table TransactionEventDetail (
TransactionEventDetail_id int identity,
tag varchar(40),
errorMessage varchar(1000)
)

select * from TransactionEvent
