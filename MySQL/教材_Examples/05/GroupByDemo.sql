select * from book order by publisher_id;

-- 書依照各出版社分組統計數量
select publisher_id, count(1) book_count
from book
group by publisher_id
order by publisher_id;

-- 書依照各作者分組統計數量
select author, count(1) book_count
from book
group by author
order by author;

-- 書依照各出版社與作者分組統計數量，搭配 WITH ROLLUP 顯示小計與總計
select publisher_id, author, count(1) book_count
from book where publisher_id is not null
group by publisher_id, author with rollup;


-- select所列欄位，除了聚集函式外，其餘都要列在group by後面，否則導致錯誤，因為不符合閱讀邏輯
select author, publisher_id, count(1) book_count
from book
group by author
order by author;

-- 如果上述沒發生錯誤，可查看當前連線的sql_mode是否有'ONLY_FULL_GROUP_BY'
SELECT @@SESSION.sql_mode;
-- 如果沒有，要加上才正確；sql_mode不能直接設定成'ONLY_FULL_GROUP_BY'，否則其他參數會消失
-- CONCAT_WS(sep, a, b, …) = Concat With Separator → 用指定的分隔符把字串接起來
SET SESSION sql_mode = CONCAT_WS(',', @@SESSION.sql_mode, 'ONLY_FULL_GROUP_BY');

-- 也可查詢或加到Global層級(會影響所有連線)
SELECT @@GLOBAL.sql_mode;
SET GLOBAL sql_mode = CONCAT_WS(',', @@SESSION.sql_mode, 'ONLY_FULL_GROUP_BY');


-- 若不列publisher_id，當出版社不同但名稱相同時，會誤將不同出版社的資料合併計算
select b.publisher_id, publisher_name, avg(price) average_price
from book b 
join publisher p on b.publisher_id = p.publisher_id
group by b.publisher_id, publisher_name
order by publisher_name;

-- 列出每個出版社最貴/最便宜的書價
select b.publisher_id, max(price), min(price)
from book b
join publisher p on b.publisher_id = p.publisher_id
group by b.publisher_id
order by b.publisher_id;

-- 列出每本書的總進貨量
select p.isbn, book_name, sum(quantity)
from purchase p
join book b on p.isbn = b.isbn
group by p.isbn, book_name
order by book_name;

-- HAVING: 列出總進貨量超過200本的出版社，having可以使用total別名(但Oracle不行)
select b.publisher_id, publisher_name, sum(quantity) total
from purchase pc
join book b on pc.isbn = b.isbn
join publisher pb on b.publisher_id = pb.publisher_id
group by b.publisher_id, publisher_name
having total >= 200
order by total desc;