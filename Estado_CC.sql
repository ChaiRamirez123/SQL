--- Crear Tabla Datos de Cuenta
CREATE TABLE ECCorriente_data (
	Fecha_reporte DATE,
	Nombre VARCHAR(15),
    ID_Cuenta  INT NOT NULL FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta(ID_Cuenta),
	Tipo VARCHAR(15),
    Fecha_Inicio DATE,
	Fecha_fin DATE,
	Saldo_inicial FLOAT,
	Saldo_fin FLOAT
);
--- Crear Tabla desglose de movimientos
CREATE TABLE ECCorriente_mov (
	Movimiento DATE,
	Deposito FLOAT,
	Retiro FLOAT
);
--- SP
ALTER PROCEDURE EstadoCuenta_Corriente
    @ID_Cuenta INT,
	@Fecha_inicio DATE,
	@Fecha_fin DATE
AS
BEGIN
	DECLARE @Tipo VARCHAR(15) = 'Cuenta Corriente'
	DECLARE @Saldo_inicial FLOAT
	DECLARE @Saldo_fin FLOAT = 0
	DECLARE @Movimientos DATE
	DECLARE @Monto FLOAT
	DECLARE @Saldo_act FLOAT
	DECLARE @Fecha_reporte DATE = GETDATE()
	DECLARE @Nombre VARCHAR(30)
	DECLARE @Paterno VARCHAR(30)
	DECLARE @Deposito FLOAT
	DECLARE @Retiro FLOAT
	DECLARE @Fecha_mov DATE

	-- obtener información
	SELECT @Saldo_act = Saldo, @Nombre = Nombre, @Paterno = Paterno
	FROM Cuenta INNER JOIN Cliente ON Cuenta.ID_Cliente = Cliente.ID_Cliente
	WHERE Cuenta.ID_Cuenta = @ID_Cuenta;

	-- Calcular saldo inicial
	SELECT @Movimientos = MIN(Fecha), @Monto = SUM(Monto)
	FROM Transaccion WHERE ID_Cuenta = @ID_Cuenta AND Fecha <= @Fecha_inicio
	GROUP BY ID_Cuenta

	SET @Saldo_inicial = @Saldo_act - COALESCE(@Monto, 0)

	-- Calcular saldo final
	SELECT @Monto = SUM(Monto)
	FROM Transaccion WHERE ID_Cuenta = @ID_Cuenta AND Fecha >= @Fecha_inicio AND Fecha <= @Fecha_fin

	SET @Saldo_fin = @Saldo_inicial + COALESCE(@Monto, 0)

	-- Insertar datos en tabla
	SET @Nombre = @Nombre + ' ' + @Paterno
	INSERT INTO ECCorriente_data(Fecha_reporte,Nombre,ID_Cuenta,Tipo,Fecha_inicio, Fecha_fin, Saldo_inicial, Saldo_fin)
	VALUES (@Fecha_reporte, @Nombre, @ID_Cuenta, @Tipo, @Fecha_inicio, @Fecha_fin, @Saldo_inicial, @Saldo_fin)

	-- Obtener tabla ECCorriente_mov
	SELECT @Fecha_mov = MIN(Fecha) FROM Transaccion WHERE ID_Cuenta = @ID_Cuenta AND Fecha >= @Fecha_inicio AND Fecha <= @Fecha_fin

	INSERT INTO ECCorriente_mov(Movimiento, Deposito, Retiro)
	SELECT Fecha, SUM(CASE WHEN Monto > 0 THEN Monto ELSE NULL END) AS Deposito, SUM(CASE WHEN Monto < 0 THEN Monto ELSE NULL END) AS Retiro
	FROM Transaccion WHERE ID_Cuenta = @ID_Cuenta AND Fecha >= @Fecha_inicio AND Fecha <= @Fecha_fin
	GROUP BY Fecha
	ORDER BY Fecha ASC;
END

DELETE FROM ECCorriente_data
DELETE FROM ECCorriente_mov

exec EstadoCuenta_Corriente 6, '2022-10-01', '2023-10-01'
select * from ECCorriente_data
select * from ECCorriente_mov

