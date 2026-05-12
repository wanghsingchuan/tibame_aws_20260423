use bookshop;


-- Ex4-1
-- customer 表格新增 1 筆如下資料
-- customer_id = 'C001', customer_name = 'Jack', phone = '0987654321', address = 'Taipei'
insert into customer(customer_id, customer_name, phone, address) 
values('C001', 'Jack', '0987654321', 'Taipei');

insert into customer(customer_id, customer_name, phone, address) 
values('C002', 'Sue', '0912345678', 'Taipei');

insert into customer(customer_id, customer_name, phone, address) 
values('C003', 'Jason', '0927346211', 'Taoyuan'); 

select * from customer;

-- order_master 表格的 order_id 改採自動編號，然後 order_master 表格新增 1 筆資料
-- 使用 alter table 語法：先移除 FK 限制才能將 order_id 改為自動編號，最後再加回 FK 限制
-- 新增 1 筆 customer_id = 1 的資料至 order_master 表格內
-- 1. 先移除參照到order_mater.order_id的FK，否則會發生「Error Code: 1833. Cannot change column 'order_id'」錯誤
alter table order_detail drop foreign key fk_order_detail_order_master;
-- 2. order_id改為自動編號
alter table order_master
modify order_id bigint unsigned auto_increment;
-- 3. 加回FK限制
alter table order_detail add constraint fk_order_detail_order_master
foreign key(order_id) references order_master(order_id)
on delete cascade;

-- order_detail 表格新增 1 筆如下資料
-- order_id = 1, isbn = '9780596009205', quantity = 2
insert into order_master(customer_id) 
values('C001');

insert into order_master(customer_id) 
values('C002');

select * from order_master;

-- order_detail 表格新增 1 筆如下資料
-- order_id = 1, isbn = '9780596009205', quantity = 2
insert into order_detail(order_id, isbn, quantity)
values(1, '9780596009205', 2);

insert into order_detail(order_id, isbn, quantity)
values(1, '9780596809157', 1);

insert into order_detail(order_id, isbn, quantity)
values(2, '9781484226766', 1);

select * from order_detail;


-- Ex4-2
-- 將 customer 表格內 customer_id = 'C001' 的資料修改如下
-- customer_name = 'Ken', phone = '03-3456789', address = 'Taoyuan'
update customer set customer_name = 'Ken', phone = '03-3456789', address = 'Taoyuan'
where customer_id = 'C001';

select * from customer;

-- 將 order_detail 表格內 order_id = 1,  isbn = '9780596009205' 的 quantity 修改為 5
update order_detail set quantity = 5
where order_id = 1 and isbn = '9780596009205';

select * from order_detail;


-- Ex4-3
-- 先查詢FK規則是否包含連鎖刪除
select constraint_name, delete_rule
from information_schema.referential_constraints
where constraint_schema = 'bookshop' and table_name = 'order_detail';
-- 如果FK規則包含連鎖刪除，刪除order_master表格內資料就會連鎖刪除order_detail表格對應資料
-- 將 order_master 表格內 order_id = 1 的資料刪除
delete from order_master
where order_id = 1;

select * from order_master;
select * from order_detail;

-- 如果FK規則不包含連鎖刪除，就要先從order_detail表格資料刪除，才能刪除order_master表格對應資料
-- 先將 order_detail 表格內 order_id = 1 的資料刪除
-- delete from order_detail 
-- where order_id = 1;

-- select * from order_detail;

-- -- 再將 order_master 表格內 order_id = 1 的資料刪除
-- delete from order_master
-- where order_id = 1;

-- select * from order_master;

-- 將 customer 表格內 customer_id = 'C001' 的資料刪除
delete from customer
where customer_id = 'C001';

select * from customer;


-- Ex4-4 
-- customer 表格先新增一筆資料，然後修改，最後還原，步驟如下： 
-- 建立 savepoint - point01
-- customer 表格新增一筆資料
-- customer_id = 'C00X', customer_name = 'Michael', phone = '03-4567890', address = 'Taoyuan'
-- 再建立 savepoint - point02
-- 將剛新增資料的 customer_name 修改為 'Mary'
-- 還原至 point02
-- 異動結束並確定
savepoint point01;
insert into customer (customer_id, customer_name, phone, address)
values('C00X', 'Michael', '03-4567890', 'Taoyuan');

savepoint point02;
update customer set customer_name = 'Mary'
where customer_id = 'C00X';

rollback to savepoint point02;
commit;

select * from customer;

