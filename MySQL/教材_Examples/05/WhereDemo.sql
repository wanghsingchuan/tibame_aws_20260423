-- 查詢名稱為pearson的出版社；查詢時文字值預設不區別大小寫
select * from publisher 
where publisher_name = 'pearson';
-- 要區別大小寫，可加上 binary
select * from publisher 
where binary publisher_name = 'pearson';

-- 查詢publisher_id不為的p001的出版社
select * from publisher where publisher_id <> 'p001';
-- "!=" 不是標準語法但 MySQL 支援
select * from publisher where publisher_id != 'p001';

-- 查詢書價在1000元以內的書籍
select * from book
where price <= 1000
order by price;

-- 將publisher_id為空值的書列出，
select * from book 
where publisher_id is null;

-- 查詢書名開頭為任一字元再加上「ava」的資料
select * from book 
where book_name like '_ava%'; 

-- 查詢書名含有「py」的資料
select * from book 
where book_name like '%py%';
