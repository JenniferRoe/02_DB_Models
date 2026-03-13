\! cls 
-- SELECTS
SELECT * FROM design.cats;
SELECT * FROM design.servants;

-- Einzeltabellen
-- Alle Katzen mit bestimmtem Namen
SELECT * 
FROM design.cats
WHERE cat_name = 'Grizabella';

-- Alle Diener mit mehr als 5 Jahren Dienstzeit
SELECT *
FROM design.servants
WHERE yrs_served > 5;


-- Kreuzprodukt (Kartesisches Produkt)


-- Inner Join 1 / Gesamte Tabelle



-- Inner Join 2 / (Wer dient wem?)
-- Wer dient Grizabella?
-- Wem dient X?




-- Inner Join 2a / (Wer dient wem?)
-- "X ist der Diener von Y"  / Dienstverhältnis




-- Inner Join 3 / Dienstzeit


-- Inner Join 4 / Dienstzeit 
-- "X - der Diener von Y - ist der Diener mit der längsten Dienstzeit" // MAX()



-- 1. LIMIT (QUICK & DIRTY / Nur bei einem MAX-Wert vollständige Lösung)




-- 2. Subquery

-- QUERY / MAX()
-- SELECT MAX(yrs_served) FROM design.servants;





-- 3. VIEW / QUERY / MAX() in VIEW gekapselt
