--- CONSULTAS
	---Conocer cuentas activas
	SELECT * FROM Cuenta WHERE Estatus = 'Activa';
	
	---Conocer el estatus de cada cuenta con su saldo
	SELECT ID_Cuenta, Saldo, Estatus FROM Cuenta;


	---Conocer Egresos
	CREATE PROCEDURE ConocerEgreso 
			@FechaInicio DATE, 
			@FechaFin DATE
		AS
		  SELECT (SELECT sum(Monto) FROM Transaccion WHERE Monto<0 AND Fecha BETWEEN @FechaInicio AND @FechaFin) + (SELECT sum(Interes) FROM DetalleInversion WHERE Fecha BETWEEN @FechaInicio AND @FechaFin) as Egreso;

	EXEC ConocerEgreso '2022-01-01', '2022-12-01'

	---Conocer Ingresos
	CREATE PROCEDURE ConocerIngreso
			@FechaInicio DATE, 
			@FechaFin DATE
		AS
		  SELECT (SELECT sum(Monto) FROM Transaccion WHERE Monto>0 AND Fecha BETWEEN @FechaInicio AND @FechaFin) + (SELECT sum(Interes) FROM DetallePrestamo WHERE Fecha BETWEEN @FechaInicio AND @FechaFin) as Ingreso;

	EXEC ConocerIngreso '2022-01-01', '2022-12-01'

	---Consultar el saldo y el estado de una cuenta
	CREATE PROCEDURE ConsultarSaldoEstatusCuenta 
		@ID_Cuenta INT
	AS
	  SELECT Saldo, Estatus FROM Cuenta WHERE ID_Cuenta = @ID_Cuenta;

	EXEC ConsultarSaldoEstatusCuenta  7

	---Consultar todas las transacciones de una cuenta en un rango de fechas
	CREATE PROCEDURE ConsultarTransaccionesRangoFechas 
		@ID_Cuenta INT, 
		@FechaInicio DATE, 
		@FechaFin DATE
	AS
	  SELECT * FROM Transaccion WHERE ID_Cuenta = @ID_Cuenta AND Fecha BETWEEN @FechaInicio AND @FechaFin;

	EXEC ConsultarTransaccionesRangoFechas   7, '2022-01-01', '2023-01-01'

	---Consultar el saldo actual y los detalles de todas las inversiones de un cliente
	CREATE PROCEDURE ConsultarInversionesCliente 
		@ID_Cliente INT
	AS
	  SELECT I.*, C.Saldo FROM Inversion I JOIN Cuenta C ON I.ID_Cuenta = C.ID_Cuenta WHERE C.ID_Cliente = @ID_Cliente;

	EXEC ConsultarInversionesCliente  14

	---Consultar el saldo insoluto y los detalles de todos los préstamos de un cliente
	CREATE PROCEDURE ConsultarPrestamosCliente
		@ID_Cliente INT
	AS
	BEGIN
		SELECT Prestamo.*, Cuenta.Saldo FROM Prestamo
		JOIN Cuenta ON Prestamo.ID_Cuenta = Cuenta.ID_Cuenta
		WHERE Cuenta.ID_Cliente = @ID_Cliente;
	END;

	EXEC ConsultarPrestamosCliente  8

