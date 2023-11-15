USE DBClinica_test1;

SELECT * FROM TipoEmpleado;

SELECT * FROM Empleado;
INSERT INTO Empleado VALUES(1,'Daniel','Aguilar','Villegas', '568123', 1, NULL, 'daniel', 'daniel');
INSERT INTO Empleado VALUES(2,'Jose','Lopez','Martinez', 'INE', 1, NULL, 'jose', 'jose');
INSERT INTO Empleado VALUES(2,'Miguel','Mendoza','Rodriguez', 'Licencia', 1, NULL, 'miguel', 'miguel');

SELECT * FROM Paciente;
INSERT INTO Paciente VALUES('Pepe','Briceno','Ramos',23,'M','INE','Blvd. 2000', '66432598746', 1, NULL);

SELECT * FROM Cita;
SELECT * FROM HorarioAtencion;

2017/10/15