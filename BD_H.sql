USE master
GO

DROP DATABASE DB_H
go

CREATE DATABASE DB_H
GO 

USE DB_H	
GO

CREATE TABLE ANTROPOMETRIA_1
( 
	IDAntropometria      int IDENTITY ( 1,1 ) ,
	Peso                 float  NULL ,
	Talla                float  NULL ,
	PerimetroAbdominal   varchar(20)  NULL 
)
go



ALTER TABLE ANTROPOMETRIA_1
	ADD CONSTRAINT XPKANTROPOMETRIA PRIMARY KEY  CLUSTERED (IDAntropometria ASC)
go



CREATE TABLE AREA_HOSPITALARIA_1
( 
	IDArea               int IDENTITY ( 1,1 ) ,
	Nombre               varchar(30)  NOT NULL 
)
go



ALTER TABLE AREA_HOSPITALARIA_1
	ADD CONSTRAINT XPKAREA_HOSPITALARIA PRIMARY KEY  CLUSTERED (IDArea ASC)
go



CREATE TABLE DIAGNOSTICO_1
( 
	IDDiagnostico        int IDENTITY ( 1,1 ) ,
	Descripcion          varchar(50)  NOT NULL 
)
go



ALTER TABLE DIAGNOSTICO_1
	ADD CONSTRAINT XPKENFERMEDAD PRIMARY KEY  CLUSTERED (IDDiagnostico ASC)
go



CREATE TABLE DOCTOR_1
( 
	IDDoctor             int IDENTITY ( 1,1 ) ,
	Nombre               varchar(20)  NULL ,
	Apellido             varchar(20)  NULL ,
	DNI                  char(8)  NULL ,
	Telefono             char(9)  NULL ,
	Email                varchar(30)  NULL ,
	NrColegiatura        varchar(30)  NULL 
)
go



ALTER TABLE DOCTOR_1
	ADD CONSTRAINT XPKDOCTOR PRIMARY KEY  CLUSTERED (IDDoctor ASC)
go



CREATE TABLE DOCTOR_ESPECIALIDAD_2
( 
	IDDoctor             int  NOT NULL ,
	IDEspecialidad       int  NOT NULL 
)
go



ALTER TABLE DOCTOR_ESPECIALIDAD_2
	ADD CONSTRAINT XPKDOCTOR_ESPECIALIDAD PRIMARY KEY  CLUSTERED (IDDoctor ASC,IDEspecialidad ASC)
go



CREATE TABLE ESPECIALIDAD_1
( 
	IDEspecialidad       int IDENTITY ( 1,1 ) ,
	Nombre               varchar(30)  NOT NULL 
)
go



ALTER TABLE ESPECIALIDAD_1
	ADD CONSTRAINT XPKESPECIALIDAD PRIMARY KEY  CLUSTERED (IDEspecialidad ASC)
go



CREATE TABLE EXAMEN_AUXILIAR_3
( 
	Resultado            varchar(50)  NOT NULL ,
	Fecha                datetime  NULL ,
	Indicacion           varchar(50)  NULL ,
	IDPrueba             int  NULL ,
	IDExamenAuxiliar     int IDENTITY ( 1,1 ) 
)
go



ALTER TABLE EXAMEN_AUXILIAR_3
	ADD CONSTRAINT XPKPRUEBA_LABORATORIO PRIMARY KEY  CLUSTERED (IDExamenAuxiliar ASC)
go



CREATE TABLE EXAMEN_CLINICO_2
( 
	IDExamenClinico      int IDENTITY ( 1,1 ) ,
	IDSignosVitales      int  NOT NULL ,
	IDAntropometria      int  NULL 
)
go



ALTER TABLE EXAMEN_CLINICO_2
	ADD CONSTRAINT XPKEXAMEN_CLINICO PRIMARY KEY  CLUSTERED (IDExamenClinico ASC)
go



CREATE TABLE EXPEDIENTE_CLINICO_4
( 
	IDExpediente         int  NOT NULL ,
	IDHistoria           int  NOT NULL ,
	Indicaciones         varchar(250)  NULL ,
	IDReceta             int  NULL ,
	IDExpedienteDiagnostico int  NOT NULL ,
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
	IDHospital           char(18)  NOT NULL ,
	IDArea               int  NOT NULL ,
	IDServicio           int  NOT NULL 
)
go



ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT XPKHISTORIA_ENFERMEDAD PRIMARY KEY  CLUSTERED (IDExpediente ASC,IDHistoria ASC)
go



CREATE TABLE EXPEDIENTE_DIAGNOSTICO_2
( 
	IDExpedienteDiagnostico int IDENTITY ( 1,1 ) ,
	Tipo                 varchar(50)  NOT NULL ,
	Alta                 char(2)  NOT NULL ,
	IDDiagnostico        int  NOT NULL ,
	Caso                 char(18)  NOT NULL 
)
go



