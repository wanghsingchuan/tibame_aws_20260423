-- 使用指定資料庫
use bookshop; 
select * from order_master;
-- 先利用下列指令新增多筆資料，否則rows數量差異不大
insert into order_master(customer_id)
values
('C001'), ('C001'), ('C001'), ('C001'), ('C001'), ('C001'), ('C001'), ('C001'), ('C001'), ('C001'), 
('C002'), ('C002'), ('C002'), ('C002'), ('C002'), ('C002'), ('C002'), ('C002'), ('C002'), ('C002'); 
select * from order_master where customer_id = 'C001' and order_date between '2019-1-1' and '2019-12-31';

-- Ex7-1 
explain select * from order_master 
where customer_id = 'C001' and order_date between '2019-1-1' and '2019-12-31';

explain analyze select * from order_master 
where customer_id = 'C001' and order_date between '2019-1-1' and '2019-12-31';

create index idx_order_customer_id_date on order_master(customer_id, order_date);
drop index idx_order_customer_id_date on order_master;

show index from order_master;


