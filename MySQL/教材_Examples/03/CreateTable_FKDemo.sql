-- 使用指定資料庫
use bookshop; 

create table book(
  isbn char(13) primary key,
  book_name varchar(200) not null,
  price decimal(8, 2), 
  author varchar(200),
  publication_date date,
  publisher_id varchar(40),
  -- 建立FK語法不可直接加到該欄位後面，而要放在所有欄位之後
  constraint fk_book_publisher -- 此行可省略，但系統會自動為constraint取名
  foreign key(publisher_id) references publisher(publisher_id)
  -- 連鎖式刪除：當publisher出版社被刪除，該出版社書籍自動刪除(預設不採連鎖反應)
  -- on delete cascade 
);

create table book (
  isbn char(13) primary key,
  book_name varchar(200) not null,
  price decimal(8,2),
  author varchar(200),
  publication_date date,
  -- 建立FK語法不可直接加到該欄位後面，雖不會錯誤，但沒有FK效果
  publisher_id varchar(40) references publisher(publisher_id) 
);

-- 顯示表格結構，Key值為MUL代表可重複值的索引(Multiple Key)，例如外鍵或一般索引
describe book;
-- 顯示constraint資訊
select * from information_schema.table_constraints
where constraint_schema = 'bookshop' and table_name = 'book';
-- 顯示表格參照資訊
select constraint_name, table_name, column_name, 
referenced_table_name, referenced_column_name
from information_schema.key_column_usage 
where referenced_table_schema = 'bookshop' and table_name = 'book';
-- 顯示FK規則是否包含連鎖修改與刪除
select constraint_name, update_rule, delete_rule
from information_schema.referential_constraints
where constraint_schema = 'bookshop' and table_name = 'book';

-- 新增一筆測試資料
insert into book(isbn, book_name, price, author, publication_date, publisher_id) 
values('1234567890123', 'MySQL DB', 920 ,'Michael', '2025-03-19', 'test_id1');
-- 新增失敗：因為publisher表格沒有test_id3出版社
insert into book(isbn, book_name, price, author, publication_date, publisher_id) 
values('1231234567890', 'MySQL DB', 920 ,'Michael', '2025-03-19', 'test_id3');

-- 查詢表格內容
select * from book;

-- 刪除表格
drop table book;