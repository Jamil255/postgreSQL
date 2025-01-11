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
















































