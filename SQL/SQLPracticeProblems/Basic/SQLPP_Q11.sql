SELECT firstname,lastname,title,
dateonlybirthdate=convert(date,birthdate)
FROM employees
ORDER BY birthdate;
