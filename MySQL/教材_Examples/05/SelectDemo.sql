use bookshop;

-- 查詢表格所有欄位內的值
select * from book;

-- 別名前的AS可加可不加
select isbn, book_name, price, price * 0.9 as sale_price, author, publication_date 
from book;

-- 如果別名有關鍵字或空白字元要加上「``」或「""」才不會出錯
select isbn, book_name, price, price * 0.9 as `sale price`, author, publication_date 
from book;

-- DISTINCT
select distinct publisher_id from book;

