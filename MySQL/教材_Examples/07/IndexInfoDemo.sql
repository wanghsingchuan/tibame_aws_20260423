use bookshop;

describe book;

-- 查詢表格的索引資訊，雖然索引種類(INDEX_TYPE)為BTREE，但實際上為B+ Tree，可能因為名詞沿用以相容，或是"+"與其他運算符號衝突
SELECT NON_UNIQUE, INDEX_NAME, COLUMN_NAME, NULLABLE, INDEX_TYPE 
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'bookshop' AND TABLE_NAME = 'book';

-- SHOW INDEX其實就是SELECT STATISTICS的結果，但無法指定欄位，而且某些欄位改用別名
SHOW INDEX FROM book;


