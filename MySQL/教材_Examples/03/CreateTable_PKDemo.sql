-- 使用指定資料庫
use bookshop; 

-- 建立主鍵可以直接在欄位後面加上PRIMARY KEY
create table publisher (
  publisher_id varchar(40) primary key, -- 主鍵一定 not null，所以可省略
  publisher_name varchar(40) unique, -- 唯一鍵可以為 null；not null需手動加上
  contact varchar(40),
  phone varchar(40),
  create_time timestamp default current_timestamp on update current_timestamp
);

-- 建立主鍵語法也可以放在所有欄位後面
-- 如果建立複合主鍵(composite primary key)則一定要放在所有欄位後面
create table publisher (
  publisher_id varchar(40),
  publisher_name varchar(40),
  contact varchar(40),
  phone varchar(40) not null,
  create_time timestamp default current_timestamp on update current_timestamp,
  -- MySQL PK constraint name皆為primary，無法修改
  constraint pk_publisher primary key(publisher_id), -- constraint pk_publisher 可省略
  constraint uk_publisher unique(publisher_name) -- constraint uk_publisher 可省略
);

-- 顯示表格結構，Key值為PRI代表主鍵；UNI代表唯一鍵
describe publisher;
-- 顯示constraint資訊
select * from information_schema.table_constraints
where constraint_schema = 'bookshop' and table_name = 'publisher';

-- 新增一筆測試資料
insert into publisher(publisher_id, publisher_name, contact, phone)
values('test_id1', 'Test A', 'Jane Doe', '02-92882773');
-- PK重複導致錯誤 
insert into publisher(publisher_id, publisher_name, contact, phone)
values('test_id1', 'Test B', 'Johe Doe', '03-23342342');
-- UK重複導致錯誤 
insert into publisher(publisher_id, publisher_name, contact, phone)
values('test_id2', 'Test A', 'Ken', '04-38737727');

-- 查詢表格內容
select * from publisher;

-- 刪除表格
drop table publisher;
