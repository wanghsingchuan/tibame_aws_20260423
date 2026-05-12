-- 利用查詢建立表格 
-- 建立book_back表格並將書價>=1000的書名、定價、作者、出版日期插入
create table book_back as 
select book_name, price, author, publication_date from book
where price >= 1000;

describe book_back;
select * from book_back;


-- 利用查詢新增資料
-- 將書價 < 1000的書名、定價、作者、出版日期插入到已存在的book_back表格內
insert into book_back 
select book_name, price, author, publication_date from book
where price < 1000;






