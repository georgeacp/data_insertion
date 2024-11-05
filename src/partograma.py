import pyodbc
from faker import Faker
import os
from dotenv import load_dotenv
import random

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

# Obtener IDs de todos los bebés de la tabla BEBE
cursor.execute("SELECT IDBebe FROM BEBE")
bebes = cursor.fetchall()

# Obtener IDs de Expediente y Historia para ciertos diagnósticos específicos
query = """
SELECT ed.IDExpediente, ed.IDHistoria
FROM EXPEDIENTE_DIAGNOSTICO ed
INNER JOIN DIAGNOSTICO d on ed.IDDiagnostico = d.IDDiagnostico
WHERE d.Descripcion in ('Parto normal', 'Parto normal/obito fetal', 'Parto cesarea', 'Parto cesarea/obito fetal')
"""
cursor.execute(query)
expedientes = cursor.fetchall()

# Función para generar datos para la tabla PARTOGRAMA
def generar_datos_partograma():
    expediente_historia_list = list(expedientes)

    # Generar un partograma para cada bebé en la lista
    for bebe in bebes:
        expediente = random.choice(expediente_historia_list)
        IDExpediente = expediente.IDExpediente
        IDHistoria = expediente.IDHistoria
        HoraInicio = fake.time()
        IDObstetra = random.randint(1, 300)

        # Generar valores de FrecuenciaCardiacaFetal como un rango
        valor_minimo = random.randint(110, 140)
        valor_maximo = random.randint(valor_minimo + 1, 160)
        FrecuenciaCardiacaFetal = f"{valor_minimo}-{valor_maximo}"

        DilatacionCervical = f"{random.randint(1, 10)}"
        LiquidoAmniotico = random.choice(["Claro", "Meconial", "Sanguinolento"])
        Moldeamiento = random.choice(["Suturas en contacto", "Moderado", "Severo"])
        VariedadPosicion = random.choice(["Occipito-anterior", "Occipito-posterior", "Lateral izquierdo", "Lateral derecho"])
        IDBebe = bebe.IDBebe

        # Insertar datos en PARTOGRAMA
        cursor.execute("""
            INSERT INTO PARTOGRAMA (IDExpediente, IDHistoria, HoraInicio, IDObstetra, 
                                    FrecuenciaCardiacaFetal, DilatacionCervical, 
                                    LiquidoAmniotico, Moldeamiento, VariedadPosicion, IDBebe)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (IDExpediente, IDHistoria, HoraInicio, IDObstetra, FrecuenciaCardiacaFetal,
              DilatacionCervical, LiquidoAmniotico, Moldeamiento, VariedadPosicion, IDBebe))

# Generar e insertar los datos
generar_datos_partograma()

# Confirmar y cerrar conexión
conn.commit()
cursor.close()
conn.close()

print("Inserciones masivas completadas.")
