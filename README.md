# 💳 End-to-End Fraud Analytics Pipeline: Snowflake + dbt

Este proyecto implementa una arquitectura de datos moderna (**Medallion Architecture**) utilizando **Snowflake** como Data Warehouse y **dbt Cloud** para la transformación y orquestación de datos. 

El objetivo es procesar transacciones bancarias en bruto para identificar patrones de fraude y generar alertas de riesgo para el negocio.

---

## 🏗️ Arquitectura del Proyecto
He diseñado un flujo de datos dividido en tres capas lógicas para asegurar la calidad y trazabilidad:

1.  **Bronze (Raw Data):** Datos originales de transacciones cargados desde CSV directamente en Snowflake.
2.  **Silver (Staging):** Limpieza, tipado de datos y normalización de nombres utilizando dbt.
3.  **Gold (Marts):** Capa de negocio con lógica de detección de fraude y cálculo de niveles de riesgo.



---

## 🛠️ Stack Tecnológico
* **Data Warehouse:** Snowflake.
* **Transformación:** dbt (Data Build Tool) Cloud.
* **Control de Versiones:** GitHub (Gitflow con ramas de desarrollo y producción).
* **Lenguaje:** SQL (Snowflake Dialect).

---

## 🚀 Modelos Clave
* `stg_transactions`: Limpieza de IDs, formateo de fechas y normalización de montos.
* `fct_fraud_summary`: Modelo final que clasifica las transacciones en niveles (Bajo, Medio, Alto Riesgo) basándose en reglas de negocio.

---

## 🧪 Calidad de Datos (Tests)
Para asegurar la integridad del pipeline, he implementado tests automáticos:
* **Unique:** Garantiza que no haya IDs de transacción duplicados.
* **Not Null:** Asegura que campos críticos como el monto o el ID siempre contengan información.

---

## 📊 Visualización del Linaje
A continuación, se muestra el grafo de linaje (Lineage Graph) que representa la trazabilidad desde la fuente hasta el modelo final de negocio:

> **<img width="964" height="403" alt="image" src="https://github.com/user-attachments/assets/78637370-cee6-4cea-8a43-6fe77f7271eb" />
**
---
## 📊 Visualización e Insights

He creado un **Dashboard en Snowflake** que consume los datos finales de la capa Gold. Este panel permite identificar rápidamente qué comercios presentan mayores incidencias de fraude potencial.

![Dashboard de Análisis de Fraude]<img width="1066" height="485" alt="image" src="https://github.com/user-attachments/assets/4ffd9963-5d79-4712-961c-6cb9c3a5a5cc" />
<img width="1066" height="485" alt="image" src="https://github.com/user-attachments/assets/4ffd9963-5d79-4712-961c-6cb9c3a5a5cc" />

*Visualización de niveles de riesgo por comercio.*
