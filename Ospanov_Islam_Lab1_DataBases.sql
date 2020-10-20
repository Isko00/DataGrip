--1
create database laboratory_work1;

--2
create table adminstrators (
    num serial,
    first_name varchar(50),
    last_name varchar(50),
    middle_name varchar(50),
    birth_date date
);

--3
alter table adminstrators
    add admin_group INT,
    add salary INT;

--4
alter table adminstrators
    alter column admin_group type boolean using admin_group::boolean;

--5
alter table adminstrators
    alter column admin_group set default false,
    alter column salary set default 100000;

--6
alter table adminstrators
    add primary key (num);

--7
create table jobs (
    num serial,
    name varchar(50),
    adminstrator_num int,
    description varchar(50)
);

insert into jobs(name, adminstrator_num, description)
    values ('Kasym', 1, 'zakazyvai');

--8
drop table jobs;

--9
drop database laboratory_work1;

--additional
DROP TABLE adminstrators;


--task


select * from adminstrators;