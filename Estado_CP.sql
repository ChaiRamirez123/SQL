--- Crear Tabla Datos de Prestamo
CREATE TABLE ECPrestamo_data (
	Fecha_reporte DATE,
	Nombre VARCHAR(15),
    ID_Cuenta  INT NOT NULL FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta(ID_Cuenta),
	Tipo VARCHAR(15),
    Fecha_Inicio DATE,
	Fecha_fin DATE,
	Saldo_inicial FLOAT,
	Saldo_fin FLOAT,
	Interes_Mensual FLOAT
);
--- Crear Tabla desglose de pagos
CREATE TABLE ECPrestamo_mov (
	Movimiento DATE,
	Pago FLOAT,
);

ALTER PROCEDURE EstadoCuenta_Prestamo
    @ID_Cuenta INT,
	@Fecha_inicio DATE,
	@Fecha_fin DATE
AS
BEGIN
	DECLARE @Tipo VARCHAR(15) = 'Prestamo'
	DECLARE @Monto_inicial FLOAT
	DECLARE @Saldo_fin FLOAT
	DECLARE @Saldo_act FLOAT
	DECLARE @Fecha_reporte DATE = GETDATE()
	DECLARE @Nombre VARCHAR(30)
	DECLARE @Paterno VARCHAR(30)
	DECLARE @Interes_Mensual FLOAT
	DECLARE @Pago FLOAT
	DECLARE @ID_Prestamo INT

	-- Obtener informacion
	SELECT @Nombre = Nombre, @Paterno = Paterno
	FROM Cuenta INNER JOIN Cliente ON Cuenta.ID_Cliente = Cliente.ID_Cliente
	WHERE Cuenta.ID_Cuenta = @ID_Cuenta;

	SELECT @Interes_Mensual = Interes_Mensual, @ID_Prestamo = ID_Prestamo
	FROM Prestamo WHERE ID_Cuenta = @ID_Cuenta

	SELECT top 1 @Monto_inicial = Monto_Financiar, @Pago = Renta_Mensual
	FROM DetallePrestamo WHERE ID_Prestamo = @ID_Prestamo AND Fecha >= @Fecha_inicio AND Fecha <= @Fecha_fin

	SELECT top 1 @Saldo_fin = Capital
	FROM DetallePrestamo WHERE ID_Prestamo = @ID_Prestamo AND Fecha >= @Fecha_inicio AND Fecha <= @Fecha_fin 
	ORDER BY Mensualidad DESC

	SET @Nombre = @Nombre + ' ' + @Paterno
	SET @Fecha_reporte = GETDATE()

	INSERT INTO ECPrestamo_data(Fecha_reporte,Nombre,ID_Cuenta,Tipo,Fecha_inicio, Fecha_fin, Saldo_inicial, Saldo_fin,Interes_Mensual)
	VALUES (@Fecha_reporte, @Nombre, @ID_Cuenta, @Tipo, @Fecha_inicio, @Fecha_fin, @Monto_inicial, @Saldo_fin,@Interes_Mensual)

	INSERT INTO ECPrestamo_mov (Movimiento, Pago)
	SELECT Fecha as Movimiento, -Renta_Mensual as Pago 
	FROM DetallePrestamo
	WHERE Fecha >= @Fecha_inicio AND Fecha <= @Fecha_fin
END

DELETE FROM ECPrestamo_data
DELETE FROM ECPrestamo_mov

exec EstadoCuenta_Prestamo 8, '2022-10-01', '2023-03-01'
select * from ECPrestamo_data
select * from ECPrestamo_mov

