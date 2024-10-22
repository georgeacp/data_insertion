import pyodbc
from faker import Faker
import random

# Conexión a la base de datos usando autenticación de Windows
conexion = pyodbc.connect('DRIVER={SQL Server};SERVER=LAPC;DATABASE=DB_H;Trusted_Connection=yes')
cursor = conexion.cursor()

faker = Faker('es_ES')

# Inserciones para tablas sin dependencias

def insertar_grupo_sanguineo():
    tipos_sangre = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']  # Valores reales para grupo sanguíneo
    datos = [(random.choice(tipos_sangre),) for _ in range(8)]
    cursor.executemany('''
        INSERT INTO GRUPO_SANGUINEO_1 (Nombre)
        VALUES (?)''', datos)
    conexion.commit()

def insertar_seguro():
    nombres_seguros = [
        'SIS', 'EsSalud', 'Rimac', 'Pacifico', 'Mapfre', 'La Positiva',
        'Sanitas'
    ]
    datos = [(random.choice(nombres_seguros),) for _ in range(7)]
    cursor.executemany('''
        INSERT INTO SEGURO_1 (Nombre)
        VALUES (?)''', datos)
    conexion.commit()

def insertar_diagnostico():
    diagnosticos = [
        'Hipertensión', 'Diabetes tipo 2', 'Insuficiencia cardíaca', 
        'Asma', 'Neumonía', 'Gripe', 'Anemia', 'Fractura ósea', 'Gastritis', 
        'Infección urinaria', 'Migraña', 'Osteoartritis', 'Cáncer de mama',
        'Embarazo', 'Parto prematuro', 'Preeclampsia', 
        'Endometriosis', 'Menopausia', 'Síndrome de ovario poliquístico', 
        'Infertilidad', 'Miomas uterinos', 'Cáncer de cuello uterino', 
        'Cáncer de ovario', 'Cáncer de endometrio', 'Aborto espontáneo', 
        'Infección vaginal', 'Parto normal', 'Parto por cesárea', 'Parto de Mortinato', 'Labor de parto', 'Parto por cesarea de Mortinato'
    ]
    datos = [(random.choice(diagnosticos),) for _ in range(31)]
    cursor.executemany('''
        INSERT INTO DIAGNOSTICO_1 (Descripcion)
        VALUES (?)''', datos)
    conexion.commit()

def insertar_hospital(cantidad):
    # Generar datos de hospitales
    datos = [(f'HOSP-{i}', faker.company()[:30]) for i in range(1, cantidad + 1)]
    
    # Insertar en la base de datos
    cursor.executemany(''' 
        INSERT INTO HOSPITAL_1 (IDHospital, CasaAtencion)   
        VALUES (?, ?)''', datos)
    
    # Confirmar los cambios en la base de datos
    conexion.commit()

def insertar_servicio_hospitalario(cantidad):
    servicios_hospitalarios = [
        'Urgencias', 'Radiología', 'Oncología', 'Pediatría', 'Cardiología', 
        'UCI', 'Cirugía', 'Traumatología', 'Ginecología', 'Oftalmología'
    ]
    datos = [(random.choice(servicios_hospitalarios),) for _ in range(cantidad)]
    cursor.executemany('''
        INSERT INTO SERVICIO_HOSPITALARIO_1 (Nombre)
        VALUES (?)''', datos)
    conexion.commit()

def insertar_laboratorio(cantidad):
    nombres_laboratorios = [
        'Laboratorio Roche', 'Laboratorios Biomédicos', 'Laboratorio Pharma', 
        'LabQuim', 'LabTec', 'Laboratorios FARMA', 'BioLab Internacional'
    ]
    datos = [(random.choice(nombres_laboratorios), faker.address()[:50]) for _ in range(cantidad)]
    cursor.executemany('''
        INSERT INTO LABORATORIO_1 (Nombre, Ubicacion)
        VALUES (?, ?)''', datos)
    conexion.commit()

def insertar_especialidad(cantidad):
    especialidades_medicas = [
        'Cardiología', 'Dermatología', 'Neurología', 'Gastroenterología', 
        'Endocrinología', 'Hematología', 'Infectología', 'Pediatría', 'Urología'
    ]
    datos = [(random.choice(especialidades_medicas),) for _ in range(cantidad)]
    cursor.executemany('''
        INSERT INTO ESPECIALIDAD_1 (Nombre)
        VALUES (?)''', datos)
    conexion.commit()

