from faker import Faker
import pyodbc
from datetime import datetime, timedelta
import random
import os
from dotenv import load_dotenv

# Cargar las variables de entorno
load_dotenv()

fake = Faker()

# Conexión a la base de datos usando variables de entorno
conn = pyodbc.connect(
    f'DRIVER={os.getenv("DB_DRIVER")};'
    f'SERVER={os.getenv("DB_SERVER")};'
    f'DATABASE={os.getenv("DB_DATABASE")};'
    f'Trusted_Connection={os.getenv("DB_TRUSTED_CONNECTION")};'
)
cursor = conn.cursor()

# Resto del código permanece igual
# Consulta para obtener las fechas de FechaAtencion filtradas por las condiciones especificadas
cursor.execute("""
    SELECT FechaAtencion 
    FROM EXPEDIENTE_CLINICO ec
    JOIN AREA_HOSPITALARIA ah ON ec.IDArea = ah.IDArea
    JOIN SERVICIO_HOSPITALARIO sh ON ec.IDServicio = sh.IDServicio
    JOIN PACIENTE p ON ec.IDPaciente = p.IDPaciente
    WHERE ah.Nombre = 'Hospitalización'
      AND (sh.Nombre = 'Obstetricia' OR sh.Nombre = 'Ginecología')
      AND p.Sexo = 'F'
""")
fechas_atencion = [row[0] for row in cursor.fetchall()]

# Si no hay fechas, termina el script
if not fechas_atencion:
    print("No hay registros de FechaAtencion que cumplan con las condiciones.")
else:
    # Número de registros a insertar basado en las fechas obtenidas
    num_registros = len(fechas_atencion)

    # Preparamos la lista de registros
    registros_bebe = []

    # Generamos los datos
    for fecha_atencion in fechas_atencion:
        # Genera la fecha del bebé permitiendo un día adicional
        fecha_bebe = fecha_atencion + timedelta(days=random.choice([0, 1]))
        hora_bebe = datetime.strptime(fake.time(), "%H:%M:%S")  # Extrae solo la hora para el campo Hora
        sexo = random.choice(['M', 'F'])
        peso = round(random.uniform(2.0, 4.5), 2)  # Peso sin 'kg'
        talla = random.randint(45, 60)  # Talla sin 'cm'
        pc = random.randint(30, 40)
        pt = random.randint(20, 35)

        # Agregamos el registro a la lista
        registros_bebe.append((fecha_bebe, hora_bebe, sexo, peso, talla, pc, pt))

    # Inserción masiva de registros
    insert_query = """
    INSERT INTO BEBE (Fecha, Hora, Sexo, Peso, Talla, PC, PT)
    VALUES (?, ?, ?, ?, ?, ?, ?)
    """

    try:
        cursor.executemany(insert_query, registros_bebe)
        conn.commit()  # Confirmamos la transacción
        print("Registros insertados con éxito.")
    except Exception as e:
        print("Error al insertar los registros:", e)
    finally:
        conn.close()
