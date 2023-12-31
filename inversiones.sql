CREATE PROCEDURE LlenarDetalleInversion
    @ID_Inversion INT
AS
BEGIN
	DECLARE @Monto_Inicial FLOAT
	DECLARE @Tasa_Interes_Anual FLOAT
	DECLARE @Plazo INT
	DECLARE @Fecha_Inicio DATE
	DECLARE @Fecha_fin DATE
	DECLARE @Monto FLOAT
	DECLARE @Mes INT
	DECLARE @Fecha DATE
	DECLARE @Dias INT
	DECLARE @Interes FLOAT
	DECLARE @ID_DetalleInversion INT = 0
	
	---Obtener info
	SELECT @Monto_Inicial = Monto_Inicial, @Plazo = Plazo, @Tasa_Interes_Anual = Tasa_Interes_Anual, @Fecha_Inicio = Fecha_Inicio, @Fecha_Fin = Fecha_Fin
    FROM Inversion WHERE ID_Inversion = @ID_Inversion
    
	-- Calcular la mensualidad
    SET @Mes = 0
	SET @Monto = @Monto_Inicial
	SET @Fecha = @Fecha_Inicio
	SET @Dias = 0
	SET @Interes = 0
	-- Generar tabla de rendimientos
    WHILE @Mes <= @Plazo
    BEGIN
		INSERT INTO DetalleInversion(ID_Inversion, Mes, Monto, Fecha, Dias, Interes)
		VALUES (@ID_Inversion, @Mes,  @Monto, @Fecha, @Dias,@Interes)
		SET @ID_DetalleInversion = SCOPE_IDENTITY()
		---Calcular Dias
		SET @Dias = DATEDIFF(day, @Fecha,  DATEADD(month, 1, @Fecha))
		---Calcular Fecha
		SET @Fecha = DATEADD(month, 1, @Fecha)
		---Calcular Interes
		SET @Interes = @Monto * @Tasa_Interes_Anual/365*@Dias
		---Calcular Monto
		SET @Monto = @Monto + @Interes
		---Calcular Mes
		SET @Mes=1+@Mes
	END 
END

EXEC LlenarDetalleInversion 1
EXEC LlenarDetalleInversion 2
EXEC LlenarDetalleInversion 3
EXEC LlenarDetalleInversion 4
EXEC LlenarDetalleInversion 5
EXEC LlenarDetalleInversion 6
EXEC LlenarDetalleInversion 7
EXEC LlenarDetalleInversion 8
EXEC LlenarDetalleInversion 9
EXEC LlenarDetalleInversion 10

select * from Inversion
select * from DetalleInversion
