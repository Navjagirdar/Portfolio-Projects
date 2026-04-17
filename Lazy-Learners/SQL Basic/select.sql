Select * from sales.order_items;

--- Retrieving individual Columns; Alias 
Select order_id as OrderID, item_id as ItemID, quantity as Quantity from sales.order_items;


--- Where Clasue: Fetch records for ProductId = 10 
Select * from sales.order_items
Where product_id = 10;

---Fetch records where list_price > 1000
Select * from sales.order_items
where list_price > 1000
Order by list_price desc;

--Fetch records where list_price between 500 and 1000
Select * from sales.order_items
where list_price between 500 and 1000
Order by 5 desc ;

--Fetch records where itemId = 3 and listPrice > 500 

Select * from sales.order_items
where item_id = 3 and list_price > 500
Order by 5  ;

--Fetch records where itemId = 2 or dicount = 10%
Select * from sales.order_items
Where discount = 0.10 or item_id = 2
order by item_id;

--Fetch records where discount = 10 % and listPrice between 500 and 1000
Select * from sales.order_items
where discount = 0.10 and (list_price between 500 and 1000) 
Order by list_price;

--Fetch records where orderId is not 1 and 2
Select * from sales.order_items
Where not order_id = 1 and not order_id = 2 
Order by 1; 