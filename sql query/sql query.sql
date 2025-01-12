select *from employes; 
select distinct dept from employes;
alter table employes add column age int not null default 20
alter table employes drop column age;
alter table employes rename column id to employid;
update employes set salary=4000 where emp_id=4;
alter table employes alter column fname set data type varchar(150);
alter table employes alter column lname set default 'unkown';
alter table employes alter column salary set not null;
alter table employes alter column lname drop default;
alter table employes drop  column contact;
ALTER TABLE employes ADD COLUMN contact VARCHAR(15) UNIQUE;
INSERT INTO employes (fname,lname,email,dept,salary,hire_date,contact) 
VALUES ('john','deo','j1324@jgmail.com','finance',5000,'2024-01-11','12345678900000');
alter table employes drop constraint employes_contact_check;
alter table employes drop column contact;
alter table employes add constraint contact check(length(contact)<=10);
select fname,salary,case
when salary>=50000 then 'High' else 'Low' end as salary_categoriy from employes;


select fname,salary,case
when salary>0 then round(salary*.10) end as salary_bouns from employes

create table student(sid serial primary key ,name varchar(100) not null);
create table course(cid serial primary key,name varchar(30) not null,fee numeric not null);
create table enrollment
(enrollid serial primary key,
sid int not null,
cid int not null,
enroll_date date default current_date,
foreign key (sid)references student(sid),
foreign key (cid)references course(cid)

);
insert into student(name)values('jamil'),('anees'),('haseeb'),('majid');
insert into course(name,fee)values('Math',400.0),('Physics',300.0),('Chemistry',500.0),('Computer',1000.00);
insert into enrollment(sid,cid)values(1,1),(2,2),(3,3),(4,4);

select s.name,c.name, c.fee, e.enroll_date from enrollment e join  student s on e.sid=s.sid join course c on e.cid=c.cid;

insert into customer(name,email)values('haseeb','haseeb#gmail.com'),('majid','majid@gmail.com');
select * from customer cross join orders;
insert into orders(ord_price,custid) values(100.00,3);
select*from customer c left join orders o on c.custid=o.custid;
select *from orders o left join customer c on o.custid=c.custid;


create table customers
(custid serial primary key,name varchar(100) not null);

create table orders
(ordid serial primary key  
,ord_date date default current_date,
custid int not null,
foreign key (custid)references customers(custid)
);
create table products
(p_id serial primary key,
p_name varchar(100)not null,
price numeric not null
);

create table ord_items
(item_id serial,
ordid int not null,
p_id int not null,
quantity int not null,
foreign key (ordid)references orders(ordid),
foreign key (p_id) references products(p_id)

);

select     
c.name as name,
o.ord_date as order_date,
p.p_name as product,
p.price as price,
oi.quantity as quantity,
(p.price * oi.quantity) AS total_price
from ord_items oi join products p on oi.p_id=p.p_id
join orders o on oi.ordid=o.ordid
join customers c on o.custid=c.custid

insert into customers(name) values('majid'),('waleed');
insert into orders(custid)values(4),(5);
insert into products(p_name,price)values('bat',1200),('ball',500);
insert into ord_items(ordid,p_id,quantity)values(4,4,2),(5,5,2);


insert into customers(name) values('khalid'),('saleh');
insert into orders(custid)values(6),(7);
insert into products(p_name,price)values('jeans',1600),('shoe',1500);
insert into ord_items(ordid,p_id,quantity)values(6,6,2),(7,7,2);

 select product,sum(total_price) from billing_info group by product
 having sum(total_price)>=1000;

select
coalesce(product,'Total'),
sum(total_price) as amount
from billing_info group by rollup(product) order by  amount


-- store proceducre

create or replace procedure add_employee(
fname varchar,
lname varchar,
email varchar,
dept varchar,
salary int
)

language plpgsql
as $$
begin
insert into employes(fname,lname,email,dept,salary,hire_date)
values(fname,lname,email,dept,salary,hire_date);
end;
$$

call add_employee('loss','anle','loss@gmail.com','finance',4000);
select *from employes;

select distinct dept from employes;

select e.employid,
e.fname,
e.salary
from employes e where e.dept='cse' and e.salary=(select max(emp.salary)from employes emp where emp.dept='cse')


select e.employid,e.fname,e.salary from employes e where e.dept='cse' and e.salary=(select max(emp.salary) from employes emp where emp.dept='cse')
-- // function
create or replace function dept_max_salary(dept_name varchar)
returns  table(employid int,fname varchar,salary int)
as $$
begin
return query
select e.employid,e.fname,e.salary from employes e
where e.dept=dept_name and e.salary=(
select max(emp.salary) from employes emp where emp.dept=dept_name
);
end;
$$ language plpgsql;

select * from dept_max_salary('finance')









































