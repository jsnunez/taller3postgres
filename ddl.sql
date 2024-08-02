DROP DATABASE  miscompras;-- Create a new database called 'DatabaseName'
CREATE DATABASE miscompras;

\c miscompras

CREATE TABLE categorias(
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(45),
    estado smallint
);

CREATE TABLE productos(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(45),
    id_categoria INT,
    codigo_barras VARCHAR(150),
    precio_venta DECIMAL(16,2),
    cantidad_stock INT,
    estado smallint,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

CREATE TABLE clientes(
    id VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(40),
    apellidos VARCHAR(100),
    celular DECIMAL(10,0),
    direccion VARCHAR(80),
    correo_electronico VARCHAR(70)
);

CREATE TABLE compras(
    id SERIAL PRIMARY KEY,
    id_cliente VARCHAR(20),
    fecha DATE,
    medio_pago CHAR(1),
    comentario VARCHAR(300),
    estado CHAR(1),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE compras_productos(
    id_compra INT,
    id_producto INT,
    cantidad INT,
    total decimal(16,2),
    estado SMALLINT,
    PRIMARY KEY (id_compra, id_producto),
    FOREIGN KEY (id_compra) REFERENCES compras(id),
    FOREIGN KEY (id_producto) REFERENCES productos(id)
);
