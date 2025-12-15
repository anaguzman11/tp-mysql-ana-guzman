--Ejercicio 1 – Crear Base de Datos

CREATE DATABASE veterinaria_patitas_felices;
USE veterinaria_patitas_felices;


--Ejercicio 2 – Crear tabla duenos

CREATE TABLE duenos (
    id INT PRIMARY KEY AUTO_INCREMENT,       
    nombre VARCHAR(50) NOT NULL,            
    apellido VARCHAR(50) NOT NULL,          
    telefono VARCHAR(20) NOT NULL, 
    direccion VARCHAR(100) NOT NULL       
);


--Ejercicio 3 – Crear tabla mascotas

CREATE TABLE mascotas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE,
    id_duenos INT,
FOREIGN KEY (id_duenos) REFERENCES duenos(id)
ON DELETE CASCADE
ON UPDATE CASCADE
);


--Ejercicio 4 – Crear tabla veterinarios

CREATE TABLE veterinarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    especialidad VARCHAR(50) NOT NULL
)


--Ejercicio 5 – Crear tabla historial_clinico

CREATE TABLE historial_clinico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_mascota INT,
    id_veterinario INT,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(250) NOT NULL,

FOREIGN KEY (id_mascota) REFERENCES mascotas(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)


--Ejercicio 6 – Insertar registros

-- tres dueños
INSERT INTO duenos (nombre, apellido, telefono, direccion) VALUES
('Ana Laura', 'Guzman Icazati', '264-5078218', 'Av.Paula A. de Sarmiento 533 sur-Capital'),
('Camila', 'Gonzalez','264-5078259', 'Av.Libertado 1250 oeste-Capital'),
('Ariel', 'Guzman', '264-4567890', 'Mendoza 58 norte-Capital');

--tres mascotas
INSERT INTO mascotas (nombre, especie, fecha_nacimiento, id_duenos) VALUES
('Vilma', 'Gato', '2021-05-11', 1),
('Gordon', 'Perro', '2022-11-01', 2),
('Goyo', 'Perro', '2015-12-25',3);

--dos veterinarios
INSERT INTO veterinarios (nombre, apellido, matricula, especialidad)
VALUES
('Ana', 'Martínez', 'MAT001', 'Clínica general'),
('Luis', 'Fernández', 'MAT002', 'Cirugía');

--3 historial clinicos
INSERT INTO historial_clinico (id_mascota, id_veterinario, descripcion)
VALUES
(1, 1, 'Vacunación anual aplicada sin complicaciones'),
(2, 2, 'Cirugía menor realizada con éxito'),
(3, 1, 'Consulta general por control de rutina');

--- consulta y devolución de tabla 
SELECT 
    hc.id AS id_historial,
    m.nombre AS nombre_mascota,
    d.nombre AS nombre_dueno,
    d.apellido AS apellido_dueno,
    v.nombre AS nombre_veterinario,
    v.apellido AS apellido_veterinario,
    hc.fecha_registro,
    hc.descripcion
FROM historial_clinico hc
JOIN mascotas m ON hc.id_mascota = m.id
JOIN duenos d ON m.id_duenos = d.id
JOIN veterinarios v ON hc.id_veterinario = v.id;


-- Ejercicio 7-Actualizar registros

--cambiar la direccion de un dueño por id o por nombre
UPDATE duenos
SET direccion = 'Av.Ignacio de la Roza 890 norte-Capital'
WHERE id = 2; 
-- se verifica el cambio de dirección
SELECT *
FROM duenos
WHERE id = 2;

--actualizar especialidad de un veterinario por id o por matricula
UPDATE veterinarios
SET especialidad = 'Traumatología Veterinaria'
WHERE id = 1;
-- se verifica el cambio de especialidad
SELECT *
FROM duenos
WHERE id = 1; 

--editar la descripcion de un historial clinico por id
UPDATE historial_clinico
SET descripcion = 'Control general, analisis y RX'
WHERE id = 3;
-- se verifica el cambio de descripción
SELECT *
FROM historial_clinico
WHERE id = 3; 


--Ejercicio 8 -  Eliminar Registros

-- por ID o nombre de mascota
DELETE FROM mascotas
WHERE nombre = 'Gordon'; 
-- se verifica la eliminacion de Gordon
SELECT *
FROM mascotas
WHERE nombre = 'Gordon';


--Ejercicio 9 - JOIN simple

SELECT 
    mascotas.nombre AS nombre_mascota,
    mascotas.especie AS especie,
    CONCAT(duenos.nombre, ' ', duenos.apellido) AS nombre_completo_dueno
FROM mascotas
JOIN duenos ON mascotas.id_duenos = duenos.id;


--Ejercicio 10 - JOIN multiple con historial
SELECT 
    mascotas.nombre AS nombre_mascota,
    mascotas.especie AS especie,
    CONCAT(duenos.nombre, ' ', duenos.apellido) AS nombre_completo_dueno,
    CONCAT(veterinarios.nombre, ' ', veterinarios.apellido) AS nombre_completo_veterinario,
    historial_clinico.fecha_registro,
    historial_clinico.descripcion
FROM historial_clinico
JOIN mascotas ON historial_clinico.id_mascota = mascotas.id
JOIN duenos ON mascotas.id_duenos = duenos.id
JOIN veterinarios ON historial_clinico.id_veterinario = veterinarios.id
ORDER BY historial_clinico.fecha_registro DESC;