-- 流程控制函式

-- if(expr1, expr2, expr3): expr1為true回傳expr2，否則回傳expr3
select book_name, price, 
if(price >= 1000, 'expensive', 'cheap') as tag 
from book;

-- ifnull(expr1, expr2): expr1不是null則回傳expr1，否則回傳expr2
select ifnull('john', 'johnny') as name;
select ifnull(null, 'johnny') as name;
-- price為null則顯示0
select book_name, ifnull(price, 0) as price 
from book order by price;