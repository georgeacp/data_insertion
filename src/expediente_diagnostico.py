import pyodbc
from faker import Faker
import os
from dotenv import load_dotenv
import random
from datetime import date
import sys

# Cargar variables de entorno
load_dotenv()

# Inicializar Faker
fake = Faker()

# Conectar a la base de datos SQL Server usando variables de entorno
conn = pyodbc.connect(
    f'DRIVER={os.getenv("DB_DRIVER")};'
    f'SERVER={os.getenv("DB_SERVER")};'
    f'DATABASE={os.getenv("DB_DATABASE")};'
    f'Trusted_Connection={os.getenv("DB_TRUSTED_CONNECTION")};'
)

cursor = conn.cursor()

# Obtener IDs de la tabla diagnosticos
cursor.execute("SELECT IDDiagnostico FROM DIAGNOSTICO")
diagnosticos = cursor.fetchall()

# Obtener IDs de la tabla expediente clinico
query = """
SELECT IDExpediente, IDHistoria
FROM EXPEDIENTE_CLINICO
"""
cursor.execute(query)
expedientes = cursor.fetchall()

# Función para generar datos para la tabla EXPEDIENTE_DIAGNOSTICO
def generar_datos_expediente_diagnostico():
    expediente_historia_list = list(expedientes)
    total = len(expediente_historia_list)  # Número total de expedientes

    # Generar registros de diagnóstico para cada expediente clínico
    for index, expediente in enumerate(expediente_historia_list, start=1):
        IDExpediente = expediente.IDExpediente
        IDHistoria = expediente.IDHistoria

        # Mantener un conjunto de IDDiagnostico usados para evitar duplicados
        diagnosticos_usados = set()

        # Generar entre 1 y 3 registros de diagnóstico para cada expediente clínico
        for _ in range(random.randint(1, 3)):
            # Seleccionar un IDDiagnostico que no esté en diagnosticos_usados
            IDDiagnostico = random.choice(diagnosticos).IDDiagnostico
            while IDDiagnostico in diagnosticos_usados:
                IDDiagnostico = random.choice(diagnosticos).IDDiagnostico
            
            # Agregar el IDDiagnostico al conjunto de usados
            diagnosticos_usados.add(IDDiagnostico)

            FechaDiagnostico = fake.date_between(start_date=date(2020, 1, 1), end_date=date(2024, 12, 31)).strftime('%Y-%m-%d')
            Tipo = random.choice(['Definitivo', 'Presuntivo'])
            Alta = random.choice(['Si', 'No'])
            Caso = random.choice(['Nuevo', 'Crónico', 'Recurrente'])

            # Insertar datos en EXPEDIENTE_DIAGNOSTICO
            cursor.execute("""
                INSERT INTO EXPEDIENTE_DIAGNOSTICO (IDExpediente, IDHistoria, IDDiagnostico, FechaDiagnostico, Tipo, Alta, Caso)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            """, (IDExpediente, IDHistoria, IDDiagnostico, FechaDiagnostico, Tipo, Alta, Caso))
        
        # Barra de progreso
        progreso = (index / total) * 100
        sys.stdout.write(f"\rProgreso: [{int(progreso)}%] {'#' * (int(progreso) // 2)}")
        sys.stdout.flush()

    print("\n")  # Nueva línea al terminar la barra de progreso

# Generar datos para la tabla EXPEDIENTE_DIAGNOSTICO
generar_datos_expediente_diagnostico()

# Confirmar cambios en la base de datos
conn.commit()
cursor.close()
conn.close()

print("Datos de EXPEDIENTE_DIAGNOSTICO generados exitosamente.")