ALTER TABLE EXPEDIENTE_DIAGNOSTICO_2
	ADD CONSTRAINT XPKDIAGNOSTICO PRIMARY KEY  CLUSTERED (IDExpedienteDiagnostico ASC)
go



CREATE TABLE GRUPO_SANGUINEO_1
( 
	IDGrupoSanguineo     int IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL 
)
go



ALTER TABLE GRUPO_SANGUINEO_1
	ADD CONSTRAINT XPKGRUPO_SANGUINEO PRIMARY KEY  CLUSTERED (IDGrupoSanguineo ASC)
go



CREATE TABLE HISTORIA_CLINICA_3
( 
	IDHistoria           int IDENTITY ( 1,1 ) ,
	FechaCreacion        datetime  NOT NULL ,
	Observaciones        varchar(50)  NULL ,
	IDPaciente           int  NOT NULL 
)
go



ALTER TABLE HISTORIA_CLINICA_3
	ADD CONSTRAINT XPKHISTORIA_CLINICA PRIMARY KEY  CLUSTERED (IDHistoria ASC)
go



CREATE TABLE HOSPITAL_1
( 
	IDHospital           char(18)  NOT NULL ,
	CasaAtencion         varchar(30)  NOT NULL 
)
go



ALTER TABLE HOSPITAL_1
	ADD CONSTRAINT XPKHOSPITAL PRIMARY KEY  CLUSTERED (IDHospital ASC)
go



CREATE TABLE LABORATORIO_1
( 
	IDLaboratorio        int IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL ,
	Ubicacion            varchar(50)  NULL 
)
go



ALTER TABLE LABORATORIO_1
	ADD CONSTRAINT XPKLABORATORIO PRIMARY KEY  CLUSTERED (IDLaboratorio ASC)
go



CREATE TABLE MEDICAMENTO_1
( 
	IDMedicamento        int IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NULL ,
	Dosis                varchar(50)  NOT NULL ,
	ViaAdministracion    varchar(50)  NOT NULL ,
	Frecuencia           varchar(20)  NOT NULL ,
	Indicaciones         varchar(50)  NOT NULL 
)
go



ALTER TABLE MEDICAMENTO_1
	ADD CONSTRAINT XPKMEDICAMENTO PRIMARY KEY  CLUSTERED (IDMedicamento ASC)
go



CREATE TABLE PACIENTE_2
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
	FechaRegistro        datetime  NOT NULL ,
	IDSeguro             int  NULL ,
	IDGrupoSanguineo     int  NULL 
)
go



ALTER TABLE PACIENTE_2
	ADD CONSTRAINT XPKPACIENTE PRIMARY KEY  CLUSTERED (IDPaciente ASC)
go



CREATE TABLE PRUEBA_2
( 
	IDPrueba             int IDENTITY ( 1,1 ) ,
	NombrePrueba         varchar(50)  NOT NULL ,
	IDTipoPrueba         int  NULL ,
	IDLaboratorio        int  NULL 
)
go



ALTER TABLE PRUEBA_2
	ADD CONSTRAINT XPKPRUEBA_ESPECIFICA PRIMARY KEY  CLUSTERED (IDPrueba ASC)
go



CREATE TABLE RECETA_1
( 
	IDReceta             int IDENTITY ( 1,1 ) ,
	Recomendacion        varchar(50)  NULL 
)
go



ALTER TABLE RECETA_1
	ADD CONSTRAINT XPKRECETA PRIMARY KEY  CLUSTERED (IDReceta ASC)
go



CREATE TABLE RECETA_MEDICAMENTO_2
( 
	IDReceta             int  NOT NULL ,
	IDMedicamento        int  NOT NULL ,
	Cantidad             varchar(30)  NOT NULL ,
	Dosis                varchar(20)  NOT NULL ,
	Frecuencia           varchar(50)  NOT NULL ,
	Duracion             varchar(20)  NOT NULL 
)
go



ALTER TABLE RECETA_MEDICAMENTO_2
	ADD CONSTRAINT XPKRECETA_MEDICAMENTO PRIMARY KEY  CLUSTERED (IDReceta ASC,IDMedicamento ASC)
go



CREATE TABLE SEGURO_1
( 
	IDSeguro             int IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL 
)
go



ALTER TABLE SEGURO_1
	ADD CONSTRAINT XPKSEGURO PRIMARY KEY  CLUSTERED (IDSeguro ASC)
go



CREATE TABLE SERVICIO_HOSPITALARIO_1
( 
	IDServicio           int IDENTITY ( 1,1 ) ,
	Nombre               varchar(30)  NOT NULL 
)
go



