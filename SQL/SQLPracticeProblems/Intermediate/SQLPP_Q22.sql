SELECT productid, productname, unitsinstock, reorderlevel
FROM products
WHERE unitsinstock <= reorderlevel;