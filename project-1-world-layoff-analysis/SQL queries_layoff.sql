/*  Objectives* 
1. identify and remove duplicate
2. Standardizing data if there are issues (mispelling, etc.)
3. Populate blanks/empty values
4. Delete columns or rows that are unnecessary
*/

SELECT * FROM layoffs;

# create duplicate table to keep the originals
CREATE TABLE layoffs_staging LIKE layoffs;
INSERT INTO layoffs_staging SELECT * FROM layoffs;

#Identify duplicates
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;
 
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
 )
 SELECT *
 FROM duplicate_cte
 WHERE row_num > 1;
 
 SELECT * FROM layoffs_staging
 WHERE company = 'casper';
 
 #Create new table to add new column(row_num)
 CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` double DEFAULT NULL,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 SELECT * FROM layoffs_staging2;
 
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

#Delete the duplicate rows
 SELECT * FROM layoffs_staging2
 WHERE row_num > 1;
 
DELETE FROM layoffs_staging2
WHERE row_num > 1;
 
SELECT * FROM layoffs_staging2;

#Standardizing data
#Remove whitespace
  
  SELECT company, TRIM(company)
  FROM layoffs_staging2;
  
  UPDATE layoffs_staging2
  SET company = TRIM(company);
  
  #Standardize the spelling, etc.
  
  SELECT DISTINCT industry
  FROM layoffs_staging2;
  
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%' ;

  UPDATE layoffs_staging2
  SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%' ;

#Cleans extra characters at the end of text

 SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
  FROM layoffs_staging2
  ORDER BY 1;
  
  UPDATE layoffs_staging2
  SET country = TRIM(TRAILING '.' FROM country)
  WHERE country LIKE 'United States%';
  
  #change date format
  
  SELECT `date`,
  STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;
  
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

SELECT DISTINCT industry FROM layoffs_staging2;

#Populate blank values

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT * FROM layoffs_staging2
WHERE company = 'Airbnb';

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_staging2;
