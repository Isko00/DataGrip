create database task1;

create table islamtask (
    num serial,
    first_name varchar(50),
    last_name varchar(50),
    middle_name varchar(50),
    birth_date date
);

alter table islamtask
    alter column country set default 'Kazakhstan';
    add column country varchar(50);

