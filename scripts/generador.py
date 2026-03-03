import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta

# Configuración inicial
n_transactions = 10000
n_fraudulent = int(n_transactions * 0.005) # 0.5% de fraude
df = pd.DataFrame()

print("Generando datos básicos...")

# 1. GENERACIÓN DE DATOS NORMALES
data_normal = {
    'ID': range(1, n_transactions - n_fraudulent + 1),
    'AMOUNT': np.random.uniform(10, 1000, n_transactions - n_fraudulent),
    'LOCATION': [random.choice(['Madrid', 'Barcelona', 'Valencia', 'Sevilla', 'Bilbao']) for _ in range(n_transactions - n_fraudulent)],
    'MERCHANT': [random.choice(['Amazon', 'Starbucks', 'Netflix', 'Zara', 'Apple']) for _ in range(n_transactions - n_fraudulent)],
    'EVENT_TIME': [datetime.now() - timedelta(days=random.randint(0, 30)) for _ in range(n_transactions - n_fraudulent)],
    'IS_FRAUD': 0
}
df_normal = pd.DataFrame(data_normal)

# 2. GENERACIÓN DE DATOS FRAUDULENTOS (Cantidades inusuales y sitios raros)
data_fraud = {
    'ID': range(n_transactions - n_fraudulent + 1, n_transactions + 1),
    'AMOUNT': np.random.uniform(5000, 20000, n_fraudulent), # Cantidades muy altas
    'LOCATION': ['Cayman Islands' if i % 2 == 0 else 'Unknown' for i in range(n_fraudulent)],
    'MERCHANT': ['Shell Company LLC' for _ in range(n_fraudulent)],
    'EVENT_TIME': [datetime.now() - timedelta(minutes=random.randint(0, 60)) for _ in range(n_fraudulent)], # Ocurrieron hace poco
    'IS_FRAUD': 1
}
df_fraud = pd.DataFrame(data_fraud)

# 3. UNIR Y GUARDAR
df = pd.concat([df_normal, df_fraud], ignore_index=True)
df = df.sample(frac=1).reset_index(drop=True) # Mezclamos los datos para que no estén ordenados

# Guardar a CSV
df.to_csv('financial_transactions.csv', index=False)

print(f"¡Éxito! Se ha generado 'financial_transactions.csv' con {len(df)} filas.")
print("Ahora puedes subir este archivo a FINANCE_DEV.BRONZE en Snowflake.")