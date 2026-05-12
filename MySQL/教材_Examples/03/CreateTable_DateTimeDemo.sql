-- 使用指定資料庫
use bookshop; 

-- 自動填入新增時系統時間: DEFAULT CURRENT_TIMESTAMP
-- 自動填入修改時系統時間: ON UPDATE CURRENT_TIMESTAMP
create table datetime_table(
  id int unsigned auto_increment primary key,
  date_type date,
  time_type time,
  time_type6 time(6),
  timestamp_type timestamp default current_timestamp on update current_timestamp,
  -- 資料類型為timestamp(6)，default與on update也必須為timestamp(6)
  timestamp_type6 timestamp(6) default current_timestamp(6) on update current_timestamp(6),
  datetime_type datetime default current_timestamp on update current_timestamp
);

-- 顯示表格結構
describe datetime_table;

-- MySQL的Timestamp會將日期時間轉成UTC時間再儲存，所以有時區資訊
-- MySQL的DateTime不儲存時區資訊
-- 新增一筆測試資料
insert into datetime_table(date_type, time_type, time_type6)
values('2025-1-3', '21:10:3', '21:10:3.123456');

-- 查詢表格內容
select * from datetime_table;

-- 改變時區設定時，Timestamp會隨著新時區調整；但DateTime不會
set time_zone = '+00:00';
set time_zone = '+08:00';
select * from datetime_table;

-- 刪除表格
drop table datetime_table;

