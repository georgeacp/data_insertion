import pyodbc
from faker import Faker
import random
from datetime import datetime
import os
from dotenv import load_dotenv
import sys

# Cargar las variables de entorno
load_dotenv()

# Crear un generador de datos falsos
fake = Faker()

# Conectar a la base de datos SQL Server usando variables de entorno
conn = pyodbc.connect(
    f'DRIVER={os.getenv("DB_DRIVER")};'
    f'SERVER={os.getenv("DB_SERVER")};'
    f'DATABASE={os.getenv("DB_DATABASE")};'
    f'Trusted_Connection={os.getenv("DB_TRUSTED_CONNECTION")};'
)

cursor = conn.cursor()

# Listas de palabras para campos específicos
anammesis_words = [
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

# Obtener IDs de las tablas relacionadas para su uso en las inserciones
def obtener_ids(tabla, columna_id):
    cursor.execute(f"SELECT {columna_id} FROM {tabla}")
    return [row[0] for row in cursor.fetchall()]

# Cargar los IDs válidos de las tablas
ids_pacientes = obtener_ids("PACIENTE", "IDPaciente")
ids_doctores = obtener_ids("DOCTOR", "IDDoctor")
ids_recetas = obtener_ids("RECETA", "IDReceta")
ids_examenes_clinicos = obtener_ids("EXAMEN_CLINICO", "IDExamenClinico")
ids_examenes_auxiliares = obtener_ids("EXAMEN_AUXILIAR", "IDExamenAuxiliar")
ids_hospitales = obtener_ids("HOSPITAL", "IDHospital")
ids_areas = obtener_ids("AREA_HOSPITALARIA", "IDArea")
ids_servicios = obtener_ids("SERVICIO_HOSPITALARIO", "IDServicio")
ids_historias = obtener_ids("HISTORIA_CLINICA", "IDHistoria")

# Función para generar una hora aleatoria en formato HH:MM:SS sin microsegundos
def generar_horas_ordenadas():
    hora_inicio = random.randint(7, 23)
    minuto_inicio = random.randint(0, 59)
    segundo_inicio = random.randint(0, 59)
    HoraInicio = f"{hora_inicio:02d}:{minuto_inicio:02d}:{segundo_inicio:02d}"
    
    # Añadir un intervalo de 10-30 minutos para HoraFin
    minuto_fin = minuto_inicio + random.randint(10, 30)
    if minuto_fin >= 60:
        minuto_fin -= 60
        hora_fin = (hora_inicio + 1) if hora_inicio < 23 else 23
    else:
        hora_fin = hora_inicio
    
    HoraFin = f"{hora_fin:02d}:{minuto_fin:02d}:{segundo_inicio:02d}"
    return HoraInicio, HoraFin

# Función para insertar datos en EXPEDIENTE_CLINICO
def insert_expediente_clinico():
    start_date = datetime(2020, 1, 1)
    end_date = datetime(2025, 12, 31)
    total = len(ids_historias)  # Número total de historias clínicas para la barra de progreso
    
    for index, historia_id in enumerate(ids_historias, start=1):  # Iterar sobre los IDs válidos de historias clínicas
        # Generar de 0 a 10 expedientes para cada historia clínica
        num_expedientes = random.randint(0, 10)
        
        for _ in range(num_expedientes):
            IDHistoria = historia_id
            IDPaciente = random.choice(ids_pacientes)
            IDDoctor = random.choice(ids_doctores)
            IDReceta = random.choice(ids_recetas)
            IDExamenClinico = random.choice(ids_examenes_clinicos)
            IDExamenAuxiliar = random.choice(ids_examenes_auxiliares)
            IDHospital = random.choice(ids_hospitales)
            IDArea = random.choice(ids_areas)
            IDServicio = random.choice(ids_servicios)
            
            # Generar una fecha de atención aleatoria y asegurar orden cronológico
            FechaAtencion = fake.date_time_between(start_date=start_date, end_date=end_date)
            HoraInicio, HoraFin = generar_horas_ordenadas()
            
            # Generar otros datos aleatorios utilizando las listas definidas
            Indicaciones = ' '.join(random.choices(indicaciones_words, k=1))
            Anammesis = ' '.join(random.choices(anammesis_words, k=1))
            PlanTrabajo = ' '.join(random.choices(plan_trabajo_words, k=1))
            ResultadoAtencion = ' '.join(random.choices(resultado_atencion_words, k=1))
            
            # Insertar los datos en la tabla EXPEDIENTE_CLINICO con el orden correcto de columnas
            cursor.execute(""" 
                INSERT INTO EXPEDIENTE_CLINICO
                (IDHistoria, FechaAtencion, HoraInicio, HoraFin, Anammesis, PlanTrabajo, Indicaciones, ResultadoAtencion, IDReceta, IDExamenClinico, IDExamenAuxiliar, IDDoctor, IDPaciente, IDHospital, IDArea, IDServicio)   
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """, (IDHistoria, FechaAtencion, HoraInicio, HoraFin, Anammesis, PlanTrabajo, Indicaciones, ResultadoAtencion, IDReceta, IDExamenClinico, IDExamenAuxiliar, IDDoctor, IDPaciente, IDHospital, IDArea, IDServicio))

        # Barra de progreso
        progreso = (index / total) * 100
        sys.stdout.write(f"\rProgreso: [{int(progreso)}%] {'#' * (int(progreso) // 2)}")
        sys.stdout.flush()
    
    print("\n")  # Nueva línea al terminar la barra de progreso

# Ejecutar la función para insertar datos
insert_expediente_clinico()

# Confirmar cambios en la base de datos
conn.commit()
cursor.close()
conn.close()

print("Inserción de datos en EXPEDIENTE_CLINICO completada exitosamente.")
