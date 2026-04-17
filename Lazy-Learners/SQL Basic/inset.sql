select * from Customer;


---Insert data into the table 

Insert into Customer 
Values (1, 'Smith', 'John', 'jsmith34@gmail.com', '6302541234');

Insert into Customer 
Values (3, 'Paterson', 'John', 'jpaterson@gmail.com', '3247867878');

Insert into Customer (cust_Id, LastName, FirstName, phone)
Values(2, 'Wilson', 'Amy', '4358971256');

----Update table 
Update Customer 
Set email = 'awilson25@yahoo.com'
Where cust_Id = 2; 

--- Delete a record from the table 
Delete from Customer 
where FirstName = 'John';

---Deleting all the data from the table 
Truncate table Customer; 