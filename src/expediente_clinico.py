import pyodbc
from faker import Faker
import random
from datetime import datetime
import os
from dotenv import load_dotenv

# Cargar las variables de entorno
load_dotenv()

# Crear un generador de datos falsos
fake = Faker()

# Establecer conexión a la base de datos SQL Server usando variables de entorno
conn = pyodbc.connect(
    f'DRIVER={os.getenv("DB_DRIVER")};'
    f'SERVER={os.getenv("DB_SERVER")};'
    f'DATABASE={os.getenv("DB_DATABASE")};'
    f'Trusted_Connection={os.getenv("DB_TRUSTED_CONNECTION")};'
)

cursor = conn.cursor()

# Función para generar una hora aleatoria en formato HH:MM:SS sin microsegundos
def generar_hora():
    hora = random.randint(7, 23)  # Horas entre 7 y 23
    minuto = random.randint(0, 59)  # Minutos entre 0 y 59
    segundo = random.randint(0, 59)  # Segundos entre 0 y 59
    return f"{hora:02d}:{minuto:02d}:{segundo:02d}"

# Definir una función para insertar datos falsos
def insert_fake_data():
    anamnesis_words = [
        "Dolor", "Fiebre", "Náuseas", "Tos", "Fatiga", "Vómitos", 
        "Mareos", "Cefalea", "Dolor abdominal", "Pérdida de apetito",
        "Cansancio", "Dolor lumbar", "Dolor pélvico", "Sangrado vaginal", 
        "Calambres", "Hinchazón", "Dificultad para respirar", "Palpitaciones", 
        "Pérdida de peso", "Aumento de peso", "Ansiedad", "Insomnio",
        "Amenorrea", "Dismenorrea", "Metrorragia", "Prurito", "Flujo vaginal anormal",
        "Micción frecuente", "Dolor en los senos", "Sensibilidad mamaria", 
        "Dolor articular", "Sudores nocturnos"
    ]

    plan_trabajo_words = [
        "Control prenatal", "Ecografía", "Anticonceptivos", "Examen pélvico", 
        "Papanicolaou", "Mamografía", "Control menstrual", "Suplementos de hierro", 
        "Planificación familiar", "Seguimiento postparto", "Cirugía ginecológica",
        "Tratamiento hormonal", "Control de fertilidad", "Terapia hormonal",
        "Biopsia endometrial"
    ]

    resultado_atencion_words = [
        "Mejoría", "Estable", "Empeoramiento", "Sin cambios", 
        "Alta médica", "Requiere seguimiento", "Crítico", 
        "Controlado", "Complicaciones", "Recuperación parcial", 
        "Sin complicaciones", "Recuperación completa", 
        "En observación", "Derivado a especialista", "Condición grave",
        "Requiere intervención quirúrgica", "Recuperación lenta", 
        "Respuesta favorable al tratamiento", "Sin respuesta al tratamiento"
    ]

    indicaciones_words = [
        "Tomar medicación cada 8 horas", "Reposo absoluto por 5 días", 
        "Mantener una dieta baja en grasas", "Evitar esfuerzos físicos", 
        "Hidratación adecuada", "Asistir a control en una semana", 
        "Aplicar compresas frías", "Evitar exposición al sol", 
        "Tomar analgésicos según sea necesario", "Seguir con fisioterapia", 
        "Monitorear la presión arterial", "Realizar ejercicios respiratorios", 
        "Evitar alimentos con alto contenido de sodio", "Mantener la herida limpia y seca",
        "Usar protector solar", "Evitar consumo de alcohol", 
        "Reducir el consumo de azúcar", "Controlar los niveles de glucosa", 
        "Descanso de al menos 8 horas", "Seguir tratamiento con antibióticos"
    ]

    IDHistoria = random.randint(1, 1000000)
    Indicaciones = ' '.join(random.choices(indicaciones_words, k=1))
    IDReceta = random.randint(1, 1000000)
    IDExpedienteDiagnostico = random.randint(1, 1000000)
    HoraInicio = generar_hora()
    HoraFin = generar_hora()

    start_date = datetime(2020, 1, 1)
    end_date = datetime(2025, 12, 31)

    FechaAtencion = fake.date_time_between(start_date=start_date, end_date=end_date)
    Anammesis = ' '.join(random.choices(anamnesis_words, k=1))
    IDExamenClinico = random.randint(1, 1000000)
    ResultadoAtencion = ' '.join(random.choices(resultado_atencion_words, k=1))
    IDExamenAuxiliar = random.randint(1, 1000000)
    PlanTrabajo = ' '.join(random.choices(plan_trabajo_words, k=1))
    IDDoctor = random.randint(1, 250)
    IDPaciente = random.randint(1, 1000000)
    IDHospital = random.randint(1, 30)
    IDArea = random.randint(1, 3)
    IDServicio = random.randint(1, 30)

    # Insertar los datos en la tabla EXPEDIENTE_CLINICO
    cursor.execute(""" 
        INSERT INTO EXPEDIENTE_CLINICO
        (IDHistoria, Indicaciones, IDReceta, IDExpedienteDiagnostico, HoraInicio, HoraFin, FechaAtencion,
         Anammesis, IDExamenClinico, ResultadoAtencion, IDExamenAuxiliar, PlanTrabajo, IDDoctor, IDPaciente, 
         IDHospital, IDArea, IDServicio)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (IDHistoria, Indicaciones, IDReceta, IDExpedienteDiagnostico, HoraInicio, HoraFin, 
              FechaAtencion, Anammesis, IDExamenClinico, ResultadoAtencion, IDExamenAuxiliar, PlanTrabajo, 
              IDDoctor, IDPaciente, IDHospital, IDArea, IDServicio))
    
    # Guardar cambios
    conn.commit()

# Número de inserciones que quieres realizar
num_inserciones = 3

# Generar registros falsos
for i in range(num_inserciones):
    insert_fake_data()
    print(f"{i + 1} EXPEDIENTE_CLINICO insertado")

# Cerrar conexión
cursor.close()
conn.close()
