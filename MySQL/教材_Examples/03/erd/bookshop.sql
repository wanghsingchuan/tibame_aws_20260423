create table if not exists publisher (
  publisher_id varchar(40) primary key not null, 
  publisher_name varchar(40) unique, 
  contact varchar(40),
  phone varchar(40),
  create_time timestamp default current_timestamp on update current_timestamp
);

create table if not exists book(
  isbn char(13) primary key not null,
  book_name varchar(200) not null,
  price decimal(8, 2) check(price >= 0), 
  author varchar(200),
  publication_date date,
  publisher_id varchar(40),
  constraint fk_book_publisher 
  foreign key(publisher_id) references publisher(publisher_id)
  on delete cascade 
);

create table if not exists customer (
	customer_id varchar(40) primary key not null,
    customer_name varchar(40) unique not null,
    phone varchar(40) not null,
    address varchar(200) not null
);

create table if not exists order_master (
	order_id bigint unsigned primary key not null,
    customer_id varchar(40),
    order_date timestamp default current_timestamp on update current_timestamp,
    constraint fk_order_master_customer 
    foreign key(customer_id) references customer(customer_id)
);

create table if not exists order_detail (
	order_id bigint unsigned not null, 
    isbn char(13) not null, 
    quantity decimal(6) check(quantity > 0),
    primary key(order_id, isbn), 
    constraint fk_order_detail_order_master
    foreign key(order_id) references order_master(order_id)
    on delete cascade, 
    constraint fk_order_detail_book 
    foreign key(isbn) references book(isbn)    
);
