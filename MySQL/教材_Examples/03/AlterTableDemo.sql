-- 使用指定資料庫
use bookshop; 

-- 顯示表格結構
show tables;
describe book;

-- 表格更名
alter table book rename to books;
alter table books rename to book;

-- 新增欄位
alter table book add column type varchar(40);

-- 欄位更名
alter table book rename column type to class;

-- 修改/刪除欄位預設值
alter table book alter column class set default 'computer';
alter table book alter column class drop default;

-- 修改欄位類型
alter table book modify class varchar(20);

-- 欄位改為不可/可為空值
alter table book modify author varchar(200) not null;
alter table book modify author varchar(200) null;

-- 刪除欄位
alter table book drop column class;

-- 顯示表格參照資訊
select constraint_name, table_name, column_name, 
referenced_table_name, referenced_column_name
from information_schema.key_column_usage 
where referenced_table_schema = 'bookshop' and table_name = 'book';

-- 移除FK
alter table book drop foreign key fk_book_publisher;

-- 建立FK
alter table book add constraint fk_book_publisher
foreign key (publisher_id) references publisher(publisher_id);

