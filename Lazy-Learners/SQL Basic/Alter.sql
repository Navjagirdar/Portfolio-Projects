Select * from Customer;



--To Add a column 

Alter table Customer 
Add email varchar(50);


--To Modify a column 
Alter table Customer 
Alter Column email varchar(20);



--To Drop a column 
Alter table Customer 
Drop Column phone;



--To Rename a column 
Exec sp_rename 'Customer.custlname', 'LastName';




--To Drop a table 
Drop table demo_order;
