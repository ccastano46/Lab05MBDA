    /*
Ciclo1: Tablas
*/
CREATE TABLE Personas(
    id NUMBER(9,0) NOT NULL,
    tipo VARCHAR2(2) NOT NULL,
    numero VARCHAR2(10) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    registro DATE NOT NULL,
    celular NUMBER(10) NOT NULL,
    correo VARCHAR2(50) NOT NULL
);

CREATE TABLE Clientes(
    id NUMBER(9,0) NOT NULL,
    idioma VARCHAR2(10) NOT NULL
);

CREATE TABLE POSICIONES(
    ID VARCHAR2(10) NOT NULL,
    LONGITUD NUMBER(3,2) NOT NULL,
    LATITUD NUMBER(3,2) NOT NULL
);

CREATE TABLE SOLICITUDES(
    CODIGO NUMBER(9,0) NOT NULL,
    FECHA_CREACION TIMESTAMP NOT NULL,
    FECHA_VIAJE TIMESTAMP,
    PLATAFORMA CHAR NOT NULL,
    PRECIO NUMBER(5),
    ESTADO CHAR NOT NULL,
    CLIENTE NUMBER(9,0) NOT NULL,
    UBICACION_INICIAL VARCHAR2(10) NOT NULL,
    UBICACION_FINAL VARCHAR2(10) NOT NULL
);

CREATE TABLE REQUERIMIENTOS(
    REQUERIMIENTO VARCHAR2(15) NOT NULL,
    SOLICITUD NUMBER(9,0) NOT NULL
);

CREATE TABLE TARJETAS_POR_CLIENTE(
    tarjeta NUMBER(15,0) NOT NULL,
    CLIENTE NUMBER(9,0) NOT NULL
);

CREATE TABLE TARJETAS(
    numero NUMBER(15,0) NOT NULL,    
    ENTIDAD VARCHAR2(10) NOT NULL,
    VENCIMIENTO DATE NOT NULL
);


CREATE TABLE PQRSS(
    TICKED VARCHAR2(20) NOT NULL,
    RADICACION DATE NOT NULL,
    CIERRE DATE,
    DESCRIPCION VARCHAR2(255),
    TIPO CHAR NOT NULL,
    ESTADO VARCHAR2(50) NOT NULL,
    SOLICITUD NUMBER(9,0) NOT NULL
);

CREATE TABLE ANEXOS(
    ID VARCHAR2(10) NOT NULL,
    PQRS VARCHAR2(13) NOT NULL,
    NOMBRE VARCHAR2(20) NOT NULL,
    URL VARCHAR2(100) NOT NULL
);

CREATE TABLE VEHICULOS(
    PLACA VARCHAR2(30) NOT NULL,
    CONDUCTOR NUMBER(9,0),
    A_O NUMBER(4,0) NOT NULL,
    TIPO CHAR NOT NULL,
    ESTADO CHAR NOT NULL,
    PUERTAS NUMBER(3,0),
    PASAJEROS NUMBER(3,0),
    CARGA NUMBER(3,0)
);

CREATE TABLE CONDUCTORES(
    id NUMBER(9,0) NOT NULL,
    licencia VARCHAR2(10) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    estrellas NUMBER(1,0) NOT NULL,
    estado CHAR NOT NULL
);

CREATE TABLE PQRSRESPUESTAS(
    TICKED VARCHAR2(13) NOT NULL,
    fecha DATE NOT NULL,
    descripcion VARCHAR2(50) NOT NULL,
    nombre VARCHAR2(20)NOT NULL,
    correo VARCHAR2(50) NOT NULL,
    comentario VARCHAR2(20),
    evaluacion NUMBER(1,0)
);

/*Ciclo1: Primarias*/
ALTER TABLE TARJETAS
ADD CONSTRAINT PK_Tarjetas PRIMARY KEY (numero);

ALTER TABLE TARJETAS_POR_CLIENTE
ADD CONSTRAINT PK_TarjetasPorCLiente PRIMARY KEY (TARJETA,CLIENTE);

