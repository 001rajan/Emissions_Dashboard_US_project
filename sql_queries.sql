/* =====================================================
   US Greenhouse Gas Emissions Dashboard
   Databricks SQL Queries
   ===================================================== */


/* =====================================================
   1. Geospatial Emissions Map
   Purpose: Plot emissions across US counties
   ===================================================== */

SELECT
    latitude,
    longitude,
    `GHG emissions mtons CO2e` AS emissions
FROM emissions_data;


/* =====================================================
   2. Emissions Per Person Analysis
   Purpose: Identify counties with highest emissions
            per resident
   ===================================================== */

SELECT
    county_name,
    population,
    `GHG emissions mtons CO2e` / population AS emissions_per_person
FROM emissions_data
WHERE population > 0
ORDER BY emissions_per_person DESC;


/* =====================================================
   3. Top 10 States by Total Emissions
   Purpose: Compare state-level contributions
   ===================================================== */

SELECT
    state_abbr,
    SUM(
        CAST(
            REPLACE(`GHG emissions mtons CO2e`, ',', '')
            AS DOUBLE
        )
    ) AS total_emissions
FROM emissions_data
GROUP BY state_abbr
ORDER BY total_emissions DESC
LIMIT 10;


/* =====================================================
   4. Top 10 Counties by Total Emissions
   Purpose: Rank the highest emitting counties
   ===================================================== */

SELECT
    county_state_name,
    population,
    `GHG emissions mtons CO2e` AS total_emissions
FROM emissions_data
ORDER BY total_emissions DESC
LIMIT 10;


/* =====================================================
   5. KPI - Total Population
   ===================================================== */

SELECT
    ROUND(SUM(population), 0) AS total_population
FROM emissions_data;


/* =====================================================
   6. KPI - Total Emissions
   ===================================================== */

SELECT
    ROUND(
        SUM(`GHG emissions mtons CO2e`),
        2
    ) AS total_emissions
FROM emissions_data;


/* =====================================================
   7. KPI - Average Emissions Per Person
   ===================================================== */

SELECT
    ROUND(
        SUM(`GHG emissions mtons CO2e`) /
        SUM(population),
        2
    ) AS emissions_per_person
FROM emissions_data
WHERE population > 0;
