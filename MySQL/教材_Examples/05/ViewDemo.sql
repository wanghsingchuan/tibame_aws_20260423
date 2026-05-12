-- 建立或取代View
create or replace view book_view as
select * from book 
where publication_date >= '2016-1-1';

-- 查詢View
select * from book_view;

-- View為虛擬表格，可join其他表格
select isbn, book_name, price, p.publisher_id, publisher_name, phone
from book_view b
join publisher p on b.publisher_id = p.publisher_id;

-- 刪除View
drop view book_view;


-- 列出所有User帳號: user為帳號，host為可以登入的主機
select user, host from mysql.user;
-- 先建立新使用者，方便之後授權
create user mary identified by 'mary';

-- 授權其他使用者只能查詢View而不能修改
-- 注意：如果使用者沒授權成功，SQLTools登入會失敗該使用者沒有任何資料庫使用權限
grant select on bookshop.book_view to mary;

-- 切換其他使用者以測試授權
-- 測試查詢
select * from book_view;
-- 測試異動
insert into book_view (isbn, book_name, publisher_id)
values ('test_isbn', 'test_book2', 'P002');