ALTER TABLE CLIENTES
ADD CONSTRAINT PK_Cliente PRIMARY KEY (ID);

ALTER TABLE SOLICITUDES
ADD CONSTRAINT PK_Solicitud PRIMARY KEY (CODIGO);

ALTER TABLE REQUERIMIENTOS
ADD CONSTRAINT PK_Requerimiento PRIMARY KEY (REQUERIMIENTO, SOLICITUD);

ALTER TABLE POSICIONES
ADD CONSTRAINT PK_Posicion PRIMARY KEY(ID);

ALTER TABLE PQRSS
ADD CONSTRAINT PK_PQRS PRIMARY KEY (TICKED);

ALTER TABLE ANEXOS
ADD CONSTRAINT PK_Anexo PRIMARY KEY (ID);

ALTER TABLE VEHICULOS
ADD CONSTRAINT PK_Vehiculos PRIMARY KEY (PLACA);

ALTER TABLE PERSONAS
ADD CONSTRAINT PK_Persona PRIMARY KEY (ID);

ALTER TABLE CONDUCTORES
ADD CONSTRAINT PK_Conductor PRIMARY KEY (id);

ALTER TABLE PQRSRESPUESTAS
ADD CONSTRAINT PK_Respuestas PRIMARY KEY (ticked);
/*CICLO 1: UNICAS*/

ALTER TABLE PERSONAS 
ADD CONSTRAINT UC_Persona UNIQUE (TIPO,NUMERO);

ALTER TABLE ANEXOS
ADD CONSTRAINT UC_Anexo UNIQUE (URL);

/*CICLO 1: FOR�NEAS*/

ALTER TABLE TARJETAS_POR_CLIENTE
ADD CONSTRAINT FK_TarjetasPorCliente_IDCliente
FOREIGN KEY (CLIENTE) REFERENCES CLIENTES(ID);

ALTER TABLE TARJETAS_POR_CLIENTE
ADD CONSTRAINT FK_TarjetasPorCliente_NumeroTarjeta
FOREIGN KEY (TARJETA) REFERENCES TARJETAS(numero);

ALTER TABLE CLIENTES
ADD CONSTRAINT FK_Clientes_IDPersona
FOREIGN KEY (ID) REFERENCES PERSONAS(ID);

ALTER TABLE SOLICITUDES
ADD CONSTRAINT FK_Solicitudes_IDCliente
FOREIGN KEY (CLIENTE) REFERENCES CLIENTES(ID);

ALTER TABLE SOLICITUDES
ADD CONSTRAINT FK_Solicitudes_IDInicio
FOREIGN KEY (UBICACION_INICIAL) REFERENCES POSICIONES(ID);

ALTER TABLE SOLICITUDES
ADD CONSTRAINT FK_Solicitudes_IDFinal
FOREIGN KEY (UBICACION_FINAL) REFERENCES POSICIONES(ID);

ALTER TABLE REQUERIMIENTOS
ADD CONSTRAINT FK_Requerimientos_Solicitud
FOREIGN KEY (SOLICITUD) REFERENCES SOLICITUDES(CODIGO);

ALTER TABLE PQRSS
ADD CONSTRAINT FK_PQRSS_Solicitud
FOREIGN KEY (SOLICITUD) REFERENCES SOLICITUDES(CODIGO);

ALTER TABLE ANEXOS
ADD CONSTRAINT FK_Anexos_PQRSS
FOREIGN KEY (PQRS) REFERENCES PQRSS(TICKED);

ALTER TABLE VEHICULOS
ADD CONSTRAINT FK_Vehiculos_Conductor
FOREIGN KEY (conductor) REFERENCES CONDUCTORES (id);

ALTER TABLE PQRSRESPUESTAS
ADD CONSTRAINT FK_Respuestas_PQRS
FOREIGN KEY (ticked) REFERENCES PQRSS(ticked);

ALTER TABLE CONDUCTORES
ADD CONSTRAINT FK_Conductores_IDPersona
FOREIGN KEY (id) REFERENCES PERSONAS(id);

