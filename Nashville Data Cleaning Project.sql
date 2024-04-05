/*

Cleaning Data in SQL Queries

*/


Select *
From SQLPROJECT.dbo.NashvileeHousing

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


Select saleDateConverted, CONVERT(Date,SaleDate)
From SQLPROJECT.dbo.NashvileeHousing


Update SQLPROJECT.dbo.NashvileeHousing
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE SQLPROJECT.dbo.NashvileeHousing
Add SaleDateConverted Date;

Update SQLPROJECT.dbo.NashvileeHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)


 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From SQLPROJECT.dbo.NashvileeHousing
--Where PropertyAddress is null
order by ParcelID



Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From SQLPROJECT.dbo.NashvileeHousing a
JOIN SQLPROJECT.dbo.NashvileeHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From SQLPROJECT.dbo.NashvileeHousing a
JOIN SQLPROJECT.dbo.NashvileeHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From SQLPROJECT.dbo.NashvileeHousing
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From SQLPROJECT.dbo.NashvileeHousing


ALTER TABLE SQLPROJECT.dbo.NashvileeHousing
Add PropertySplitAddress Nvarchar(255);

Update SQLPROJECT.dbo.NashvileeHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashvileeHousing
Add PropertySplitCity Nvarchar(255);

Update NashvileeHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

select PropertyAddress
From SQLPROJECT.dbo.NashvileeHousing



-------------------------------------------------------------------------
select *
From SQLPROJECT.dbo.NashvileeHousing


select OwnerAddress
From SQLPROJECT.dbo.NashvileeHousing

Select
PARSENAME(Replace(OwnerAddress, ',', '.') ,3) as Address
,PARSENAME(Replace(OwnerAddress, ',', '.') ,2) as City
,PARSENAME(Replace(OwnerAddress, ',', '.') ,1) as State
From SQLPROJECT.dbo.NashvileeHousing

ALTER TABLE SQLPROJECT.dbo.NashvileeHousing
Add OwnerSplitAddress Nvarchar(255);

Update SQLPROJECT.dbo.NashvileeHousing
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.') ,3)


ALTER TABLE SQLPROJECT.dbo.NashvileeHousing
Add OwnerSplitCity Nvarchar(255);

Update SQLPROJECT.dbo.NashvileeHousing
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.') ,2)

ALTER TABLE SQLPROJECT.dbo.NashvileeHousing
Add OwnerSplitState Nvarchar(255);

Update SQLPROJECT.dbo.NashvileeHousing
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.') ,3)

select OwnerAddress
From SQLPROJECT.dbo.NashvileeHousing

--------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select distinct(SoldAsVacant), count(SoldAsVacant) 
From SQLPROJECT.dbo.NashvileeHousing
group by SoldAsVacant
order  by 2



Select SoldAsVacant,
case
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else 
	SoldAsVacant
end
From SQLPROJECT.dbo.NashvileeHousing

Update SQLPROJECT.dbo.NashvileeHousing
Set SoldAsVacant = case
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else 
	SoldAsVacant
end

------------------------------------------------------------------------------------------------
--Remove duplicates

--Write a CTE
With RowNumCTE as(
Select *,
	ROW_NUMBER() over (
	partition by ParcelID, 
				 PropertyAddress, 
				 SaleDate, 
				 SalePrice, 
				 LegalReference
				 order by
					UniqueID
					) row_num
From SQLPROJECT.dbo.NashvileeHousing
--order by ParcelID
)
--partition data (use rank, order rank, row number)

Select *
From RowNumCTE
where row_num > 1

--------------------------------------------------------------------------------------------
--Delete Unused column

Select *
from SQLPROJECT..NashvileeHousing

alter table SQLPROJECT..NashvileeHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress

alter table SQLPROJECT..NashvileeHousing
drop column SaleDate



















