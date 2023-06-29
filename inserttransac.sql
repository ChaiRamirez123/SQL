ALTER PROCEDURE InsertAndUpdateTransaction
    @ID_Cuenta INT,
    @Monto DECIMAL(18, 2),
	@Fecha DATE
AS
BEGIN
    -- Insertar una nueva transacción
    INSERT INTO Transaccion (ID_Cuenta, Fecha, Monto)
    VALUES (@ID_Cuenta, @Fecha, @Monto);

    -- Actualizar la columna Saldo en la tabla Cuenta
    UPDATE Cuenta
    SET Saldo = Saldo + @Monto
    WHERE ID_Cuenta = @ID_Cuenta;
END;


select * from Transaccion
select * from Cuenta

