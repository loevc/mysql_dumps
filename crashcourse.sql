-- create schame
create schema crash_course;

use crash_course;

show databases ;

show tables;

-- cmd mysql command
#  source D:\workspaces\mysql\mysql_crash_course\mysql_scripts\create.sql
#  source D:\workspaces\mysql\mysql_crash_course\mysql_scripts\populate.sql

show columns from customers;

describe customers ;

show status ;

--  show create database
--  show create table

show grants ;

show errors ;

show warnings ;

-- mysql cmd command
#  help show;

select prod_name from products;

SELECT prod_id,prod_name,prod_price  FROM products ;

select * from products;

select vend_id from products ;

select distinct vend_id from products ;

select prod_name from products limit 5;

select prod_name from products limit 5,5;
-- 第一行上面的指针 标识为0     下面的指针标识为 1
-- 行0 检索出来的第一行为行0而不是行1。因此，LIMIT 1, 1     将检索出第二行而不是第一行。
select prod_name from products limit 0,5;

select prod_name from products limit 3 , 4  ;
--  ==
select prod_name from products limit 4 offset 3  ;

select products.prod_name from products;

select products.prod_name from crash_course.products;

select prod_name from products order by prod_name;

select prod_id, prod_price , prod_name from  products order by  prod_price, prod_name;

select prod_id, prod_price , prod_name from  products order by  prod_price desc ;

select prod_id, prod_price , prod_name from  products order by  prod_price desc, prod_name ;

select  prod_price  from  products order by  prod_price desc limit 1;

select prod_name, prod_price  from  products where prod_price = 2.5 ;

-- 关于是否区分大小写的问题，可是设置排序规则  collate
select prod_name, prod_price  from  products where prod_name = 'fuses' ;

select prod_name, prod_price  from  products where prod_price < 10  ;

select prod_name, prod_price  from  products where prod_price <= 10  ;

select vend_id, prod_name  from  products where products.vend_id <> 1003  ;

select vend_id, prod_name  from  products where products.vend_id != 1003  ;

select prod_name, prod_price  from  products where prod_price between 5 and 10  ;

select prod_name from products where prod_price is null ;

-- 注意过滤列是否包含null ，如果包含，需验证结果是否符合预期， 因为null 是特殊意义的值
select cust_id from customers where cust_email is null ;

select  prod_id , prod_price ,prod_name from  products where vend_id = 1003 and prod_price <= 10 ;

select  prod_name , prod_price  from  products where vend_id = 1002 or vend_id = 1003 ;

select  prod_name , prod_price  from  products where vend_id = 1002 or vend_id = 1003 and prod_price >= 10 ;

select  prod_name , prod_price  from  products where ( vend_id = 1002 or vend_id = 1003 ) and prod_price >= 10 ;

select  prod_name , prod_price  from  products where  vend_id in ( 1002 , 1003 ) order by  prod_name;

select  prod_name , prod_price  from  products where   vend_id = 1002 or vend_id = 1003  order by  prod_name;

select  prod_name , prod_price  from  products where  vend_id not in ( 1002 , 1003 ) order by  prod_name;

select prod_id, prod_name from products where prod_name like 'jet%' ;

select prod_id, prod_name from products where prod_name like '%anvil%' ;

-- 注意：  % 不能匹配 null
select  prod_name from products where prod_name like 's%e' ;

select prod_id, prod_name from products where prod_name like '_ ton anvil' ;

select prod_id, prod_name from products where prod_name like '% ton anvil' ;

--  chapter 9
select prod_name from products where prod_name regexp '1000' order by prod_name ;

-- regexp 后加 binary 开启大小写匹配
select prod_name from products where prod_name regexp '.000' order by prod_name ;

select prod_name from products where prod_name regexp '1000|2000' order by prod_name ;

select prod_name from products where prod_name regexp '[123] ton' order by prod_name ;

select prod_name from products where prod_name regexp '1|2|3 ton' order by prod_name ;

