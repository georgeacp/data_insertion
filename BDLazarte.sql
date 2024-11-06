create database BDLazarte
go

CREATE TABLE ANTROPOMETRIA
( 
	IDAntropometria      int IDENTITY ( 1,1 ) ,
	Peso                 float  NULL ,
	Talla                float  NULL ,
	PerimetroAbdominal   varchar(20)  NULL 
)
go



ALTER TABLE ANTROPOMETRIA
	ADD CONSTRAINT XPKANTROPOMETRIA PRIMARY KEY  CLUSTERED (IDAntropometria ASC)
go



CREATE TABLE AREA_HOSPITALARIA
( 
	IDArea               int IDENTITY ( 1,1 ) ,
	Nombre               varchar(30)  NOT NULL 
)
go



ALTER TABLE AREA_HOSPITALARIA
	ADD CONSTRAINT XPKAREA_HOSPITALARIA PRIMARY KEY  CLUSTERED (IDArea ASC)
go



CREATE TABLE BEBE
( 
	IDBebe               int IDENTITY ( 1,1 ) ,
	Fecha                datetime  NOT NULL ,
	Hora                 time  NOT NULL ,
	Sexo                 char(1)  NOT NULL ,
	Peso                 varchar(10)  NOT NULL ,
	Talla                varchar(10)  NOT NULL ,
	PC                   varchar(8)  NOT NULL ,
	PT                   varchar(8)  NOT NULL 
)
go



ALTER TABLE BEBE
	ADD CONSTRAINT XPKBEBE PRIMARY KEY  CLUSTERED (IDBebe ASC)
go



CREATE TABLE DIAGNOSTICO
( 
	IDDiagnostico        int IDENTITY ( 1,1 ) ,
	Descripcion          varchar(50)  NOT NULL ,
	Tipo                 varchar(15)  NOT NULL 
)
go



ALTER TABLE DIAGNOSTICO
	ADD CONSTRAINT XPKENFERMEDAD PRIMARY KEY  CLUSTERED (IDDiagnostico ASC)
go



CREATE TABLE DOCTOR
( 
	IDDoctor             int IDENTITY ( 1,1 ) ,
	Nombre               varchar(20)  NOT NULL ,
	Apellido             varchar(50)  NOT NULL ,
	DNI                  char(8)  NOT NULL ,
	Telefono             char(9)  NOT NULL ,
	Email                varchar(50)  NOT NULL ,
	NrColegiatura        varchar(10)  NOT NULL 
)
go



ALTER TABLE DOCTOR
	ADD CONSTRAINT XPKDOCTOR PRIMARY KEY  CLUSTERED (IDDoctor ASC)
go



CREATE TABLE DOCTOR_ESPECIALIDAD
( 
	IDDoctor             int  NOT NULL ,
	IDEspecialidad       int  NOT NULL 
)
go



ALTER TABLE DOCTOR_ESPECIALIDAD
	ADD CONSTRAINT XPKDOCTOR_ESPECIALIDAD PRIMARY KEY  CLUSTERED (IDDoctor ASC,IDEspecialidad ASC)
go



CREATE TABLE ESPECIALIDAD
( 
	IDEspecialidad       int IDENTITY ( 1,1 ) ,
	Nombre               varchar(30)  NOT NULL 
)
go



ALTER TABLE ESPECIALIDAD
	ADD CONSTRAINT XPKESPECIALIDAD PRIMARY KEY  CLUSTERED (IDEspecialidad ASC)
go



CREATE TABLE EXAMEN_AUXILIAR
( 
	Resultado            varchar(50)  NOT NULL ,
	Fecha                datetime  NULL ,
	Indicacion           varchar(50)  NULL ,
	IDPrueba             int  NULL ,
	IDExamenAuxiliar     int IDENTITY ( 1,1 ) 
)
go



ALTER TABLE EXAMEN_AUXILIAR
	ADD CONSTRAINT XPKPRUEBA_LABORATORIO PRIMARY KEY  CLUSTERED (IDExamenAuxiliar ASC)
go



CREATE TABLE EXAMEN_CLINICO
( 
	IDExamenClinico      int IDENTITY ( 1,1 ) ,
	IDSignosVitales      int  NOT NULL ,
	IDAntropometria      int  NULL 
)
go



ALTER TABLE EXAMEN_CLINICO
	ADD CONSTRAINT XPKEXAMEN_CLINICO PRIMARY KEY  CLUSTERED (IDExamenClinico ASC)
go



