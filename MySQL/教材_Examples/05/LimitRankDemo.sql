-- LIMIT: 將最便宜的前2本書列出，但空值也會列出
select * from book order by price limit 2;

-- 列出所有價格非空值的書
select * from book where price is not null order by price;

-- 空值排除後將最便宜的2本書列出。LIMIT(2)會取前2本，即使第2, 3書價相同，除非改用之後的RANK()
select * from book where price is not null
order by price limit 2;

-- 處理分頁：書價升冪排序，先取出第一頁 (1 ~ 10)、再取得第二頁 (11 ~ 20)
select * from book where price is not null order by price limit 10;
select * from book where price is not null order by price limit 10 offset 10;

-- RANK(): 書價升冪排序，相同價格名次要相同
select book_name, price, rank() over(order by price) price_rank
from book 
where price is not null;

-- 列出前2名便宜的書
select * from (
	select book_name, price, 
	rank() over(order by price) price_rank
	from book
	where price is not null
) book_rank
where price_rank <= 2;

-- 列出出版日期前3名新的書
select book_name, publication_date from (
	select book_name, publication_date, 
	rank() over(order by publication_date desc) publication_date_rank
	from book
) book_rank 
where publication_date_rank <= 3;

-- 列出總進貨量前3名高的書
select * from (
	select p.isbn, book_name, sum(quantity), 
	rank() over(order by sum(quantity) desc) sum_rank
	from purchase p
	join book b on p.isbn = b.isbn
	group by p.isbn, book_name
) purchase_rank
where sum_rank <= 3;
