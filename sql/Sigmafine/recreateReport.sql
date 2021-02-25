select starttime, productcategory, productdesc, purchase, sale, dbo.GetOpeningVolume(starttime -1, productdesc) opeingVol, closingvol,
case when ischarge = 'Y' then -1 else 1 end * (sale - purchase + closingvol - dbo.GetOpeningVolume(starttime-1, productdesc)) production
from (
select starttime,productcategory,productdesc, max(ischarge) ischarge,
round(sum(case when flowtype = 'R' then measliqvol + isnull(MeasGasLiqVol,0) else 0 end),0) Purchase,
round(sum(case when flowtype = 'S' or flowtype = 'M' then measliqvol + isnull(MeasGasLiqVol,0) else 0 end),0) Sale,
round(sum(tankclosevol ),0) closingVol
--sum(case when closeflag = 'Y' then tankclosevol else 0 end ) closingVol
from sigmafinex where 
starttime = '2021-01-01'  
--and (flowcc = 'East_Plt' or sourcecc = 'East_Plt' or flowcc = 'West_Plt-East_Plt' or flowcc = '')
and flowcc <> 'West_Plt'
--productdesc = 'EP Sweet Crude Trucks'
group by starttime, productcategory, productdesc) r
where sale - purchase + closingvol - dbo.GetOpeningVolume(starttime-1, productdesc) <> 0
order by 1,2,3

select *--flowtype, openflag,CloseFlag, ischarge, tankcloserecvol, tankclosevol,RecLiqVol, RecGasLiqVol,MeasLiqVol, MeasGasLiqVol
from sigmafinex where productdesc = 'WP Normal Butane'
and starttime = '2021-01-01'


drop function GetOpeningVolume;

CREATE FUNCTION [dbo].[GetOpeningVolume] (@day datetime, @product varchar(50) )
RETURNS decimal(20,0)
AS
BEGIN
    DECLARE @opening decimal(20,5)
    select @opening = sum(tankclosevol) from sigmafinex where productdesc = @product and starttime = @day and sourcecc = 'East_plt'
    return isnull(round(@opening,0),0)
END;

