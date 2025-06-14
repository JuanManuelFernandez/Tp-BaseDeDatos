--CREATE DATABASE LibreriaUTN;
--GO
--USE LibreriaUTN
--GO

--CREATE TABLE Cliente (
--	IDCliente INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
--	DNI INT UNIQUE NOT NULL,
--	Nombre NVARCHAR(50) NOT NULL,
--	Apellido NVARCHAR(50) NOT NULL,
--	Telefono INT,
--	Mail NVARCHAR(100) NOT NULL
--)
--GO

--CREATE TABLE Autor (
--	IDAutor INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	NombreAutor NVARCHAR(50) NOT NULL,
--	ApellidoAutor NVARCHAR(50) NOT NULL
--)
--GO

--CREATE TABLE GENERO (
--	IDGenero INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	NombreGenero NVARCHAR(50) NOT NULL
--)
--GO

--CREATE TABLE Editorial (
--	IDEditorial INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	NombreEditorial NVARCHAR(50) NOT NULL
--)
--GO

--CREATE TABLE Libro (
--	IDLibro INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	Titulo NVARCHAR(50) NOT NULL,
--	IDAutor INT NOT NULL FOREIGN KEY REFERENCES Autor(IDAutor),
--	IDGenero INT NOT NULL FOREIGN KEY REFERENCES Genero(IDGenero),
--	Descripcion NVARCHAR(200) NOT NULL,
--	CantidadDePaginas INT NOT NULL,
--	FechaDePublicacion DATETIME NOT NULL,
--	IDEditorial INT NOT NULL FOREIGN KEY REFERENCES Editorial(IDEditorial),
--	Stock INT NOT NULL,
--	Precio MONEY NOT NULL
--)
--GO

--ALTER TABLE Libro
--DROP CONSTRAINT DF__Libro__Disponibi__2DE6D218

--ALTER TABLE Libro
--DROP COLUMN Disponibilidad;

--ALTER TABLE Libro
--ADD Disponibilidad BIT NOT NULL DEFAULT 1;

--CREATE TABLE Compras (
--	IDCompra INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	IDCliente INT NOT NULL FOREIGN KEY REFERENCES Cliente(IDCliente),
--	FechaDeCompra DATETIME NOT NULL,
--	IDLibroComprado INT NOT NULL FOREIGN KEY REFERENCES Libro(IDLibro),
--	Importe MONEY NOT NULL,
--	MedioDePago NVARCHAR(50) NOT NULL
--)
--GO

--ALTER TABLE Compras
--ADD Estado NVARCHAR(50);

--CREATE TABLE Devoluciones (
--	IDDevolucion INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	IDCompra INT NOT NULL FOREIGN KEY REFERENCES Compras(IDCompra),
--	FechaDevolucion DATETIME NOT NULL,
--	ImporteDevolucion MONEY NOT NULL,
--	IDLibroDevuelto INT FOREIGN KEY REFERENCES Libro(IDLibro)
--)
--GO

--INSERTS DE DATOS

--CLIENTE
--INSERT INTO Cliente (DNI, Nombre, Apellido, Telefono, Mail) VALUES
--(12345678, 'Juan', 'Pérez', 123456789, 'juan.perez@example.com'),
--(87654321, 'María', 'Gómez', 987654321, 'maria.gomez@example.com'),
--(11223344, 'Carlos', 'López', 456789123, 'carlos.lopez@example.com'),
--(44332211, 'Ana', 'Martínez', 321654987, 'ana.martinez@example.com'),
--(55667788, 'Luis', 'Fernández', 654321789, 'luis.fernandez@example.com');
--GO

--AUTOR
--INSERT INTO Autor (NombreAutor, ApellidoAutor) VALUES
--('Gabriel', 'García Márquez'),
--('Isabel', 'Allende'),
--('Jorge', 'Luis Borges'),
--('Julio', 'Cortázar'),
--('Mario', 'Vargas Llosa');
--GO

--GENERO
--INSERT INTO GENERO (NombreGenero) VALUES
--('Ficción'),
--('No Ficción'),
--('Ciencia Ficción'),
--('Romance'),
--('Terror');
--GO

