-- Viewing the top rows of the data set
SELECT
	TOP 10 *
FROM
	Sheet1$;

-- Checking for null values in the data set
SELECT
	(SELECT COUNT(*) FROM Sheet1$ WHERE Time IS NULL) AS Time_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE [Energy_delta(Wh)] IS NULL) AS Energy_Delta_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE GHI IS NULL) AS GHI_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE temp IS NULL) AS Temp_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE Pressure IS NULL) AS Pressure_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE humidity IS NULL) AS Humidity_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE wind_speed IS NULL) AS Wind_speed_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE rain_1h IS NULL) AS Rain_1h_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE snow_1h IS NULL) AS Snow_1h_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE clouds_all IS NULL) AS Clouds_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE is_Sun IS NULL) AS Is_sun_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE sunlight_Time IS NULL) AS Sunlight_Time_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE day_Length IS NULL) AS Day_Length_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE weather_type IS NULL) AS Weather_Type_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE hour IS NULL) AS Hour_Null_Count,
	(SELECT COUNT(*) FROM Sheet1$ WHERE month IS NULL) AS Month_Null_Count

-- checking energy consumption with respect to time (year, months, weekday, hours)

-- Energy consumption with respect to Year
SELECT
	DATEPART(year, Time) AS Year,
	ROUND(AVG([Energy_delta(Wh)]), 2) AS Avg_energy_consume,
	SUM([Energy_delta(Wh)]) AS Sum_energy_consume
FROM 
	Sheet1$
GROUP BY
	DATEPART(year, Time)
ORDER BY
	Sum_energy_consume DESC;

--Energy consumption with respect to accumulated Months
SELECT
	month,
	ROUND(AVG([Energy_delta(Wh)]), 2) AS Avg_energy_consume,
	SUM([Energy_delta(Wh)]) AS Sum_energy_consume
FROM 
	Sheet1$
GROUP BY
	month
ORDER BY
	Sum_energy_consume DESC;

-- Energy consumption with respect to acumulated WeekDays
SELECT
	DATEPART(weekday, Time) AS Week_Day,
	ROUND(AVG([Energy_delta(Wh)]), 2) AS Avg_energy_consume,
	SUM([Energy_delta(Wh)]) AS Sum_energy_consume
FROM 
	Sheet1$
GROUP BY
	DATEPART(weekday, Time)
ORDER BY
	Sum_energy_consume DESC;

-- Energy consumption with respect to Hours
SELECT
	hour,
	ROUND(AVG([Energy_delta(Wh)]), 2) AS Avg_energy_consume,
	SUM([Energy_delta(Wh)]) AS Sum_energy_consume
FROM 
	Sheet1$
GROUP BY
	hour
ORDER BY
	Sum_energy_consume DESC;
/* the above queries were ran to determine seasonal trend and time series pattern of energy consumption
which will help in proper energy planning, distribution, and forecasting*/

-- Energy consumption with weathertype
-- OPTIMIZE and NORMAL WITHOUT PERCENTAGE
WITH Total_Energy_Consume AS (
	SELECT 
		SUM([Energy_delta(Wh)]) AS Total_Energy
	FROM 
		Sheet1$
	)
SELECT
	weather_type,
	ROUND(AVG([Energy_delta(Wh)]), 2) AS Average_Energy_Consume,
	SUM([Energy_delta(Wh)]) AS Sum_Energy_consume,
	ROUND((SUM([Energy_delta(Wh)]) / TE.Total_Energy) * 100,2) AS Percentage_of_Total_Energy
	FROM
		Sheet1$
	CROSS JOIN
		Total_Energy_Consume AS TE
	GROUP BY
		weather_type, Total_Energy
	ORDER BY
		Sum_Energy_consume DESC;

SELECT
	weather_type,
	ROUND(AVG([Energy_delta(Wh)]), 2) AS Avg_energy_consume,
	SUM([Energy_delta(Wh)]) AS Sum_energy_consume
FROM 
	Sheet1$
GROUP BY
	weather_type
ORDER BY
	Sum_energy_consume DESC;

-- Solar potential

-- Relationship between solar horizontal irradiance and energy consume
SELECT
	month,
	ROUND(AVG(GHI), 2) AS Average_solar_radiation,
	ROUND(SUM(GHI), 2) AS Total_solar_radiation,
	SUM([Energy_delta(Wh)]) AS Total_Energy_consume
FROM
	Sheet1$
GROUP BY 
	month
ORDER BY
	Total_solar_radiation DESC;

-- Relationship between irradiance and hour
SELECT
	hour,
	ROUND(AVG(GHI), 2) AS Average_solar_radiation,
	ROUND(SUM(GHI), 2) AS Total_solar_radiation
FROM
	Sheet1$
GROUP BY 
	hour
ORDER BY
	Total_solar_radiation DESC;

-- iirradiance and temp
SELECT
	TOP 10
	temp,
	GHI
FROM
	Sheet1$
ORDER BY
	temp DESC;

-- relationship between irradiance and weather type
SELECT
	weather_type,
	ROUND(AVG(GHI),2) AS Average_irradiance,
	ROUND(SUM(GHI),2) AS total_irradiance
FROM
	Sheet1$
GROUP BY
	weather_type
ORDER BY
	total_irradiance DESC;


-- irradiance with rain_1h, snow_1h and cloud_all
SELECT
	month,
	ROUND(AVG(GHI),2) AS Average_irradiance,
	ROUND(AVG(rain_1h),2) AS Average_rain_hr,
	ROUND(SUM(GHI),2) AS Total_irradiance,
	ROUND(SUM(rain_1h),2) AS Total_rain_hr
