--SELECT * 
--FROM PortfolioProject..NashvilleHousing

----------------------------------------------------------------------

-- Standardize Date Format

--Alter Table PortfolioProject..NashvilleHousing
--Add SalesDateConverted Date

--Update PortfolioProject..NashvilleHousing
--Set SalesDateConverted = CONVERT(Date, SaleDate)

----------------------------------------------------------------------

-- Populate Property Address Data

--Select * 
--From PortfolioProject..NashvilleHousing
--Where PropertyAddress Is Null

--Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
--From PortfolioProject..NashvilleHousing as a
--JOIN PortfolioProject..NashvilleHousing as b
--	On a.ParcelID = b.ParcelID
--	AND a. [UniqueID ] <> b.[UniqueID ]
--Where a.PropertyAddress Is Null

--Update a 
--Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
--From PortfolioProject..NashvilleHousing as a
--JOIN PortfolioProject..NashvilleHousing as b
--	On a.ParcelID = b.ParcelID
--	AND a. [UniqueID ] <> b.[UniqueID ]
--Where a.PropertyAddress Is Null


-- Breaking Down Address into Individual Columns

--Select Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address, 
--SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address 
--From PortfolioProject..NashvilleHousing

--Alter Table PortfolioProject..NashvilleHousing
--Add PropertySplitAddress Nvarchar(255)

--Update PortfolioProject..NashvilleHousing
--Set PropertySplitAddress = Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

--Alter Table PortfolioProject..NashvilleHousing
--Add PropertySplitCity Nvarchar(255)

--Update PortfolioProject..NashvilleHousing
--Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

--Alter Table PortfolioProject..NashvilleHousing


--Drop Column PropertySplitXity 

--Select *
--	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
--	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
--	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
--From PortfolioProject..NashvilleHousing

--Alter Table PortfolioProject..NashvilleHousing
--Add OwnerSplitAddress Nvarchar(255)

--Update PortfolioProject..NashvilleHousing
--Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

--Alter Table PortfolioProject..NashvilleHousing
--Add OwnerSplitCity Nvarchar(255)

--Update PortfolioProject..NashvilleHousing
--Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

--Alter Table PortfolioProject..NashvilleHousing
--Add OwnerSplitState Nvarchar(255)

--Update PortfolioProject..NashvilleHousing
--Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

--Change the Y and N to Yes and No

--UPDATE NashvilleHousing
--SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'YES'
--		When SoldAsVacant = 'N' THEN 'NO'
--		ELSE SoldAsVacant 
--		End

-- Remove Duplicates

--WITH RowNumCTE AS(
--Select *, 
--	ROW_NUMBER() Over(
--	PARTITION BY ParcelID,
--				 PropertyAddress,
--				 SalePrice,
--				 SaleDate,
--				 LegalReference
--				 Order By
--					UniqueID
--					) row_num

--From PortfolioProject..NashvilleHousing
--)
--DELETE 
--From RowNumCTE
--Where row_num >1

-- Drop Columns

--Alter Table PortfolioProject..NashvilleHousing 
--Drop Column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate