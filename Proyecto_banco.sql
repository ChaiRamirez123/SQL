--Crear base de datos--
CREATE DATABASE banco_project;
--Creacion de Tablas--
-- Crear tabla Cliente
CREATE TABLE Cliente (
    ID_Cliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Paterno VARCHAR(255) NOT NULL,
    Materno VARCHAR(255) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Calle VARCHAR(255) NOT NULL,
    Num_calle INT NOT NULL,
    Colonia VARCHAR(255) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL
);

	---Llenar tabla Cliente
INSERT INTO Cliente VALUES ('Juan', 'P�rez', 'Garc�a', '1990-05-20', 'Calle 1', 123, 'Colonia 1', '555-1234', 'juan.perez@gmail.com');
INSERT INTO Cliente VALUES ('Mar�a', 'Gonz�lez', 'L�pez', '1985-02-10', 'Calle 2', 456, 'Colonia 2', '555-5678', 'maria.gonzalez@gmail.com');
INSERT INTO Cliente VALUES ('Jos�', 'Rodr�guez', 'Hern�ndez', '1992-11-30', 'Calle 3', 789, 'Colonia 3', '555-9012', 'jose.rodriguez@gmail.com');
INSERT INTO Cliente VALUES ('Ana', 'Mart�nez', 'S�nchez', '1980-09-15', 'Calle 4', 101, 'Colonia 4', '555-3456', 'ana.martinez@gmail.com');
INSERT INTO Cliente VALUES ('Pedro', 'L�pez', 'D�az', '1995-07-02', 'Calle 5', 111, 'Colonia 5', '555-7890', 'pedro.lopez@gmail.com');
INSERT INTO Cliente VALUES ('Laura', 'Hern�ndez', 'Guti�rrez', '1998-04-18', 'Calle 6', 222, 'Colonia 6', '555-2345', 'laura.hernandez@gmail.com');
INSERT INTO Cliente VALUES ('Mario', 'Castillo', 'Ram�rez', '1987-12-25', 'Calle 7', 333, 'Colonia 7', '555-6789', 'mario.castillo@gmail.com');
INSERT INTO Cliente VALUES ('Silvia', 'Garc�a', 'Jim�nez', '1993-10-12', 'Calle 8', 444, 'Colonia 8', '555-0123', 'silvia.garcia@gmail.com');
INSERT INTO Cliente VALUES ('Fernando', 'P�rez', 'Hern�ndez', '1983-08-08', 'Calle 9', 555, 'Colonia 9', '555-4567', 'fernando.perez@gmail.com');
INSERT INTO Cliente VALUES ('Sof�a', 'S�nchez', 'Gonz�lez', '1991-06-25', 'Calle 10', 666, 'Colonia 10', '555-8901', 'sofia.sanchez@gmail.com');
INSERT INTO Cliente VALUES ('Carlos', 'Guti�rrez', 'Mart�nez', '1988-04-12', 'Calle 11', 777, 'Colonia 11', '555-2345', 'carlos.gutierrez@gmail.com');
INSERT INTO Cliente VALUES ('Ana', 'L�pez', 'Hern�ndez', '1996-02-28', 'Calle 12', 888, 'Colonia 12', '555-6789', 'ana.lopez@gmail.com');
INSERT INTO Cliente VALUES ('Jorge', 'Mart�nez', 'Garc�a', '1981-12-05', 'Calle 13', 999, 'Colonia 13', '555-0123', 'jorge.martinez@gmail.com');
INSERT INTO Cliente VALUES ('Mar�a', 'Hern�ndez', 'G�mez', '1999-10-22', 'Calle 14', 1010, 'Colonia 14', '555-4567', 'maria.hernandez@gmail.com');
INSERT INTO Cliente VALUES ('Luis', 'D�az', 'P�rez', '1987-08-09', 'Calle 15', 1111, 'Colonia 15', '555-8901', 'luis.diaz@gmail.com');

