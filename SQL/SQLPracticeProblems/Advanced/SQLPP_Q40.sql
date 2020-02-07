Select OrderDetails.OrderID ,ProductID ,UnitPrice ,Quantity ,Discount
From OrderDetails Join
(Select Distinct OrderID 
From OrderDetails 
Where Quantity >= 60 
Group By OrderID, Quantity 
Having Count(*) = 2 ) PotentialProblemOrders
on PotentialProblemOrders.OrderID = OrderDetails.OrderID
Order by OrderID, ProductID;

/*Remember that you can use subqueries to create additional tables to join
with the original table included in the database*/