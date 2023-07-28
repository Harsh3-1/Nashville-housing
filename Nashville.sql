select saledateconverted, convert(date, saledate)
from portfolio..Nashville

update Nashville
set saledate = convert(date, saledate)

alter table Nashville
add saledateconverted date

update Nashville
set saledateconverted = convert(date, saledate)

select *
from portfolio..Nashville
order by parcelid

select *
from portfolio..Nashville a
join portfolio..Nashville b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid

select a.parcelid,a.propertyaddress,b.parcelid,b.propertyaddress, ISNULL(a.propertyaddress,b.propertyaddress)
from portfolio..Nashville a
join portfolio..Nashville b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid

update a
set propertyaddress = ISNULL(a.propertyaddress,b.propertyaddress)
from portfolio..Nashville a
join portfolio..Nashville b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.propertyaddress is null

select a.parcelid,a.propertyaddress,b.parcelid,b.propertyaddress, ISNULL(a.propertyaddress,b.propertyaddress)
from portfolio..Nashville a
join portfolio..Nashville b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.propertyaddress is null

select substring(propertyaddress,1,charindex(',',propertyaddress)-1) as propertysplitaddress,
 substring(propertyaddress,charindex(',',propertyaddress)+1, len(propertyaddress))
       
from portfolio..Nashville

alter table Nashville
add propertysplitaddress nvarchar(255);

update Nashville
set propertysplitaddress = substring(propertyaddress,1,charindex(',',propertyaddress)-1)

alter table Nashville
add propertysplitcity nvarchar(255);

update Nashville
set propertysplitcity = substring(propertyaddress,charindex(',',propertyaddress)+1, len(propertyaddress))

select owneraddress


select
parsename(replace(owneraddress, ',','.'),3),
parsename(replace(owneraddress, ',','.'),2),
parsename(replace(owneraddress, ',','.'),1)
from portfolio..Nashville

alter table Nashville
add ownersplitaddress nvarchar(255);

update Nashville
set ownersplitaddress = parsename(replace(owneraddress, ',','.'),3)

alter table Nashville
add ownersplitcity nvarchar(255);

update Nashville
set ownersplitcity = parsename(replace(owneraddress, ',','.'),2)

alter table Nashville
add ownersplitstate nvarchar(255);

update Nashville
set ownersplitstate = parsename(replace(owneraddress, ',','.'),1)

select ownersplitaddress,ownersplitcity,ownersplitstate
from portfolio..Nashville

select distinct soldasvacant, count(soldasvacant)
from portfolio..Nashville
group by soldasvacant

select soldasvacant,
case when soldasvacant = 'Y' then 'Yes'
     when soldasvacant = 'N' then 'No'
	 else soldasvacant
	 end
from portfolio..Nashville

update Nashville
set soldasvacant = case when soldasvacant = 'Y' then 'Yes'
     when soldasvacant = 'N' then 'No'
	 else soldasvacant
	 end

	 --removing duplicates
	 with rownumCTE as(
select *,
row_number() over(
partition by parcelid,
             propertyaddress,
			 saledate,
			 saleprice,
			 legalreference
			 order by uniqueid) row_num

from portfolio..Nashville)
delete
from rownumCTE
where row_num > 1
--order by propertyaddress

	 with rownumCTE as(
select *,
row_number() over(
partition by parcelid,
             propertyaddress,
			 saledate,
			 saleprice,
			 legalreference
			 order by uniqueid) row_num

from portfolio..Nashville)
select *
from rownumCTE
where row_num > 1
--order by propertyaddress

select *
from portfolio..Nashville

alter table portfolio..Nashville
drop column propertyaddress, owneraddress, taxdistrict, saledate