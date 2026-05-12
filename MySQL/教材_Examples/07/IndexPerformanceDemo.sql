-- 評估執行效能：主要查看type, key, rows, extra欄位，說明如下
-- type：存取型態（非常重要）
    -- ALL：全表掃描（最慢）
    -- index：全索引掃描
    -- range：索引範圍查詢（如 BETWEEN、>、<）
    -- ref：使用非唯一索引等值查詢
    -- eq_ref：唯一索引等值查詢（例如主鍵 join）
    -- const：單筆常數查詢（最快）
    -- system：表只有一筆記錄，效能最佳
-- key：MySQL 實際選用的索引（如果是 NULL 表示沒用索引） 
-- rows：MySQL 預估需要掃描的行數（越小越好） 
-- Extra：額外資訊，常見值：
    -- Using where：有套用 WHERE 條件
    -- Using index：覆蓋索引查詢（不用回表，效率佳）
    -- Using temporary：建立臨時表（通常出現在 GROUP BY、DISTINCT）
    -- Using filesort：需要額外排序（ORDER BY 可能沒用到索引）
    -- Using join buffer：表示 join 沒用到索引，需要額外緩衝區

-- 其他欄位說明如下
-- id：查詢中 SELECT 的識別號，數字越大代表優先執行（巢狀子查詢或 UNION 會有多個 id） 
-- select_type：查詢的類型，例如：
    -- SIMPLE：單一 SELECT，沒有 UNION 或子查詢
    -- PRIMARY：最外層的 SELECT
    -- SUBQUERY：子查詢
    -- DERIVED：FROM 子句裡的子查詢（會產生臨時表）
    -- UNION：UNION 中的第二個或後續查詢
    -- UNION RESULT：UNION 的結果集
-- table：正在存取的資料表名稱，可能是實體表、臨時表或衍生表（例如子查詢結果） 
-- partitions：分區表（partitioned table）用到哪些分區，如果沒用分區通常是 NULL 
-- possible_keys：查詢可能用到的索引（但不一定會選用） 
-- key_len：使用索引的長度（單位：位元組），可以看出索引是否被完整使用，例如複合索引只用了前幾個欄位 
-- ref：與索引比較的欄位或常數，例如 const、func、或另一個表的欄位 
-- filtered：MySQL 預估符合條件的資料百分比（0–100），與 rows 搭配可估算最終輸出數量 

select * from book;
show index from book;
-- PK欄位已經有主鍵索引，所以條件比對為PK欄位則效能佳
explain select * from book where isbn = '9780596009205';
-- EXPLAIN ANALYZE 可以直接顯示花費時間(可將分析結果複製後請ChatGPT解釋)
explain analyze select * from book where isbn = '9780596009205';

explain select * from book where book_name = 'Starting Out with Python';
explain analyze select * from book where book_name = 'Starting Out with Python';
-- 常用於條件比對的欄位，可加上一般索引以提升效能
create index idx_book_name on book(book_name);
drop index idx_book_name on book;
-- 但前面有%，索引失效，必須全表掃描
explain select * from book where book_name like '%python%';
-- 但僅後面有%，索引仍有效
explain select * from book where book_name like 'python%';

show index from book;
explain select * from book 
where book_name like 'python%' and publication_date between '2015-1-1' and '2025-12-31';
-- 常用於條件比對的多個欄位，而且順序固定，可加上複合索引以提升效能
create index idx_book_name_publication_date on book(book_name, publication_date);
drop index idx_book_name_publication_date on book;
-- 複合索引順序與條件欄位的順序不同，執行效能變差
create index idx_publication_date_book_name on book(publication_date, book_name);
drop index idx_publication_date_book_name on book;

show index from book;
explain select price from book order by price;
-- 排序欄位加上索引，因為不用排序所以效能變佳(extra欄位值由filesort變成using index)
-- 但只能列排序欄位才不用回表，效能才會佳，但只列排序欄位這很少見
create index idx_book_price on book(price);
drop index idx_book_price on book;

explain select isbn, book_name, price from book order by price;
-- 查詢多個欄位，又要排序效能佳，必須將多個欄位加入複合索引，這樣才不用回表，而且排序欄位需在最左
-- 回表(back to table lookup)就是查詢時透過次要索引(非主鍵索引都是次要索引)找到主鍵值後，還要回到主鍵索引拿完整的資料
create index idx_book_price_isbn_name on book(price, isbn, book_name);
drop index idx_book_price_isbn_name on book;