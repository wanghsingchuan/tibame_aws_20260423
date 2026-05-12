-- in: 查詢所有出版python書籍的出版社
select publisher_id, publisher_name from publisher
where publisher_id in (select publisher_id from book where book_name like '%python%');

-- 用any改寫
select publisher_id, publisher_name from publisher
where publisher_id = any(select publisher_id from book where book_name like '%python%');

/* in, any, all差別
in: 單純比較是否與子查詢結果值相同，所以無法使用<>, <, >, <=, >=
any: 除了值是否相同外，還可以跟子查詢結果的任一個值比大小，屬於or觀念
all: 跟子查詢結果的每一個值比大小，屬於and觀念
*/
-- in: 列出與java書價相同的書(此例無意義，純粹展示in功能)
select * from book
where price in (select price from book where book_name like '%java%');

-- any: 列出高於任一本java書價的書(相當於大於最小值)
select * from book
where price >= any(select price from book where book_name like '%java%');
-- some: 與any是同義複詞，所以結果一樣
select * from book
where price >= some(select price from book where book_name like '%java%');

-- all: 列出高於所有java書價的書(相當於大於最大值)
select * from book
where price >= all(select price from book where book_name like '%java%');

-- exists: 查詢所有出版python書籍的出版社
select publisher_id, publisher_name from publisher p
where exists (
	select 1 from book b 
	where p.publisher_id = b.publisher_id and book_name like '%python%'
);

/* 
exists執行邏輯：主查詢一筆 > 去子查詢看有沒有符合 > 找到一筆就返回true，不會繼續比對。
in執行邏輯：子查詢會先執行並產生一個集合，然後主查詢逐一比對是否在集合中。
以往在相同條件下exists通常比較快，但MySQL 8.0開始將in優化成類似exists，所以執行效能相差不大

因為exists找到一筆就返回true所以"SELECT 1"與"SELECT *"沒有差別
*/
