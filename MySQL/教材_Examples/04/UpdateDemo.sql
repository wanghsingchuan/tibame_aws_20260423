-- 修改資料
update publisher set contact = 'John', phone = '07-1234567765'
where publisher_id = 'P00X'; -- 條件欄位最好為PK或UK，否則有誤改可能

select * from publisher;

