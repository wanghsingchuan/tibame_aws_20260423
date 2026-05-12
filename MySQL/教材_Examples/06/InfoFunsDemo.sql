-- 系統資訊函式

-- version(): 回傳資料庫版本
select version();

-- database(): 回傳使用中的資料庫名稱
select database();

-- user(): 回傳目前登入的使用者帳號與主機名稱
select user();

-- charset(str): 回傳str的字元集
select book_name, charset(book_name) from book;
-- 補充說明：MySQL的utf8不是完整的UTF-8，只支援到3 bytes；
-- "utf8mb4"才可支援所有UTF-8(共4 bytes, 包含 emoji、冷僻漢字、特殊符號)

-- 說明row_count()與last_insert_id()函式
-- 準備測試資料
use bookshop;
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
('9780596009205', 20);

-- row_count()回傳最後一個DML(INSERT, UPDATE, DELETE)影響的筆數
-- row_count()不一定每個client都有效，SQLTools有效，但MySQL Workbench無效(只回傳0)
select row_count();
-- 注意：執行其他SQL指令後，即使是查詢，row_count()即失效
select row_count();

-- last_insert_id()回傳新增資料的自動編號
select last_insert_id();
select * from purchase;

-- 注意：如果一個SQL指令新增多筆資料，只會取得第一筆的自動編號
insert into purchase(isbn, quantity) 
values
('9781118407813', 40),
('9781617291999', 30),
('9781430237174', 50);
-- 回傳新增資料的自動編號
select last_insert_id();
select * from purchase;