--EDITORIAL
--INSERT INTO Editorial (NombreEditorial) VALUES
--('Editorial Planeta'),
--('Penguin Random House'),
--('HarperCollins'),
--('Grupo Anaya'),
--('Ediciones SM');
--GO

--LIBRO
--INSERT INTO Libro (Titulo, IDAutor, IDGenero, Descripcion, CantidadDePaginas, FechaDePublicacion, IDEditorial, Stock, Precio) VALUES
--('Cien Años de Soledad', 1, 1, 'Una novela que narra la historia de la familia Buendía a lo largo de varias generaciones.', 417, '1967-06-05', 1, 5, 29.99),
--('La Casa de los Espíritus', 2, 1, 'La saga de una familia chilena combinando realismo mágico y política.', 350, '1982-03-01', 2, 5, 24.99),
--('Ficciones', 3, 3, 'Una colección de relatos cortos que exploran la realidad y la ficción.', 224, '1944-05-01', 3, 5, 19.99),
--('Rayuela', 4, 1, 'Una novela experimental que desafía la estructura narrativa tradicional.', 500, '1963-09-28', 4, 5, 27.50),
--('La Ciudad y los Perros', 5, 1, 'Una cruda mirada a la vida en una academia militar en Perú.', 368, '1963-11-02', 5, 10, 22.75);
--GO

--SELECTS
--SELECT * FROM Cliente;
--SELECT * FROM Autor;
--SELECT * FROM GENERO;
--SELECT * FROM Editorial;
--SELECT * FROM Libro;
--SELECT * FROM Compras;
--SELECT * FROM Devoluciones;

--SELECT *
--FROM Devoluciones D
--JOIN Compras C ON D.IDCompra = C.IDCompra;

--VISTAS

--GENEROS
CREATE VIEW GeneroFiccion AS
SELECT L.Titulo, (A.NombreAutor + ' ' + A.ApellidoAutor) AS Autor
FROM Libro L
INNER JOIN Autor A ON L.IDAutor = A.IDAutor
INNER JOIN GENERO G ON L.IDGenero = G.IDGenero
WHERE G.NombreGenero = 'Ficción';

--DROP VIEW GeneroFiccion;

CREATE VIEW GeneroNoFiccion AS
SELECT L.Titulo, (A.NombreAutor + ' ' + A.ApellidoAutor) AS Autor
FROM Libro L
INNER JOIN Autor A ON L.IDAutor = A.IDAutor
INNER JOIN GENERO G ON L.IDGenero = G.IDGenero
WHERE G.NombreGenero = 'No Ficción';

--DROP VIEW GeneroNoFiccion;

CREATE VIEW GeneroCFiccion AS
SELECT L.Titulo, (A.NombreAutor + ' ' + A.ApellidoAutor) AS Autor
FROM Libro L
INNER JOIN Autor A ON L.IDAutor = A.IDAutor
INNER JOIN GENERO G ON L.IDGenero = G.IDGenero
WHERE G.NombreGenero = 'Ciencia Ficción';

--DROP VIEW GeneroCFiccion;

CREATE VIEW GeneroRomance AS
SELECT L.Titulo, (A.NombreAutor + ' ' + A.ApellidoAutor) AS Autor
FROM Libro L
INNER JOIN Autor A ON L.IDAutor = A.IDAutor
INNER JOIN GENERO G ON L.IDGenero = G.IDGenero
WHERE G.NombreGenero = 'Romance';

--DROP VIEW GeneroRomance;

CREATE VIEW GeneroTerror AS
SELECT L.Titulo, (A.NombreAutor + ' ' + A.ApellidoAutor) AS Autor
FROM Libro L
INNER JOIN Autor A ON L.IDAutor = A.IDAutor
INNER JOIN GENERO G ON L.IDGenero = G.IDGenero
WHERE G.NombreGenero = 'Terror';

--DROP VIEW GeneroTerror;

--SELECT VIEWS GENEROS
SELECT * FROM GeneroFiccion;
SELECT * FROM GeneroNoFiccion;
SELECT * FROM GeneroCFiccion;
SELECT * FROM GeneroRomance;
SELECT * FROM GeneroTerror;

