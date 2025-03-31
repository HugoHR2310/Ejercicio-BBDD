--SCRIPT PARA CREAR LA BASE DE DATOS--

CREATE TABLE jesuita (
    idJesuita TINYINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    codigo CHAR(5) NULL,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    nombreAlumno VARCHAR(100) NOT NULL UNIQUE,
    firma VARCHAR(300) NOT NULL,
    firmaIngles VARCHAR(300) NOT NULL
);

CREATE TABLE lugar (
    ip CHAR(15) NOT NULL PRIMARY KEY,
    nombre_maquina CHAR(12) NOT NULL,
    lugar VARCHAR(30) NOT NULL
);

CREATE TABLE visita (
    idVisita SMALLINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    idJesuita TINYINT NOT NULL,
    ip CHAR(15) NOT NULL,
    fechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Lugar_Visita FOREIGN KEY (ip) REFERENCES lugar(ip),
    CONSTRAINT FK_Jesuita_Visita FOREIGN KEY (idJesuita) REFERENCES jesuita(idJesuita)
);

--3--
--Añadir un Jesuita que no va a realizar visita--
INSERT INTO jesuita(codigo,nombre,nombreAlumno,firma,firmaIngles)
VALUES ('5','Igancio de Loyola','Hugo','Este es mi Jesuita','This is my Jesuita');


--4--
--Añadir 2 lugares nuevos que no se van a visitar--
INSERT INTO lugar(ip,nombre_maquina,lugar)
VALUES ('102.123.170.0','WIN-06','Medellin'),
		('192.120.70.0','WIN-05','Cádiz');
--5--
-- LEFT JOIN--
SELECT jesuita.idJesuita, jesuita.nombre, lugar.lugar
FROM jesuita
LEFT JOIN visita
ON jesuita.idJesuita = visita.idJesuita
LEFT JOIN lugar
ON visita.ip = lugar.ip;
--RIHGT JOIN--
SELECT jesuita.idJesuita, jesuita.nombre, lugar.lugar
FROM lugar
RIGHT JOIN visita
ON lugar.ip = visita.ip
RIGHT JOIN jesuita
ON visita.idJesuita = jesuita.idJesuita;
--6--
--OBSERVA LOS LUGARES QUE EL JESUITA A VISITADO Y NO HA VISITADO
SELECT lugar.lugar, jesuita.nombre
FROM lugar
LEFT JOIN visita ON lugar.ip= visita.ip
LEFT JOIN jesuita ON visita.idJesuita=jesuita.idJesuita;
--7--
-- Muestra los lugares que no se han visitado
SELECT lugar.lugar
FROM lugar
LEFT JOIN visita ON lugar.ip = visita.ip
WHERE visita.idVisita IS NULL;