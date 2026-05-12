-- INNER JOIN: 2個表格都有相同的publisher_id才會呈現該筆資料
select book_name, price, author, b.publisher_id, publisher_name
from book b 
join publisher p on b.publisher_id = p.publisher_id
order by book_name;

-- LEFT JOIN: 只顯示左邊表格有的值，右邊表格無此值者會顯示null
select book_name, price, author, b.publisher_id, publisher_name
from book b 
left join publisher p on b.publisher_id = p.publisher_id
order by book_name;

-- RIGHT JOIN: 只顯示右邊表格有的值，左邊表格無此值者會顯示null
select book_name, price, author, b.publisher_id, p.publisher_id, publisher_name
from book b 
right join publisher p on b.publisher_id = p.publisher_id
order by book_name;

-- FULL OUTER JOIN: 顯示雙方表格都有的值，無值者會顯示null
-- MySQL不支援FULL OUTER JOIN，可將LEFT JOIN與RIGHT JOIN用UNION語法結合以達到目的
select book_name, price, author, b.publisher_id, publisher_name
from book b 
left join publisher p on b.publisher_id = p.publisher_id
union
select book_name, price, author, b.publisher_id, publisher_name
from book b 
right join publisher p on b.publisher_id = p.publisher_id
order by book_name;


select * from book;
-- 極少數情況join時不使用FK，例如：搜尋書的作者恰為出版社聯絡人(作者並非FK)
select isbn, book_name, author, contact, p.publisher_id, publisher_name 
from book b
join publisher p on b.author = p.contact;


select * from employee;
-- self join: manager_id與employee_id有相同意義
-- 將每位員工的主管名稱列出(manager_id可參照到employee_id以搜尋到name)
select e.employee_id, e.name, e.manager_id, m.name as manager_name
from employee e 
left join employee m on e.manager_id = m.employee_id;