-- Crear tabla Cuenta
CREATE TABLE Cuenta (
    ID_Cuenta INT IDENTITY (1,1) PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    Tipo_Cuenta VARCHAR(255) NOT NULL,
    Fecha_Apertura DATE NOT NULL,
    Fecha_Cierre DATE,
    Saldo DECIMAL(15, 2) NOT NULL,
    Estatus VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);
	---Llenar cuentas
INSERT INTO Cuenta VALUES (1, 'Ahorro', '2022-03-15', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (2, 'Corriente', '2022-04-20', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (3, 'Ahorro', '2022-02-10', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (4, 'Corriente', '2022-06-01', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (5, 'Ahorro', '2022-08-20', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (6, 'Corriente', '2022-11-05', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (7, 'Ahorro', '2022-01-08', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (8, 'Corriente', '2022-07-12', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (9, 'Ahorro', '2022-04-17', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (10, 'Corriente', '2022-09-22', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (11, 'Ahorro', '2022-05-18', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (12, 'Corriente', '2022-08-02', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (13, 'Ahorro', '2022-11-30', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (14, 'Corriente', '2022-10-10', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (15, 'Ahorro', '2022-07-01', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (1, 'Corriente', '2022-02-05', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (2, 'Ahorro', '2022-09-25', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (3, 'Corriente', '2022-06-15', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (4, 'Ahorro', '2022-03-20', NULL, 1000, 'Activa');
INSERT INTO Cuenta VALUES (5, 'Corriente', '2022-01-30', NULL, 1000, 'Activa');

-- Crear tabla Transaccion
CREATE TABLE Transaccion (
    ID_Transaccion INT IDENTITY(1,1) PRIMARY KEY,
    ID_Cuenta INT NOT NULL,
    Fecha DATE NOT NULL,
    Monto DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta(ID_Cuenta)
);

	---SP para llenar transaccion & modificar cuenta
CREATE PROCEDURE InsertTransaction_UpdateCuenta
    @ID_Cuenta INT,
    @Monto DECIMAL(18, 2),
	@Fecha DATE
AS
BEGIN
    -- Insertar una nueva transacci�n
    INSERT INTO Transaccion (ID_Cuenta, Fecha, Monto)
    VALUES (@ID_Cuenta, @Fecha, @Monto);

    -- Actualizar la columna Saldo en la tabla Cuenta
    UPDATE Cuenta
    SET Saldo = Saldo + @Monto
    WHERE ID_Cuenta = @ID_Cuenta;
END;
 
	---Llenado en Query "transaccionesejem'

-- Crear tabla Prestamo
CREATE TABLE Prestamo (
    ID_Prestamo INT IDENTITY(1,1) PRIMARY KEY,
    ID_Cuenta INT NOT NULL,
    Monto_Inicial FLOAT NOT NULL,
    Plazo INT NOT NULL,
    Interes_Mensual FLOAT NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta(ID_Cuenta)
);

	---Llenar Prestamo
			-- Valores para los rangos de cantidad prestada e inter�s
DECLARE @Rango1 FLOAT = 0.005;
DECLARE @Rango2 FLOAT = 0.01;
DECLARE @Rango3 FLOAT = 0.02;
DECLARE @Rango4 FLOAT = 0.04;
DECLARE @Rango5 FLOAT = 0.06;
INSERT INTO Prestamo (ID_Cuenta, Monto_Inicial, Plazo, Interes_Mensual, Fecha_Inicio, Fecha_Fin)
VALUES 
    (1, 10000, 12, @Rango2, '2022-01-01', DATEADD(MONTH, 12, '2022-01-01')),
    (2, 15000, 12, @Rango3, '2022-01-15', DATEADD(MONTH, 12, '2022-01-15')),
    (3, 20000, 12, @Rango3, '2022-02-01', DATEADD(MONTH, 12, '2022-02-01')),
    (4, 25000, 12, @Rango4, '2022-02-15', DATEADD(MONTH, 12, '2022-02-15')),
    (5, 30000, 12, @Rango4, '2022-03-01', DATEADD(MONTH, 12, '2022-03-01')),
    (6, 35000, 12, @Rango5, '2022-03-15', DATEADD(MONTH, 12, '2022-03-15')),
    (7, 40000, 12, @Rango5, '2022-04-01', DATEADD(MONTH, 12, '2022-04-01')),
    (8, 45000, 12, @Rango5, '2022-05-01', DATEADD(MONTH, 12, '2022-05-01')),
    (9, 50000, 12, @Rango5, '2022-05-15', DATEADD(MONTH, 12, '2022-05-15')),
    (10, 5000, 12, @Rango1, '2022-06-01', DATEADD(MONTH, 12, '2022-06-01'));

---Crear DetallePrestamo
CREATE TABLE DetallePrestamo (
    ID_DetallePrestamo INT IDENTITY(1,1) PRIMARY KEY,
    ID_Prestamo INT NOT NULL FOREIGN KEY REFERENCES Prestamo(ID_Prestamo),
    Mensualidad INT NOT NULL,
    Fecha DATE NOT NULL,
    Renta_Mensual FLOAT NOT NULL,
    Monto_Financiar FLOAT NOT NULL,
    Interes FLOAT NOT NULL,
    Diferencia FLOAT NOT NULL,
    Capital FLOAT NOT NULL
);

	---Llenado de DetallePrestamo con SP en Query 'detalleprestamo'

-- Crear tabla Inversion
CREATE TABLE Inversion (
    ID_Inversion INT IDENTITY(1,1) PRIMARY KEY,
	ID_Cuenta INT NOT NULL FOREIGN KEY REFERENCES Cuenta(ID_Cuenta),
	Monto_Inicial FLOAT NOT NULL,
	Tasa_Interes_Anual FLOAT NOT NULL,
	Plazo INT NOT NULL,
	Fecha_Inicio DATE NOT NULL,
	Fecha_fin DATE
);
	---Llenar Inversion
INSERT INTO Inversion (ID_Cuenta, Monto_Inicial, Tasa_Interes_Anual, Plazo, Fecha_Inicio, Fecha_fin)
VALUES 
    (11, 5000, 0.005, 12, '2022-01-01', DATEADD(month, 12, '2022-01-01')),
    (12, 10000, 0.005, 12, '2022-01-15', DATEADD(month, 12, '2022-01-15')),
    (13, 15000, 0.01, 12, '2022-02-01', DATEADD(month, 12, '2022-02-01')),
    (14, 20000, 0.01, 12, '2022-02-15', DATEADD(month, 12, '2022-02-15')),
    (15, 25000, 0.02, 12, '2022-03-01', DATEADD(month, 12, '2022-03-01')),
    (16, 30000, 0.02, 12, '2022-03-15', DATEADD(month, 12, '2022-03-15')),
    (17, 35000, 0.04, 12, '2022-04-01', DATEADD(month, 12, '2022-04-01')),
    (18, 40000, 0.04, 12, '2022-04-15', DATEADD(month, 12, '2022-04-15')),
    (19, 45000, 0.06, 12, '2022-05-01', DATEADD(month, 12, '2022-05-01')),
    (20, 50000, 0.06, 12, '2022-05-15', DATEADD(month, 12, '2022-05-15'));

-- Crear tabla DetalleInversion
CREATE TABLE DetalleInversion (
    ID_DetalleInversion INT IDENTITY(1,1) PRIMARY KEY,
    ID_Inversion INT NOT NULL FOREIGN KEY (ID_Inversion) REFERENCES Inversion(ID_Inversion),
    Mes INT,
    Monto FLOAT NOT NULL,
    Fecha DATE NOT NULL,
    Dias INT,
    Interes FLOAT
);

	---Llenado de DetalleInversion con SP en Query 'inversiones'

Select * from Cliente
Select * from Cuenta
Select * from Transaccion
Select * from Prestamo
Select * from Inversion
Select * from DetallePrestamo
Select * from DetalleInversion

