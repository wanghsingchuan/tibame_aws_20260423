-- and: 查詢書名有「java」且書價在1000元以內的資料 (不區別大小寫)，而且依照書價升冪排序
select * from book
where book_name like '%java%' and price < 1000
order by price;

-- or: 查詢書名有「java」或是「python」的資料
select * from book
where book_name like '%java%' or book_name like '%python%';

-- not: 查詢書價沒有大於1000元的書
select * from book
where not price > 1000
order by price;

-- between: 查詢書價介於550(含)~935(含)元的書籍
select * from book
where price between 550 and 935
order by price;
-- 也可改用比較運算符號
select * from book
where price >= 550 and price <= 935
order by price;

-- in: 查詢出版社聯絡人是否為paul, mary或ocean
select * from publisher
where contact in ('paul', 'mary', 'ocean');
-- 也可改用or，但值很多時，可讀性差、維護困難
select * from publisher
where contact = 'paul' or contact = 'mary' or contact = 'ocean';

-- 查詢publisher_id不為P001, P002, P003
select * from publisher
where not publisher_id in ('P001', 'P002', 'P003');
-- 下列not in亦可
select * from publisher
where publisher_id not in ('P001', 'P002', 'P003');

-- not in陷阱：not in只要集合裡有null，條件就會變成unknown，結果就是no data
select * from book where publisher_id not in ('P001', 'P002', null);
-- 可改成下列寫法
select * from book where publisher_id not in ('P001', 'P002') and publisher_id is not null;

