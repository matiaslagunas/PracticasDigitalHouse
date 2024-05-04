

CREATE TABLE usuarios (
	id_usuario INT PRIMARY KEY,
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    categoria_usuario VARCHAR(25)
);
    
    INSERT INTO usuarios (id_usuario, nombre, apellido, categoria_usuario)
VALUES
	 (1, 'Pablo', 'Lopez', 'Estudiante'),
    (2, 'Hernan', 'Fernandez', 'Profesor'),
    (3, 'Gustavo', 'Hernandez', 'Estudiante'),
    (4, 'Kevin', 'Zenon', 'Estudiante'),
    (5, 'Diego', 'Maradona', 'Profesor');
    
    


CREATE TABLE cursos (
    id_curso INT PRIMARY KEY,
    titulo_curso VARCHAR(50),
    unidades INT
);

INSERT INTO cursos (id_curso, titulo_curso, unidades)
VALUES
    (1, 'desarrollador web' , 5),
    (2, 'Diseño Gráfico Digital', 6),
    (3, 'Marketing Digital', 10),
    (4, 'Introducción a la Programación', 11),
    (5, 'Data analitycs', 9);

CREATE TABLE usuarios_cursos (
    id_usuario INT,
    id_curso INT,
    PRIMARY KEY (id_usuario, id_curso)
);


INSERT INTO usuarios_cursos (id_usuario, id_curso)
VALUES
    (1, 1),
    (1, 3),
    (2, 2),
    (2, 4),
    (3, 1),
    (3, 5),
    (4, 4),
    (5, 3),
    (5, 5);

CREATE TABLE clases (
    id_clase INT PRIMARY KEY,
    id_curso INT,
    fecha_inicio DATE,
    hora_inicio TIME,
    duracion_horas INT
);


INSERT INTO clases (id_clase, id_curso, fecha_inicio, hora_inicio, duracion_horas)
VALUES
    (1, 1, '2024-05-17', '9:00:00', 3),
    (2, 2, '2024-05-15', '5:45:00', 3),
    (3, 3, '2024-12-10', '13:30:00', 4),
    (4, 4, '2024-07-11', '12:00:00', 2),
    (5, 5, '2024-05-15', '10:00:00', 3);

CREATE TABLE unidades (
    id_unidad INT PRIMARY KEY,
    id_clase INT,
    titulo_unidad VARCHAR(50),
    fecha_inicio DATE
);


INSERT INTO unidades (id_unidad, id_clase, titulo_unidad, fecha_inicio)
VALUES
    (1, 1, 'HTML y CSS', '2024-05-10'),
    (2, 1, 'JavaScript Avanzado', '2024-05-15'),
    (3, 2, 'Diseño Gráfico', '2024-05-15'),
    (4, 3, 'Marketing Digital', '2024-05-20'),
    (5, 4, 'Introducción al Análisis de Datos', '2024-06-01'),
    (6, 5, 'Conceptos Fundamentales de Programación', '2024-06-05');

CREATE TABLE bloques (
    id_bloque INT PRIMARY KEY,
    id_unidad INT,
    tipo_bloque VARCHAR(50),
    contenido TEXT
);

INSERT INTO bloques (id_bloque, id_unidad, tipo_bloque, contenido)
VALUES
    (1, 1, 'Texto', 'URL del video de HTML y CSS'),
    (2, 1, 'Texto', 'Descripción de HTML y CSS'),
    (3, 2, 'Video', 'URL del video de JavaScript Avanzado'),
    (4, 2, 'Texto', 'Descripción de JavaScript Básico'),
    (5, 3, 'Texto', 'URL de diseño gráfico'),
    (6, 4, 'Video', 'Conceptos de marketing digital'),
    (7, 5, 'Texto', 'Conceptos de programación orientada a objetos'),
    (8, 6, 'Video', 'Introducción al análisis exploratorio de datos');

--

SELECT titulo_curso, unidades
FROM cursos
ORDER BY unidades DESC
LIMIT 5;



SELECT titulo_curso, AVG(unidades) AS media_unidades
FROM cursos
GROUP BY titulo_curso;


SELECT nombre, apellido
FROM usuarios
WHERE id_usuario IN (
    SELECT id_usuario
    FROM usuarios_cursos
    GROUP BY id_usuario
    HAVING COUNT(*) > 3
)
ORDER BY nombre ASC;


SELECT id_clase, id_curso, fecha_inicio, hora_inicio, duracion_horas
FROM clases
WHERE fecha_inicio > '2024-05-01'  
ORDER BY fecha_inicio ASC
LIMIT 10;

SELECT tipo_bloque, COUNT(*) AS cantidad_bloques
FROM bloques
INNER JOIN unidades ON bloques.id_unidad = unidades.id_unidad
INNER JOIN clases ON unidades.id_clase = clases.id_clase
WHERE clases.id_clase = 1  
GROUP BY tipo_bloque;

SELECT 
    COALESCE(nombre, '') AS nombre,
    COALESCE(apellido, '') AS apellido
FROM usuarios;

SELECT c.titulo_curso, COUNT(uc.id_usuario) AS cantidad_usuarios
FROM cursos c
JOIN usuarios_cursos uc ON c.id_curso = uc.id_curso
GROUP BY c.id_curso, c.titulo_curso
ORDER BY cantidad_usuarios DESC
LIMIT 3;

-- apartir de aca me ayudaron amigos programadores aclasro jajan --

SELECT
    c.titulo_curso AS titulo_curso,
    AVG(num_clases) AS promedio_clases_por_unidad
FROM cursos c
JOIN clases cl ON c.id_curso = cl.id_curso
JOIN unidades u ON cl.id_clase = u.id_clase
JOIN (
    SELECT id_unidad, COUNT(*) AS num_clases
    FROM bloques
    GROUP BY id_unidad
) AS t1 ON u.id_unidad = t1.id_unidad
GROUP BY c.id_curso, c.titulo_curso;

-- no me salio el 9 --

SELECT u.titulo_unidad, c.fecha_inicio
FROM unidades u
JOIN clases c ON u.id_clase = c.id_clase
WHERE c.fecha_inicio > '2024-05-01'  -- Reemplaza '2024-05-01' con la fecha determinada
ORDER BY c.fecha_inicio DESC
LIMIT 5;



