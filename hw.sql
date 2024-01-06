/* 1 часть:
1. Выбрать все заказы из стран France, Austria, Spain */
SELECT *
FROM orders WHERE ship_country IN ('France', 'Austria', 'Spain')
/* 2. Выбрать все заказы, отсортировать по required_date (по убыванию) и отсортировать по дате отгрузке (по возрастанию) */
SELECT *
FROM orders ORDER BY required_date DESC, shipped_date
/* 3. Выбрать минимальное кол-во  единиц товара среди тех продуктов, которых в продаже более 30 единиц. */
SELECT MIN(unit_price)
FROM products WHERE units_in_stock > 30
/* 4. Выбрать максимальное кол-во единиц товара среди тех продуктов, которых в продаже более 30 единиц. */
SELECT MAX(units_in_stock)
FROM products WHERE unit_price > 30
/* 5. Найти среднее значение дней уходящих на доставку с даты формирования заказа в USA */
SELECT AVG(shipped_date - order_date)
FROM orders WHERE ship_country = 'USA'
/* 6. Найти сумму, на которую имеется товаров (кол-во * цену) причём таких, которые планируется продавать и в будущем (см. на поле discontinued) */
SELECT SUM(units_in_stock * unit_price)
FROM products WHERE discontinued <> 0
/* 2 часть:
7. Выбрать все записи заказов в которых наименование страны отгрузки начинается с 'U' */
SELECT *
FROM orders WHERE ship_country LIKE 'U%'
/* 8. Выбрать записи заказов (включить колонки идентификатора заказа, идентификатора заказчика, веса и страны отгузки), которые должны быть отгружены в страны имя которых начинается с 'N', отсортировать по весу (по убыванию) и вывести только первые 10 записей. */
SELECT order_id, customer_id, freight, ship_country
FROM orders
WHERE ship_country LIKE 'N%'
ORDER BY freight DESC
LIMIT 10
/* 9. Выбрать записи работников (включить колонки имени, фамилии, телефона, региона) в которых регион неизвестен */
SELECT first_name, last_name, home_phone, region
FROM employees WHERE region IS NULL
/* 10. Подсчитать кол-во заказчиков регион которых известен */
SELECT COUNT(*)
FROM customers WHERE region IS NOT NULL
/* 11. Подсчитать кол-во поставщиков в каждой из стран и отсортировать результаты группировки по убыванию кол-ва */
SELECT country, COUNT(*)
FROM suppliers GROUP BY country ORDER BY COUNT(*) DESC
/* 12. Подсчитать суммарный вес заказов (в которых известен регион) по странам, затем отфильтровать по суммарному весу (вывести только те записи где суммарный вес больше 2750) и отсортировать по убыванию суммарного веса. */
SELECT ship_country, SUM(freight)
FROM orders WHERE ship_region IS NOT NULL GROUP BY ship_country HAVING SUM(freight) > 2750 ORDER BY SUM(freight) DESC
/* 13. Выбрать все уникальные страны заказчиков и поставщиков и отсортировать страны по возрастанию */
SELECT country
FROM customers UNION SELECT country FROM suppliers ORDER BY country
/* 14. Выбрать такие страны в которых "зарегистированы" одновременно и заказчики и поставщики и работники. */
SELECT country
FROM customers INTERSECT SELECT country FROM suppliers INTERSECT SELECT country FROM employees ORDER BY country
/* 15. Выбрать такие страны в которых "зарегистированы" одновременно заказчики и поставщики, но при этом в них не "зарегистрированы" работники. */
SELECT country
FROM customers INTERSECT SELECT country FROM suppliers EXCEPT SELECT country FROM employees ORDER BY country