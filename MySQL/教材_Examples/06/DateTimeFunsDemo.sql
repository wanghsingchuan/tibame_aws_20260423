-- 日期時間函式

-- 以下方式都會回傳當下日期時間
select current_timestamp, current_timestamp(), now();
-- 以下方式都會回傳當下日期
select current_date, current_date(), curdate();
-- 以下方式都會回傳當下時間
select current_time, current_time(), curtime();

-- sysdate(): 回傳函式當下時間，在同一指令內呼叫多次回傳的時間不同(如果相同，改用命令列測試)
-- now(), current_date()在同一指令內呼叫多次回傳的時間相同
select sysdate(), now(), current_time(), sleep(1), sysdate(), now(), current_time();

-- date(date): 回傳日期部分
select date('2025-7-25 10:05:47');
-- time(time): 回傳時間部分
select time('2025-7-25 10:05:47');
-- year(date): 回傳年
select year('2025-7-25 10:05:47');
-- month(date): 回傳月 
select month('2025-7-25 10:05:47'); 
-- dayofmonth(date): 回傳日
select dayofmonth('2025-7-25 10:05:47');
-- dayofweek(date): 回傳weekday(1 = Sunday, 2 = Monday, …, 7 = Saturday).
select dayofweek(current_date);
-- dayofyear(date): 回傳一年的第幾日
select dayofyear('2025-7-25 10:05:47');
-- hour(time): 回傳時 
select hour('2025-7-25 10:05:47');
-- minute(time): 回傳分
select minute('2025-7-25 10:05:47'); 
-- second(time): 回傳秒
select second('2025-7-25 10:05:47'); 
-- week(date): 回傳一年的第幾週 
select week('2025-7-25 10:05:47');
-- last_day(date): 回傳date月份中的最後一天
select last_day('2025-7-25 10:05:47');

-- 日期時間單位參看 https://dev.mysql.com/doc/refman/8.0/en/expressions.html#temporal-intervals

-- extract(unit from date): 會傳unit所指定的時間單位
select extract(year_month from '2025-7-25 10:05:47');
select extract(hour_minute from '2025-7-25 10:05:47');

-- date_add(date,interval value unit), adddate(date, interval value unit)功能相同
select date_add('2025-7-25', interval 1 month);
-- "interval '1-2' year_month" 代表 1 year, 2 month
select date_add('2025-7-25', interval '1-2' year_month);

-- date_sub(date,interval value unit), subdate(date, interval value unit)功能相同
select date_sub('2025-7-25', interval 1 month);
select date_sub('2025-7-25', interval '1-2' year_month);

-- datediff(date1, date2): date1 - date2的結果天數
select datediff('2025-7-25', '2025-7-24');
select datediff('2025-7-24', '2025-7-25');

-- timediff(time1, time2): time1 - time2的結果時間
select timediff('14:05:47', '12:00:00');

-- timestampdiff(unit, datetime1, datetime2):
-- datetime2 - datetime1結果，並以指定單位計算
-- 注意：跟datediff(), timediff()相減順序不同
select timestampdiff(day, '2025-7-24 12:00:00', '2025-7-25 14:05:47');
select timestampdiff(hour, '2025-7-24 12:00:00', '2025-7-25 14:05:47');

-- 格式化符號參看：https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
-- date_format(date, format): 將指定日期date使用format來格式化
select book_name, date_format(publication_date, '%Y/%m/%d') as pubdate from book;
-- str_to_date(str, format): 將字串str解析回日期時間。%T(hh:mm:ss)
select str_to_date('2025-7-25 14:05:47', '%Y-%m-%d %T');
