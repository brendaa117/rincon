-- Database: Libreria

-- DROP DATABASE IF EXISTS "Libreria";

CREATE TABLE Libros (
    ISBN VARCHAR(13) PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    año_publicación INT,
    numero_paginas INT,
    editorial VARCHAR(255),
    imagen_portada TEXT
);


CREATE TABLE Autores (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    nacionalidad VARCHAR(100),
    fecha_nacimiento DATE,
    biografia TEXT,
    foto TEXT
);

CREATE TABLE Generos (
    id_genero SERIAL PRIMARY KEY,
    nombre_genero VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE Usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    avatar TEXT
);

CREATE TABLE Reseñas (
    id_reseña SERIAL PRIMARY KEY,
    id_libro VARCHAR(13),
    id_usuario INT,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    contenido TEXT,
    fecha_publicacion DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_libro) REFERENCES Libros(ISBN) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Comentarios (
    id_comentario SERIAL PRIMARY KEY,
    id_reseña INT,
    id_usuario INT,
    contenido TEXT,
    fecha_comentario DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_reseña) REFERENCES Reseñas(id_reseña) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Likes (
    id_like SERIAL PRIMARY KEY,
    id_reseña INT,
    id_usuario INT,
    fecha_like DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_reseña) REFERENCES Reseñas(id_reseña) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    UNIQUE (id_reseña, id_usuario)
);

CREATE TABLE Libros_guardados (
    id_usuario INT,
    id_libro VARCHAR(13),
    fecha_guardado DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_usuario, id_libro),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_libro) REFERENCES Libros(ISBN) ON DELETE CASCADE
);

CREATE TABLE Libro_Autor (
    id_autor INT,
    ISBN VARCHAR(13),
    PRIMARY KEY (id_autor, ISBN),
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor) ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Libros(ISBN) ON DELETE CASCADE
);

CREATE TABLE Libro_Genero (
    id_genero INT,
    ISBN VARCHAR(13),
    PRIMARY KEY (id_genero, ISBN),
    FOREIGN KEY (id_genero) REFERENCES Generos(id_genero) ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Libros(ISBN) ON DELETE CASCADE
);