Select * from sales.customers


--Returns the customers whose firstname starts with the letter 'E'
Select * from sales.customers
where first_name like 'e%';


--Returns the customers whose firstname ends with the letter 'n'
Select * from sales.customers
where first_name like '%n';

--Returns the customers whose firstname contains the pattern 'man'
Select * from sales.customers
where first_name like '%man%';


--Returns the customers whose firstname second letter is 'a'
Select * from sales.customers
where first_name like '__r%';

--Returns the customers who resides in the cities of Kingston, Woodside and Sugar Land. 
Select * from sales.customers
where city In ('Kingston', 'Woodside', 'Sugar Land') 
Order by state;

--Returns the customers whose phone number is null

Select * from sales.customers
Where phone is null;

--Returns the customers whose phone number exists
Select * from sales.customers
Where phone is not null;


--Returns the customer whose phone number and state exists
Select * from sales.customers
Where phone is not null and state is not null;