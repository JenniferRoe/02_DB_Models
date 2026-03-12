\! cls

-- Vorbereitungen

DROP TABLE IF EXISTS design.purchases;
DROP TABLE IF EXISTS design.products;
DROP TABLE IF EXISTS design.servants;
DROP TABLE IF EXISTS design.cats;


-- Mastertabelle (MT): unverändert

CREATE TABLE design.cats
(
  id INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
  cat_name  VARCHAR(45) NOT NULL COMMENT 'Name der Katze',
  fur_color VARCHAR(45) NOT NULL COMMENT 'Fellfarbe',
  PRIMARY KEY (id)
) COMMENT 'Entitätstyp(Datensatz)';


-- Struktur: MT
DESCRIBE design.cats;

-- Inserts: MT 

INSERT INTO design.cats (id, cat_name,fur_color) VALUES 
(DEFAULT, "Grizabella", "white"),
(DEFAULT, "Alonzo", "grey"),
(DEFAULT, "Mausi", "striped")
;



-- Inhalte: MT

SELECT * FROM design.cats;


-- Detailtabelle: Verbindung zur MT über Fremdschlüssel


CREATE TABLE design.servants
(
  id INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
  servant_name VARCHAR(45) NOT NULL,
  yrs_served TINYINT NOT NULL,
  cats_id INT NOT NULL COMMENT 'FK',
  PRIMARY KEY (id)
--  COMMENT 'Detailtabelle: Verbindung zur MT über Fremdschlüssel';
) COMMENT 'Entitätstyp(Datensatz)';

-- Fremdschlüssel: DT

ALTER TABLE design.servants
  ADD CONSTRAINT FK_cats_TO_servant
    FOREIGN KEY (cats_id)
    REFERENCES design.cats (id);

-- wichtig bei 1:1  UNIQUE im fk
ALTER TABLE design.servants
  ADD UNIQUE (cats_id);

-- Struktur: DT

DESCRIBE design.servants;

-- Inserts: DT
INSERT INTO design.servants (id, servant_name, yrs_served, cats_id) VALUES
(DEFAULT, "Jeremiah", 8, 1),
(DEFAULT, "Jocelyn", 11, 2),
(DEFAULT, "Isaiah", 2, 3)
;

-- Inhalte: DT

SELECT * FROM design.servants;