--SIN STOCK
CREATE VIEW LibrosSinStock AS
SELECT Titulo
FROM Libro
WHERE Stock = 0;

--SELECT VIEW SinStock
SELECT * FROM LibrosSinStock;

--PROCEDIMIENTOS

--DBCC CHECKIDENT ('Compras', RESEED, 1);

--PROCEDIMIENTO REPORTE PARAMETRIZADO
CREATE PROCEDURE Reporte (
	@IDCliente INT,
	@FechaDeCompra DATE
	)
AS
BEGIN
	SELECT IDCompra, IDLibroComprado, Importe FROM Compras 
	WHERE IDCliente = @IDCliente AND CONVERT(DATE, FechaDeCompra) = @FechaDeCompra;
END;

EXEC Reporte
	@IDCliente = 2,
	@FechaDeCompra = '20250609';

--PROCEDIMIENTO PARA REGISTRAR LA COMPRA
CREATE PROCEDURE RegistrarCompra (
	@IDCliente INT,
    @IDLibroComprado INT,
    @Importe MONEY,
    @MedioDePago NVARCHAR(50),
	@Estado NVARCHAR(50)
	)
AS
BEGIN
    INSERT INTO Compras (IDCliente, FechaDeCompra, IDLibroComprado, Importe, MedioDePago, Estado)
    VALUES (@IDCliente, GETDATE(), @IDLibroComprado, @Importe, @MedioDePago, @Estado);
END;

EXEC RegistrarCompra
	@IDCliente = 3,
	@IDLibroComprado = 8,
    @Importe = 39.99,
    @MedioDePago = 'Efectivo',
	@Estado = 'No devuelto';

--PROCEDIMIENTO PARA REGISTRAR DEVOLUCIONES
CREATE PROCEDURE RegistrarDevolucion (
	@IDCompra INT,
	@ImporteDevolucion MONEY,
	@IDLibro INT
	)
AS
BEGIN
	INSERT INTO Devoluciones (IDCompra, FechaDevolucion, ImporteDevolucion, IDLibroDevuelto)
	VALUES (@IDCompra, GETDATE(), @ImporteDevolucion, @IDLibro);
	--Actualizar estado de la compra
	UPDATE Compras
	SET Estado = 'Devuelto'
	WHERE IDCompra = @IDCompra;
END

EXEC RegistrarDevolucion
	@IDCompra = 4,
	@ImporteDevolucion = 39.99,
	@IDLibro = 8;

--TRIGGERS

--ACTUALIZAR EL STOCK LUEGO DE REALIZAR UNA COMPRA
CREATE TRIGGER ActualizarStock ON Compras
AFTER INSERT
AS
BEGIN
	UPDATE L
	SET L.Stock = L.Stock - C.CantidadComprada
	FROM Libro L
	INNER JOIN(
		SELECT IDLibroComprado, COUNT(*) AS CantidadComprada
		FROM inserted
		GROUP BY IDLibroComprado
	)
	C ON L.IDLibro = C.IDLibroComprado
END

--ACTUALIZAR EL STOCK LUEGO DE UNA DEVOLUCIÓN
CREATE TRIGGER ActualizarStockDevolucion ON Devoluciones
AFTER INSERT
AS
BEGIN
	UPDATE L
	SET L.Stock = L.Stock + D.CantidadComprada
	FROM Libro L
	INNER JOIN(
		SELECT IDLibroDevuelto, COUNT(*) AS CantidadComprada
		FROM inserted /*contiene las filas de la tabla que activa el trigger*/
		GROUP BY IDLibroDevuelto
	)
	D ON L.IDLibro = D.IDLibroDevuelto
END
--ACTUALIZAR DISPONIBILIDAD
CREATE TRIGGER ActualizarDisponibilidad ON Libro
AFTER UPDATE
AS
BEGIN
	UPDATE Libro
	SET Disponibilidad = CASE WHEN Libro.Stock = 0 THEN 0 ELSE 1 END
	WHERE IDLibro IN (SELECT DISTINCT IDLibro FROM inserted);
END