select prod_name from products where prod_name regexp '[1-5] ton' order by prod_name ;

select vend_name from vendors where vend_name regexp '.' order by vend_name;

select vend_name from vendors where vend_name regexp '\\.' order by vend_name;

select prod_name from products where prod_name regexp '\\([0-9] sticks?\\)' order by prod_name;

select prod_name from products where prod_name regexp '[[:digit:]]{4}' order by prod_name;

select prod_name from products where prod_name regexp '[0-9][0-9][0-9][0-9]' order by prod_name;

select prod_name from products where prod_name regexp '^[0-9\\.]' order by prod_name;

select 'hello' regexp '[0-9]';

-- chapter 10
select concat(vend_name , ' (' , vend_country, ')') from vendors order by vend_name;

select concat (rtrim(vend_name),'(',rtrim(vend_country),')') from vendors order by vend_name;

select concat (rtrim(vend_name),'(',rtrim(vend_country),')' ) as vend_title from vendors order by vend_name;

select prod_id, quantity, item_price from orderitems where order_num = 20005 ;

select prod_id, quantity, item_price , quantity* item_price as expanded_price from orderitems where order_num = 20005 ;

-- chapter 11
select vend_name , upper(vend_name) as vend_name_upcase from vendors order by vend_name;

select cust_name , cust_contact from customers where cust_contact = 'Y. Lie';

select cust_name , cust_contact from customers where soundex(cust_contact) = soundex('Y. Lie');

select cust_id , order_num from orders where  order_date = '2005-09-01';

select cust_id , order_num from orders where  date(order_date) = '2005-09-01';

select cust_id , order_num from orders where  date(order_date) between '2005-09-01' and '2005-09-30';

select cust_id , order_num from orders where  year(order_date) = 2005 and month(order_date) =  9 ;

--  chapter 12
select avg(prod_price) as avg_price from products;

select avg(prod_price) as avg_price from products where  vend_id = 1003;

select count(*) as num_count from customers ;

select count(cust_email) as num_cust from customers;

select max(prod_price) as max_price from products;

select min(prod_price) as min_price from products;

select sum(quantity) as items_ordered from orderitems where  order_num = 20005;

select sum(item_price*quantity) as total_price from orderitems where order_num = 20005;

select avg(distinct prod_price) as avg_price from products where vend_id = 1003;

-- 不允许使用 count(distinct)
select count(*) as num_items, min(prod_price) as price_min , max(prod_price) as price_max, avg(prod_price) as price_avg from products;

-- chapter 13
select count(*) as num_prods from products where vend_id = 1003;

select vend_id , count(*) as num_prods from products group by vend_id;

--  不敲了   真tm烦  ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

select vend_id , count(*) as num_prods from products group by vend_id with rollup ;

select note_text from productnotes where match(note_text) against('rabbit') ;

select note_text from productnotes where match(note_text) against('anvils' with query expansion ) ;

select note_text from productnotes where match(note_text) against('heavy -rope*' in boolean mode) ;

-- 书上存在的修改操作
insert into customers values (null, 'Pep E. LaPew', '100 Main Street', 'Los Angeles', 'CA', '90046', 'USA', null, null) ;

-- 可以降低插入操作的优先级  对 update 和  delete 同样适用  ：
#  insert low_priority  into  ... values ...

insert into customers
    (cust_name, cust_address , cust_city , cust_state , cust_zip , cust_country)
values
    ('M Martian', '42 Galaxy Way', 'New York', 'NY' , '11213', 'USA') ;


########################
# Create customers table
########################
CREATE TABLE custnew
(
  cust_id      int       NOT NULL AUTO_INCREMENT,
  cust_name    char(50)  NOT NULL ,
  cust_address char(50)  NULL ,
  cust_city    char(50)  NULL ,
  cust_state   char(5)   NULL ,
  cust_zip     char(10)  NULL ,
  cust_country char(50)  NULL ,
  cust_contact char(50)  NULL ,
  cust_email   char(255) NULL ,
  PRIMARY KEY (cust_id)
) ENGINE=InnoDB;

