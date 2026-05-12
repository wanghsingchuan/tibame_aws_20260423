-- 資料類型轉換函式

-- cast(expr AS type): 將值expr轉成指定類型(可以為binary, char, date, datetime, time, signed, unsigned, decimal, double)
-- 參看https://dev.mysql.com/doc/refman/8.0/en/cast-functions.html#function_cast
select cast('20201231' as date);
select cast('100501' as time);
select cast(123.456 as char);
-- 轉成整數不支援直接寫integer，要用signed或unsigned
select cast(123.456 as signed);
select cast('123.456' as double);
select cast('123.456' as decimal(5,2));
