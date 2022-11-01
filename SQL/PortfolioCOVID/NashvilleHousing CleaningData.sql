Select *
From NashHousing

-- Standardize Date Format

Select SaleDateConv, CONVERT(Date,SaleDate) From NashHousing


Update NashHousing SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE NashHousing Add SaleDateConv Date
Update NashHousing SET SaleDateConv = CONVERT(Date,SaleDate)

-- Populate Property Address data

Select * From NashHousing --Where PropertyAddress is null 
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashHousing a JOIN NashHousing b on a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress) From NashHousing a JOIN NashHousing b
	on a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ] Where a.PropertyAddress is null

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropAddress From NashHousing
--Where PropertyAddress is null
--order by ParcelID

SELECT SUBSTRING(PropAddress, 1, CHARINDEX(',', PropAddress) -1 ) as Address 
, SUBSTRING(PropAddress, CHARINDEX(',', PropAddress) + 1 , LEN(PropAddress)) as Address
From NashHousing


ALTER TABLE NashvilleHousing Add PropertySplitAddress Nvarchar(255);

Update NashHousing SET PropAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashHousing Add PropertySplitCity Nvarchar(255);

Update NashHousing SET PropCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select OwnerAddress From NashHousing


Select PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3),PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2) 
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1) From NashHousing


ALTER TABLE NashHousing Add Owner_Address Nvarchar(255);

Update NashHousing SET Owner_Address = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashHousing Add OwnerCity Nvarchar(255);

Update NashHousing SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE NashHousing Add OwnerState Nvarchar(255);

Update NashHousing SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant) From NashHousing Group by SoldAsVacant Order by 2


Select SoldAsVacant, CASE When SoldAsVacant = 'Y' THEN 'Yes' When SoldAsVacant = 'N' THEN 'No' ELSE SoldAsVacant END
From NashHousing


Update NashHousing SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes' When SoldAsVacant = 'N' THEN 'No' ELSE SoldAsVacant END

-- Remove Duplicates

WITH RowNumCTE AS(Select *, ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDateConv, LegalReference
ORDER BY UniqueID) row_num From NashHousing
--order by ParcelID
) SELECT * FROM RowNumCTE WHERE row_num >1
-- DELETE From RowNumCTE Where row_num > 1
--Order by PropAddress

SELECT * FROM NashHousing

-- Delete Unused Columns
Select * From NashHousing

ALTER TABLE NashHousing DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress






