-- VIWEING THE TOP 10 ROWS OF THE DATA
SELECT
	TOP 10 *
FROM
	Insurance$

-- CHECKING FOR NULLS OR BLANK FILLS
SELECT
	(SELECT COUNT(*) FROM Insurance$ WHERE Age IS NULL)	AS Age_Is_Null_Count,
	(SELECT COUNT(*) FROM Insurance$ WHERE Sex IS NULL)	AS Sex_Is_Null_Count,
	(SELECT COUNT(*) FROM Insurance$ WHERE BMI IS NULL)	AS BMI_Is_Null_Count,
	(SELECT COUNT(*) FROM Insurance$ WHERE Children IS NULL)	AS Children_Is_Null_Count,
	(SELECT COUNT(*) FROM Insurance$ WHERE Smoker IS NULL)	AS Smoker_Is_Null_Count,
	(SELECT COUNT(*) FROM Insurance$ WHERE Region IS NULL)	AS Region_Is_Null_Count,
	(SELECT COUNT(*) FROM Insurance$ WHERE Charges IS NULL)	AS Age_Is_Null_Count

-- Identify outliers in the data
SELECT 
	MAX(Age) AS Max_Age,
	MIN(Age) AS Min_Age, 
	MAX(BMI) AS Max_BMI,
	MIN(BMI) AS Min_BMI, 
	MAX(Children) AS Max_Children,
	MIN(Children) AS Min_Children, 
	MAX(Charges) AS Max_Carges,
	MIN(Charges) AS Min_Charges
FROM 
	Insurance$;
/* The outliers found using a box plot were found to be within 34672.1472 and the max value,
but they are subject to confirmation on the insurance premium */

-- Standardize categorical variables
UPDATE 
	Insurance$
SET Smoker =
			CASE
				WHEN smoker = 'yes' THEN 1
				ELSE 0 
			END;
/* the value for the smokers has been transform from yes and no to 1's and 0's*/

-- Create a new variable based on age and sex
ALTER TABLE 
	Insurance$
ADD
	Age_Sex VARCHAR(10);

-- Adding values to the newly created column above
UPDATE 
	Insurance$
SET
	Age_Sex = CASE 
			WHEN sex = 'male' THEN CONCAT(age, '_M') 
			ELSE CONCAT(age, '_F') 
		END;

-- Calculate the average healthcare costs by region
SELECT 
	Region, 
	ROUND(AVG(Charges), 2) AS Avg_Charge
FROM 
	Insurance$ 
GROUP BY 
	Region
ORDER BY
	Avg_Charge DESC;
-- The Region with the highest Average Health Insurance cost is the SouthEast with an $14,735.41

-- Identifying the top 10 policyholders with the highest healthcare costs
SELECT 
	TOP 10 * 
FROM 
	Insurance$ 
ORDER BY 
	Charges DESC;

-- Categorizing insurance cover users base on BMI: Underweight, Normal and Overweight
-- creating a new variable BMI_Classification
ALTER TABLE 
	Insurance$
ADD
	BMI_Classification VARCHAR (55);

-- Adding value to the BMI_Classification
UPDATE 
	Insurance$
SET
	BMI_Classification = CASE
			WHEN BMI < 18.5 THEN 'Underweight'
			WHEN BMI BETWEEN 18.5 AND 24.9  THEN 'Healthy_weight'
			WHEN BMI BETWEEN 25.0 AND 29.9 THEN 'Over_weight'
			ELSE 'Obese'
		END;

-- Number of insurance cover by Region
SELECT
	Region,
	COUNT(*) AS Region_Grouping
FROM
	Insurance$
GROUP BY
	Region

-- We can Create a linear regression model to predict healthcare costs based on age, bmi, and smoker status
SELECT 
	Age,
	BMI,
	Smoker,
	Charges
FROM 
	Insurance$;