-- VIEWING THE TOP 12 ROWS OF THE DATA
SELECT
	TOP 12 *
FROM
	D202$

-- DROPPING THE NOTES COLUMN SINCE ITS ALL EMPTY 
ALTER TABLE
	D202$
DROP COLUMN
	NOTES;

--VIEWING TOP 12 TO SEE IF NULLS COLUMN HAVE BEEN DROPPPED
SELECT
	TOP 12 *
FROM
	D202$;


/*Analyzing yearly electric usage patterns: To group the data by year and calculate metrics such as average, minimum, and maximum
electric usage for each year*/
SELECT
	DATEPART(year, Date) AS Year,
	ROUND(AVG(Usage), 2) AS Avg_Usage,
	MIN(Usage) AS Min_USAGE,
	MAX(Usage) AS Max_Usage
FROM
	D202$
GROUP BY
	DATEPART(year,Date)
ORDER BY
	Year;


/*Analyzing monthly electric usage patterns: To group the data by months and calculate metrics such as average, minimum, and maximum
electric usage for each accumulated months*/
SELECT
	DATEPART(month, Date) AS Month,
	ROUND(AVG(Usage), 2) AS Avg_Usage,
	MIN(Usage) AS Min_USAGE,
	MAX(Usage) AS Max_Usage
FROM
	D202$
GROUP BY
	DATEPART(month,Date)
ORDER BY
	Month;


/*Analyzing monthly electric usage patterns: To group the data by months and calculate metrics such as average, minimum, and maximum
electric usage for each months where year is 2017*/
SELECT
	DATEPART(month, Date) AS Month,
	ROUND(AVG(Usage), 2) AS Avg_Usage,
	MIN(Usage) AS Min_USAGE,
	MAX(Usage) AS Max_Usage
FROM
	D202$
WHERE
	DATEPART(year, Date) = 2017
GROUP BY
	DATEPART(month,Date)
ORDER BY
	Month;

/*Analyzing weekly electric usage patterns: To group the data by weekday and calculate metrics such as average, minimum, and maximum
electric usage for each weekday*/
SELECT
	DATEPART(WEEKDAY, Date) AS Week_day,
	ROUND(AVG(Usage), 2) AS Avg_Usage,
	MIN(Usage) AS Min_USAGE,
	MAX(Usage) AS Max_Usage
FROM
	D202$
GROUP BY
	DATEPART(WEEKDAY,Date)


-- Analyzing costs associated with electric usage: over years
SELECT
	DATEPART(year, Date) As Year,
	ROUND(SUM(Usage), 2) AS Total_Usage,
	ROUND(SUM([Cost($)]), 2) AS Total_Cost
FROM
	D202$
GROUP BY
	DATEPART(year, Date);




-- Analyzing costs associated with electric usage: over months
SELECT
	DATEPART(month, Date) As Month,
	ROUND(SUM(Usage), 2) AS Total_Usage,
	ROUND(SUM([Cost($)]), 2) AS Total_Cost
FROM
	D202$
GROUP BY
	DATEPART(month, Date)
ORDER BY
	Total_Cost DESC;


-- Analyzing costs associated with electric usage: over weekdays
SELECT
	DATEPART(WEEKDAY, Date) As Week_Day,
	ROUND(AVG(Usage), 2) AS Avg_Usage,
	ROUND(SUM(Usage), 2) AS Total_Usage,
	ROUND(AVG([Cost($)]), 2) AS Avg_Cost,
	ROUND(SUM([Cost($)]), 2) AS Total_Cost
FROM
	D202$
GROUP BY
	DATEPART(WEEKDAY, Date)
ORDER BY
	Total_Cost DESC;

