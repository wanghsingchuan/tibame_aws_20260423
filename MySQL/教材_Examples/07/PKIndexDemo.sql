-- 建立表格時建立主鍵就會自動加上主鍵索引
create table publisher (
  publisher_id varchar(40) primary key,
  publisher_name varchar(40),
  contact varchar(40),
  phone varchar(40),
  create_time timestamp default current_timestamp on update current_timestamp
);

describe publisher;

-- 查詢表格的索引資訊
SELECT NON_UNIQUE, INDEX_NAME, COLUMN_NAME, NULLABLE, INDEX_TYPE 
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'bookshop' AND TABLE_NAME = 'publisher';

-- SHOW INDEX其實就是SELECT STATISTICS的結果，但無法指定欄位，而且某些欄位改用別名
SHOW INDEX FROM publisher;


