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
