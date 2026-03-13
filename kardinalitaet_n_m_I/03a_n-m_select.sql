\! cls
# SELECTS

# Einzeltabellen
-- SELECT * FROM design.cats;
-- SELECT * FROM design.servants;


# Kreuzprodukt (Kartesisches Produkt)
-- SELECT * FROM design.cats JOIN design.servants
-- order by design.cats.id ASC;


-- INNER JOIN / Kombination (cats + servants)
-- SELECT *  
-- FROM design.cats 
-- INNER JOIN design.servants
-- ON design.cats.id = design.servants.cats_id
-- ORDER BY design.cats.id ASC;'

-- Inner Joint 2 / Wer dient wem?
-- SELECT 
--     cat_name AS "Katzenherrschaft",
--     servant_name AS "Diener",
--     yrs_served AS "Dienstjahre"
-- FROM design.cats
-- INNER JOIN design.servants
-- ON design.cats.id = design.servants.cats_id

-- WHERE servant_name = 'Jocelyn'
-- ORDER BY yrs_served DESC;

-- Inner Joint 2a / Wer dient wem? (mit LIKE)
-- SELECT 
--     CONCAT(servant_name, " ist der Herrschafter von ", cat_name) AS "Diener-Katzen-Beziehung",
--     yrs_served AS "Dienstjahre"
-- FROM design.cats
-- INNER JOIN design.servants
-- ON design.cats.id = design.servants.cats_id
-- WHERE servant_name LIKE 'Jocelyn'
-- ORDER BY yrs_served DESC;

-- Inner Joint 3 / Wer dient am längsten?
-- SELECT *
-- FROM design.servants
-- INNER JOIN design.cats
-- ON design.servants.cats_id = design.cats.id
-- ORDER BY design.servants.yrs_served DESC;

-- Subquery / Wer dient am längsten?

-- SELECT
--     -- yrs_served AS Dienstzeit,
--     CONCAT(servant_name, " - der Diener von ", cat_name, " - ist der Diener mit der laengsten Dienstzeit") AS Dienstzeit
-- FROM design.cats INNER JOIN design.servants
-- ON design.cats.id = design.servants.cats_id
-- ORDER BY yrs_served DESC
-- LIMIT 1
-- ;


SELECT
    yrs_served AS Zeit,
    CONCAT(servant_name, " - der Diener von ", cat_name, " - ist der Diener mit der laengsten Dienstzeit") AS Dienstzeit
FROM design.cats INNER JOIN design.servants
ON design.cats.id = design.servants.cats_id
WHERE yrs_served = (SELECT MAX(yrs_served) FROM design.servants)
;


DROP VIEW IF EXISTS design.max_time;

CREATE VIEW design.max_time AS 
SELECT 
    MAX(yrs_served) AS Test
FROM design.servants;

SELECT * FROM design.max_time;

SELECT
    yrs_served AS Zeit,
    CONCAT(servant_name, " - der Diener von ", cat_name, " - ist der Diener mit der laengsten Dienstzeit") AS Dienstzeit
FROM design.cats INNER JOIN design.servants
ON design.cats.id = design.servants.cats_id
WHERE yrs_served = (SELECT * FROM design.max_time)
;


