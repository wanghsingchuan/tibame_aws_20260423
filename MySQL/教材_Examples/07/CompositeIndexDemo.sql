-- 顯示表格的索引資訊
show index from book;

-- 建立複合索引有下列方式，優先序為左到右(查詢條件欄位有多個時會依照索引優先序)
create index idx_book_name_publication_date on book(book_name, publication_date);
alter table book add index idx_book_name_publication_date(book_name, publication_date);
-- 移除索引
drop index idx_book_name_publication_date on book;
-- 沒給索引名稱會自動以第一個欄位名稱當做索引名稱
alter table book add index(book_name, publication_date);
-- 移除索引
drop index book_name on book;