/*Ciclo 1: Atributos*/

ALTER TABLE PERSONAS
ADD CONSTRAINT CHK_Personas_tipo CHECK (tipo = 'TI' OR tipo = 'CC' OR tipo = 'CE' OR tipo = 'PS');

ALTER TABLE CONDUCTORES
ADD CONSTRAINT CHK_Conductores_Estrellas CHECK (1 <= estrellas AND estrellas <= 5);

ALTER TABLE CONDUCTORES
ADD CONSTRAINT CHK_Conductores_Estado CHECK (estado = 'A' OR estado = 'I' OR estado = 'R' OR estado = 'O');

ALTER TABLE VEHICULOS
ADD CONSTRAINT CHK_Vehiculos_tipo CHECK (tipo = 'C' OR tipo = 'M');

ALTER TABLE VEHICULOS
ADD CONSTRAINT CHK_Vehiculos_estado CHECK (estado = 'A' OR estado = 'I' OR estado = 'O');

ALTER TABLE VEHICULOS
ADD CONSTRAINT CHK_Vehiculos_puertas CHECK (puertas > 0);

ALTER TABLE VEHICULOS
ADD CONSTRAINT CHK_Vehiculos_pasajeros CHECK (pasajeros > 0);

ALTER TABLE VEHICULOS
ADD CONSTRAINT CHK_Vehiculos_carga CHECK (carga > 0);

ALTER TABLE SOLICITUDES
ADD CONSTRAINT CHK_Solicitudes_Precio CHECK (MOD(precio, 100) = 0);

ALTER TABLE SOLICITUDES
ADD CONSTRAINT CHK_Solicitudes_Estado CHECK (estado = 'P' OR estado = 'A' OR estado = 'C' OR estado = 'F');

ALTER TABLE SOLICITUDES
ADD CONSTRAINT CHK_Solicitudes_Plataforma CHECK (plataforma = 'A' OR plataforma = 'W');

ALTER TABLE REQUERIMIENTOS
ADD CONSTRAINT CHK_Requerimientos_Requerimiento CHECK (requerimiento = 'MUSICA' OR requerimiento = 'RUTA' OR requerimiento = 'IDIOMA');

ALTER TABLE PQRSS
ADD CONSTRAINT CHK_PQRSS_Ticked CHECK (REGEXP_LIKE(TICKED,'^([A-Z])([0-9]{12})$'));

ALTER TABLE PQRSS
ADD CONSTRAINT CHK_PQRSS_Tipo CHECK (tipo = 'P' OR tipo = 'Q' OR tipo = 'R' OR tipo = 'S');

ALTER TABLE PQRSS
ADD CONSTRAINT CHK_PQRSS_Estado CHECK (estado = 'ABIERTO' OR estado = 'ATENDIDA' OR estado = 'RECHAZADA' OR estado = 'CANCELADA');

ALTER TABLE ANEXOS
ADD CONSTRAINT CHK_Anexos_Url CHECK (URL LIKE('https://%'));

ALTER TABLE PQRSRESPUESTAS
ADD CONSTRAINT CHK_Respuestas_Correo CHECK (LENGTH(CORREO) - LENGTH(REPLACE(CORREO,'.','')) = 2 AND (REGEXP_LIKE(CORREO,'^[^\s@]+@[^\s@]$') OR (REGEXP_LIKE(CORREO,'^[^\s@]+@[^\s@]+\.[^\s@.]$'))));

ALTER TABLE PQRSRESPUESTAS
ADD CONSTRAINT CHK_Respuestas_Evalucacion CHECK (1 <= evaluacion AND evaluacion <= 5);

/*CRUD: SOLICITUDES*/
/*Funcion que me retorna el codigo de la fila especificada de la tabla SOLICITUDES*/
CREATE OR REPLACE FUNCTION Codigo_Solicitudes(fila NUMBER) RETURN NUMBER IS
codigoSolicitado NUMBER(9,0);
codigoSolicitud  NUMBER(9,0);
BEGIN
    DBMS_OUTPUT.PUT_LINE(fila);
    SELECT codigo INTO codigoSolicitado FROM SOLICITUDES WHERE rownum = fila;
     DBMS_OUTPUT.PUT_LINE(codigoSolicitado);
    codigoSolicitud := codigoSolicitado;
    RETURN codigoSolicitud;
