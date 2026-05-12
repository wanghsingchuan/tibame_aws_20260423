use bookshop; 

-- 新增一筆資料到publisher表格；如果值已經有單引號就再加上「\」跳脫
insert into publisher(publisher_id, publisher_name, contact, phone) 
values ('P001', 'O\'Reilly', 'Ocean', '02-23456789');

select * from publisher;

-- 新增多筆資料到publisher表格
insert into publisher(publisher_id, publisher_name, contact, phone) 
values 
('P002', 'John Wiley, Sons Inc', 'Don', '03-36962869'),
('P003', 'Manning Publications', 'Mary', '04-43456789'),
('P004', 'Apress', 'Allen', '05-59876543'),
('P005', 'McGraw-Hill', 'Mike', '06-69876543'),
('P006', 'Pearson', 'Paul', '09-98767867'),
('P00X', 'Publisher X', 'X-Man', '07-75698765'),
('P00Y', 'Publisher Y', 'Yale', '08-83698765');


-- 新增一筆資料到book表格(因為FK限制，所以book.publisher_id要參照到publisher.publisher_id，否則失敗)
insert into book 
(isbn, book_name, price, author, publication_date, publisher_id) 
values
('9780596009205', 'Head First Java', 1186 , 
'Kathy Sierra and Bert Bates', '2005-02-19', 'P001');
-- 新增失敗，因為違法FK限制
insert into book 
(isbn, book_name, price, author, publication_date, publisher_id) 
values
('001', 'Head First Java', 1186 , 
'Kathy Sierra and Bert Bates', '2005-02-19', 'P00A');

select * from book;

-- 新增多筆資料到book表格
-- 若資料類型由DATE改為TIMESTAMP(包含時分秒)，需改為「'2005-02-19 21:02:44'」
insert into book 
(isbn, book_name, price, author, publication_date, publisher_id) 
values
('9780596809157', 'R Cookbook', 935 , 
'Paul Teetor', '2016-03-01', 'P001'),
('9781491936696', 'iOS 9 Swift Programming Cookbook', 1443 , 
'Vandad Nahavandipoor', '2016-01-08', 'P001'),
('9781118407813', 'Beginning Programming with Java For Dummies', 550 , 
'Barry Burd', '2014-07-11', 'P002'),
('9781617291999', 'Java 8 in Action', 936 , 
'Raoul-gabriel Urma, Mario Fusco, Alan Mycroft', '2014-08-28', 'P003'),
('9781430237174', 'Pro IOS Apps Performance Optimization', 1151 , 
'Khang Vo', '2011-11-16', 'P004'),
('9781484226766', 'Python Unit Test Automation', 731 , 
'Ashwin Pajankar', '2017-6-12', 'P004'),
('9780071751292', 'Oracle Database 11g', 1139 , 
'Jinyu Wang', '2011-09-14', 'P005'),
('9781259587405', 'Programming the Raspberry Pi', 440 , 
'Simon Monk', '2015-10-5', 'P005'),
('9780134543666', 'Starting Out with Python', 1451 , 
'Tony Gaddis', '2017-6-15', 'P006'),
('9781119017929', 'Android App Development for Dummies, 3rd Edition', 560, 
 'Donn Felker', '2015-03-09', 'P002'),
('9783527711499', 'Android App Entwicklung fur Dummies', 845, 
 'Donn Felker', '2016-12-01', 'P002'),
('9789352133468', '25 Recipes for Getting Started with R', 303.00, 
 'Paul Teetor', '2016-08-01', 'P001');