CREATE TABLE EXPEDIENTE_CLINICO
( 
	IDExpediente         int IDENTITY ( 1,1 ) ,
	IDHistoria           int  NOT NULL ,
	Indicaciones         varchar(250)  NULL ,
	IDReceta             int  NULL ,
	HoraInicio           time  NOT NULL ,
	HoraFin              time  NOT NULL ,
	FechaAtencion        datetime  NOT NULL ,
	Anammesis            varchar(300)  NULL ,
	IDExamenClinico      int  NOT NULL ,
	ResultadoAtencion    varchar(50)  NOT NULL ,
	IDExamenAuxiliar     int  NULL ,
	PlanTrabajo          varchar(300)  NULL ,
	IDDoctor             int  NOT NULL ,
	IDPaciente           int  NOT NULL ,
	IDHospital           int  NOT NULL ,
	IDArea               int  NOT NULL ,
	IDServicio           int  NOT NULL 
)
go



ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT XPKHISTORIA_ENFERMEDAD PRIMARY KEY  CLUSTERED (IDExpediente ASC,IDHistoria ASC)
go



CREATE TABLE EXPEDIENTE_DIAGNOSTICO
( 
	Tipo                 varchar(50)  NOT NULL ,
	Alta                 char(2)  NOT NULL ,
	Caso                 char(18)  NOT NULL ,
	FechaDiagnostico     datetime  NOT NULL ,
	IDExpediente         int  NOT NULL ,
	IDHistoria           int  NOT NULL ,
	IDDiagnostico        int  NOT NULL 
)
go



ALTER TABLE EXPEDIENTE_DIAGNOSTICO
	ADD CONSTRAINT XPKDIAGNOSTICO PRIMARY KEY  CLUSTERED (IDExpediente ASC,IDHistoria ASC,IDDiagnostico ASC)
go



CREATE TABLE GRUPO_SANGUINEO
( 
	IDGrupoSanguineo     int IDENTITY ( 1,1 ) ,
	Nombre               varchar(3)  NOT NULL 
)
go



ALTER TABLE GRUPO_SANGUINEO
	ADD CONSTRAINT XPKGRUPO_SANGUINEO PRIMARY KEY  CLUSTERED (IDGrupoSanguineo ASC)
go



CREATE TABLE HISTORIA_CLINICA
( 
	IDHistoria           int IDENTITY ( 1,1 ) ,
	FechaCreacion        date  NOT NULL ,
	IDPaciente           int  NOT NULL 
)
go



ALTER TABLE HISTORIA_CLINICA
	ADD CONSTRAINT XPKHISTORIA_CLINICA PRIMARY KEY  CLUSTERED (IDHistoria ASC)
go



CREATE TABLE HOSPITAL
( 
	IDHospital           int IDENTITY ( 1,1 ) ,
	CasaAtencion         varchar(50)  NOT NULL 
)
go



ALTER TABLE HOSPITAL
	ADD CONSTRAINT XPKHOSPITAL PRIMARY KEY  CLUSTERED (IDHospital ASC)
go



CREATE TABLE LABORATORIO
( 
	IDLaboratorio        int IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL ,
	Ubicacion            varchar(50)  NULL 
)
go



ALTER TABLE LABORATORIO
	ADD CONSTRAINT XPKLABORATORIO PRIMARY KEY  CLUSTERED (IDLaboratorio ASC)
go



CREATE TABLE MEDICAMENTO
( 
	IDMedicamento        int IDENTITY ( 1,1 ) ,
	Nombre               varchar(30)  NOT NULL ,
	Dosis                varchar(20)  NOT NULL ,
	ViaAdministracion    varchar(20)  NOT NULL ,
	Frecuencia           varchar(30)  NOT NULL ,
	Indicaciones         varchar(100)  NOT NULL 
)
go



ALTER TABLE MEDICAMENTO
	ADD CONSTRAINT XPKMEDICAMENTO PRIMARY KEY  CLUSTERED (IDMedicamento ASC)
go



CREATE TABLE OBSTETRA
( 
	IDObstetra           int IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL ,
	Apellido             varchar(50)  NOT NULL ,
	DNI                  char(8)  NOT NULL 
)
go



ALTER TABLE OBSTETRA
	ADD CONSTRAINT XPKOBSTE PRIMARY KEY  CLUSTERED (IDObstetra ASC)
go



