-- 使用指定資料庫
use bookshop; 
drop table book;

-- MySQL 8.0.16開始支援CHECK；之前加上CHECK constraint不會報錯，但沒有效果
create table book(
  isbn char(13) primary key,
  book_name varchar(200) not null,
  -- CHECK constraint可直接放在欲限制的欄位後方
  price decimal(8, 2) check(price >= 0), 
  author varchar(200),
  publication_date date,
  publisher_id varchar(40),
  constraint fk_book_publisher -- 此行可省略，但系統會自動為constraint取名
  foreign key(publisher_id) references publisher(publisher_id)
);

create table book(
  isbn char(13) primary key,
  book_name varchar(200) not null,
  price decimal(8, 2), 
  author varchar(200),
  publication_date date,
  publisher_id varchar(40),
  constraint fk_book_publisher -- 此行可省略，但系統會自動為constraint取名
  foreign key(publisher_id) references publisher(publisher_id),
  -- CHECK constraint也可放在所有欄位之後
  constraint chk_price check(price >= 0)
);

-- 顯示表格結構
describe book;

-- 顯示constraint資訊
select * from information_schema.table_constraints
where constraint_schema = 'bookshop' and table_name = 'book';
-- 顯示CHECK constraint詳細資訊
select * from information_schema.check_constraints
where constraint_schema = 'bookshop';

-- 新增一筆測試資料
insert into book(isbn, book_name, price, author, publication_date, publisher_id) 
values('2345678901201', 'MySQL DB', 720,'Michael', '2025-03-19', 'test_id1');
-- 新增失敗：價格不可為-920
insert into book(isbn, book_name, price, author, publication_date, publisher_id) 
values('0123456789012', 'Mongo DB', -920,'Ken', '2025-03-19', 'test_id1');

-- 查詢表格內容
select * from book;

-- 刪除表格
drop table book;