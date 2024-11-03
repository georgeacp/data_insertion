import pyodbc
from faker import Faker
from time import time
import random
from datetime import datetime, timedelta
import os
from dotenv import load_dotenv

# Cargar las variables de entorno
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

# Obtener las claves primarias de las tablas BEBE, OBSTETRA y EXPEDIENTE_CLINICO
def obtener_claves_primarias():
    bebes = [row[0] for row in cursor.execute("SELECT IDBebe FROM BEBE").fetchall()]
    obstetras = [row[0] for row in cursor.execute("SELECT IDObstetra FROM OBSTETRA").fetchall()]
    expedientes = [(row[0], row[1]) for row in cursor.execute("SELECT IDExpediente, IDHistoria FROM EXPEDIENTE_CLINICO").fetchall()]
    return bebes, obstetras, expedientes

# Generar fecha y hora aleatoria entre 2020 y 2024
def generar_fecha_aleatoria():
    start_date = datetime(2020, 1, 1)
    end_date = datetime(2024, 12, 31)
    random_date = fake.date_between(start_date=start_date, end_date=end_date)
    random_time = fake.time_object()
    return datetime.combine(random_date, random_time)

# Listas de valores reales para los campos clínicos
frecuencia_cardiaca_fetal_opciones = ["120-160", "110-150", "130-170"]
dilatacion_cervical_opciones = ["1", "3", "5", "7", "9", "10"]
liquido_amniotico_opciones = ["Claro", "Meconial", "Sanguinolento"]
moldeamiento_opciones = ["Suturas en contacto", "Moderado", "Severo"]
variedad_posicion_opciones = ["Occipito-anterior", "Occipito-posterior", "Lateral izquierdo", "Lateral derecho"]

# Poblar la tabla PARTOGRAMA en lotes
def poblar_partograma(batch_size=100):
    bebes, obstetras, expedientes = obtener_claves_primarias()
    total_registros = len(bebes)  # Usar la cantidad de registros en BEBE como límite de inserciones
    start_time = time()

    partogramas = []
    for idx in range(total_registros):
        id_bebe = bebes[idx]  # Usar cada IDBebe en el orden en que fueron extraídos
        id_obstetra = random.choice(obstetras)
        id_expediente, id_historia = expedientes[idx % len(expedientes)]  # Ciclar si hay menos expedientes que bebes
        hora_inicio = generar_fecha_aleatoria()
        frecuencia_cardiaca_fetal = random.choice(frecuencia_cardiaca_fetal_opciones)
        dilatacion_cervical = random.choice(dilatacion_cervical_opciones)
        liquido_amniotico = random.choice(liquido_amniotico_opciones)
        moldeamiento = random.choice(moldeamiento_opciones)
        variedad_posicion = random.choice(variedad_posicion_opciones)

        partogramas.append((
            id_expediente, id_historia, hora_inicio, id_obstetra, frecuencia_cardiaca_fetal,
            dilatacion_cervical, liquido_amniotico, moldeamiento, variedad_posicion, id_bebe
        ))

        # Insertar en lotes
        if len(partogramas) >= batch_size:
            cursor.executemany('''
                INSERT INTO PARTOGRAMA (
                    IDExpediente, IDHistoria, HoraInicio, IDObstetra, FrecuenciaCardiacaFetal, 
                    DilatacionCervical, LiquidoAmniotico, Moldeamiento, VariedadPosicion, IDBebe
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''', partogramas)
            conn.commit()
            partogramas.clear()
            print(f"{idx+1}/{total_registros} registros insertados")

    # Insertar cualquier registro restante
    if partogramas:
        cursor.executemany('''
            INSERT INTO PARTOGRAMA (
                IDExpediente, IDHistoria, HoraInicio, IDObstetra, FrecuenciaCardiacaFetal, 
                DilatacionCervical, LiquidoAmniotico, Moldeamiento, VariedadPosicion, IDBebe
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', partogramas)
        conn.commit()
        print(f"{total_registros} registros insertados")

    end_time = time()
    print(f"Poblamiento completado en {end_time - start_time:.2f} segundos.")

# Llamada a la función para poblar la tabla PARTOGRAMA con registros
poblar_partograma()

# Cerrar la conexión
conn.close()
