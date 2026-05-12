-- 使用指定資料庫
use bookshop; 

-- 雖然 BLOB 類型可以儲存很大檔案，但基於資料庫系統的效能考量
-- 還是建議將檔案儲存在檔案系統，只在表格內儲存該檔案的路徑 (文字類型)
create table blob_table(
  id int unsigned auto_increment primary key,
  blob_type blob,
  mediumblob_type mediumblob
);

-- 顯示表格結構
describe blob_table;

-- 查詢表格內容
select * from blob_table;

-- 刪除表格
drop table blob_table;
