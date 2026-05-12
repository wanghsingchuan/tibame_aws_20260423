-- 字串函式

-- lower(str): 將str轉成小寫字，lcase(str)功能相同
select book_name, lower(book_name) as lower_book_name from book;

-- upper(str): 將str轉成大寫字，ucase(str))功能相同
select book_name, upper(book_name) as upper_book_name from book;

-- substring(str, pos),  substring(str,pos,len): 回傳指定位置的局部字串
-- 只有pos代表取值範圍從pos到最後一個字元；有len代表取len個數的字元
select substring('123456789', 5);
select substring('123456789', 5, 3);

-- substring_index(str, delim, count): 回傳第count分隔符號(delim)前的局部字串
-- count為正代表左算到右(取左側值)；負代表右算到左(取右側值)
select substring_index('www.mysql.com', '.', 2);
select substring_index('www.mysql.com', '.', -2);

-- format(x, d[,locale]): 格式化數字x，使其長得像 ‘#,###,###.##'。
-- d代表小數位數，如果d為0代表不需要小數部分。locale代表在地化設定（可以不設定）
select format(12332.123456, 4); -- 4代表保留4位小數，第5位小數四捨五入
select format(12332.123456, 0);
select format(12332.123456, 4, 'de_DE'); -- de_DE代表德語。德語分位與小數符號與美語顛倒

-- field(str, str1, str2, str3, …): 文字值不區別大小寫，索引位置皆為1-based
-- 在字串列表（str1, str2, ...）內搜尋是否存在str字串，有則回傳所在位置，無則回傳0
select field('bb', 'aa', 'bb', 'cc', 'dd', 'ff');
select field('gg', 'aa', 'bb', 'cc', 'dd', 'ff');

-- find_in_set(str, strlist): 在字串列表 strlist 內搜尋是否存在str字串，
-- 有則回傳所在位置，無則回傳0。2個參數任一個為null則結果為null。str不可包含逗號（,）
select find_in_set('b','a,b,c,d');
select find_in_set('g','a,b,c,d');

-- concat(str1, str2, …): 將str1, str2...等各個字串串接起來
select concat('SN', '-', order_id) as id from order_master;

-- concat_ws(separator, str1, str2, …): ws (with separator)，使用分隔符號串接各字串
select concat_ws(' | ', isbn, book_name, publication_date) from book;

-- right(str, len): 將str右邊len長度的字回傳
select book_name, right(book_name, 5) as right_5 from book;

-- left(str, len): 將str左邊len長度的字回傳
select book_name, left(book_name, 5) as left_5 from book;

-- lpad(str, len, padstr): str-原始字串, len-填補後的總長度, padstr-填補用字串 
select lpad('1', 3, '0'); -- 總字元數如果少於3個會在左邊填補0

-- rpad(str, len, padstr): str-原始字串, len-填補後的總長度, padstr-填補用字串 
select rpad('1', 3, '0'); -- 總字元數如果少於3個會在右邊填補0

-- replace(str, from_str, to_str): 將str文字中所有from_str都替換成to_str (區別大小寫)
select book_name, replace(book_name, 'Oracle', 'MySQL') as replaced_book_name
from book where book_name like '%oracle%';

-- insert(str, pos, len, newstr): 以newstr取代指定位置pos與長度len所代表的文字
select insert('abc.com', 1, 3, 'xyz');

-- instr(str, substr): 尋找str內是否存在substr，有則回傳第一個找到的位置；找不到回傳0
select book_name, instr(book_name, 'python') from book;
-- 功能與instr(str, substr)相似，只不過參數位置顛倒
select book_name, locate('python', book_name) from book; 

-- trim([{both | leading | trailing} [remstr] from] str), trim([remstr from] str): 
-- 去除左右空白字元或指定字元
select trim('  hello  ');
select trim(leading from '  hello  ');
select trim(trailing from '  hello  ');
select trim('x' from 'xxhelloxx');
select trim(leading 'x' from 'xxhelloxx');
select trim(trailing 'x' from 'xxhelloxx');

-- length(str): 回傳str長度，以byte計算
-- char_length(str): 回傳str的長度，以字元計算
select length('哈囉'), char_length('哈囉');
select length('hello'), char_length('hello');

-- repeat(str, count): 將str重複count次數
select repeat('mysql', 3);

-- reverse(str): 將str內容反轉
select book_name, reverse(book_name) as reverse_book_name from book;

