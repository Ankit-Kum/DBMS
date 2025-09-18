use classicmodels;

# Question-1
create table Student(
StudentID int primary key,
name varchar(50) not null,
age int check (age>=18 and age<=30),
city varchar(50) default "delhi"
);

#Question-2
Insert into Student(StudentID,name,age) values(1,"Faraz",20);
#Insert into Student(StudentID,name,age) values(1,"Faraz",10); # Throw Error for age constraint 
select * from Student;

#Question-3
create table Employee(
EmpID int primary key,
EmpName varchar(50) not null,
salary float check (salary>5000),
Department varchar(100) default "HR" 
);

#Question-4
Insert into Employee(EmpID,EmpName,salary) values(1,"Suhail",4000); #Throw Error because Salary is below 5000 violating check constraint.

#Question-5
create table Product(
ProductID int primary key,
ProductName varchar(50) not null,
Price float default 100,
Stock int check (Stock>=0)
);

#Question-6
Insert into Product(ProductID,ProductName,Stock) values(1,"Cat food",-2); #Throw Error Stock can not be negative

#Question-7
Insert into Product(ProductID,ProductName,Price,Stock) values(2,"dog food",null,200);
update Product set price=100 where ProductID>0 and price is null;

#Question-8
delete from  Student where age=25 and StudentID>0;

#Question-9
update Employee set Salary=4000 where EmpID>0; #Error Throw salary is below 5000

#Question-10
insert into Student(StudentID,age) values(3,29); #Throw Error Name can not be null

#Question-11
update Employee set Department="HR" where EmpID>0 ;

#Question-12
delete from Product where price=100 and ProductID>0;

#Question-13
create table Orders1(
OrderID int primary key,
Amount float check (Amount>0),
Discount float,
CustomerName Varchar(50) not null,
Constraint chk_discount check (Discount<Amount)
);