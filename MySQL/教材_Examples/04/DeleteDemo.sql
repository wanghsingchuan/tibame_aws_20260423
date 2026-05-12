-- 刪除資料
delete from publisher 
where publisher_id = 'P00X' or publisher_id = 'P00Y';

select * from publisher;

-- 未加條件會將所有資料刪除；但被外鍵參照到的資料無法刪除
delete from publisher;
delete from book;
