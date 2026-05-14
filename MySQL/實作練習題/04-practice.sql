-- Ex4-1
-- customer 表格新增 1 筆如下資料
-- customer_id = 'C001', customer_name = 'Jack', phone = '0987654321', address = 'Taipei'
describe customer;
insert into customer(customer_id, customer_name, phone, address) values ('C001', 'Jack', '0987654321', 'Taipei');
insert into customer(customer_id, customer_name, phone, address) values ('C002', 'Jim', '0987654320', 'Hsinchu');
select * from customer;

-- order_master 表格的 order_id 改採自動編號，然後 order_master 表格新增 1 筆資料
-- 使用 alter table 語法：先移除 FK 限制才能將 order_id 改為自動編號，最後再加回 FK 限制
select * from order_master;
describe order_master;
select * from information_schema.table_constraints where CONSTRAINT_NAME like '%order_master%';
-- 1. 先移除 FK 
alter table order_detail drop foreign key fk_order_detail_order_master;
-- 2. 改為自動編號
alter table order_master modify order_id bigint unsigned AUTO_INCREMENT;
-- 3. 加回 FK 限制
alter table order_detail add constraint fk_order_detail_order_master
foreign key (order_id) references order_master(order_id) on delete cascade;
describe order_detail;
-- 4. 添加資料進行測試
insert into order_master(customer_id) values ('C001');
insert into order_master(customer_id) values ('C002');

-- order_detail 表格新增 1 筆如下資料
-- order_id = 1, isbn = '9780596009205', quantity = 2
insert into order_detail(order_id, isbn, qunatity)
values ('1','9780596009205','2');


-- Ex4-2
-- 將 customer 表格內 customer_id = 'C001' 的資料修改如下
-- customer_name = 'Ken', phone = '03-3456789', address = 'Taoyuan'
update customer set customer_name = 'Ken', phone = '03-3456789', address = 'Taoyuan' where customer_id = 'C001';


-- Ex4-3
-- 將 order_master 表格內 order_id = 1 的資料刪除 
-- • 連同將 order_detail 表格內 order_id = 1 的資料刪除 
-- 將 customer 表格內 customer_id = 'C001' 的資料刪除
select * from information_schema.referential_constraints where TABLE_NAME='order_master';
-- 如果DELETE_RULE是 on delete cascade，直接刪除: 後面子從屬的Table資料都會刪除。
delete from order_master where order_id = 1;

select * from bookshop.book;