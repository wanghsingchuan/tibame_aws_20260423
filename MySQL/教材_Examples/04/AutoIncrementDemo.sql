-- 主鍵可以加上自動編號 (auto increment) 功能
create table purchase(
  purchase_id bigint unsigned primary key auto_increment,
  isbn char(13) not null,
  quantity int not null,
  purchase_date timestamp default current_timestamp,
  constraint fk_purchase_book 
  foreign key(isbn) references book(isbn)
);

-- 新增資料時，自動編號欄位會自動給值
insert into purchase(isbn, quantity) 
values
('9780596009205', 20),
('9780596809157', 10),
('9781491936696', 10),
('9781118407813', 40),
('9781617291999', 30),
('9781430237174', 50),
('9781484226766', 20),
('9780071751292', 30),
('9781259587405', 60),
('9780134543666', 70),
('9781119017929', 80),
('9783527711499', 40),
('9789352133468', 60),
('9780596009205', 80),
('9780596809157', 40),
('9781491936696', 20),
('9781118407813', 50),
('9781617291999', 20),
('9781430237174', 70),
('9781484226766', 90),
('9780071751292', 30),
('9781259587405', 60),
('9780134543666', 40),
('9781119017929', 10),
('9783527711499', 40),
('9789352133468', 20);

select * from purchase;

-- 下列違反FK限制，導致新增失敗，仍會自動跳號
insert into purchase(isbn, quantity) 
values
('9789352133477', 20);

-- 下列新增成功，但之前新增失敗，所以自動編號不連續
insert into purchase(isbn, quantity) 
values
('9789352133468', 20);

-- INFORMATION_SCHEMA.TABLES儲存許多暫存的統計資訊，暫存資訊不正確可以使用information_schema_stats_expiry設定失效時間
-- 設為0代表立即失效，就會重新取得最新統計資訊；建議先執行然後再取得自動編號資訊
set @@SESSION.information_schema_stats_expiry = 0;

-- 查詢下一個準備產生的號碼 
select auto_increment
from  information_schema.tables
where table_schema = 'bookshop' -- 資料庫名稱
and   table_name   = 'purchase'; -- 表格名稱

-- 顯示表格資訊也會呈現自動編號資訊（Auto-increment欄位）
show table status from bookshop where name like 'purchase';


-- MySQL的auto increment欄位一定要為整數類型，所以該欄位不可有任何文字
-- 如果希望商品ID為自訂前綴字 + 自動編號
-- 建議再新增一個欄位存放前綴字，查詢時使用CONCAT(前綴字, 自動編號)
create table product1(
	prefix varchar(2) not null default 'SN', 
	id int unsigned auto_increment primary key, 
	product_name varchar(200) not null, 
	unique(prefix, id)
);

insert into product1(product_name)
values
('product A'), 
('product B'), 
('product C'); 

select * from product1;

-- 將前綴字與自動編號串接
select concat(prefix, id) as `product ID`, product_name from product1;
-- 自動編號總字元數如果少於4個會在左邊填補0
select concat(prefix, lpad(id, 4, '0')) as `product ID`, product_name from product1;

-- 如果希望商品ID為當時日期 + 自動編號
create table product2(
	id int unsigned auto_increment primary key, 
	product_name varchar(200) not null,
	create_time timestamp default current_timestamp, 
	unique(create_time, id)
);

insert into product2(product_name)
values
('product A'), 
('product B'), 
('product C'); 

select concat(date_format(create_time,'%Y%m%d'), lpad(id, 4, '0')) as `product ID`, 
product_name, create_time from product2;
