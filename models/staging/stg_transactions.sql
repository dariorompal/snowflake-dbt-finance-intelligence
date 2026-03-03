WITH raw_transactions AS (
    SELECT * FROM {{ source('raw_data', 'transactions') }}
)

SELECT
    ID AS transaction_id,
    AMOUNT AS amount_usd,
    UPPER(LOCATION) AS location_city,
    MERCHANT AS merchant_name,
    EVENT_TIME AS transaction_timestamp,
    CAST(IS_FRAUD AS BOOLEAN) AS is_fraud_flag
FROM raw_transactions