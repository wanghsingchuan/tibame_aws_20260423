-- 數學函式

-- round(x, d): -- 將x數字四捨五入到小數第d位，省略d則代表到整數位
select round(1.67), round(1.67, 1);
-- 函式有參數，呼叫時大部分可提供欄位名稱來計算
select book_name, round(price, 1) from book;

-- pi(): 回傳圓周率
select pi();

-- abs(x): 回傳x的絕對值，如果x是NULL則回傳NULL
select abs(-1.1);
select abs(null);

-- ceil(x): 回傳大於x的最小整數，ceiling(x)功能相同
select ceil(1.67), ceil(1.37);
select ceiling(1.67), ceiling(1.37);

-- floor(x): 回傳小於x的最大整數
select floor(1.67), floor(1.37);

-- 以下功能皆同，都是取餘數計算
select 10 % 3;
select 10 mod 3;
select mod(10, 3);

-- pow(x, y): x的y次方，power(x, y)功能相同
select pow(2, 3);
select power(2, 3);

-- sqrt(x): 回傳x的正平方根
select sqrt(9);

-- degrees(x): 將弧度轉成角度
select degrees(1);
select degrees(pi());
-- radians(x): 將角度x轉成弧度
select radians(60);
-- sin(x): 回傳弧度為x的sine值
select sin(radians(60));

-- rand([n]): 回傳一個介於0(含)~1.0(不含)的亂數。
-- n是seed value，如果加上則可重複產生相同亂數
select rand(), rand(3);
-- 回傳一個介於5(含)~10(不含)的亂數，公式為: low + rand() * (high - low)
select 5 + rand() * (10 - 5) as rand_value_5_10; 


