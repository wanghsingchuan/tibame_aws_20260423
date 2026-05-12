-- 顯示auto-commit狀態(0 - 關閉；1 - 開啟)
select @@autocommit;
-- 修改auto-commit狀態(0 - 關閉；1 - 開啟)
set autocommit = 0;

insert into publisher(publisher_id, publisher_name, contact, phone) 
values('P00A', 'Publisher A', 'Sue' , '04-45678901');
insert into publisher(publisher_id, publisher_name, contact, phone) 
values('P00B', 'Publisher B', 'Hellen' , '07-78907890');

select * from publisher; -- 先查看結果
rollback;
select * from publisher; -- 再查看結果	

commit; -- commit後無法還原


