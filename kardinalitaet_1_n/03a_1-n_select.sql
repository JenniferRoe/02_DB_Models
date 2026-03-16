\! cls
# 04 SELECTS

# Einzeltabellen
SELECT * FROM design.catmoms;
SELECT * FROM design.kittens;

# Inner Join 1 / Gesamte Kombi-Tabelle
SELECT
    *
FROM design.catmoms INNER JOIN design.kittens
ON design.catmoms.id = design.kittens.catmoms_id
; 

# Inner Join 2 / Verwandschaft
# "X ist die Mutter von Y"
SELECT
    catmoms.cat_name AS Katzen,
    CONCAT(catmoms.cat_name, " ist die Mutter von ", kittens.kitten_name) Verwandschaft
FROM design.catmoms INNER JOIN design.kittens
ON design.catmoms.id = design.kittens.catmoms_id
;

# Inner Join 3 / Wieviel Kinder haben die Katzen?
SELECT
    cat_name AS Katzen, -- nicht aggregiert / organisch
    COUNT(cat_name) Kinderzahl -- aggregiert / f()
FROM design.catmoms INNER JOIN design.kittens
ON design.catmoms.id = design.kittens.catmoms_id
GROUP BY cat_name -- Wichtig bei Kombi Aggr./Nicht-Aggr.
;