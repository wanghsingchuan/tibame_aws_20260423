-- 顯示所有資料庫
SHOW DATABASES;

-- 顯示資料庫名稱有schema的資料庫
SHOW DATABASES LIKE '%schema%';

-- 使用指定資料庫
USE information_schema;

-- 顯示現行資料庫名稱
SELECT database();

-- 顯示現行資料庫的所有表格名稱
SHOW TABLES;

-- 顯示表格的結構
DESCRIBE ADMINISTRABLE_ROLE_AUTHORIZATIONS;