ALTER TABLE SERVICIO_HOSPITALARIO_1
	ADD CONSTRAINT XPKDEPARTAMENTO PRIMARY KEY  CLUSTERED (IDServicio ASC)
go



CREATE TABLE SIGNOS_VITALES_1
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



ALTER TABLE SIGNOS_VITALES_1
	ADD CONSTRAINT XPKSIGNOS_VITALES PRIMARY KEY  CLUSTERED (IDSignosVitales ASC)
go



CREATE TABLE TIPO_PRUEBA_1
( 
	IDTipoPrueba         int IDENTITY ( 1,1 ) ,
	NombreTipo           varchar(50)  NULL 
)
go



ALTER TABLE TIPO_PRUEBA_1
	ADD CONSTRAINT XPKTIPO_PRUEBA PRIMARY KEY  CLUSTERED (IDTipoPrueba ASC)
go




ALTER TABLE DOCTOR_ESPECIALIDAD_2
	ADD CONSTRAINT R_25 FOREIGN KEY (IDDoctor) REFERENCES DOCTOR_1(IDDoctor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DOCTOR_ESPECIALIDAD_2
	ADD CONSTRAINT R_26 FOREIGN KEY (IDEspecialidad) REFERENCES ESPECIALIDAD_1(IDEspecialidad)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXAMEN_AUXILIAR_3
	ADD CONSTRAINT R_36 FOREIGN KEY (IDPrueba) REFERENCES PRUEBA_2(IDPrueba)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXAMEN_CLINICO_2
	ADD CONSTRAINT R_64 FOREIGN KEY (IDSignosVitales) REFERENCES SIGNOS_VITALES_1(IDSignosVitales)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXAMEN_CLINICO_2
	ADD CONSTRAINT R_65 FOREIGN KEY (IDAntropometria) REFERENCES ANTROPOMETRIA_1(IDAntropometria)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_13 FOREIGN KEY (IDHistoria) REFERENCES HISTORIA_CLINICA_3(IDHistoria)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_23 FOREIGN KEY (IDReceta) REFERENCES RECETA_1(IDReceta)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_55 FOREIGN KEY (IDExpedienteDiagnostico) REFERENCES EXPEDIENTE_DIAGNOSTICO_2(IDExpedienteDiagnostico)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_63 FOREIGN KEY (IDExamenClinico) REFERENCES EXAMEN_CLINICO_2(IDExamenClinico)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_67 FOREIGN KEY (IDExamenAuxiliar) REFERENCES EXAMEN_AUXILIAR_3(IDExamenAuxiliar)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_72 FOREIGN KEY (IDDoctor) REFERENCES DOCTOR_1(IDDoctor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_73 FOREIGN KEY (IDPaciente) REFERENCES PACIENTE_2(IDPaciente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_74 FOREIGN KEY (IDHospital) REFERENCES HOSPITAL_1(IDHospital)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_75 FOREIGN KEY (IDArea) REFERENCES AREA_HOSPITALARIA_1(IDArea)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_CLINICO_4
	ADD CONSTRAINT R_76 FOREIGN KEY (IDServicio) REFERENCES SERVICIO_HOSPITALARIO_1(IDServicio)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EXPEDIENTE_DIAGNOSTICO_2
	ADD CONSTRAINT R_77 FOREIGN KEY (IDDiagnostico) REFERENCES DIAGNOSTICO_1(IDDiagnostico)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE HISTORIA_CLINICA_3
	ADD CONSTRAINT R_12 FOREIGN KEY (IDPaciente) REFERENCES PACIENTE_2(IDPaciente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PACIENTE_2
	ADD CONSTRAINT R_1 FOREIGN KEY (IDSeguro) REFERENCES SEGURO_1(IDSeguro)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PACIENTE_2
	ADD CONSTRAINT R_2 FOREIGN KEY (IDGrupoSanguineo) REFERENCES GRUPO_SANGUINEO_1(IDGrupoSanguineo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PRUEBA_2
	ADD CONSTRAINT R_37 FOREIGN KEY (IDTipoPrueba) REFERENCES TIPO_PRUEBA_1(IDTipoPrueba)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PRUEBA_2
	ADD CONSTRAINT R_71 FOREIGN KEY (IDLaboratorio) REFERENCES LABORATORIO_1(IDLaboratorio)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE RECETA_MEDICAMENTO_2
	ADD CONSTRAINT R_21 FOREIGN KEY (IDReceta) REFERENCES RECETA_1(IDReceta)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE RECETA_MEDICAMENTO_2
	ADD CONSTRAINT R_22 FOREIGN KEY (IDMedicamento) REFERENCES MEDICAMENTO_1(IDMedicamento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go