-- insert select 语句
insert into customers
    (cust_id, cust_contact, cust_email, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country)
select cust_id, cust_contact, cust_email, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country
    from custnew;

update customers set cust_email = 'elmer@fudd.com' where cust_id = 10005;

update customers
    set cust_name = 'The Fudds',
          cust_email = 'elmer@fudd.com'
    where cust_id = 10005;

-- 忽略错误，这样即使一行或者多行插入错误，也不会回滚了， 可以继续更新
# update ignore  customers ...

update customers set cust_email = null where cust_id = 10005 ;

delete from customers where  cust_id = 10006;

-- 更快的删除  , 其实是删除表，再新建一个表
#  truncate table

-- how relate the reality table ?
select last_insert_id() ;

alter table vendors add vend_phone char(20);

alter table vendors drop column vend_phone;

drop table customers2;

rename table customers2 to customers;

rename  table   backup_customers to customers,
                        backup_vendors to vendors,
                        backup_products to products;

select cust_name, cust_contact
    from customers, orders, orderitems
    where customers.cust_id = orders.cust_id
        and orderitems.order_num = orders.order_num
        and prod_id = 'TNT2';

select cust_name, cust_contact
    from productcustomers
    where prod_id = 'TNT2';

-- 视图  不包含数据  ， 包含的是 sql 查询

create view productcustomers as
    select cust_name, cust_contact , prod_id
        from customers, orders, orderitems
        where customers.cust_id = orders.cust_id
            and orderitems.order_num = orders.order_num;

select * from productcustomers;

select cust_name, cust_contact from productcustomers where prod_id = 'TNT2';

create view vendorlocations as
    select concat(rtrim(vend_name), ' (', rtrim(vend_country), ')') as vend_title
        from vendors
        order by vend_name;

select * from vendorlocations;

create view customeremaillist as
    select cust_id, cust_name, cust_email
        from customers
        where cust_email is not null;

select * from customeremaillist;

create view orderitemsexpanded as
    select order_num, prod_id, quantity, item_price, quantity * item_price as expanded_price
        from orderitems;

select * from orderitemsexpanded where order_num = 20005;

call productpricing(@pricelow, @pricehigh, @priceaverage) ;

create procedure productpricing()
    begin
        select avg(prod_price) as priceaverage
            from products;
    end;

-- if in cmd command
delimiter //
# there is segment
delimiter ;
-- end  the initialize

call productpricing();

drop procedure productpricing;

drop procedure if exists productpricing;

create procedure productpricing(
    out  pl decimal(8,2),
    out ph decimal(8,2),
    out pa decimal(8,2)
)
begin
    select min(prod_price)
        into pl
        from products;
    select max(prod_price)
        into ph
        from products;
    select avg(prod_price)
        into pa
        from products;
end;

call productpricing(@pricelow, @pricehigh, @priceaverage);

-- so this variable has been storage in mysql inside;
select @priceaverage ;

select @pricehigh , @pricelow , @priceaverage ;

-- where is the procedure variable ?
show variables ;

show session variables;

create procedure ordertotal(
    in onumber int,
    out ototal decimal(8,2)
)
begin
    select sum(item_price * quantity)
        from orderitems
        where order_num = onumber
        into ototal;
end;

call ordertotal(20005, @total) ;

select @total;

call ordertotal(20009, @total);
select @total;

-- Name: ordertotal
-- Parameters: onumber = order number
--                    taxable  = 0 if not taxable, 1 if taxable
--                    ototal    = order total variable
create procedure ordertotal(
    in onumber int,
    in taxable boolean,
    out ototal decimal(8,2)
) comment 'Obtain order total , optionally adding tax'
begin
    -- Declare variable for  total
    declare total decimal(8,2);
    -- Declare tax percentage
    declare taxrate int default 6;
    -- Get the order total
    select sum(item_price * quantity)
        from orderitems
        where order_num = onumber
        into total;
    -- Is the taxable?
    if taxable then
        -- Yes, so add taxrate to the total
        select total + (total / 100 * taxrate) into total;
    end if;
    -- And finally , save to out variable
    select total into ototal;
