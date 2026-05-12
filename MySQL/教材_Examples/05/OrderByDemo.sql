-- ORDER BY 可將查詢結果排序；DESC 代表降冪
select * from book order by publication_date desc;

-- ORDER BY 兩個以上欄位，可分別指定升冪或降冪
select * from book order by price, publication_date desc;

-- MySQL 視 NULL 值小於 non-NULL 值
select isbn, book_name, price from book order by price;

-- 如果要自訂 NULL 排序先後，可搭配 ISNULL() - ISNULL(NULL) 為 1，其餘為 0
select isbn, book_name, price, isnull(price) from book order by isnull(price), price;
