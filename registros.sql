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

--Ejercicio 7-Actualizar registros
--cambiar la direccion de un dueño por id o por nombre
UPDATE duenos
SET direccion = 'Av.Ignacio de la Roza 890 norte-Capital'
WHERE id = 2; 
--actualizar especialidad de un veterinario por id o por matricula
UPDATE veterinarios
SET especialidad = 'Traumatología Veterinaria'
WHERE id = 1;
--editar la descripcion de un historial clinico por id
UPDATE historial_clinico
SET descripcion = 'Control general, analisis y RX'
WHERE id = 3;


--Ejercicio 8 -  Eliminar Registros
-- por ID o nombre de mascota
DELETE FROM mascotas
WHERE nombre = 'Gordon'; 

-- se verifica la eliminacion de Gordon

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
