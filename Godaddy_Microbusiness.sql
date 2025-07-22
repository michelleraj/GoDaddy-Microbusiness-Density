SELECT * FROM
  `microgo_database`.`microgo_table` LIMIT 1000;


-- Cumulative Average Microbusiness Density per County
--Use case: Track average growth over time up to each month for a county.
SELECT
  cfips,
  county_name,
  state_name,
  first_day_of_month,
  microbusiness_density,
  AVG(microbusiness_density) OVER (PARTITION BY cfips ORDER BY first_day_of_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_avg_density
FROM `microgo_database`.`microgo_table`
ORDER BY cfips, first_day_of_month;



-- Best/Worst Performing States or Regions

SELECT
  state_name,
  ROUND(AVG(microbusiness_density), 2) AS avg_density,
  RANK() OVER (ORDER BY AVG(microbusiness_density) DESC) AS state_rank
FROM`microgo_database`.`microgo_table`
GROUP BY state_name
ORDER BY state_rank;

-- Top 10 counties—national leaderboard
SELECT *
FROM (
  SELECT
    county_name,
    state_name,
    AVG(microbusiness_density) AS avg_density,
    RANK() OVER (ORDER BY AVG(microbusiness_density) DESC) AS density_rank
  FROM `microgo_database`.`microgo_table`
  GROUP BY county_name, state_name
) ranked
WHERE density_rank <= 10;

-- Is Microbusiness Density Increasing or Decreasing Month-over-Month

SELECT
  cfips,
  county_name,
  first_day_of_month,
  microbusiness_density,
  LAG(microbusiness_density) OVER (PARTITION BY cfips ORDER BY first_day_of_month) AS prev_month_density,
  ROUND(microbusiness_density - LAG(microbusiness_density) OVER (PARTITION BY cfips ORDER BY first_day_of_month), 4) AS mom_change
FROM `microgo_database`.`microgo_table`
WHERE microbusiness_density IS NOT NULL
ORDER BY cfips, first_day_of_month;

-- Is Microbusiness Density Increasing or Decreasing Year over Year
WITH yearly AS (
  SELECT
    cfips,
    county_name,
    state_name,
    EXTRACT(YEAR FROM first_day_of_month) AS year,
    AVG(microbusiness_density) AS avg_yearly_density
  FROM `microgo_database`.`microgo_table`
  GROUP BY cfips, county_name, state_name, EXTRACT(YEAR FROM first_day_of_month)
)
SELECT
  *,
  LAG(avg_yearly_density, 1) OVER (PARTITION BY cfips ORDER BY year) AS prev_year_density,
  avg_yearly_density - LAG(avg_yearly_density, 1) OVER (PARTITION BY cfips ORDER BY year) AS yoy_change
FROM yearly
ORDER BY cfips, year;

-- Purpose: Rank counties within each state by their latest density.
SELECT
  state_name,
  county_name,
  microbusiness_density,
  RANK() OVER (PARTITION BY state_name ORDER BY microbusiness_density DESC) AS density_rank
FROM `microgo_database`.`microgo_table`
WHERE first_day_of_month = (
  SELECT MAX(first_day_of_month) FROM `microgo_database`.`microgo_table`
);

-- county rank
SELECT
  first_day_of_month,
  state_name,
  county_name,
  microbusiness_density,
  RANK() OVER (
    PARTITION BY state_name, first_day_of_month
    ORDER BY microbusiness_density DESC
  ) AS density_rank_in_state
FROM `microgo_database`.`microgo_table`
ORDER BY first_day_of_month, state_name, density_rank_in_state;


-- 10 Top and Bottom Counties by Business Density (All-Time)
-- You can easily rank counties based on their latest, highest, or average -- microbusiness density—just like with any other metric.

WITH latest_data AS (
  SELECT
    county_name,
    state_name,
    first_day_of_month,
    microbusiness_density,
    ROW_NUMBER() OVER (PARTITION BY county_name, state_name ORDER BY first_day_of_month DESC) AS rn
  FROM `microgo_database`.`microgo_table`
),
ranked AS (
  SELECT
    county_name,
    state_name,
    microbusiness_density,
    RANK() OVER (ORDER BY microbusiness_density DESC) AS density_rank
  FROM latest_data
  WHERE rn = 1
)
SELECT *
FROM ranked
WHERE density_rank <= 10 OR density_rank >= (SELECT MAX(density_rank) - 9 FROM ranked)
ORDER BY density_rank;

-- High Growth Counties 
WITH recent_density AS (
  SELECT
    cfips,
    county_name,
    state_name,
    first_day_of_month,
    microbusiness_density,
    LAG(microbusiness_density) OVER (PARTITION BY cfips ORDER BY first_day_of_month) AS prev_density
  FROM `microgo_database`.`microgo_table`
)
SELECT
  county_name,
  state_name,
  prev_density,
  microbusiness_density,
  ROUND(microbusiness_density - prev_density, 2) AS growth
FROM recent_density
WHERE prev_density IS NOT NULL
   AND (microbusiness_density - prev_density) > 0.1 
ORDER BY growth DESC
LIMIT 10;

-- Potential High Growth Counties who have lower density <1
WITH recent_density AS (
  SELECT
    cfips,
    county_name,
    state_name,
    first_day_of_month,
    microbusiness_density,
    LAG(microbusiness_density) OVER (PARTITION BY cfips ORDER BY first_day_of_month) AS prev_density
  FROM `microgo_database`.`microgo_table`
)
SELECT
  county_name,
  state_name,
  prev_density,
  microbusiness_density,
  ROUND(microbusiness_density - prev_density, 2) AS growth
FROM recent_density
WHERE prev_density IS NOT NULL
  AND microbusiness_density < 1 -- Low current density
  AND (microbusiness_density - prev_density) > 0.1 -- Significant recent growth
ORDER BY growth DESC
LIMIT 10;


--  National Monthly Growth Rate (%)
WITH monthly_density AS (
  SELECT
    state_name,
    first_day_of_month,
    AVG(microbusiness_density) AS avg_density
  FROM microgo_database.microgo_table
  GROUP BY state_name, first_day_of_month
),
growth_rate AS (
  SELECT
    state_name,
    first_day_of_month,
    avg_density,
    LAG(avg_density) OVER (
      PARTITION BY state_name ORDER BY first_day_of_month
    ) AS prev_density
  FROM monthly_density
)
SELECT
  state_name,
  first_day_of_month,
  ROUND(((avg_density - prev_density) / prev_density) * 100, 2) AS state_monthly_growth_pct
FROM growth_rate
WHERE prev_density IS NOT NULL
ORDER BY state_name, first_day_of_month;


