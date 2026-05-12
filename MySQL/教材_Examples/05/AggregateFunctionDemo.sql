select * from book;

-- sum()：加總書名有python的書價
select sum(price) as books_sum from book 
where book_name like '%python%';

-- avg()：計算平均書價
select avg(price) as books_average from book;

-- count()：計算書價在1000元以上的總數量
select count(1) as book_count from book
where price >= 1000;
-- 或是
select count(isbn) as book_count from book
where price >= 1000;

-- max(), min()：取得最高書與最低書價
select max(price) as book_max_price, min(price) as book_min_price
from book;

-- 聚集函式都可合併使用
select sum(price), avg(price), count(1), max(price), min(price)
from book;
