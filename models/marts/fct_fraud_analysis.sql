{{ config(materialized='table', schema='GOLD') }}

WITH transactions AS (
    SELECT * FROM {{ ref('stg_transactions') }}
)

SELECT
    *,
    -- Usamos una lógica de negocio para la capa Gold
    CASE 
        WHEN amount_usd > 10000 AND location_city = 'UNKNOWN' THEN 'Crítico'
        WHEN amount_usd > 5000 THEN 'Sospechoso'
        ELSE 'Normal'
    END AS risk_score,
    -- Simulamos una descripción generada (esto es lo que vería el usuario final)
    'Revisar transaccion de ' || amount_usd || ' en ' || location_city AS alert_message
FROM transactions