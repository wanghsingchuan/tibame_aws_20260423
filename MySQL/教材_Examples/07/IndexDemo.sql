-- 顯示表格結構，Key 值為 MUL 代表可重複值的索引 (Multiple Key)，例如外鍵或一般索引
describe book;
show index from book;

-- 建立一般索引有下列方式
create index idx_book_name on book(book_name);
alter table book add index idx_book_name(book_name);
-- 移除索引
drop index idx_book_name on book;
-- 沒給索引名稱會自動以欄位名稱當做索引名稱
alter table book add index(book_name);
-- 移除索引
drop index book_name on book;

-- 建立外鍵會自動建立一般索引來支援外鍵約束，確保父表在做 DELETE 或 UPDATE 時能快速檢查是否已被FK參照
create table book(
  isbn char(13) primary key,
  book_name varchar(200) not null,
  price decimal(8, 2), 
  author varchar(200),
  publication_date date,
  publisher_id varchar(40),
  constraint fk_book_publisher 
  foreign key(publisher_id) references publisher(publisher_id)
);







