SELECT productid,productname,companyname AS supplier
FROM products,suppliers
WHERE products.supplierid=suppliers.supplierid;