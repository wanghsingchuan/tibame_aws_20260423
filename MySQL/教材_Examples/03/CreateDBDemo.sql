-- 以下指令皆可建立資料庫 (如果資料庫已存在，會報錯)
create database bookshop;
create schema bookshop;

-- 建立資料庫 (即使資料庫已存在，不會報錯)
create schema if not exists bookshop;

-- 使用指定資料庫
use bookshop; 

-- 顯示現行資料庫名稱
select database();

-- 顯示所有資料庫
show databases;

-- 顯示 book 開頭的資料庫
show databases like 'book%';

-- 以下指令皆可刪除資料庫(資料庫不存在會報錯)
drop database bookshop;
drop schema bookshop;

-- 刪除資料庫 (即使資料庫不存在，不會報錯)
drop schema if exists bookshop;

