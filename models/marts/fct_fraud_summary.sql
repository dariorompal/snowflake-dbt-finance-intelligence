{{ config(materialized='table', schema='GOLD') }}

WITH transactions AS (
    SELECT * FROM {{ ref('stg_transactions') }}
)

SELECT
    transaction_id,
    amount_usd,
    location_city,
    merchant_name,
    transaction_timestamp,
    -- Lógica de negocio: Categorizamos el riesgo
    CASE 
        WHEN is_fraud_flag = TRUE THEN 'FRAUDE CONFIRMADO'
        WHEN amount_usd > 8000 AND location_city = 'UNKNOWN' THEN 'ALTO RIESGO'
        WHEN amount_usd > 5000 THEN 'RIESGO MODERADO'
        ELSE 'BAJO RIESGO'
    END AS fraud_risk_level,
    -- Calculamos la antigüedad de la transacción
    DATEDIFF('day', transaction_timestamp, CURRENT_TIMESTAMP()) AS days_since_event
FROM transactions