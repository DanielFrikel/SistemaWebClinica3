CREATE PROCEDURE spAccesoSistema 
	@prmUser varchar(50),
	@prmPass varchar(50)
AS
BEGIN	
	SET NOCOUNT ON;
    
	SELECT E.idEmpleado, E.usuario, E.clave
	FROM Empleado E
	WHERE E.usuario = @prmUser and E.Clave = @prmPass
END
GO
--==================================================================================
CREATE PROCEDURE spRegistrarPaciente
	@prmNombre VARCHAR(50),
    @prmApPaterno VARCHAR(20),
    @prmApMaterno VARCHAR(20),
    @prmEdad INT,
    @prmSexo CHAR(1),
    @prmNroDoc VARCHAR(8),
    @prmDireccion VARCHAR(150),
    @prmTelefono VARCHAR(20),
    @prmEstado BIT
AS
BEGIN
	SET NOCOUNT ON;    
	INSERT INTO Paciente(nombres,apPaterno,apMaterno,edad,sexo,nroDocumento,direccion,telefono,estado) 
				VALUES(@prmNombre,@prmApPaterno,@prmApMaterno,
								@prmEdad,@prmSexo,@prmNroDoc,@prmDireccion,
								@prmTelefono,@prmEstado);
END
GO
--==================================================================================
CREATE PROCEDURE spListarPacientes	
AS
BEGIN	
	SELECT P.idPaciente
		  ,P.nombres
		  ,P.apPaterno
		  ,P.apMaterno
		  ,P.edad
		  ,P.sexo
		  ,P.nroDocumento
		  ,P.direccion
		  ,P.telefono
		  ,P.estado
	FROM Paciente P
	WHERE P.estado = 1				
END
GO
--==================================================================================

CREATE PROCEDURE spActualizarDatosPaciente
	@prmIdPaciente INT,    
    @prmDireccion VARCHAR(150)
AS
BEGIN
	SET NOCOUNT ON;    
	UPDATE Paciente SET Paciente.Direccion = @prmDireccion WHERE Paciente.idPaciente = @prmIdPaciente;
END
GO

--==================================================================================

CREATE PROCEDURE spEliminarPaciente
	@prmIdPaciente INT
AS
	BEGIN
		UPDATE Paciente SET Estado = 0 WHERE idPaciente = @prmIdPaciente;
	END
GO

--==================================================================================
--==================================================================================
--==================================================================================

USE DBClinica_test;

SELECT * FROM TipoEmpleado;

SELECT * FROM Empleado;
INSERT INTO Empleado VALUES(2,'Jose','Lopez','Martinez', 'INE', 1, NULL, 'jose', 'jose');
INSERT INTO Empleado VALUES(2,'Miguel','Mendoza','Rodriguez', 'Licencia', 1, NULL, 'miguel', 'miguel');

SELECT * FROM Paciente;
INSERT INTO Paciente VALUES('Pepe','Briceno','Ramos',23,'M','INE','Blvd. 2000', '66432598746', 1, NULL);