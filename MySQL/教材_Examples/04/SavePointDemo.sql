-- 建立儲存點
savepoint point01;
delete from publisher 
where publisher_id = 'P00A';
									  
savepoint point02;
delete from publisher
where publisher_id = 'P00B';
									  
-- 回復到指定儲存點, savepoint關鍵字可省略
rollback to savepoint point02;
rollback to savepoint point01;

select * from publisher;