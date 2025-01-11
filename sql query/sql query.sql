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



















































