-- 使用指定資料庫
use bookshop; 

-- 建立表格(加上 "IF NOT EXISTS" 即使表格已存在，不會報錯，也不會更改原有結構)
-- create table if not exists number_table(
create table number_table(
  id int unsigned auto_increment primary key,  
  tinyint_type tinyint,
  int_type int,
  double_type double,
  decimal_type decimal(5, 2)
);

-- 顯示現行資料庫的所有表格名稱
show tables;
-- 顯示表格結構
describe number_table;
-- 顯示表格建立語法
show create table number_table;

-- 新增一筆測試資料
insert into number_table(tinyint_type, int_type, double_type, decimal_type)
values(123, 12345678, 12345.45678, 123.45);

-- 查詢表格內容
select * from number_table;

-- 刪除表格(加上 "IF EXISTS" 即使表格不存在，不會報錯)
drop table if exists number_table;
drop table number_table;