# def insertar_medicamento(cantidad):
#     nombres_medicamentos = [
#         'Paracetamol', 'Ibuprofeno', 'Amoxicilina', 'Omeprazol', 'Metformina', 
#         'Atorvastatina', 'Losartán', 'Loratadina', 'Levotiroxina', 'Simvastatina'
#     ]
#     vias_administracion = ['Oral', 'Intravenosa', 'Intramuscular', 'Tópica']
#     frecuencias = ['Cada 8 horas', 'Cada 12 horas', 'Cada 24 horas', 'Antes de las comidas']
#     indicaciones = [
#         'Tomar con comida', 'No exceder la dosis', 'Evitar conducir', 
#         'Usar con precaución en embarazadas', 'No mezclar con alcohol'
#     ]
    
#     datos = [(random.choice(nombres_medicamentos), faker.sentence(nb_words=3), random.choice(vias_administracion), random.choice(frecuencias), random.choice(indicaciones)) for _ in range(cantidad)]
#     cursor.executemany('''
#         INSERT INTO MEDICAMENTO_1 (Nombre, Dosis, ViaAdministracion, Frecuencia, Indicaciones)
#         VALUES (?, ?, ?, ?, ?)''', datos)
#     conexion.commit()

def insertar_area_hospitalaria(cantidad):
    areas_hospitalarias = [
        'Consulta Externa', 'Hospitalización', 'Sala de Operaciones', 
        'Emergencias', 'Rehabilitación', 'Unidad de Cuidados Intensivos'
    ]
    datos = [(random.choice(areas_hospitalarias),) for _ in range(cantidad)]
    cursor.executemany('''
        INSERT INTO AREA_HOSPITALARIA_1 (Nombre)
        VALUES (?)''', datos)
    conexion.commit()

def insertar_tipo_prueba(cantidad):
    tipos_pruebas = [
        'Hemograma', 'Prueba de glucosa', 'Prueba de colesterol', 
        'Ecografía', 'Rayos X', 'Resonancia magnética', 'Electrocardiograma'
    ]
    datos = [(random.choice(tipos_pruebas),) for _ in range(cantidad)]
    cursor.executemany('''
        INSERT INTO TIPO_PRUEBA_1 (NombreTipo)
        VALUES (?)''', datos)
    conexion.commit()

def insertar_doctor(cantidad):
    doctors = [(faker.first_name()[:20], faker.last_name()[:20], faker.random_int(min=10000000, max=99999999), 
            faker.phone_number()[:9], faker.email()[:30], faker.random_int(min=10000, max=99999)) for _ in range(cantidad)]
    cursor.executemany("INSERT INTO DOCTOR_1 (Nombre, Apellido, DNI, Telefono, Email, NrColegiatura) VALUES (?, ?, ?, ?, ?, ?)", doctors)
    conexion.commit()

def insertar_signos_vitales(cantidad):
    vital_signs = [(faker.random_int(min=90, max=180), faker.word(), faker.random_int(min=35, max=40), 
                faker.random_int(min=60, max=100), faker.random_int(min=12, max=30), 
                faker.random_int(min=90, max=100), faker.random_int(min=0, max=100)) for _ in range(cantidad)]
    cursor.executemany("INSERT INTO SIGNOS_VITALES_1 (PresionArterial, PresionVenosaCentral, TemperaturaCorporal, FrecuenciaCardiaca, FrecuenciaRespiratoria, SaturacionO2, FiO2) VALUES (?, ?, ?, ?, ?, ?, ?)", vital_signs)
    conexion.commit()

def insertar_antropometria(cantidad):
    anthropometries = [(faker.random_int(min=50, max=150), faker.random_int(min=150, max=200), faker.random_int(min=90, max=110)) for _ in range(cantidad)]
    cursor.executemany("INSERT INTO ANTROPOMETRIA_1 (Peso, Talla, PerimetroAbdominal) VALUES (?, ?, ?)", anthropometries)
    conexion.commit()

def insertar_receta(cantidad):
    prescriptions = [(faker.sentence(nb_words=5)[:50],) for _ in range(cantidad)]
    cursor.executemany("INSERT INTO RECETA_1 (Recomendacion) VALUES (?)", prescriptions)
    conexion.commit()


# Inserta X registros en cada tabla
cant = 100
insertar_grupo_sanguineo(cant)
insertar_seguro(cant)
insertar_diagnostico(cant)
insertar_hospital(cant)
insertar_servicio_hospitalario(cant)
insertar_laboratorio(cant)
insertar_especialidad(cant)
insertar_medicamento(cant)
insertar_area_hospitalaria(cant)
insertar_tipo_prueba(cant)
insertar_doctor(cant)
insertar_signos_vitales(cant)
insertar_antropometria(cant)
insertar_receta(cant)

conexion.close()
