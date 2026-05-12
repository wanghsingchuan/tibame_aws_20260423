-- 使用指定資料庫
use bookshop; 

create table text_table(
  id int unsigned auto_increment primary key,
  char_type char(3),
  varchar_type varchar(9),
  text_type text
);

-- 顯示表格結構
describe text_table;

-- 新增一筆測試資料
insert into text_table(char_type, varchar_type, text_type)
values('s01', 'ken', 'Today is a nice day!');

-- 查詢表格內容
select * from text_table;

-- 刪除表格
drop table text_table;
