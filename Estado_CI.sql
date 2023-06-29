--- Crear Tabla Datos de Inversión
CREATE TABLE ECInversion_data (
	Fecha_reporte DATE,
	Nombre VARCHAR(15),
    ID_Cuenta  INT NOT NULL FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta(ID_Cuenta),
	Tipo VARCHAR(15),
    Fecha_Inicio DATE,
	Fecha_fin DATE,
	Saldo_inicial FLOAT,
	Saldo_fin FLOAT,
	Tasa_Interes_Anual FLOAT
);

--- Crear Tabla de desglose de pago de intereses
CREATE TABLE ECInversion_mov (
	Movimiento DATE,
	Pago FLOAT,
);
--- SP
ALTER PROCEDURE EstadoCuenta_Inversion
    @ID_Cuenta INT,
	@Fecha_inicio DATE,
	@Fecha_fin DATE
AS
BEGIN
	DECLARE @Tipo VARCHAR(15) = 'Inversion'
	DECLARE @Saldo_inicial FLOAT
	DECLARE @Saldo_fin FLOAT
	DECLARE @Fecha_reporte DATE = GETDATE()
	DECLARE @Nombre VARCHAR(30)
	DECLARE @Paterno VARCHAR(30)
	DECLARE @Tasa_Interes_Anual FLOAT
	DECLARE @Pago FLOAT
	DECLARE @ID_Inversion INT

	-- Obtener informacion
	SELECT @Nombre = Nombre, @Paterno = Paterno
	FROM Cuenta INNER JOIN Cliente ON Cuenta.ID_Cliente = Cliente.ID_Cliente
	WHERE Cuenta.ID_Cuenta = @ID_Cuenta;

	SELECT @Tasa_Interes_Anual = Tasa_Interes_Anual, @ID_Inversion = ID_Inversion
	FROM Inversion WHERE ID_Cuenta = @ID_Cuenta

	SELECT top 1 @Saldo_inicial = Monto, @Pago = Interes
	FROM DetalleInversion WHERE ID_Inversion = @ID_Inversion AND Fecha >= @Fecha_inicio AND Fecha <= @Fecha_fin

	SELECT top 1 @Saldo_fin = Monto
	FROM DetalleInversion WHERE ID_Inversion = @ID_Inversion AND Fecha >= @Fecha_inicio AND Fecha <= @Fecha_fin 
	ORDER BY Mes DESC

	SET @Nombre = @Nombre + ' ' + @Paterno
	SET @Fecha_reporte = GETDATE()

	INSERT INTO ECInversion_data(Fecha_reporte,Nombre,ID_Cuenta,Tipo,Fecha_inicio, Fecha_fin, Saldo_inicial, Saldo_fin,Tasa_Interes_Anual)
	VALUES (@Fecha_reporte, @Nombre, @ID_Cuenta, @Tipo, @Fecha_inicio, @Fecha_fin, @Saldo_inicial, @Saldo_fin,@Tasa_Interes_Anual)

	INSERT INTO ECInversion_mov (Movimiento, Pago)
	SELECT Fecha as Movimiento, Interes as Pago 
	FROM DetalleInversion
	WHERE Fecha >= @Fecha_inicio AND Fecha <= @Fecha_fin
END

DELETE FROM ECInversion_data
DELETE FROM ECInversion_mov

exec EstadoCuenta_Inversion 13, '2022-10-01', '2023-01-01'
select * from ECInversion_data
select * from ECInversion_mov


SELECT * FROM Inversion
select * from DetalleInversion