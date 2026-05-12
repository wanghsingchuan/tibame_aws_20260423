describe book;
-- 顯示表格的索引資訊
show index from book;

-- 修改表格以建立唯一鍵(等於唯一索引)
alter table book add unique unique_book_name(book_name);
-- 下列2種方式都可移除唯一鍵
alter table book drop index unique_book_name;
drop index unique_book_name on book;

-- 建立唯一鍵沒給名稱會自動以欄位名稱當做索引名稱
alter table book add unique(book_name); 
-- 下列2種方式都可移除唯一鍵(等於唯一索引)
alter table book drop index book_name;
drop index book_name on book;

-- 建立表格時建立唯一鍵就會自動加上唯一索引
create table book(
  isbn char(13) primary key,
  book_name varchar(200) unique not null,
);