FROM
	Sheet1$
GROUP BY
	month
ORDER BY
	Total_rain_hr DESC;

SELECT
	hour,
	ROUND(AVG(GHI),2) AS Average_irradiance,
	ROUND(AVG(rain_1h),2) AS Average_rain_hr,
	ROUND(SUM(GHI),2) AS Total_irradiance,
	ROUND(SUM(rain_1h),2) AS Total_rain_hr
FROM
	Sheet1$
GROUP BY
	hour
ORDER BY
	Total_rain_hr DESC;

-- irradiance with snow
SELECT
	month,
	ROUND(AVG(GHI),2) AS Average_irradiance,
	ROUND(AVG(snow_1h),2) AS Average_snow_hr,
	ROUND(SUM(GHI),2) AS Total_irradiance,
	ROUND(SUM(snow_1h),2) AS Total_snow_hr
FROM
	Sheet1$
GROUP BY
	month
ORDER BY
	Total_snow_hr DESC;

SELECT
	hour,
	ROUND(AVG(GHI),2) AS Average_irradiance,
	ROUND(AVG(snow_1h),2) AS Average_snow_hr,
	ROUND(SUM(GHI),2) AS Total_irradiance,
	ROUND(SUM(snow_1h),2) AS Total_snow_hr
FROM
	Sheet1$
GROUP BY
	hour
ORDER BY
	Total_snow_hr DESC;

-- cloud with irradiance

SELECT
	month,
	ROUND(AVG(GHI),2) AS Average_irradiance,
	ROUND(AVG(clouds_all),2) AS Average_cloud_all,
	ROUND(SUM(GHI),2) AS Total_irradiance,
	ROUND(SUM(clouds_all),2) AS Total_cloud_all
FROM
	Sheet1$
GROUP BY
	month
ORDER BY
	Total_cloud_all DESC;

SELECT
	hour,
	ROUND(AVG(GHI),2) AS Average_irradiance,
	ROUND(AVG(clouds_all),2) AS Average_cloud_all,
	ROUND(SUM(GHI),2) AS Total_irradiance,
	ROUND(SUM(clouds_all),2) AS Total_cloud_all
FROM
	Sheet1$
GROUP BY
	hour
ORDER BY
	Total_cloud_all DESC;

-- sunlight time
-- sunlight time by months
SELECT
	month,
	ROUND(AVG(sunlight_Time),2) AS Average_sunlight_time,
	ROUND(SUM(sunlight_Time),2) AS Total_sunlight_time
FROM
	Sheet1$
GROUP BY
	month
ORDER BY
	Total_sunlight_time DESC;

-- sunlight time by hour
SELECT
	hour,
	ROUND(AVG(sunlight_Time),2) AS Average_sunlight_time,
	ROUND(SUM(sunlight_Time),2) AS Total_sunlight_time
FROM
	Sheet1$
GROUP BY
	hour
ORDER BY
	Total_sunlight_time DESC;

-- sunlight-daylength ratio
-- sunlight-daylength ratio with respect to months
SELECT
	month,
	ROUND(AVG([SunlightTime/daylength]),2) AS Average_SunLightTime_DayLength,
	ROUND(SUM([SunlightTime/daylength]),2) AS Total_SunLightTime_DayLength
FROM
	Sheet1$
GROUP BY
	month
ORDER BY
	Total_SunLightTime_DayLength DESC;

-- sunlight-daylength ratio with respect to hours
SELECT
	hour,
	ROUND(AVG([SunlightTime/daylength]),2) AS Average_SunLightTime_DayLength,
	ROUND(SUM([SunlightTime/daylength]),2) AS Total_SunLightTime_DayLength
FROM
	Sheet1$
GROUP BY
	hour
ORDER BY
	Total_SunLightTime_DayLength DESC;

-- is_sun with months... monthly count of whether the month is sunny or not
SELECT
	month,
	COUNT(is_Sun) AS sunny_days
FROM
	Sheet1$
WHERE
	is_Sun = 1
GROUP BY
	month
ORDER BY
	sunny_days DESC;

-- Average temperature and humidity for each month:
SELECT 
	month,
	ROUND(AVG(temp), 2) AS avg_temp,
	ROUND(AVG(humidity), 2) AS avg_humidity
FROM 
	Sheet1$
GROUP BY
	month

--Percentage of time the sun is shining for each month:
SELECT
	month,
	ROUND(AVG(is_Sun), 2) *100 AS sunlight_percentage
FROM
	Sheet1$
GROUP BY
	month
ORDER BY
	sunlight_percentage DESC;

-- The average wind speed for different weather types:
SELECT
	weather_type,
	ROUND(AVG(wind_speed),2) AS avg_wind_speed
FROM 
	Sheet1$
GROUP BY 
	weather_type
ORDER BY
	avg_wind_speed DESC;

-- The number of days with precipitation:
SELECT 
	ROUND(COUNT(DISTINCT CAST(Time AS date)),2) AS days_with_precipitation
FROM 
	Sheet1$
WHERE 
	rain_1h > 0 OR snow_1h > 0

-- The distribution of temperature during the day:
SELECT 
	hour,
	ROUND(AVG(temp), 2) AS avg_temp
FROM 
	Sheet1$
GROUP BY
	hour
ORDER BY
	avg_temp;

--The relationship between temperature and energy consumption:
SELECT 
	temp,
	ROUND(AVG([Energy_delta(Wh)]), 2) AS avg_energy_consumption
FROM 
	Sheet1$
GROUP BY
	temp
ORDER BY
	temp DESC;
