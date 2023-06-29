CREATE PROCEDURE Amortizacion_Prestamo
    @ID_Prestamo INT
AS
BEGIN
    -- Variables auxiliares
    DECLARE @Monto_Inicial FLOAT
    DECLARE @Plazo INT
    DECLARE @Interes_Mensual FLOAT
    DECLARE @Fecha_Inicio DATE
    DECLARE @Fecha_Fin DATE
    DECLARE @Mensualidad FLOAT
    DECLARE @Renta_Mensual FLOAT
    DECLARE @Monto_Finaniar FLOAT
    DECLARE @Interes FLOAT
    DECLARE @Diferencia FLOAT 
    DECLARE @Capital FLOAT
    DECLARE @Fecha DATE
    DECLARE @ID_DetallePrestamo INT = 0

    -- Obtener informaci�n del pr�stamo
    SELECT @Monto_Inicial = Monto_Inicial, @Plazo = Plazo, @Interes_Mensual = Interes_Mensual, @Fecha_Inicio = Fecha_Inicio, @Fecha_Fin = Fecha_Fin
    FROM Prestamo
    WHERE ID_Prestamo = @ID_Prestamo

    -- Calcular la mensualidad
    SET @Mensualidad = 1
    -- Inicializar variables
    SET @Monto_Financiar = @Monto_Inicial
    SET @Interes = 0
    SET @Diferencia = 0
    SET @Capital = 0

    -- Generar tabla de amortizaci�n
    WHILE @Mensualidad <= @Plazo
    BEGIN
        -- Calcular renta mensual
		SET @Renta_Mensual = (@Monto_Inicial * @Interes_Mensual)/(1-POWER((1+@Interes_Mensual), (-@Plazo)))
        
        -- Calcular fecha de la mensualidad
        IF @Mensualidad = 1
            SET @Fecha = @Fecha_Inicio
        ELSE
            SET @Fecha = DATEADD(MONTH, 1, @Fecha)

        -- Calcular intereses
        SET @Interes = ROUND(@Monto_Financiar * @Interes_Mensual, 2)

		-- Calcular diferencia
        SET @Diferencia = ROUND(@Renta_Mensual - @Interes, 2)

        -- Calcular capital amortizado
        SET @Capital = ROUND(@Monto_Financiar - @Diferencia, 2)

        -- Insertar registro en tabla DetallePrestamo
        INSERT INTO DetallePrestamo (ID_Prestamo, Mensualidad, Fecha, Renta_Mensual, Monto_Financiar, Interes, Diferencia, Capital)
        VALUES (@ID_Prestamo, @ID_DetallePrestamo + 1, @Fecha, @Renta_Mensual, @Monto_Financiar, @Interes, @Diferencia, @Capital)

        -- Actualizar monto financiado
        SET @Monto_Financiar = @Capital

		    -- Asignar ID_DetallePrestamo generado
		SET @ID_DetallePrestamo = SCOPE_IDENTITY()
		SET @Mensualidad = @Mensualidad + 1

	END
END

EXEC Amortizacion_Prestamo 1
EXEC Amortizacion_Prestamo 2
EXEC Amortizacion_Prestamo 3
EXEC Amortizacion_Prestamo 4
EXEC Amortizacion_Prestamo 5
EXEC Amortizacion_Prestamo 6
EXEC Amortizacion_Prestamo 7
EXEC Amortizacion_Prestamo 8
EXEC Amortizacion_Prestamo 9
EXEC Amortizacion_Prestamo 10

Select * from DetallePrestamo;
Select * from Prestamo