END Codigo_Solicitudes;

/*Tuplas*/
ALTER TABLE SOLICITUDES
ADD CONSTRAINT CK_Solicitudes_Posiciones CHECK (ubicacion_Inicial <> ubicacion_Final);

/*Disparadores*/
CREATE SEQUENCE Seq_CodigoSolicitudes START WITH 1 INCREMENT BY 1 MAXVALUE 99999999;
CREATE OR REPLACE TRIGGER TR_Solicitudes_CodigoFecha
BEFORE INSERT ON SOLICITUDES
FOR EACH  ROW
BEGIN
        :new.codigo := Seq_CodigoSolicitudes.NEXTVAL;
        :new.fecha_creacion := SYSDATE;
END;


CREATE OR REPLACE TRIGGER TR_Solicitudes_FechaViaje
BEFORE INSERT ON SOLICITUDES
FOR EACH  ROW 
BEGIN
    IF (:new.FECHA_VIAJE <= SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20001,'La fecha de viaje debe ser superior a la actual');
    END IF;
END;

CREATE OR REPLACE TRIGGER TR_Solicitudes_estadoInicial
BEFORE INSERT ON SOLICITUDES
FOR EACH  ROW 
BEGIN
    :new.estado := 'P';
END;

CREATE OR REPLACE TRIGGER TR_Solicitudes_SolicitudActiva
BEFORE INSERT ON Solicitudes
FOR EACH ROW
DECLARE
    solicitudes_activas NUMBER;
BEGIN
    SELECT COUNT(*) INTO solicitudes_activas
    FROM solicitudes
    WHERE cliente = :new.CLIENTE AND (estado = 'P' OR estado = 'A');
    IF solicitudes_activas > 1 THEN
        RAISE_APPLICATION_ERROR(-20001,'Un cliente no puede tener m?s de una solicitud activa');
    end if;
END;

CREATE OR REPLACE TRIGGER TR_Solicitudes_ViajePrecio
BEFORE INSERT ON Solicitudes
FOR EACH ROW
BEGIN
    :new.Fecha_Viaje := NULL;
    :new.precio := NULL;
END;

CREATE OR REPLACE TRIGGER TR_Solicitudes_NoActualizar
BEFORE UPDATE OF codigo, fecha_creacion,plataforma,cliente,ubicacion_inicial,ubicacion_final
ON SOLICITUDES
BEGIN
    RAISE_APPLICATION_ERROR(-20001,'Unicamente se pueden cambiar los valores de Precio; fecha de viaje y estado');
END;

CREATE OR REPLACE TRIGGER TR_Solicitudes_ActualizarConSolicitudPendiente
BEFORE UPDATE OF precio, FECHA_VIAJE
ON SOLICITUDES
FOR EACH ROW
BEGIN
    IF(:old.estado <> 'P' OR :new.estado <> 'P') THEN
        RAISE_APPLICATION_ERROR(-20001,'El precio o fecha de viaje solo se pueden cambiar si el estado de la solicitud es pendiente');
    END IF;
END;

CREATE OR REPLACE TRIGGER TR_Solicitudes_FechaViajeSuperior
BEFORE UPDATE OF Fecha_Viaje ON SOLICITUDES
FOR EACH ROW
BEGIN
    IF (:new.Fecha_viaje <= SYSDATE OR :new.Fecha_viaje <= :old.Fecha_creacion) THEN 
        RAISE_APPLICATION_ERROR(-20001,'La fecha de viaje debe ser superior a la fecha actual y a la de creaci?n');
    END IF;
END;

