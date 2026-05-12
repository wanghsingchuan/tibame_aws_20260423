-- Ex3-1 
-- 建立 customer 表格，包含 4 個欄位
-- • customer_id - varchar(40)
-- • customer_name - varchar(40)
-- • phone - varchar(40)
-- • address - varchar(200)
-- ✤ 所有欄位都必須有值
-- ✤ customer_id 是主鍵
-- ✤ customer_name 是唯一鍵
create table customer(
	customer_id varchar(40) primary key,
    customer_name varchar(40) unique not null,
    phone varchar(40) not null,
    address varchar(200) not null
);

describe customer;
drop table customer;

-- Ex3-2
-- 建立 order_master 表格，包含下列欄位
-- • order_id - bigint unsigned
-- • customer_id - varchar(40)
-- • order_date - timestamp，無論資料新增會修改都會自動填入系統時間
-- ✤ order_id 是主鍵
-- ✤ 建立外鍵限制
-- • customer_id 關聯到 customer 表格
create table order_master(
	order_id bigint unsigned primary key,
    customer_id varchar(40),
    order_date timestamp default current_timestamp on update current_timestamp,
    constraint fk_order_master_customer
    foreign key (customer_id) references customer(customer_id)
);

describe order_master;
select * from information_schema.table_constraints;

-- Ex3-3
-- 建立 order_detail 表格，包含下列欄位
-- • order_id
-- • isbn
-- • quantity (限制要大於 0)
-- ✤ 建立複合主鍵限制 - Composite PK
-- • order_id、isbn 都是主鍵
-- ✤ 建立外鍵限制
-- • order_id 關聯到 order_master
-- ✦ 當 order_master 訂單被刪除，明細自動刪除
-- • isbn 關聯到 book 表格
create table order_detail(
	order_id bigint unsigned,
    isbn char(13),
    quantity decimal(6) check(quantity > 0),
    primary key (order_id, isbn),
    constraint fk_order_detail_order_master
    foreign key (order_id) references order_master(order_id)
    on delete cascade,
    constraint fk_order_detail_book
    foreign key (isbn) references book(isbn)
);