CREATE TABLE PACIENTE
( 
	IDPaciente           int IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL ,
	Apellido             varchar(50)  NOT NULL ,
	DNI                  char(8)  NOT NULL ,
	FechaNac             date  NOT NULL ,
	Sexo                 char(1)  NOT NULL ,
	Direccion            varchar(50)  NULL ,
	Telefono             char(9)  NULL ,
	Email                varchar(50)  NULL ,
	FechaRegistro        date  NOT NULL ,
	IDSeguro             int  NULL ,
	IDGrupoSanguineo     int  NULL ,
	EstadoCivil          varchar(20)  NOT NULL 
)
go



ALTER TABLE PACIENTE
	ADD CONSTRAINT XPKPACIENTE PRIMARY KEY  CLUSTERED (IDPaciente ASC)
go



CREATE TABLE PARTOGRAMA
( 
	IDPartograma         int IDENTITY ( 1,1 ) ,
	IDExpediente         int  NOT NULL ,
	IDHistoria           int  NOT NULL ,
	HoraInicio           time  NOT NULL ,
	IDObstetra           int  NOT NULL ,
	FrecuenciaCardiacaFetal varchar(200)  NOT NULL ,
	DilatacionCervical   varchar(200)  NOT NULL ,
	LiquidoAmniotico     varchar(200)  NOT NULL ,
	Moldeamiento         varchar(200)  NOT NULL ,
	VariedadPosicion     varchar(200)  NOT NULL ,
	IDBebe               int  NOT NULL 
)
go



ALTER TABLE PARTOGRAMA
	ADD CONSTRAINT XPKPARTIMETRO PRIMARY KEY  CLUSTERED (IDPartograma ASC,IDExpediente ASC,IDHistoria ASC)
go



CREATE TABLE PRUEBA
( 
	IDPrueba             int IDENTITY ( 1,1 ) ,
	NombrePrueba         varchar(50)  NOT NULL ,
	IDTipoPrueba         int  NULL ,
	IDLaboratorio        int  NULL 
)
go



ALTER TABLE PRUEBA
	ADD CONSTRAINT XPKPRUEBA_ESPECIFICA PRIMARY KEY  CLUSTERED (IDPrueba ASC)
go



CREATE TABLE RECETA
( 
	IDReceta             int IDENTITY ( 1,1 ) ,
	Recomendacion        varchar(150)  NULL 
)
go



ALTER TABLE RECETA
	ADD CONSTRAINT XPKRECETA PRIMARY KEY  CLUSTERED (IDReceta ASC)
go



CREATE TABLE RECETA_MEDICAMENTO
( 
	IDReceta             int  NOT NULL ,
	IDMedicamento        int  NOT NULL ,
	Cantidad             varchar(30)  NOT NULL ,
	Dosis                varchar(20)  NOT NULL ,
	Frecuencia           varchar(50)  NOT NULL ,
	Duracion             varchar(20)  NOT NULL 
)
go



ALTER TABLE RECETA_MEDICAMENTO
	ADD CONSTRAINT XPKRECETA_MEDICAMENTO PRIMARY KEY  CLUSTERED (IDReceta ASC,IDMedicamento ASC)
go



CREATE TABLE SEGURO
( 
	IDSeguro             int IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL 
)
go



ALTER TABLE SEGURO
	ADD CONSTRAINT XPKSEGURO PRIMARY KEY  CLUSTERED (IDSeguro ASC)
go



CREATE TABLE SERVICIO_HOSPITALARIO
( 
	IDServicio           int IDENTITY ( 1,1 ) ,
	Nombre               varchar(30)  NOT NULL 
)
go



ALTER TABLE SERVICIO_HOSPITALARIO
	ADD CONSTRAINT XPKDEPARTAMENTO PRIMARY KEY  CLUSTERED (IDServicio ASC)
go



CREATE TABLE SIGNOS_VITALES
( 
	IDSignosVitales      int IDENTITY ( 1,1 ) ,
	PresionArterial      varchar(7)  NOT NULL ,
	PresionVenosaCentral varchar(20)  NULL ,
	TemperaturaCorporal  varchar(5)  NOT NULL ,
	FrecuenciaCardiaca   varchar(20)  NOT NULL ,
	FrecuenciaRespiratoria varchar(20)  NOT NULL ,
	SaturacionO2         varchar(10)  NULL ,
	FiO2                 varchar(10)  NULL 
)
go



ALTER TABLE SIGNOS_VITALES
	ADD CONSTRAINT XPKSIGNOS_VITALES PRIMARY KEY  CLUSTERED (IDSignosVitales ASC)
go



