SELECT categoryname, COUNT(productid) AS totalproducts
FROM products, categories
WHERE products.categoryid=categories.categoryid
GROUP BY categoryname;