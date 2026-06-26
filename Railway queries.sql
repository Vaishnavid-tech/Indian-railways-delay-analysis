
CREATE DATABASE IF NOT EXISTS indian_railways;

USE indian_railways;

SHOW TABLES;

DROP TABLE IF EXISTS train_delays;


CREATE TABLE train_delays (
    train_number INT,
    train_name VARCHAR(100),
    station_code VARCHAR(20),
    station_name VARCHAR(100),
    average_delay_minutes FLOAT,
    pct_right_time FLOAT,
    pct_slight_delay FLOAT,
    pct_significant_delay FLOAT,
    pct_cancelled_unknown FLOAT,
    scraped_at VARCHAR(50),
    source_url VARCHAR(300),
    original_order INT,
    stop_order INT
);
SELECT COUNT(*) FROM train_delays;

SELECT * FROM train_delays LIMIT 5;

-- 1. which trains have the highest average delay across all their stops:
SELECT 
    train_number,
    train_name,
    ROUND(AVG(average_delay_minutes), 2) AS avg_delay,
    COUNT(*) AS total_stops
FROM train_delays
GROUP BY train_number, train_name
ORDER BY avg_delay DESC
LIMIT 10;


--  2. which stations cause the most delay (worst stations across all trains):
SELECT 
    station_code,
    station_name,
    ROUND(AVG(average_delay_minutes), 2) AS avg_delay,
    COUNT(*) AS times_appeared
FROM train_delays
GROUP BY station_code, station_name
ORDER BY avg_delay DESC
LIMIT 10;


-- 3. delay buildup along a specific route:
SELECT 
    stop_order,
    station_name,
    average_delay_minutes
FROM train_delays
WHERE train_number = 12621
ORDER BY stop_order;

-- 4. trains that are most punctual (best performers):
SELECT 
    train_number,
    train_name,
    ROUND(AVG(pct_right_time), 2) AS avg_on_time_pct,
    ROUND(AVG(average_delay_minutes), 2) AS avg_delay
FROM train_delays
GROUP BY train_number, train_name
ORDER BY avg_on_time_pct DESC
LIMIT 10;

-- 5. Which train has the worst delay at its final destination (shows end-to-end delay
SELECT 
    train_number,
    train_name,
    station_name AS final_station,
    average_delay_minutes AS final_delay
FROM train_delays
WHERE stop_order = (
    SELECT MAX(stop_order) 
    FROM train_delays t2 
    WHERE t2.train_number = train_delays.train_number
)
ORDER BY final_delay DESC
LIMIT 10;

-- 6. Stations where delay is consistently high across multiple trains (shows which stations are systemically problematic):
 SELECT 
    station_name,
    COUNT(DISTINCT train_number) AS num_trains,
    ROUND(AVG(average_delay_minutes), 2) AS avg_delay,
    ROUND(MAX(average_delay_minutes), 2) AS max_delay
FROM train_delays
WHERE average_delay_minutes > 0
GROUP BY station_name
HAVING num_trains >= 3
ORDER BY avg_delay DESC
LIMIT 10;

-- 7.  Delay comparison between Rajdhani vs non-Rajdhani trains (premium vs regular trains :
SELECT 
    CASE 
        WHEN train_name LIKE '%Rajdhani%' THEN 'Rajdhani'
        WHEN train_name LIKE '%Vande Bharat%' THEN 'Vande Bharat'
        WHEN train_name LIKE '%Shatabdi%' THEN 'Shatabdi'
        ELSE 'Other Express'
    END AS train_type,
    COUNT(DISTINCT train_number) AS num_trains,
    ROUND(AVG(average_delay_minutes), 2) AS avg_delay,
    ROUND(MIN(average_delay_minutes), 2) AS min_delay,
    ROUND(MAX(average_delay_minutes), 2) AS max_delay
FROM train_delays
WHERE average_delay_minutes > 0
GROUP BY train_type
ORDER BY avg_delay ASC;
