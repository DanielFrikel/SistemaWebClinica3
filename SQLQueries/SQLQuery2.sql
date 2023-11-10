--CREATE DATABASE DBClinica_test1

--USE DBClinica_test1

GO
/****** Object:  StoredProcedure [dbo].[spAccesoSistema]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAccesoSistema]
( @prmUser varchar(50),
  @prmPass varchar(50)
)
AS
	BEGIN
		SELECT E.idEmpleado, E.usuario, E.clave, E.nombres, E.apPaterno, E.apMaterno, E.nroDocumento
		FROM Empleado E
		WHERE E.usuario = @prmUser AND E.clave = @prmPass
	END
GO
/****** Object:  StoredProcedure [dbo].[spActualizaMenu]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spActualizaMenu]
(@prmIdMenu int ,
 @prmNombreMenu varchar(200),
 @prmUrlMenu varchar(200),
 @prmIdMenuParent int,
 @prmIsSubMenu bit,
 @prmEstado bit)
AS
	BEGIN
		UPDATE Menu
		SET nombre = @prmNombreMenu, 
		    url = @prmUrlMenu,
			idMenuParent = @prmIdMenuParent,
			isSubmenu = @prmIsSubMenu,
			estado = @prmEstado
		WHERE idMenu = @prmIdMenu
	END

GO
/****** Object:  StoredProcedure [dbo].[spActualizarDatosPaciente]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spActualizarDatosPaciente]
(@prmIdPaciente int,
@prmDireccion varchar(300))
as
	begin
		update Paciente
		set Paciente.direccion = @prmDireccion
		where Paciente.idPaciente = @prmIdPaciente
	end
GO
/****** Object:  StoredProcedure [dbo].[spActualizarEstadoCita]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spActualizarEstadoCita]
(@prmIdCita INT, @prmEstado varchar(1))
AS
	BEGIN
		UPDATE Cita
		SET estado = @prmEstado -- Atendido
		WHERE idCita = @prmIdCita
	END
GO
/****** Object:  StoredProcedure [dbo].[spActualizarHorarioAtencion]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spActualizarHorarioAtencion]
(@prmIdMedico int,
 @prmIdHorario int,
 @prmFecha datetime,
 @prmHora varchar(5)
)
AS
	BEGIN
		DECLARE @idHora int;

		SET @idHora = (SELECT H.idHora FROM Hora  H WHERE H.hora = RTRIM(@prmHora));

		UPDATE HA
		SET HA.fecha = @prmFecha,
		    HA.idHoraInicio = @idHora
		FROM HorarioAtencion HA
		WHERE HA.idHorarioAtencion = @prmIdHorario
		AND HA.idMedico = @prmIdMedico
		
	END
GO
/****** Object:  StoredProcedure [dbo].[spBuscarEmpleado]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spBuscarEmpleado]
(@prmNroDocumento varchar(8))
AS
	BEGIN
		SELECT E.idEmpleado
			 , E.nombres
			 , E.apPaterno
			 , E.apMaterno
			 , E.nroDocumento
			 , TE.descripcion
			 , E.usuario
		FROM Empleado E 
		INNER JOIN TipoEmpleado TE ON (E.idTipoEmpleado = TE.idTipoEmpleado)
		WHERE E.nroDocumento = @prmNroDocumento
	END
GO
/****** Object:  StoredProcedure [dbo].[spBuscarMedico]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spBuscarMedico] 
(@prmDni varchar(8))
AS
	BEGIN
		SELECT M.idMedico
			 , E.idEmpleado
			 , E.nombres as nombre
			 , E.apPaterno
			 , E.apMaterno
			 , ES.idEspecialidad
			 , ES.descripcion
			 , M.estado as estadoMedico
		FROM Medico M 
		INNER JOIN Empleado E ON (M.idEmpleado = E.idEmpleado)
		INNER JOIN Especialidad ES ON (M.idEspecialidad = ES.idEspecialidad)
		WHERE M.estado = 1
		AND E.nroDocumento = @prmDni
	END
GO
/****** Object:  StoredProcedure [dbo].[spBuscarPacienteDNI]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spBuscarPacienteDNI]
(@prmDni varchar(10)
)
AS
	BEGIN
		SELECT P.idPaciente
		     , P.nombres AS Nombres
			 , P.apPaterno AS ApPaterno
			 , P.apMaterno AS ApMaterno
			 , P.telefono AS Telefono
			 , P.edad AS Edad
			 , P.sexo AS Sexo
		FROM Paciente P
		WHERE nroDocumento = @prmDni
	END
GO
/****** Object:  StoredProcedure [dbo].[spBuscarPacienteIdCita]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spBuscarPacienteIdCita]
(@prmIdCita INT)
AS
	BEGIN
		DECLARE @prmIdPaciente INT
		SET @prmIdPaciente = (SELECT idPaciente FROM Cita WHERE idCita = @prmIdCita)
		
		SELECT idPaciente, nombres, apPaterno, apMaterno, edad, sexo
		FROM  Paciente
		WHERE idPaciente = @prmIdPaciente
	END
GO
/****** Object:  StoredProcedure [dbo].[spEditarHorarioAtencion]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEditarHorarioAtencion]
( @prmIdHorarioAtencion int,
  @prmIdMedico int,
  @prmFecha datetime,
  @prmHora varchar(6)
)
AS
	BEGIN
		DECLARE @idHora int;
		SET @idHora = (SELECT idHora FROM Hora WHERE hora =  RTRIM(@prmHora));
	
		UPDATE HA
		SET HA.fecha = @prmFecha,
		    HA.idHoraInicio = @idHora
		FROM HorarioAtencion HA 
		JOIN Hora H ON (HA.idHoraInicio = H.idHora)
		WHERE H.idHora = @idHora
		AND HA.idHorarioAtencion = @prmIdHorarioAtencion
		AND HA.idMedico = @prmIdMedico
	END
GO
/****** Object:  StoredProcedure [dbo].[spEliminarHorarioAtencion]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEliminarHorarioAtencion]
( @prmIdHorarioAtencion int
)
AS
	BEGIN
		UPDATE HorarioAtencion
		SET estado = 0
		WHERE idHorarioAtencion = @prmIdHorarioAtencion
	END
GO
/****** Object:  StoredProcedure [dbo].[spEliminarMenu]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEliminarMenu]
(@prmIdMenu int)
AS
	BEGIN
		UPDATE Menu
		SET estado = 0
		WHERE idMenu = @prmIdMenu
	END

GO
/****** Object:  StoredProcedure [dbo].[spEliminarPaciente]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEliminarPaciente]
(@prmIdPaciente int)
AS
	BEGIN
		UPDATE Paciente
		SET estado = 0
		WHERE idPaciente = @prmIdPaciente
	END
GO
/****** Object:  StoredProcedure [dbo].[spListaHorariosAtencion]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListaHorariosAtencion]
(@prmIdMedico int
)
AS
	BEGIN
		SELECT M.idMedico, HA.idHorarioAtencion, HA.fecha, H.hora
		FROM Medico M
		INNER JOIN HorarioAtencion HA ON (M.idMedico = HA.idMedico)
		INNER JOIN Hora H ON (HA.idHoraInicio = H.idHora)
		WHERE M.idMedico = @prmIdMedico 
		AND CONVERT(VARCHAR(10), HA.fecha, 103) >= CONVERT(VARCHAR(10), GETDATE(), 103)
		AND HA.estado = 1
	END
GO
/****** Object:  StoredProcedure [dbo].[spListaMenuPrincipal]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListaMenuPrincipal]
AS
	BEGIN
		SELECT 0 idMenu, '-- Sin Menú --' nombre
		UNION
		SELECT idMenu, nombre
		FROM Menu
		WHERE url = ''
	END

GO
/****** Object:  StoredProcedure [dbo].[spListarCitas]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListarCitas]
AS
	BEGIN
		SELECT C.idCita, C.idMedico, C.idPaciente, C.fechaReserva, C.hora, 
			   P.nombres, P.apPaterno, P.apMaterno, P.edad, P.sexo, 
			   P.nroDocumento, P.direccion
		FROM Cita AS C inner join Paciente AS P ON C.idPaciente = P.idPaciente
		WHERE --CONVERT(VARCHAR(10), C.fechaReserva, 103) = (SELECT CONVERT(VARCHAR(10), GETDATE(), 103)) AND
			  C.estado = 'P' AND -- P = 'Pendiente', A = 'Atendida'
			  P.estado = 1
		ORDER BY C.hora ASC
	END

GO
/****** Object:  StoredProcedure [dbo].[spListarEspecialidades]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListarEspecialidades]
AS
	BEGIN
		SELECT E.idEspecialidad, E.descripcion
		FROM Especialidad E
		WHERE E.estado = 1
	END
GO
/****** Object:  StoredProcedure [dbo].[spListarHorariosAtencionPorFecha]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListarHorariosAtencionPorFecha]
( @prmIdEspecialidad INT,
  @prmFecha DATE
)
AS
	BEGIN
		SELECT HA.idHorarioAtencion, HA.fecha, M.idMedico, E.nombres, H.idHora, H.hora
		FROM HorarioAtencion HA 
		INNER JOIN Medico M ON (HA.idMedico = M.idMedico)
		INNER JOIN Empleado E ON (M.idEmpleado = E.idEmpleado)
		INNER JOIN Hora H ON (HA.idHoraInicio = H.idHora)
		WHERE CAST(HA.fecha AS DATE) = @prmFecha 
		AND M.idEspecialidad = @prmIdEspecialidad
	END
GO
/****** Object:  StoredProcedure [dbo].[spListarMenu]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListarMenu]
AS
	BEGIN
		SELECT idMenu, 
			   nombre, 
			   isSubmenu, 
			   ISNULL(url, '') url, 
			   ISNULL(idMenuParent, 0) idMenuParent, 
			   estado,
			   show
		FROM Menu
		--WHERE estado = 1 
	END



GO
/****** Object:  StoredProcedure [dbo].[spListarMenuPermisos]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListarMenuPermisos]
(@prmIdEmpleado INT,
 @prmOption INT)
AS
	SET NOCOUNT ON
	BEGIN
		CREATE TABLE #TMPPERMISOS( IDTMPPERMISOS INT IDENTITY(1,1) NOT NULL
								 , IDEMPLEADO INT
								 , ENOMBRES VARCHAR(50)
								 , TIPOEMPLEADO VARCHAR(100)
								 , IdMenu INT
								 , nombre VARCHAR(200)
								 , isSubMenu BIT
								 , url VARCHAR(200)
								 , idMenuParent INT
								 , orden INT)

		INSERT INTO #TMPPERMISOS(IDEMPLEADO, ENOMBRES, TIPOEMPLEADO, IdMenu, nombre, isSubMenu, url, idMenuParent, orden)
		SELECT E.idEmpleado
			 , E.nombres
			 , TE.descripcion
			 , M.idMenu
			 , M.nombre
			 , M.isSubmenu
			 , M.url
			 , ISNULL(M.idMenuParent, 0)
			 , M.orden
		FROM Empleado E 
		INNER JOIN TipoEmpleado TE ON (E.idTipoEmpleado = TE.idTipoEmpleado)
		INNER JOIN Permisos P ON(E.idEmpleado = P.idEmpleado)
		INNER JOIN Menu M ON (P.idMenu = M.idMenu)
		WHERE E.idEmpleado = @prmIdEmpleado AND E.estado = 1 AND M.estado = 1
		ORDER BY M.orden, M.idMenu


		IF @prmOption = 0
			BEGIN
				SELECT IdMenu
					 , nombre
					 , isSubMenu
					 , url
					 , idMenuParent
				FROM #TMPPERMISOS
			END
		ELSE
			BEGIN
				SELECT IdMenu
					 , nombre
					 , isSubMenu
					 , url
					 , ISNULL(idMenuParent, 0)idMenuParent
				FROM Menu
				WHERE idMenu NOT IN(SELECT IDMENU FROM #TMPPERMISOS)
			END

		DROP TABLE #TMPPERMISOS

	END

GO
/****** Object:  StoredProcedure [dbo].[spListarPacientes]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListarPacientes]
AS
	BEGIN
		SELECT P.idPaciente
		     , P.nombres
			 , P.apPaterno
			 , P.apMaterno
			 , P.edad
			 , P.sexo
			 , P.nroDocumento
			 , P.direccion
		FROM Paciente P
		WHERE P.estado = 1
	END
GO
/****** Object:  StoredProcedure [dbo].[spListarSexo]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListarSexo]
AS	
	SET NOCOUNT ON
	BEGIN
		SELECT 'Femenino' idSexo
		     , 'Femenino' nombre
		UNION 
		SELECT 'Masculino' idSexo
		     , 'Masculino' nombre
	END

	



GO
/****** Object:  StoredProcedure [dbo].[spMenuPorEmpleado]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMenuPorEmpleado] 
(@prmIdEmpleado int)
AS
	BEGIN
		SELECT M.idMenu, 
			   M.nombre, M.url, 
			   M.isSubmenu, 
			   ISNULL(M.idMenuParent, 0) idMenuParent, 
			   M.estado MEstado,
			   P.estado,
			   M.show
		FROM Menu M INNER JOIN 
			 Permisos P ON (M.idMenu = P.idMenu) INNER JOIN 
			 Empleado E ON (E.idEmpleado = P.idEmpleado)
		WHERE E.idEmpleado = @prmIdEmpleado 
		  AND P.estado = 1	
		ORDER BY M.orden
	END



GO
/****** Object:  StoredProcedure [dbo].[spRegistrarCita]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegistrarCita]
( @idMedico int,
  @idPaciente int,
  @fechaReserva datetime,
  @hora varchar(5)
)
AS
	BEGIN
		INSERT INTO Cita(idMedico, idPaciente, fechaReserva, estado, hora)
		VALUES(@idMedico, @idPaciente, @fechaReserva, 'P', @hora)
	END


GO
/****** Object:  StoredProcedure [dbo].[spRegistrarDiagnostico]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegistrarDiagnostico]
(@prmIdPaciente INT,
 @prmObservacion VARCHAR(500),
 @prmDiagnostico VARCHAR(500)
 )
AS
	SET NOCOUNT ON
	BEGIN
		DECLARE @prmFecha DATETIME = GETDATE()
		DECLARE @prmEstado BIT = 1
		DECLARE @prmIdHistoriaClinica INT
		-- guardar la historia clinica
		IF NOT EXISTS(SELECT TOP 1 idHistoriaClinica FROM HistoriaClinica WHERE idPaciente = @prmIdPaciente)
			BEGIN
				INSERT INTO HistoriaClinica(idPaciente, fechaApertura, estado)
				VALUES(@prmIdPaciente, @prmFecha, @prmEstado)

				SET @prmIdHistoriaClinica = SCOPE_IDENTITY()
			END
		ELSE
			BEGIN
				SET @prmIdHistoriaClinica = (SELECT TOP 1 idHistoriaClinica FROM HistoriaClinica WHERE idPaciente = @prmIdPaciente)
			END

		-- guardar el diagnostico	
		INSERT INTO Diagnostico(idHistoriaClinica, fechaEmision, observacion, estado)
		VALUES(@prmIdHistoriaClinica, @prmFecha, @prmObservacion, @prmEstado)	
	END
GO
/****** Object:  StoredProcedure [dbo].[spRegistrarEliminarPermiso]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegistrarEliminarPermiso]
(@prmIdMenu int,
 @prmIdEmpleado int,
 @prmOpcion int)
AS
	SET NOCOUNT ON
	BEGIN
		IF @prmOpcion = 1  -- CREAR
			BEGIN
				
				IF NOT EXISTS(SELECT TOP 1 1 FROM Permisos WHERE idEmpleado = @prmIdEmpleado AND idMenu = @prmIdMenu)
					BEGIN
						INSERT INTO Permisos(idMenu, idEmpleado, estado)
						VALUES(@prmIdMenu, @prmIdEmpleado, 1)
					END
			END
		ELSE IF @prmOpcion = 0
			BEGIN		   -- ELIMINAR 
				DELETE FROM Permisos 
				WHERE idEmpleado = @prmIdEmpleado AND
					  idMenu = @prmIdMenu
			END
	END


GO
/****** Object:  StoredProcedure [dbo].[spRegistrarHorarioAtencion]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegistrarHorarioAtencion]
(@prmIdMedico int,
 @prmHora varchar(5),
 @prmFecha datetime
)
AS
	BEGIN
		-- TRY CATCH
		BEGIN TRY
			DECLARE @hora int;
			DECLARE @idHorarioAtencion int;
			
			-- OBTENER EL ID RESPECTIVO DEL PARAMETRO HORA
			SET @hora = (SELECT H.idHora FROM Hora H WHERE H.hora = @prmHora);
						
			-- INSERT
			INSERT INTO HorarioATencion(idMedico, fecha, idHoraInicio, estado)
			VALUES(@prmIdMedico, @prmFecha, @hora, 1); 
			
			-- OBTENER EL ULTIMO REGISTRO INSERTADO EN LA TABLA HORARIOATENCION
			SET @idHorarioAtencion = SCOPE_IDENTITY();

			-- SELECT
			SELECT HA.idHorarioAtencion, HA.fecha, H.idHora, H.hora, HA.estado
			FROM HorarioAtencion HA
			INNER JOIN Hora H ON(HA.idHoraInicio = H.idHora)
			WHERE HA.idHorarioAtencion = @idHorarioAtencion
		END TRY
		BEGIN CATCH
			ROLLBACK;
			-- RAISERROR('',,,,'')
			-- PRINT 'mensaje'
		END CATCH
	END
GO
/****** Object:  StoredProcedure [dbo].[spRegistrarMenu]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegistrarMenu]
(@prmNombre varchar(100),
 @prmIsSubmenu bit,
 @prmUrl varchar(200),
 @prmMenuParent int)
 AS
	BEGIN
		DECLARE @prmIdMenuParent INT
		IF @prmIsSubmenu = 0
			BEGIN
				
				IF @prmMenuParent = 0
				BEGIN SET @prmIdMenuParent = NULL 
				END 
				ELSE 
				BEGIN SET @prmIdMenuParent = @prmMenuParent 
				END

				INSERT INTO Menu(nombre, isSubmenu, url, idMenuParent, estado, show, orden)
				VALUES(@prmNombre, @prmIsSubmenu, @prmUrl, @prmIdMenuParent, 1, 1, 7)
			END
		ELSE 
			BEGIN 
					INSERT INTO Menu(nombre, isSubmenu, url, idMenuParent, estado, show, orden)
					VALUES(@prmNombre, @prmIsSubmenu, @prmUrl, @prmMenuParent, 1, 1, 7)
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[spRegistrarPaciente]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegistrarPaciente]
(
@prmNombres VARCHAR(50),
@prmApPaterno VARCHAR(50),
@prmApMaterno VARCHAR(50),
@prmEdad INT,
@prmSexo CHAR(1),
@prmNroDoc VARCHAR(8), 
@prmDireccion VARCHAR(150),
@prmTelefono VARCHAR(20),
@prmEstado bit
)
AS
	BEGIN
		INSERT INTO Paciente(nombres, apPaterno, apMaterno, edad, sexo, nroDocumento, direccion, telefono, estado)
		VALUES(@prmNombres, @prmApPaterno, @prmApMaterno, @prmEdad, @prmSexo, @prmNroDoc, @prmDireccion, @prmTelefono, @prmEstado);
	END
GO
/****** Object:  Table [dbo].[Cita]    Script Date: 24/08/2018 12:11:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cita](
	[idCita] [int] IDENTITY(1,1) NOT NULL,
	[idMedico] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[fechaReserva] [datetime] NULL,
	[observacion] [varchar](350) NULL,
	[estado] [char](1) NULL,
	[hora] [varchar](6) NULL,
 CONSTRAINT [PK_Cita] PRIMARY KEY CLUSTERED 
(
	[idCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Diagnostico]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Diagnostico](
	[idDiagnostico] [int] IDENTITY(1,1) NOT NULL,
	[idHistoriaClinica] [int] NOT NULL,
	[fechaEmision] [datetime] NULL,
	[observacion] [varchar](500) NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Diagnostico] PRIMARY KEY CLUSTERED 
(
	[idDiagnostico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DiaSemana]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DiaSemana](
	[idDiaSemana] [int] IDENTITY(1,1) NOT NULL,
	[nombreDiaSemana] [varchar](50) NULL,
 CONSTRAINT [PK_DiaSemana] PRIMARY KEY CLUSTERED 
(
	[idDiaSemana] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[idEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[idTipoEmpleado] [int] NOT NULL,
	[nombres] [varchar](50) NULL,
	[apPaterno] [varchar](20) NULL,
	[apMaterno] [varchar](20) NULL,
	[nroDocumento] [varchar](8) NULL,
	[estado] [bit] NULL,
	[imagen] [varchar](500) NULL,
	[usuario] [varchar](50) NULL,
	[clave] [varchar](50) NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Especialidad]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Especialidad](
	[idEspecialidad] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](25) NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Especialidad] PRIMARY KEY CLUSTERED 
(
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HistoriaClinica]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoriaClinica](
	[idHistoriaClinica] [int] IDENTITY(1,1) NOT NULL,
	[idPaciente] [int] NULL,
	[fechaApertura] [datetime] NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_HistoriaClinica] PRIMARY KEY CLUSTERED 
(
	[idHistoriaClinica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Hora]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Hora](
	[idHora] [int] IDENTITY(1,1) NOT NULL,
	[hora] [varchar](6) NULL,
 CONSTRAINT [PK_Hora] PRIMARY KEY CLUSTERED 
(
	[idHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HorarioAtencion]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HorarioAtencion](
	[idHorarioAtencion] [int] IDENTITY(1,1) NOT NULL,
	[idMedico] [int] NOT NULL,
	[idHoraInicio] [int] NOT NULL,
	[fecha] [datetime] NULL,
	[fechaFin] [date] NULL,
	[estado] [bit] NULL,
	[idDiaSemana] [int] NULL,
 CONSTRAINT [PK_HorarioAtencion] PRIMARY KEY CLUSTERED 
(
	[idHorarioAtencion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Medico]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medico](
	[idMedico] [int] IDENTITY(1,1) NOT NULL,
	[idEmpleado] [int] NOT NULL,
	[idEspecialidad] [int] NOT NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Medico] PRIMARY KEY CLUSTERED 
(
	[idMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Menu]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menu](
	[idMenu] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](200) NOT NULL,
	[isSubmenu] [bit] NOT NULL,
	[url] [varchar](200) NULL,
	[idMenuParent] [int] NULL,
	[estado] [bit] NULL,
	[show] [bit] NULL,
	[orden] [int] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[idMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Paciente]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Paciente](
	[idPaciente] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [varchar](50) NULL,
	[apPaterno] [varchar](20) NULL,
	[apMaterno] [varchar](20) NULL,
	[edad] [int] NULL,
	[sexo] [char](1) NULL,
	[nroDocumento] [varchar](8) NULL,
	[direccion] [varchar](150) NULL,
	[telefono] [varchar](20) NULL,
	[estado] [bit] NULL,
	[imagen] [varchar](500) NULL,
 CONSTRAINT [PK_Paciente] PRIMARY KEY CLUSTERED 
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Permisos]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permisos](
	[idEmpleado] [int] NOT NULL,
	[idMenu] [int] NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_Permisos] PRIMARY KEY CLUSTERED 
(
	[idEmpleado] ASC,
	[idMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoEmpleado]    Script Date: 24/08/2018 12:11:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoEmpleado](
	[idTipoEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](25) NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_TipoEmpleado] PRIMARY KEY CLUSTERED 
(
	[idTipoEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Cita] ON 

INSERT [dbo].[Cita] ([idCita], [idMedico], [idPaciente], [fechaReserva], [observacion], [estado], [hora]) VALUES (14, 1, 1, CAST(N'2014-02-12 00:00:00.000' AS DateTime), N'', N'A', N'20:00')
INSERT [dbo].[Cita] ([idCita], [idMedico], [idPaciente], [fechaReserva], [observacion], [estado], [hora]) VALUES (15, 8, 1, CAST(N'2014-04-12 00:00:00.000' AS DateTime), N'', N'A', N'10:00')
INSERT [dbo].[Cita] ([idCita], [idMedico], [idPaciente], [fechaReserva], [observacion], [estado], [hora]) VALUES (16, 5, 1, CAST(N'2014-06-12 00:00:00.000' AS DateTime), N'', N'A', N'11:00')
INSERT [dbo].[Cita] ([idCita], [idMedico], [idPaciente], [fechaReserva], [observacion], [estado], [hora]) VALUES (18, 3, 1, CAST(N'2018-02-17 19:46:31.743' AS DateTime), NULL, N'A', N'17:30')
SET IDENTITY_INSERT [dbo].[Cita] OFF
SET IDENTITY_INSERT [dbo].[Diagnostico] ON 

INSERT [dbo].[Diagnostico] ([idDiagnostico], [idHistoriaClinica], [fechaEmision], [observacion], [estado]) VALUES (1, 1, CAST(N'2018-08-09 14:31:55.427' AS DateTime), N'Observacion de prueba', 1)
INSERT [dbo].[Diagnostico] ([idDiagnostico], [idHistoriaClinica], [fechaEmision], [observacion], [estado]) VALUES (2, 1, CAST(N'2018-08-09 14:33:54.023' AS DateTime), N'Observacion de prueba 22222', 1)
INSERT [dbo].[Diagnostico] ([idDiagnostico], [idHistoriaClinica], [fechaEmision], [observacion], [estado]) VALUES (3, 1, CAST(N'2018-08-09 14:35:08.010' AS DateTime), N'prueba 4', 1)
SET IDENTITY_INSERT [dbo].[Diagnostico] OFF
SET IDENTITY_INSERT [dbo].[Empleado] ON 

INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (1, 1, N'Juan Carlos', N'Farias', N'Villegas', N'87653021', 1, NULL, N'jcfv', N'123')
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (2, 1, N'Rosa Maria', N'Flores', N'Linares', N'78650932', 1, NULL, N'rmfl', N'123')
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (3, 1, N'Carlos Jose', N'Romero', N'Alfaro', N'70983262', 1, NULL, N'cjra', N'123')
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (4, 3, N'Juan José', N'Pérez', N'Carrión', N'70874378', 1, NULL, N'jjrc', N'admin')
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (5, 1, N'Felicita Sara', N'Abarca', N'Heredia', N'17070167', 1, NULL, N'fsah', N'123')
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (6, 1, N'Maria Isabel', N'Acuña', N'Chumpitaz', N'16060198', 1, NULL, NULL, NULL)
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (7, 2, N'Flor Beatriz', N'Alarcon', N'Samame', N'86572102', 1, NULL, N'fbas', N'fbas123456')
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (8, 1, N'Diego Carlos', N'Aquino', N'Mendez', N'14040149', 1, NULL, NULL, NULL)
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (9, 1, N'Ronald Josue', N'Pareja', N'Alvarez', N'73030139', 1, NULL, NULL, NULL)
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (10, 1, N'Jaime Raul', N'Arca', N'Rodriguez', N'66020229', 1, NULL, NULL, NULL)
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (11, 1, N'Jose Victor', N'Arias', N'Figueroa', N'58780564', 1, NULL, NULL, NULL)
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (12, 1, N'Jhon Luis', N'Alfaro', N'Ganoza', N'87690432', 1, NULL, NULL, NULL)
INSERT [dbo].[Empleado] ([idEmpleado], [idTipoEmpleado], [nombres], [apPaterno], [apMaterno], [nroDocumento], [estado], [imagen], [usuario], [clave]) VALUES (13, 1, N'Default User', N'Default', N'User', N'99007722', 1, NULL, N'prueba', N'prueba')
SET IDENTITY_INSERT [dbo].[Empleado] OFF
SET IDENTITY_INSERT [dbo].[Especialidad] ON 

INSERT [dbo].[Especialidad] ([idEspecialidad], [descripcion], [estado]) VALUES (1, N'Medico General', 1)
INSERT [dbo].[Especialidad] ([idEspecialidad], [descripcion], [estado]) VALUES (2, N'Pediatra', 1)
INSERT [dbo].[Especialidad] ([idEspecialidad], [descripcion], [estado]) VALUES (3, N'Traumatologo', 1)
INSERT [dbo].[Especialidad] ([idEspecialidad], [descripcion], [estado]) VALUES (4, N'Oftalmologo', 1)
SET IDENTITY_INSERT [dbo].[Especialidad] OFF
SET IDENTITY_INSERT [dbo].[HistoriaClinica] ON 

INSERT [dbo].[HistoriaClinica] ([idHistoriaClinica], [idPaciente], [fechaApertura], [estado]) VALUES (1, 1, CAST(N'2018-08-09 14:31:55.427' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[HistoriaClinica] OFF
SET IDENTITY_INSERT [dbo].[Hora] ON 

INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (1, N'09:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (2, N'09:30')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (3, N'10:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (4, N'10:30')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (5, N'11:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (6, N'11:30')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (7, N'12:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (8, N'15:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (9, N'15:30')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (10, N'16:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (11, N'16:30')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (12, N'17:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (13, N'17:30')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (14, N'18:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (15, N'18:30')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (16, N'19:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (17, N'19:30')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (18, N'20:00')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (19, N'20:30')
INSERT [dbo].[Hora] ([idHora], [hora]) VALUES (20, N'21:00')
SET IDENTITY_INSERT [dbo].[Hora] OFF
SET IDENTITY_INSERT [dbo].[HorarioAtencion] ON 

INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (1, 6, 10, CAST(N'2017-07-02 00:00:00.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (2, 6, 13, CAST(N'2017-07-02 00:00:00.000' AS DateTime), NULL, 0, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (3, 6, 1, CAST(N'2017-07-03 00:00:00.000' AS DateTime), NULL, 0, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (4, 6, 5, CAST(N'2017-07-03 00:00:00.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (1002, 7, 1, CAST(N'2017-10-15 00:00:00.000' AS DateTime), NULL, 0, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (1003, 7, 1, CAST(N'2017-10-15 00:00:00.000' AS DateTime), NULL, 0, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (1004, 7, 2, CAST(N'2017-10-15 00:00:00.000' AS DateTime), NULL, 0, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (1005, 7, 3, CAST(N'2017-10-15 00:00:00.000' AS DateTime), NULL, 0, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (2002, 2, 2, CAST(N'2018-01-29 00:00:00.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (2003, 2, 3, CAST(N'2018-01-29 00:00:00.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (2004, 3, 13, CAST(N'2018-02-17 00:00:00.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (2005, 4, 14, CAST(N'2018-07-08 00:00:00.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (2006, 4, 15, CAST(N'2018-07-08 00:00:00.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[HorarioAtencion] ([idHorarioAtencion], [idMedico], [idHoraInicio], [fecha], [fechaFin], [estado], [idDiaSemana]) VALUES (2007, 4, 16, CAST(N'2018-07-09 00:00:00.000' AS DateTime), NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[HorarioAtencion] OFF
SET IDENTITY_INSERT [dbo].[Medico] ON 

INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (1, 1, 1, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (2, 3, 1, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (3, 2, 1, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (4, 5, 3, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (5, 6, 1, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (6, 7, 3, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (7, 8, 1, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (8, 9, 1, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (9, 10, 1, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (10, 11, 4, 1)
INSERT [dbo].[Medico] ([idMedico], [idEmpleado], [idEspecialidad], [estado]) VALUES (21, 12, 4, 1)
SET IDENTITY_INSERT [dbo].[Medico] OFF
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (1, N'Registro de Pacientes', 0, N'GestionarPaciente.aspx', NULL, 1, 1, 2)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (2, N'Reserva de Citas', 0, N'GestionarReservaCitas.aspx', NULL, 1, 1, 3)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (3, N'Atención de Citas', 0, N'GestionarAtencionPaciente.aspx', NULL, 1, 1, 4)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (4, N'Horarios', 0, N'', NULL, 1, 1, 5)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (5, N'Horarios Médicos', 1, N'GestionarHorarioAtencion.aspx', 4, 1, 1, 1)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (6, N'Panel General', 0, N'PanelGeneral.aspx', NULL, 1, 1, 1)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (7, N'Gestionar Menús', 0, N'GestionarMenus.aspx', 0, 1, 1, 6)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (8, N'Reportes', 0, N'', NULL, 0, 1, 7)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (9, N'Reporte Atención por Fechas', 1, N'ReporteAtencionPorFechas.aspx', 8, 0, 1, 1)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (10, N'Reporte Atención por Médico', 1, N'ReporteAtencionPorMedico.aspx', 8, 0, 1, 2)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (11, N'Gestionar Permisos', 0, N'GestionarPermisos.aspx', NULL, 1, 1, 8)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (1011, N'Gestión de Medicos', 0, N'GestionarMedicos.aspx', NULL, 0, 1, 7)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (1012, N'Gestionar Pagos', 0, N'', NULL, 0, 1, 7)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (1013, N'Gestionar Pagos Medicos', 1, N'GestionarPagosMedicos.aspx', 1012, 0, 1, 7)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (1014, N'Gestionar Almacen', 0, N'GestionarAlmacen.aspx', 0, 1, 1, 7)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (1015, N'Gestionar Salas', 0, N'', NULL, 0, 1, 7)
INSERT [dbo].[Menu] ([idMenu], [nombre], [isSubmenu], [url], [idMenuParent], [estado], [show], [orden]) VALUES (1016, N'Gestionar Salas Medicas', 1, N'GestionarSalasMedicas.aspx', 1015, 0, 1, 7)
SET IDENTITY_INSERT [dbo].[Menu] OFF
SET IDENTITY_INSERT [dbo].[Paciente] ON 

INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (1, N'Jorge', N'Perez', N'Carrión', 21, N'M', N'17885200', N'Cale Prueba #854', N'99552047', 1, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (2, N'Sandra', N'Sanchez', N'Moreno', 20, N'F', N'87690987', N'Cale Prueba #854', N'85452222', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (3, N'Francisco', N'Pereda', N'Sandoval', 32, N'M', N'70981274', N'Cale Prueba #854', N'87542221', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (4, N'Javier Estefano', N'Sanchez', N'Martinez', 28, N'M', N'56743409', N'Cale Prueba #854', N'285746', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (5, N'Cesar Javier', N'Vasquez', N'Leon', 30, N'M', N'46783254', N'Cale Prueba #854', N'245684', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (6, N'Maria Isabel', N'Farias', N'Tirado', 25, N'F', N'24236789', N'Cale Prueba #854', N'346778', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (7, N'Carlos Andres', N'Paredes', N'Sisniegas', 32, N'M', N'76564909', N'Cale Prueba #854', N'95786198', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (9, N'Julia Maria', N'Santoso', N'Morales', 22, N'F', N'99632014', N'Sin dirección', N'625485', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (10, N'Julia Maria', N'Santoso', N'Morales', 21, N'F', N'78541203', N'Sin dirección', N'625485', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (11, N'Julia Maria', N'Santoso', N'Morales', 25, N'F', N'78541203', N'Sin dirección', N'625485', 1, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (12, N'JJJ RRR', N'RR', N'CC', 23, N'M', N'3456789', N'Sin dirección', N'625485', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (13, N'24', N'2', N'24', 24, N'M', N'2324', N'234', N'24', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (14, N'24', N'2', N'24', 24, N'M', N'2324', N'234', N'24', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (15, N'2434234', N'24243 2342', N'234', 24324, N'M', N'34', N'23424', N'242', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (16, N'sdsffsfs', N'Rodriguez', N'Morales', 22, N'M', N'78541203', N'Calle 128 ', N'96520140', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (17, N'ad', N'ad', N'as', 12, N'M', N'ad', N'a', N'ad', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (18, N'dssad', N'asdasd', N'asdads', 23, N'M', N'234234', N'sdsdfs', N'2332', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (19, N'dssad', N'asdasd', N'asdads', 23, N'M', N'234234', N'sdsdfs', N'2332', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (20, N'ssdsdf', N'asdasd', N'asdads', 23, N'M', N'234234', N'sdsdfs', N'2222', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (21, N'JJJ RRR', N'Santoso', N'asfaf', 23, N'M', N'99632014', N'asdsasd', N'3453', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (23, N'xtyyjyj', N'ttyytty', N'tyhytyt', 11, N'F', N'867555', N'sfddgf6565b', N'3455675', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (24, N'adasd asdasd', N'asdasd', N'asd', 12, N'M', N'1232131', N'12dasdasd', N'asdasd123', 1, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (25, N'dsad asdasd', N'asdasd', N'asdasd', 23, N'M', N'234234', N'sdsdsdf', N'23423424', 1, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (26, N'dsad asdasd', N'asdasd', N'asdasd', 23, N'M', N'22222', N'sdsdsdf', N'23423424', 0, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (27, N'Alejandro', N'Cruzado', N'Rodriguez', 19, N'F', N'99662210', N'David Lozano #8852', N'632015', 1, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (28, N'asdasdasd', N'asdasdads', N'asdasdsad', 19, N'M', N'93662210', N'Los Caballeros #585', N'23424234', 1, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [nombres], [apPaterno], [apMaterno], [edad], [sexo], [nroDocumento], [direccion], [telefono], [estado], [imagen]) VALUES (29, N'alejandro alejandro', N'asdasdads', N'asdasdsad', 19, N'M', N'93662210', N'asdasdasd', N'23424234', 0, NULL)
SET IDENTITY_INSERT [dbo].[Paciente] OFF
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 1, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 2, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 3, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 4, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 5, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 6, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 7, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 8, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 9, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 10, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 11, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 1011, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 1012, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 1013, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 1015, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (4, 1016, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (7, 1, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (7, 2, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (7, 3, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (7, 6, 1)
INSERT [dbo].[Permisos] ([idEmpleado], [idMenu], [estado]) VALUES (7, 1014, 1)
SET IDENTITY_INSERT [dbo].[TipoEmpleado] ON 

INSERT [dbo].[TipoEmpleado] ([idTipoEmpleado], [descripcion], [estado]) VALUES (1, N'Medico', 1)
INSERT [dbo].[TipoEmpleado] ([idTipoEmpleado], [descripcion], [estado]) VALUES (2, N'Secretaria', 1)
INSERT [dbo].[TipoEmpleado] ([idTipoEmpleado], [descripcion], [estado]) VALUES (3, N'Administrador', 1)
SET IDENTITY_INSERT [dbo].[TipoEmpleado] OFF
ALTER TABLE [dbo].[Cita]  WITH CHECK ADD  CONSTRAINT [FK_Cita_Medico] FOREIGN KEY([idMedico])
REFERENCES [dbo].[Medico] ([idMedico])
GO
ALTER TABLE [dbo].[Cita] CHECK CONSTRAINT [FK_Cita_Medico]
GO
ALTER TABLE [dbo].[Cita]  WITH CHECK ADD  CONSTRAINT [FK_Cita_Paciente] FOREIGN KEY([idPaciente])
REFERENCES [dbo].[Paciente] ([idPaciente])
GO
ALTER TABLE [dbo].[Cita] CHECK CONSTRAINT [FK_Cita_Paciente]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_TipoEmpleado] FOREIGN KEY([idTipoEmpleado])
REFERENCES [dbo].[TipoEmpleado] ([idTipoEmpleado])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK_Empleado_TipoEmpleado]
GO
ALTER TABLE [dbo].[HistoriaClinica]  WITH CHECK ADD  CONSTRAINT [FK_HistoriaClinica_Paciente] FOREIGN KEY([idPaciente])
REFERENCES [dbo].[Paciente] ([idPaciente])
GO
ALTER TABLE [dbo].[HistoriaClinica] CHECK CONSTRAINT [FK_HistoriaClinica_Paciente]
GO
ALTER TABLE [dbo].[HorarioAtencion]  WITH CHECK ADD  CONSTRAINT [FK_HorarioAtencion_DiaSemana] FOREIGN KEY([idDiaSemana])
REFERENCES [dbo].[DiaSemana] ([idDiaSemana])
GO
ALTER TABLE [dbo].[HorarioAtencion] CHECK CONSTRAINT [FK_HorarioAtencion_DiaSemana]
GO
ALTER TABLE [dbo].[HorarioAtencion]  WITH CHECK ADD  CONSTRAINT [FK_HorarioAtencion_Hora] FOREIGN KEY([idHoraInicio])
REFERENCES [dbo].[Hora] ([idHora])
GO
ALTER TABLE [dbo].[HorarioAtencion] CHECK CONSTRAINT [FK_HorarioAtencion_Hora]
GO
ALTER TABLE [dbo].[HorarioAtencion]  WITH CHECK ADD  CONSTRAINT [FK_HorarioAtencion_Medico] FOREIGN KEY([idMedico])
REFERENCES [dbo].[Medico] ([idMedico])
GO
ALTER TABLE [dbo].[HorarioAtencion] CHECK CONSTRAINT [FK_HorarioAtencion_Medico]
GO
ALTER TABLE [dbo].[Medico]  WITH CHECK ADD  CONSTRAINT [FK_Medico_Empleado] FOREIGN KEY([idEmpleado])
REFERENCES [dbo].[Empleado] ([idEmpleado])
GO
ALTER TABLE [dbo].[Medico] CHECK CONSTRAINT [FK_Medico_Empleado]
GO
ALTER TABLE [dbo].[Medico]  WITH CHECK ADD  CONSTRAINT [FK_Medico_Especialidad] FOREIGN KEY([idEspecialidad])
REFERENCES [dbo].[Especialidad] ([idEspecialidad])
GO
ALTER TABLE [dbo].[Medico] CHECK CONSTRAINT [FK_Medico_Especialidad]
GO


--====================================================================================================
USE DBClinica_test1;

SELECT * FROM TipoEmpleado;

SELECT * FROM Empleado;
INSERT INTO Empleado VALUES(1,'Daniel','Aguilar','Villegas', '568123', 1, NULL, 'daniel', 'daniel');
INSERT INTO Empleado VALUES(2,'Jose','Lopez','Martinez', 'INE', 1, NULL, 'jose', 'jose');
INSERT INTO Empleado VALUES(2,'Miguel','Mendoza','Rodriguez', 'Licencia', 1, NULL, 'miguel', 'miguel');

SELECT * FROM Paciente;
INSERT INTO Paciente VALUES('Pepe','Briceno','Ramos',23,'M','INE','Blvd. 2000', '66432598746', 1, NULL);

SELECT * FROM Empleado;

--====================================================================================================
--====================================================================================================
--====================================================================================================
--====================================================================================================
--====================================================================================================
--====================================================================================================
--====================================================================================================