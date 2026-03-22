-- Query1: Detect duplicate records
use cleaning_project_1;
select customer_name, email, city, order_date, amount, count(*)
from orders_cleaned
group by customer_name, email, city, order_date, amount
having count(*) > 1;

-- Query2: Remove duplicate recods

delete from orders_cleaned where order_id not in(

    select order_id from(
        select min(order_id) as order_id
        from orders_cleaned
        group by customer_name, email, city, order_date, amount) as temp
);

-- Query3: Find null emails
select * from orders_cleaned where email is null;

-- Fill null email as unknown@gmail.com
-- Query4: Replace missing email
update orders_cleaned
set email = "unknown@gmail.com"
where email is null;

-- Query5: Detect invalid emails
select * from orders_cleaned
where email not like "%@%.%";

-- Query6: Fix invalid emails
update orders_cleaned
set email = "rohit@gmail.com"
where order_id = 10;

-- Query7: Fix extra spaces in customer_name
update orders_cleaned
set customer_name = trim(customer_name);

-- Query8: Fix city spelling mistakes
update orders_cleaned
set city = "Mumbai"
where city = "Mum bai";

-- Query9: Remove extra space in city column
update orders_cleaned
set city = trim(city);

-- Query10: Fix date format(yyyy-dd-mm)
update orders_cleaned
set order_date = str_to_date(order_date, "%Y-%d-%m")
where order_date regexp "^[0-9]{4}-";

-- Query11: Fix date format(mm-dd-yyyy)
update orders_cleaned
set order_date = str_to_date(order_date, "%m-%d-%Y")
where order_date regexp "^[0-9]{2}-[1-3][0-9]-[0-9]{4}";

-- Query12: Fix date format(dd-mm-yyyy)
update orders_cleaned
set order_date = str_to_date(order_date, "%d-%m-%Y")
where order_date regexp "^[0-9]{2}-[0-9]{2}-[0-9]{4}";

-- Query13: Find missing dates
select * from orders_cleaned where order_date is null;

-- Query14: Replace missing date (2024-01-01)
update orders_cleaned
set order_date = "2024-01-01"
where order_date is null;

-- Query15: Fix negavtive amounts
update orders_cleaned
set amount = abs(amount)
where amount < 0;

-- query16: Fix null amount(with 0)
update orders_cleaned
set amount = 0
where amount is null;

describe orders_cleaned;
-- change the datatypes

alter table orders_cleaned
modify order_id int,
modify customer_name varchar(100),
modify email varchar(100),
modify city varchar(50),
modify order_date date,
modify amount int;