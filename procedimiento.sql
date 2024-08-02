INSERT INTO categorias (descripcion, estado) VALUES 
('Electrónica', 1),
('Ropa', 1),
('Hogar', 1);

INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado) VALUES
('Televisor', 1, '001122334455', 999.99, 30, 1),
('Smartphone', 1, '123456789012', 499.99, 50, 1),
('Camiseta', 2, '987654321098', 19.99, 100, 1),
('Sofá', 3, '555666777888', 299.99, 10, 1);


INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado) VALUES
('Televisor', 1, '001122334455', 999.99, 30, 1),
('Smartphone', 1, '123456789012', 499.99, 50, 1),
('Camiseta', 2, '987654321098', 19.99, 100, 1),
('Sofá', 3, '555666777888', 299.99, 10, 1);

INSERT INTO clientes (id, nombre, apellidos, celular, direccion, correo_electronico) VALUES
('C001', 'Ana', 'García Fernández', 5551234567, 'Calle 1, Madrid', 'ana.garcia@example.com'),
('C002', 'Carlos', 'López Martínez', 5552345678, 'Avenida 3, Barcelona', 'carlos.lopez@example.com'),
('C003', 'María', 'Rodríguez Gómez', 5553456789, 'Calle 2, Valencia', 'maria.rodriguez@example.com');

INSERT INTO compras (id_cliente, fecha, medio_pago, comentario, estado) VALUES
('C001', '2024-08-01', 'C', 'Compra de verano', 'A'),
('C002', '2024-08-02', 'D', 'Compra de oficina', 'A'),
('C003', '2024-08-03', 'E', 'Regalo para familia', 'A');

INSERT INTO compras_productos (id_compra, id_producto, cantidad, total, estado) VALUES
(1, 1, 1, 999.99, 1),  -- Compra de un Televisor
(1, 2, 2, 999.98, 1),  -- Compra de dos Smartphones
(2, 3, 5, 99.95, 1),   -- Compra de cinco Camisetas
(3, 4, 1, 299.99, 1);  -- Compra de un Sofá

CREATE FUNCTION insertar_cliente(
    p_id VARCHAR,
    p_nombre VARCHAR,
    p_apellidos VARCHAR,
    p_celular DECIMAL,
    p_direccion VARCHAR,
    p_correo_electronico VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO clientes (id, nombre, apellidos, celular, direccion, correo_electronico)
    VALUES (p_id, p_nombre, p_apellidos, p_celular, p_direccion, p_correo_electronico);
END;
$$ LANGUAGE plpgsql;

SELECT insertar_cliente(
    'C123',
    'Juan',
    'Pérez López',
    1234567890,
    'Calle Falsa 123',
    'juan.perez@example.com'
);

CREATE FUNCTION actualizar_cliente(
    p_id VARCHAR,
    p_nombre VARCHAR,
    p_apellidos VARCHAR,
    p_celular DECIMAL,
    p_direccion VARCHAR,
    p_correo_electronico VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE clientes
    SET nombre = p_nombre,
        apellidos = p_apellidos,
        celular = p_celular,
        direccion = p_direccion,
        correo_electronico = p_correo_electronico
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;


SELECT actualizar_cliente(
    'C123',
    'Juan Carlos',
    'Pérez López',
    9876543210,
    'Avenida Siempre Viva 456',
    'juan.carlos.perez@example.com'
);


CREATE FUNCTION eliminar_cliente(
    p_id VARCHAR
) RETURNS VOID AS $$
BEGIN
    DELETE FROM clientes
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;


SELECT eliminar_cliente('C123');


CREATE FUNCTION insertar_compra(
    p_id_cliente VARCHAR,
    p_fecha DATE,
    p_medio_pago CHAR,
    p_comentario VARCHAR,
    p_estado CHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO compras (id_cliente, fecha, medio_pago, comentario, estado)
    VALUES (p_id_cliente, p_fecha, p_medio_pago, p_comentario, p_estado);
END;
$$ LANGUAGE plpgsql;

SELECT insertar_compra(
    'C123',
    '2024-08-02',
    'C',
    'Primera compra',
    'A'
);

CREATE FUNCTION insertar_producto_compra(
    p_id_compra INT,
    p_id_producto INT,
    p_cantidad INT,
    p_total DECIMAL,
    p_estado SMALLINT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO compras_productos (id_compra, id_producto, cantidad, total, estado)
    VALUES (p_id_compra, p_id_producto, p_cantidad, p_total, p_estado);
END;
$$ LANGUAGE plpgsql;

SELECT insertar_producto_compra(
    1,
    1,
    2,
    200.00,
    1
);

CREATE FUNCTION obtener_compra(
    p_id_compra INT
) RETURNS TABLE(
    id INT,
    id_cliente VARCHAR,
    fecha DATE,
    medio_pago CHAR,
    comentario VARCHAR,
    estado CHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT id, id_cliente, fecha, medio_pago, comentario, estado
    FROM compras
    WHERE id = p_id_compra;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM obtener_compra(1);


CREATE FUNCTION insertar_producto(
    p_nombre VARCHAR,
    p_id_categoria INT,
    p_codigo_barras VARCHAR,
    p_precio_venta DECIMAL,
    p_cantidad_stock INT,
    p_estado SMALLINT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado)
    VALUES (p_nombre, p_id_categoria, p_codigo_barras, p_precio_venta, p_cantidad_stock, p_estado);
END;
$$ LANGUAGE plpgsql;


SELECT insertar_producto(
    'Laptop',
    1,
    '123456789012',
    1500.00,
    50,
    1
);


CREATE FUNCTION actualizar_producto(
    p_id INT,
    p_nombre VARCHAR,
    p_id_categoria INT,
    p_codigo_barras VARCHAR,
    p_precio_venta DECIMAL,
    p_cantidad_stock INT,
    p_estado SMALLINT
) RETURNS VOID AS $$
BEGIN
    UPDATE productos
    SET nombre = p_nombre,
        id_categoria = p_id_categoria,
        codigo_barras = p_codigo_barras,
        precio_venta = p_precio_venta,
        cantidad_stock = p_cantidad_stock,
        estado = p_estado
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;


SELECT actualizar_producto(
    1,
    'Laptop Pro',
    1,
    '123456789012',
    1800.00,
    40,
    1
);


CREATE FUNCTION obtener_productos_por_categoria(
    p_id_categoria INT
) RETURNS TABLE(
    id INT,
    nombre VARCHAR,
    precio_venta DECIMAL,
    cantidad_stock INT,
    estado SMALLINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT id, nombre, precio_venta, cantidad_stock, estado
    FROM productos
    WHERE id_categoria = p_id_categoria;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM obtener_productos_por_categoria(1);

