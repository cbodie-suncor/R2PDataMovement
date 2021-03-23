drop view SiteProductionData;
drop view InventorySnapshots;
drop view S4Inventory;
drop view ProductionMatDoc;
drop view CustodyTicketMatDoc;
drop view VarianceReport;
go
create view SiteProductionData as
select * from tagBalance
where movementtype = 'Production';
go
create view InventorySnapshots as
select * from tagBalance
where movementtype = 'Inventory' and system <> 'S4';
go
create view S4Inventory as
select * from tagBalance
where movementtype = 'Inventory' and system <> 'S4';
go
create view ProductionMatDoc as
select * from MaterialMovement
where movementtype = 'Production';
go
create view CustodyTicketMatDoc as
select * from MaterialMovement
where movementtype = 'CustodyTickets';
go
create view VarianceReport as 
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
go
select * from VarianceReport
go