end;

drop procedure if exists ordertotal;

call ordertotal(20005, 0 , @total);
select @total;

call ordertotal(20005, 1 , @total);
select @total;

show create procedure ordertotal;

show procedure status ;

create procedure processorders()
begin
    declare ordernumbers cursor
        for
        select order_num from orders;
end;

call processorders();

open ordernumbers;
close ordernumbers;

drop procedure processorders;

create procedure processorders()
begin
    declare ordernumbers cursor for
    select order_num from orders;
    open ordernumbers;
    close ordernumbers;
end;

create procedure processorders()
begin
    declare o int;
    declare ordernumbers cursor for
    select order_num from orders;
    open ordernumbers;
    fetch ordernumbers into o;
    close ordernumbers;
end;

-- initialize sort :      local_variavle >  cursor >  handler
create procedure processorders()
begin
    declare done boolean default 0;
    declare o int;
    declare ordernumbers cursor for
    select order_num from orders;
    declare continue handler for sqlstate '02000' set done = 1;
    open ordernumbers;
    repeat
        fetch ordernumbers into o;
    until done end repeat;
    close ordernumbers;
end;

call processorders();

create procedure processorders()
begin
    declare done boolean default 0;
    declare o int;
    declare t decimal(8,2);
    declare ordernumbers cursor for
    select order_num from orders;
    declare continue handler for sqlstate '02000' set done = 1;
    create table if not exists ordertotals(
        order_num int,
        total decimal(8,2)
    );
    open ordernumbers;
    repeat
        fetch ordernumbers into o;
        call ordertotal(o,1,t);
        insert into ordertotals(order_num, total) values (o,t);
    until done end repeat;
    close ordernumbers;
end;

call processorders();

-- this cannot use select
create trigger newproduct after insert on products
    for each row select 'Product added';

drop trigger newproduct;

create trigger neworder after insert on orders
    for each row select new.order_num;

insert into orders(order_date, cust_id) values (now(),10001);

create trigger deleteorder before delete on orders
    for each row
        begin
            insert into archive_orders(order_num, order_date, cust_id)
                values (OLD.order_num,OLD.order_date,OLD.cust_id);
        end;



CREATE TABLE archive_orders
(
  order_num  int      NOT NULL AUTO_INCREMENT,
  order_date datetime NOT NULL ,
  cust_id    int      NOT NULL ,
  PRIMARY KEY (order_num)
) ENGINE=InnoDB;

create trigger updatevendor before update on vendors
    for each row set NEW.vend_state = UPPER(new.vend_state);

start transaction ;

select * from ordertotals;
start transaction;
delete from ordertotals;
select * from ordertotals;
rollback ;
select * from ordertotals;

start transaction ;
delete from orderitems where order_num = 20010;
delete from orders where order_num = 20010;
commit ;

savepoint delete1;
rollback to delete1;

set autocommit = 0;
set autocommit = 1;

show character set ;

show collation;

show variables like 'character%';
show variables like 'collation%';

create table mytable(
    column1 int,
    column2 varchar(10)
)default character set hebrew collate hebrew_general_ci;

drop table mytable;

create table mytable(
    column1 int,
    column2 varchar(10),
    column3 varchar(10) character set latin1 collate latin1_general_ci
)default character set hebrew collate hebrew_general_ci;

select * from customers order by lastname, firstname collate latin1_general_cs;

use mysql;

select user from user;

create user ben identified by 'p@$$w0rd';

rename user ben  to bforta;

drop user bforta;

show grants for bforta;

grant select on crash_course.* to bforta;

revoke select on crash_course.* from bforta;

grant select , insert on crash_course.* to bforta;

set password for bforta = password ('n3w p@$$w0rd');

-- set yourself password  (current user)
# set password = password ('self password')

flush tables;

analyze table orders;

check table orders, orderitems;