CREATE TABLE TIPO_PRUEBA
( 
	IDTipoPrueba         int IDENTITY ( 1,1 ) ,
	NombreTipo           varchar(50)  NULL 
)
go



ALTER TABLE TIPO_PRUEBA
	ADD CONSTRAINT XPKTIPO_PRUEBA PRIMARY KEY  CLUSTERED (IDTipoPrueba ASC)
go




ALTER TABLE DOCTOR_ESPECIALIDAD
	ADD CONSTRAINT R_25 FOREIGN KEY (IDDoctor) REFERENCES DOCTOR(IDDoctor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DOCTOR_ESPECIALIDAD
	ADD CONSTRAINT R_26 FOREIGN KEY (IDEspecialidad) REFERENCES ESPECIALIDAD(IDEspecialidad)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXAMEN_AUXILIAR
	ADD CONSTRAINT R_36 FOREIGN KEY (IDPrueba) REFERENCES PRUEBA(IDPrueba)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXAMEN_CLINICO
	ADD CONSTRAINT R_64 FOREIGN KEY (IDSignosVitales) REFERENCES SIGNOS_VITALES(IDSignosVitales)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXAMEN_CLINICO
	ADD CONSTRAINT R_65 FOREIGN KEY (IDAntropometria) REFERENCES ANTROPOMETRIA(IDAntropometria)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT R_13 FOREIGN KEY (IDHistoria) REFERENCES HISTORIA_CLINICA(IDHistoria)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT R_23 FOREIGN KEY (IDReceta) REFERENCES RECETA(IDReceta)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT R_63 FOREIGN KEY (IDExamenClinico) REFERENCES EXAMEN_CLINICO(IDExamenClinico)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT R_67 FOREIGN KEY (IDExamenAuxiliar) REFERENCES EXAMEN_AUXILIAR(IDExamenAuxiliar)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT R_72 FOREIGN KEY (IDDoctor) REFERENCES DOCTOR(IDDoctor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT R_73 FOREIGN KEY (IDPaciente) REFERENCES PACIENTE(IDPaciente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT R_74 FOREIGN KEY (IDHospital) REFERENCES HOSPITAL(IDHospital)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT R_75 FOREIGN KEY (IDArea) REFERENCES AREA_HOSPITALARIA(IDArea)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO
	ADD CONSTRAINT R_76 FOREIGN KEY (IDServicio) REFERENCES SERVICIO_HOSPITALARIO(IDServicio)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_DIAGNOSTICO
	ADD CONSTRAINT R_78 FOREIGN KEY (IDExpediente,IDHistoria) REFERENCES EXPEDIENTE_CLINICO(IDExpediente,IDHistoria)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_DIAGNOSTICO
	ADD CONSTRAINT R_79 FOREIGN KEY (IDDiagnostico) REFERENCES DIAGNOSTICO(IDDiagnostico)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE HISTORIA_CLINICA
	ADD CONSTRAINT R_12 FOREIGN KEY (IDPaciente) REFERENCES PACIENTE(IDPaciente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PACIENTE
	ADD CONSTRAINT R_1 FOREIGN KEY (IDSeguro) REFERENCES SEGURO(IDSeguro)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PACIENTE
	ADD CONSTRAINT R_2 FOREIGN KEY (IDGrupoSanguineo) REFERENCES GRUPO_SANGUINEO(IDGrupoSanguineo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PARTOGRAMA
	ADD CONSTRAINT R_82 FOREIGN KEY (IDExpediente,IDHistoria) REFERENCES EXPEDIENTE_CLINICO(IDExpediente,IDHistoria)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PARTOGRAMA
	ADD CONSTRAINT R_83 FOREIGN KEY (IDObstetra) REFERENCES OBSTETRA(IDObstetra)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PARTOGRAMA
	ADD CONSTRAINT R_84 FOREIGN KEY (IDBebe) REFERENCES BEBE(IDBebe)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PRUEBA
	ADD CONSTRAINT R_37 FOREIGN KEY (IDTipoPrueba) REFERENCES TIPO_PRUEBA(IDTipoPrueba)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PRUEBA
	ADD CONSTRAINT R_71 FOREIGN KEY (IDLaboratorio) REFERENCES LABORATORIO(IDLaboratorio)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE RECETA_MEDICAMENTO
	ADD CONSTRAINT R_21 FOREIGN KEY (IDReceta) REFERENCES RECETA(IDReceta)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE RECETA_MEDICAMENTO
	ADD CONSTRAINT R_22 FOREIGN KEY (IDMedicamento) REFERENCES MEDICAMENTO(IDMedicamento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go