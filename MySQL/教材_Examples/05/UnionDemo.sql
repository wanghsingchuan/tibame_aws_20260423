select book_name, author from book;
select publisher_name, contact from publisher;

-- UNION：書店舉辦作者與出版社酒會，客人名單上列出作者與出版社聯絡人名稱
select distinct author as guest from book
union all -- 加上ALL，重複值也會全部顯示出來
select contact as guest from publisher
order by guest;

-- 開頭加上識別文字
select distinct concat('(author) ', author) as guest from book
union all
select concat('(publisher) ', contact) as guest from publisher
order by guest;