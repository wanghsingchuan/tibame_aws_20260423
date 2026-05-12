-- Ex6-1 
-- 產生10個介於0(含)~100(不含)之間的隨機整數
select floor(rand() * 100) as number
from book -- 只要表格內資料筆數超過10即可拿來利用
limit 10;


-- Ex6-2 
-- field()可用在自訂排序上
-- 列出 book 表格內有出版社的書，並且依照下列出版社順序排列
-- 'P005', 'P003', 'P001', 'P002', 'P004', 'P006'
select book_name, price, publisher_id 
from book where publisher_id is not null
order by field(publisher_id, 'P005', 'P003', 'P001', 'P002', 'P004', 'P006');

-- email為'ken@gmail.com'，取出使用者名稱'ken'
-- instr(str, substr): 尋找str內是否存在substr，有則回傳第一個找到的位置；找不到回傳0
-- substring(str,pos,len): 回傳指定位置的局部字串
select substring('ken@gmail.com', 1, instr('ken@gmail.com', '@') - 1) as account;


-- Ex6-3
-- 生日是2000-01-01，顯示今天幾歲又幾個月(例如：25歲8個月)
-- timestampdiff(month, '2000-1-1', current_date)會取得月差值，例如309個月
select concat(
    timestampdiff(year, '2000-1-1', current_date), '歲',
    timestampdiff(month, '2000-1-1', current_date) - 
    timestampdiff(year, '2000-1-1', current_date) * 12, '個月'
) as age;


-- Ex6-4
-- 顯示book表格的書名與價格
-- 價格為NULL則不顯示
-- 若price >= 1000，顯示expensive，否則顯示cheap
select book_name, price, 
if(price >= 1000, 'expensive', 'cheap') as tag 
from book
where price is not null;
