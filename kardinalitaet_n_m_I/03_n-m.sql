\! cls

# Vorbereitung

SET NAMES utf8mb4;

DROP TABLE IF EXISTS design.purchases;
DROP TABLE IF EXISTS design.products;
DROP TABLE IF EXISTS design.servants;

/* SERVANTS */
-- Servants: ohne Fremdschlüssel
CREATE TABLE design.servants
(
  id INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
  servant_name VARCHAR(45) NOT NULL,
  yrs_served TINYINT NOT NULL,
  PRIMARY KEY (id)
) COMMENT 'Tab. der Diener';

-- Servants: Struktur
DESCRIBE design.servants;

-- Servants: Inserts
# Servants: Inserts
INSERT INTO design.servants (id, servant_name, yrs_served) VALUES (DEFAULT, "Max", 5);
INSERT INTO design.servants (id, servant_name, yrs_served) VALUES (DEFAULT, "Maxine", 3);

-- Servants: Inhalte 
SELECT * FROM design.servants;


/*  PRODUCTS */

-- Products: ohne Fremdschlüssel
CREATE TABLE design.products
(
  id INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
  product_name  VARCHAR(45)  NOT NULL,
  product_price DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (id)
) COMMENT 'Tab. der Produkte';

-- Products: Struktur
DESCRIBE design.products;

-- Products: Inserts
INSERT INTO design.products (id, product_name, product_price) VALUES 
(DEFAULT, "Whiskas|Lachs", 2.75),
(DEFAULT, "Whiskas|Huhn", 2.80),
(DEFAULT, "Felix|Jelly", 3.75),
(DEFAULT, "Felix|Sauce", 3.80);

-- Products: Inhalte 
SELECT * FROM design.products;


/*  PURCHASES (Kaufprozesse)*/
-- ServantsProducts (purchases)
CREATE TABLE design.purchases
(
  id INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
  servants_id INT NOT NULL COMMENT 'FK von servants',
  products_id INT NOT NULL COMMENT 'FK  von products',
  p_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) COMMENT 'Kaufhandlungen';

-- fks
ALTER TABLE design.purchases
  ADD CONSTRAINT FK_servants_TO_purchases
    FOREIGN KEY (servants_id)
    REFERENCES design.servants (id);

ALTER TABLE design.purchases
  ADD CONSTRAINT FK_products_TO_purchases
    FOREIGN KEY (products_id)
    REFERENCES design.products (id);

-- Purchases: Struktur
DESCRIBE design.purchases;

-- Purchases: Inserts (Kaufprozesse : Käufer - Produkt)
-- INSERT INTO design.purchases (id, servants_id, products_id, p_time) VALUES 
-- (DEFAULT, 1 , 2, DEFAULT),
-- (DEFAULT, 1, 3, DEFAULT), 
-- (DEFAULT, 2, 1, DEFAULT),
-- (DEFAULT, 2, 2, DEFAULT),
-- (DEFAULT, 2, 3, DEFAULT),
-- (DEFAULT, 2, 4, DEFAULT);

INSERT INTO design.purchases (id, servants_id, products_id, p_time) VALUES 
(DEFAULT, 1, 2, CURRENT_TIMESTAMP),
(DEFAULT, 1, 3, TIMESTAMPADD(MINUTE, 12, CURRENT_TIMESTAMP)),
(DEFAULT, 2, 1, TIMESTAMPADD(MINUTE, 24, CURRENT_TIMESTAMP)),
(DEFAULT, 2, 2, TIMESTAMPADD(MINUTE, 36, CURRENT_TIMESTAMP)),
(DEFAULT, 2, 3, TIMESTAMPADD(MINUTE, 48, CURRENT_TIMESTAMP)),
(DEFAULT, 2, 4, TIMESTAMPADD(MINUTE, 60, CURRENT_TIMESTAMP));

-- Purchases: Inhalte 
SELECT * FROM design.purchases;
