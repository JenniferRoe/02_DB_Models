\! cls
-- 3b SELECTS 1:1 / n:m

-- 1. JOIN 
SELECT
	*
FROM design.purchases
INNER JOIN design.servants 
    ON design.servants.id = design.purchases.servants_id
INNER JOIN design.products 
    ON design.products.id = design.purchases.products_id
INNER JOIN design.cats 
    ON design.cats.id = design.servants.cats_id
;


-- 2. Wer bekommt den Lachs? 
-- SELECT
--     servant_name, product_name  
-- FROM design.purchases
-- INNER JOIN design.servants 
--     ON design.servants.id = design.purchases.servants_id
-- INNER JOIN design.products
--     ON design.products.id = design.purchases.products_id
-- WHERE product_name = "Whiskas|Lachs"
-- ;




-- 2a. Wer bekommt den Lachs? 

-- SELECT
-- 	concat(
-- 			servant_name, 
--             " ist der Diener von ", 
--             cat_name,", er kauft ",
--             product_name, 
--             "- somit bekommt ",
--             cat_name, " den Lachs."
--             ) 
--             AS "Wer bekommt den Lachs?"
-- FROM design.purchases
-- INNER JOIN design.servants ON design.servants.id = design.purchases.servants_id
-- INNER JOIN design.products ON design.products.id = design.purchases.products_id
-- INNER JOIN design.cats ON design.cats.id = design.servants.cats_id
-- WHERE product_name LIKE "%Lachs%" -- irgendwas mit Lachs...
-- ;



-- 2b. Variante mit einer VIEW
# 2b. Variante mit einer VIEW
CREATE OR REPLACE VIEW design.who_purchased_salmon AS
	SELECT
		servant_name AS Diener,
		cats_id
	FROM design.purchases
	INNER JOIN design.servants ON design.servants.id = design.purchases.servants_id
	INNER JOIN design.products ON design.products.id = design.purchases.products_id
	WHERE product_name LIKE "%Lachs%" -- irgendwas mit Lachs...
;

SELECT * FROM design.who_purchased_salmon;









