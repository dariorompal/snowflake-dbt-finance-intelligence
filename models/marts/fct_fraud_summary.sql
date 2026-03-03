{{ config(materialized='table', schema='GOLD') }}

WITH transactions AS (
    SELECT * FROM {{ ref('stg_transactions') }}
),

merchants AS (
    SELECT * FROM {{ ref('dim_merchants') }}
)

SELECT
    t.transaction_id,
    t.amount_usd,
    t.transaction_timestamp,
    -- Conectamos con la dimensión usando la llave que creamos
    m.merchant_key, 
    -- Lógica de riesgo
    CASE 
        WHEN t.is_fraud_flag = TRUE THEN 'FRAUDE CONFIRMADO'
        WHEN t.amount_usd > 8000 AND t.location_city = 'UNKNOWN' THEN 'ALTO RIESGO'
        ELSE 'RIESGO NORMAL'
    END AS fraud_risk_level
FROM transactions t
LEFT JOIN merchants m 
    ON t.merchant_name = m.merchant_name 
    AND t.location_city = m.location_city