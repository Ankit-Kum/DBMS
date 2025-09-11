use classicmodels;
select * from customers;
alter table customers add column Email varchar(50);
update customers set email= concat(Lower(Trim(contactFirstName)),'.',Lower(Trim(contactLastName)),'@gmail.com') where customerNumber>0;
#alter table customers drop column Email;
#Question-1
select contactFirstName,contactLastName,Email from customers;
# Question-2
select count(customerNumber) from customers;

#Question-3
alter table customers add column registered varchar(50);
update customers set registered=date_format(date_add('2019-01-01',interval floor(rand()*datediff('2021-12-31','2019-01-01')) Day), '%M %d, %Y') where customerNumber>0;
select contactFirstName,contactLastName from customers where country="USA" and str_to_date(registered,'%M %d, %Y')>"2020-01-01";
#alter table customers drop column registered;

#Question-4
select distinct(state) from customers;

#Question-5
select Email from customers where city="New York" or city="Los Angeles";

#Question-6
select contactFirstName,contactLastname from customers where contactLastName like 'S%';

#Question-7
select contactFirstName,contactLastName,Email from customers where state="Texas" and str_to_date(registered,'%M %d, %Y') between '2021-01-01' and '2021-12-31';

#Question-8
select contactFirstName,contactLastName,registered from customers where str_to_date(registered,'%M %d, %Y') between '2021-01-01' and '2021-12-31';

#Question-9
select contactFirstName,contactLastName from customers where contactLastName="Smith";

#Question 10
select distinct city from customers order by city;
select contactFirstName,contactLastName,email from customers where str_to_date(registered,'%M %d, %Y') > '2022-01-01' and city="Chicago";

#Question 11
select contactFirstName,contactLastName from customers where (state="Florida" or state="California")  and str_to_date(registered,'%M %d, %Y') >= '2021-01-01';

#Question 12
select contactFirstName,contactLastName,email from customers where YEAR(STR_TO_DATE(registered, '%M %d, %Y')) = 2020 and str_to_date(registered,'%M %d, %Y') >= '2020-01-15';