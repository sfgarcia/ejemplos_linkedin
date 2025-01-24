-- Crear la tabla con el registro de usuarios por plataforma
CREATE TABLE logging_por_plataforma (
    fecha DATE,
    plataforma VARCHAR(50),
    id_usuario VARCHAR(3)
);

-- Insertar datos en la tabla
INSERT INTO logging_por_plataforma (fecha, plataforma, id_usuario) VALUES
('2024-01-01', 'Web', '001'),
('2024-01-01', 'Mobile', '001'),
('2024-01-01', 'Web', '002'),
('2024-01-01', 'Mobile', '002'),
('2024-01-02', 'Web', '003'),
('2024-01-02', 'Mobile', '004'),
('2024-01-02', 'Web', '005'),
('2024-01-02', 'Mobile', '006'),
('2024-01-03', 'Web', '007'),
('2024-01-03', 'Mobile', '008'),
('2024-01-03', 'Web', '009'),
('2024-01-03', 'Mobile', '010'),
('2024-01-03', 'Web', '001'),
('2024-01-03', 'Mobile', '001'),;

-- Consulta con GROUPING SETS para contar usuarios por fecha y plataforma
SELECT 
    COALESCE(fecha::text, 'Total') AS fecha,
    COALESCE(plataforma, 'Total') AS plataforma,
    CASE WHEN
        GROUPING(fecha, plataforma) = 0 THEN 'fecha__plataforma'
        WHEN GROUPING(fecha, plataforma) = 2 THEN 'plataforma'
        ELSE 'total'
    END AS nivel_agregacion,
    COUNT(DISTINCT id_usuario) AS numero_usuarios
FROM logging_por_plataforma
GROUP BY GROUPING SETS (
    (fecha, plataforma),
    (plataforma),
    () -- Para el total
)
ORDER BY 1, 2;