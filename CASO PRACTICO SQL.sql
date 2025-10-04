--menu_items

--Explorar la tabla “menu_items” para conocer los productos del menú.
SELECT * FROM menu_items;

--Encontrar el número de artículos en el menú.
SELECT COUNT (menu_item_id) 
FROM menu_items;

--¿Cuál es el artículo menos caro y el más caro en el menú?
SELECT item_name, price FROM menu_items 
ORDER BY price DESC
LIMIT 1;

SELECT item_name, price FROM menu_items 
ORDER BY price
LIMIT 1;

SELECT item_name, price FROM menu_items 
WHERE price IN (SELECT MIN (price) FROM menu_items)
UNION ALL
SELECT item_name, price FROM menu_items 
WHERE price IN (SELECT MAX (price) FROM menu_items);

--¿Cuántos platos americanos hay en el menú?
SELECT category, COUNT (menu_item_id)
FROM menu_items
GROUP BY 1;

SELECT COUNT(menu_item_id) FROM menu_items
WHERE (category= 'American');

--¿Cuál es el precio promedio de los platos?
SELECT ROUND(AVG (price),2) FROM menu_items;


--order_details
--Explorar la tabla “order_details” para conocer los datos que han sido recolectados

SELECT * FROM order_details;

--¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT(DISTINCT (order_id))
FROM order_details; 

--¿Cuáles son los 7 pedidos que tuvieron el mayor número de artículos?
SELECT order_id AS orden, COUNT(item_id) AS recuento_platillos FROM order_details
GROUP BY 1
ORDER BY 2 DESC
LIMIT 7;

--¿Cuándo se realizó el primer pedido y el último pedido?
SELECT MIN (order_date) AS primer_pedido, MAX (order_date) AS ultimo_pedido
FROM order_details;

--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
SELECT COUNT (DISTINCT order_id)
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';

--ANALISIS
SELECT * FROM order_details AS Ordenes
LEFT JOIN menu_items AS Menu
ON Ordenes.item_id=Menu.Menu_item_id;

--Que tipo de comida fue la que mas dinero recauDo en el mes de Febrero y cuanto fue lo que recaudo?
SELECT category as categoria, ROUND(SUM(price),0) as ventas 
FROM order_details,menu_items
WHERE order_date BETWEEN '2023-02-01' AND '2023-02-28'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--¿En que mes se vendio mas?
SELECT EXTRACT(MONTH FROM order_date) AS mes,SUM(price) AS total_de_ventas
FROM order_details,menu_items
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY 2 DESC
LIMIT 1;

--¿Que item del menu tuvo mas ganancias en el primer mes del restaurante?
SELECT item_name as producto, ROUND(SUM (price),2)
FROM order_details, menu_items
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY item_name
ORDER BY 2 DESC
LIMIT 1;

--¿Cual fue el mes en el que mas ordenes hubieron?
SELECT COUNT(DISTINCT order_id),EXTRACT(MONTH FROM order_date) AS mes
FROM order_details,menu_items
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY 1 DESC
LIMIT 1;

--¿Cuanto se vendio el 14 de febrero?
SELECT EXTRACT(MONTH FROM order_date) AS mes,SUM(price) AS total_de_ventas
FROM order_details,menu_items
WHERE EXTRACT(DAY FROM order_date)=14
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY 2 DESC;

