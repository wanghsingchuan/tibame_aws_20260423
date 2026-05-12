-- 將小於等於平均書價的書列出(子查詢結果當作條件判斷的依據)
select * from book
where price <= (select avg(price) from book)
order by book_name;

-- 算出所有書籍總進貨量的平均值(子查詢結果當作資料來源時，通常要加上別名)
select avg(total) from (
	select sum(quantity) total 
	from purchase 
	group by isbn
) book_total;