/*\! cls



DROP TABLE IF EXISTS design.purchases;
DROP TABLE IF EXISTS design.products;
DROP TABLE IF EXISTS design.servants;





--TABELLE servants


CREATE TABLE design.servants
(
    id INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
    servant_name VARCHAR(45) NOT NULL,
    yrs_served TINYINT NOT NULL,
    PRIMARY KEY (id)
) COMMENT 'Tabelle der Diener';

DESCRIBE design.servants;

INSERT INTO design.servants (id, servant_name, yrs_served)
VALUES
(DEFAULT, 'Jocelyn', 11),
(DEFAULT, 'Jeremiah', 8);

SELECT * 
FROM design.servants;





--TABELLE products


CREATE TABLE design.products
(
    id INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
    product_name VARCHAR(45) NOT NULL,
    product_price DECIMAL(4,2) NOT NULL,
    PRIMARY KEY (id)
) COMMENT 'Tabelle der Produkte';

DESCRIBE design.products;

INSERT INTO design.products (id, product_name, product_price)
VALUES
(DEFAULT, 'WhiskasLachs', 2.75),
(DEFAULT, 'WhiskasHuhn', 2.80),
(DEFAULT, 'FelixJelly', 3.75),
(DEFAULT, 'FelixSauce', 3.80);

SELECT * 
FROM design.products;





-- TABELLE purchases


CREATE TABLE design.purchases
(
    id INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
    servants_id INT NOT NULL,
    products_id INT NOT NULL,
    p_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),

    CONSTRAINT fk_purchases_servants
        FOREIGN KEY (servants_id) REFERENCES design.servants(id),

    CONSTRAINT fk_purchases_products
        FOREIGN KEY (products_id) REFERENCES design.products(id)
) COMMENT 'Tabelle der Käufe';

DESCRIBE design.purchases;

INSERT INTO design.purchases (id, servants_id, products_id, p_time)
VALUES
(DEFAULT, 1, 2, '2026-03-13 09:52:20'),
(DEFAULT, 1, 3, '2026-03-13 10:04:20'),
(DEFAULT, 2, 1, '2026-03-13 10:16:20'),
(DEFAULT, 2, 2, '2026-03-13 10:28:20'),
(DEFAULT, 2, 3, '2026-03-13 10:40:20'),
(DEFAULT, 2, 4, '2026-03-13 10:52:20');

SELECT * 
FROM design.purchases;


-- EINZELTABELLEN


SELECT *
FROM design.servants;

SELECT *
FROM design.products;

SELECT *
FROM design.purchases;






--INNER JOIN / KOMBINATION (servants + purchases + products)


SELECT
    s.servant_name AS diener,
    s.yrs_served AS dienstjahre,
    pr.product_name AS produkt,
    pr.product_price AS preis,
    pu.p_time AS kaufzeit
FROM design.purchases pu

INNER JOIN design.servants s
    ON pu.servants_id = s.id

INNER JOIN design.products pr
    ON pu.products_id = pr.id

ORDER BY pu.p_time;



-- WELCHE ARTIKEL HAT X / Y GEKAUFT?
--  Beispiel: Max


SELECT
    s.servant_name AS diener,
    pr.product_name AS produkt,
    pr.product_price AS preis,
    pu.p_time AS kaufzeit
FROM design.purchases pu

INNER JOIN design.servants s
    ON pu.servants_id = s.id

INNER JOIN design.products pr
    ON pu.products_id = pr.id

WHERE s.servant_name = 'Max'
ORDER BY pu.p_time;





-- WIEVIELE PRODUKTE HAT X GEKAUFT?
   --"X kauft Y Produkte"

SELECT
    s.servant_name AS diener,
    COUNT(pu.id) AS anzahl_produkte
FROM design.purchases pu

INNER JOIN design.servants s
    ON pu.servants_id = s.id

GROUP BY s.id, s.servant_name
ORDER BY anzahl_produkte DESC;



-- WIEVIEL GELD HAT JEDER DIENER AUSGEGEBEN?

SELECT
    s.servant_name AS diener,
    COUNT(pu.id) AS anzahl_kaeufe,
    ROUND(SUM(pr.product_price), 2) AS gesamt_ausgegeben
FROM design.purchases pu

INNER JOIN design.servants s
    ON pu.servants_id = s.id

INNER JOIN design.products pr
    ON pu.products_id = pr.id

GROUP BY s.id, s.servant_name
ORDER BY gesamt_ausgegeben DESC;





-- WER HAT DAS PRODUKT X GEKAUFT?
  -- Beispiel mit exakt einem Produktnamen: WhiskasLachs
SELECT
    s.servant_name AS diener,
    pr.product_name AS produkt,
    pu.p_time AS kaufzeit
FROM design.purchases pu

INNER JOIN design.servants s
    ON pu.servants_id = s.id

INNER JOIN design.products pr
    ON pu.products_id = pr.id

WHERE pr.product_name = 'WhiskasLachs'
ORDER BY pu.p_time;





-- WER HAT PRODUKTE MIT BESTIMMTEM NAMEN GEKAUFT?
-- Beispiel mit LIKE: alles mit 'Lachs'


SELECT
    s.servant_name AS diener,
    pr.product_name AS produkt,
    pu.p_time AS kaufzeit

FROM design.purchases pu
INNER JOIN design.servants s
    ON pu.servants_id = s.id

INNER JOIN design.products pr
    ON pu.products_id = pr.id

WHERE pr.product_name LIKE '%Lachs%'
ORDER BY pu.p_time;





-- WER HAT PRODUKTE MIT 'Sauce' GEKAUFT?


SELECT
    s.servant_name AS diener,
    pr.product_name AS produkt,
    pu.p_time AS kaufzeit
FROM design.purchases pu

INNER JOIN design.servants s
    ON pu.servants_id = s.id

INNER JOIN design.products pr
    ON pu.products_id = pr.id

WHERE pr.product_name LIKE '%Sauce%'
ORDER BY pu.p_time;





-- WIE OFT WURDE PRODUKT X GEKAUFT?
-- Beispiel: WhiskasHuhn


SELECT
    pr.product_name AS produkt,
    COUNT(pu.id) AS anzahl_gekauft
FROM design.purchases pu

INNER JOIN design.products pr
    ON pu.products_id = pr.id

WHERE pr.product_name = 'WhiskasHuhn'
GROUP BY pr.id, pr.product_name;






-- WIE OFT WURDE JEDES PRODUKT GEKAUFT?

SELECT
    pr.product_name AS produkt,
    COUNT(pu.id) AS anzahl_gekauft
FROM design.purchases pu

INNER JOIN design.products pr
    ON pu.products_id = pr.id

GROUP BY pr.id, pr.product_name
ORDER BY anzahl_gekauft DESC, pr.product_name;





/*  WELCHEN UMSATZ HATTE PRODUKT X?
Beispiel: FelixJelly
Umsatz = Anzahl * Preis
 */
/*
SELECT
    pr.product_name AS produkt,
    COUNT(pu.id) AS anzahl_verkauft,
    pr.product_price AS einzelpreis,
    ROUND(COUNT(pu.id) * pr.product_price, 2) AS umsatz
FROM design.purchases pu

INNER JOIN design.products pr
    ON pu.products_id = pr.id
WHERE pr.product_name = 'FelixJelly'
GROUP BY pr.id, pr.product_name, pr.product_price;





-- UMSATZ ALLER PRODUKTE
 

SELECT
    pr.product_name AS produkt,
    COUNT(pu.id) AS anzahl_verkauft,
    pr.product_price AS einzelpreis,
    ROUND(SUM(pr.product_price), 2) AS umsatz
FROM design.purchases pu

INNER JOIN design.products pr
    ON pu.products_id = pr.id
GROUP BY pr.id, pr.product_name, pr.product_price
ORDER BY umsatz DESC;
/*