CREATE OR REPLACE TRIGGER TR_cambiarEstado
BEFORE UPDATE OF estado ON SOLICITUDES
FOR EACH ROW
BEGIN
    IF (:new.estado = 'C') THEN
        RAISE_APPLICATION_ERROR(-20001,'El estado de la solicitud no se puede cambiar a cancelado');
    END IF;
END;


/*XDisparadores*/
DROP TRIGGER TR_Solicitudes_CodigoFecha;
DROP TRIGGER TR_Solicitudes_FechaViaje;
DROP TRIGGER TR_Solicitudes_estadoInicial;
DROP TRIGGER TR_Solicitudes_SolicitudActiva;
DROP TRIGGER TR_Solicitudes_ViajePrecio;
DROP TRIGGER TR_Solicitudes_NoActualizar;
DROP TRIGGER TR_Solicitudes_ActualizarConSolicitudPendiente;
DROP TRIGGER TR_Solicitudes_FechaViajeSuperior;

/*Ciclo1: CRUD: PQRS*/
/*Tuplas*/

/*Disparadores*/
CREATE OR REPLACE TRIGGER TR_PQRSS_Ticked
BEFORE INSERT ON PQRSS
FOR EACH ROW
BEGIN
    :new.ticked := :new.tipo || TO_CHAR (SYSDATE,'YYYYMMDDHH24MI');
END;

CREATE OR REPLACE TRIGGER TR_PQRSS_Tipo
BEFORE INSERT ON PQRSS
FOR EACH ROW 
BEGIN
    IF (:new.tipo IS NULL) THEN
        :new.tipo := 'S';
    END IF;
END;

CREATE OR REPLACE TRIGGER TR_PQRSS_FechaRadicacion
BEFORE INSERT ON PQRSS
FOR EACH ROW 
BEGIN
    :new.radicacion := SYSDATE;
END;

CREATE OR REPLACE TRIGGER TR_PQRSS_estadoInicial
BEFORE INSERT ON PQRSS
FOR EACH ROW 
BEGIN
    :new.estado := 'ABIERTO';
END;

CREATE OR REPLACE TRIGGER TR_PQRSS_Modificar
BEFORE UPDATE OF ticked, radicacion, cierre, descripcion, tipo,solicitud ON PQRSS 
BEGIN
    RAISE_APPLICATION_ERROR(-20001,'Del PQRS solo se puede modificar su estado');
END;

CREATE OR REPLACE TRIGGER TR_PQRSS_CerrarRechazar
BEFORE UPDATE OF estado ON PQRSS
FOR EACH ROW
BEGIN
    IF (:new.estado = 'RECHAZADA' OR    :new.estado = 'CANCELADA') THEN 
        :new.cierre := TRUNC(SYSDATE);
    END IF;
END;

/*XDisparadores*/


/*LAB05*/

SELECT * FROM mbda.data;
INSERT INTO mbda.data(EMAIL,CEDULA,CELULAR,NOMBRES) VALUES('camilo.castano-q@mail.escuelaing.edu.co','1000271422','3183074075','Camilo Casta�o');

DELETE FROM mbda.data WHERE nombres = 'Camilo Casta�o';

UPDATE mbda.data
SET nombres = 'CC'
WHERE nombres= 'Camilo Casta�o';

SELECT COUNT(*) FROM mbda.data;


INSERT INTO PERSONAS select * from(
WITH conteo AS (SELECT cedula AS C,COUNT(CEDULA) as unic from mbda.data GROUP BY cedula HAVING COUNT(CEDULA) = 1)
SELECT SUBSTR(cedula,1,6) || TRUNC(DBMS_RANDOM.VALUE(100,999)) AS ID, 'CC' AS TIPO, SUBSTR(CEDULA,1,10) AS NUMERO, NOMBRES AS NOMBRE, trunc(SYSDATE) AS REGISTRO, CELULAR, EMAIL AS CORREO
FROM MBDA.DATA
where(MBDA.DATA.CEDULA IN (SELECT C FROM CONTEO)) and NOT (EMAIL IS NULL OR CEDULA IS NULL OR CELULAR IS NULL OR MBDA.DATA.NOMBRES IS NULL ));





