--Distinct Keyword 
Select * from production.products;

--Retrieves the list of unique products 
Select Distinct product_name 
from production.products;

Select Distinct city 
from sales.customers
Where state = 'TX';
--Retrieves the top 5 highest revenue generating orders after discount
Select Top 5 *, (quantity*list_price)*(1-discount) as OrderPrice
from sales.order_items
Order by OrderPrice desc;


--Retrieves the top 2 percent of highest revenue generating orders after discount
Select Top 2 percent *, (quantity*list_price)*(1-discount) as OrderPrice
from sales.order_items
Order by OrderPrice desc;

--Retrieves the 2nd to 6th highest grossing orders after discount 
Select *, (quantity*list_price)*(1-discount) as OrderPrice
from sales.order_items
Order by OrderPrice desc
Offset 1 Rows
Fetch Next 5 Rows Only;