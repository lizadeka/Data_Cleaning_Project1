use cleaning_project_1;
create table orders_raw (
    order_id varchar(20),
    customer_name varchar(50),
    email varchar(40),
    city varchar(20),
    order_date varchar(20),
    amount varchar(20)
);

create table orders_cleaned as
select * from orders_raw;