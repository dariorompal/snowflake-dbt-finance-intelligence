{{ config(materialized='table', schema='GOLD') }}

WITH base_merchants AS (
    SELECT DISTINCT
        merchant_name,
        location_city
    FROM {{ ref('stg_transactions') }}
)

SELECT
    -- Generamos un Surrogate Key (ID único) usando un MD5 del nombre
    -- Esto es una práctica estándar de Ingeniería de Datos
    md5(merchant_name) as merchant_key,
    merchant_name,
    location_city
FROM base_merchants