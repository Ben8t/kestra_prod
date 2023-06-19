{{ config(materialized='table') }}

SELECT
    industry,
    COUNT(DISTINCT hs_object_id) AS nb_companies
FROM demo_converteo.hubspot_companies_properties
GROUP BY industry