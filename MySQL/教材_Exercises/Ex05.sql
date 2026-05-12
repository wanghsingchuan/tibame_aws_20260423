use bookshop;


-- Ex5-1
-- 將 customer 表格的所有欄位資料列出
select * from customer;

-- 將 customer 表格的 customer_name (別名為 customer name), phone, address 欄位資料列出
select customer_name as `customer name`, phone, address
from customer;


-- Ex5-2
-- 查詢客戶ID為C001的資料
select * from customer
where customer_id = 'C001';

-- 查詢出版日期為2016/1/1以後的書籍
select * from book 
where publication_date >= '2016-1-1';

-- 查詢居住在Taipei的客戶
select * from customer
where address like '%taipei%';


-- Ex5-3
-- 查詢居住在Taipei或Taoyuan的客戶
select * from customer
where address like '%taipei%' or address like '%taoyuan%';

-- 查詢出版日期介於2016-1-1~2016-12-31之間的書籍，而且依照出版日期降冪排序
select * from book
where publication_date between '2016-1-1' and '2016-12-31'
order by publication_date desc;
-- 也可使用函式取其年份
select * from book 
where year(publication_date) = 2016
order by publication_date desc;


-- Ex5-4
-- 統計居住在台北的客戶總數量
select count(1) as count_taipei from customer
where address like '%taipei%';

-- 統計訂單1、2號的訂購總量
select sum(quantity) from order_detail
where order_id in (1, 2);

-- 統計2016年的平均書價
select avg(price) average_price_2016 from book
where publication_date between '2016-1-1' and '2016-12-31';
-- 也可使用函式取其年份
select avg(price) from book where year(publication_date) = 2016;


-- Ex5-5
-- 舉辦讀者與作者酒會，客人名單上列出讀者與作者名稱，並列出他們的身份別
select customer_name guest, 'reader' type from customer
union all
select distinct author guest, 'author' type from book
order by type;


-- Ex5-6
-- customer LEFT JOIN order_master，
-- 顯示customer_name, phone, address, order_id, order_date欄位資料
select customer_name, phone, address, order_id, order_date
from customer c
left join order_master om on om.customer_id = c.customer_id;

-- inner join order_master, customer, order_detail, book表格，
-- 顯示order_id, customer_name, orderdate, book_name, price, quantity欄位
-- 依照order_id排序
select om.order_id, customer_name, order_date, book_name, price, quantity
from order_master om
join customer c on om.customer_id = c.customer_id
join order_detail od on om.order_id = od.order_id
join book b on od.isbn = b.isbn
order by om.order_id;


-- Ex5-7-1
-- 計算每本書的訂購總量，並列出ISBN、書名與訂購總量資訊
select b.isbn, book_name, sum(quantity) total
from book b
join order_detail od on od.isbn = b.isbn
group by b.isbn, book_name;

-- 計算每個客戶在每張訂單的訂購總量，列出客戶編號、客戶名稱、訂單編號、訂購總量，並依照客戶名稱排序
select c.customer_id, customer_name, om.order_id, sum(quantity) 
from customer c
join order_master om on om.customer_id = c.customer_id
join order_detail od on om.order_id = od.order_id
group by c.customer_id, customer_name, om.order_id
order by customer_name;

-- Ex5-7-2
-- 列出書籍總訂量在3以上的作者名與總訂量，並依照總訂量排序
select author, sum(quantity) total
from book b 
join order_detail od on b.isbn = od.isbn
group by author
having total >= 3
order by total desc;

-- 統計2016~2017年間每個月出版的書籍數量，並依照日期排序
-- 格式化符號參看 https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html 的 DATE_FORMAT()
select date_format(publication_date, '%Y-%m') pub_month, count(isbn) total
from book
where publication_date between '2016-1-1' and '2017-12-31'
group by pub_month
order by pub_month;

-- 可列出2016~2017年間出版的書籍，並依照日期排序，方便觀察
select * from book where publication_date 
between '2016-1-1' and '2017-12-31' 
order by publication_date;


-- Ex5-8
-- 找大客戶：計算各客戶總訂量佔所有訂單總訂量的百分比，列出客戶名與所佔總訂量的百分比
select c.customer_id, customer_name, sum(quantity) * 100 / (
	select sum(quantity) from order_detail
) as percent_sales
from customer c
join order_master om on c.customer_id = om.customer_id
join order_detail od on om.order_id = od.order_id
group by c.customer_id, customer_name;

-- 找大單：列出大於訂單平均訂量的訂單編號與訂量
select order_id, sum(quantity) as total_sales
from order_detail
group by order_id
having total_sales > (
	select avg(total) from ( 
		select sum(quantity) total from order_detail 
        group by order_id
	) order_id_sum
);


-- Ex5-9
-- 使用LIMIT功能列出總訂量最高2本書的ISBN、書名與總訂量
select b.isbn, book_name, sum(quantity) as total
from book b
join order_detail od on b.isbn = od.isbn
group by b.isbn, book_name
order by total desc
limit 2; 

-- 承上題，改用RANK()，若訂量相同可並列
select * from(
	select b.isbn, book_name, sum(quantity) total, 
	rank() over (order by sum(quantity) desc) total_rank
	from book b
	join order_detail od on b.isbn = od.isbn
	group by b.isbn, book_name
) book_rank
where total_rank <= 2;


-- Ex5-10
-- 先查看所有客戶訂單資訊
select c.customer_id, address, om.order_id, quantity
from customer c
join order_master om on c.customer_id = om.customer_id
join order_detail od on om.order_id = od.order_id;

-- 使用IN列出所有台北客戶的總訂量
select sum(quantity) from order_detail od
join order_master om on od.order_id = om.order_id
and customer_id in
(select customer_id from customer where address like '%taipei%');
-- 或改成下列寫法
select sum(quantity) from order_detail
where order_id in (
	select order_id from order_master 
	where customer_id in (
		select customer_id from customer where address like '%taipei%'
	)
);

-- 承上題，以EXISTS改寫
select sum(quantity) from order_detail od
join order_master om on od.order_id = om.order_id
and exists (
	select 1 from customer c 
	where om.customer_id = c.customer_id and address like '%taipei%'
);
-- 或改成下列寫法
select sum(quantity) from order_detail od where exists (
	select 1 from order_master om where od.order_id = om.order_id and exists (
        select 1 from customer c 
		where om.customer_id = c.customer_id and address like '%taipei%'
	)
);

-- 列出不在訂單上的所有書名 (使用EXISTS)
select book_name from book b where not exists (
	select 1 from order_detail od where b.isbn = od.isbn
);


-- Ex5-11
-- 建立 customer_back 表格並將 customer 表格內地址在台北的所有客戶資料插入
create table customer_back as 
select * from customer
where address like '%taipei%';

describe customer_back;
select * from customer_back;
drop table customer_back;

-- 將 customer 表格內地址在桃園的所有客戶資料插入到 customer_back 表格
insert into customer_back 
select * from customer
where address like '%taoyuan%';


-- Ex5-12
-- 查詢書名有 Python 的資料並建成 View，名稱為 my_book_view
create or replace view my_book_view as
select * from book where book_name like '%python%';

select * from my_book_view;

-- 授權帳號為 mary 的使用者只能查詢 my_book_view 內容
grant select on bookshop.my_book_view to mary;

-- 如果沒建立mary帳號，需要先建立方能授權
create user mary identified by 'mary';

-- 刪除my_book_view
drop view my_book_view;
