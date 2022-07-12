#--------------------------------------------------------
#-------------MYSQL part 2- Q7-----------#
select CARTON_ID, LEN*WIDTH*HEIGHT as CARTON_VOL from CARTON
having CARTON_VOL > (
select sum(order_items.product_quantity*product.len*product.width*product.height) as "Total volume" from order_items
inner join product
on order_items.product_id = product.product_id
where order_items.order_id = 10006)
order by CARTON_VOL ASC limit 1;
#--------------------------------------------------------
#-------------MYSQL part 2- Q8-----------#
select oc.CUSTOMER_ID,concat(oc.customer_fname," ",oc.customer_lname) as CUSTOMER_FULLNAME, oh.ORDER_ID, sum(oi.product_quantity) as TOTAL_ORDER_QUANTITY from online_customer oc
inner join order_header oh
on oc.customer_id = oh.customer_id
inner join order_items oi
on oi.order_id = oh.order_id
where oh.order_id in (
select order_id from order_items group by order_id having sum(product_quantity)  > 10)
and oh.payment_mode = 'Credit Card' or 'Net Banking'
and oh.order_status = 'Shipped'
group by oc.customer_id;
#--------------------------------------------------------
#-------------MYSQL part 2- Q9-----------#
select oh.ORDER_ID,oc.CUSTOMER_ID,concat(oc.customer_fname," ",oc.customer_lname) as CUSTOMER_FULLNAME,  sum(oi.product_quantity) as TOTAL_ORDER_QUANTITY from online_customer oc
inner join order_header oh
on oc.customer_id = oh.customer_id
inner join order_items oi
on oi.order_id = oh.order_id
where oh.order_id in (
select order_id from order_items where order_id > 10030)
and oc.customer_fname LIKE 'A%'  and oh.order_status = 'Shipped'
group by oc.customer_id;
#--------------------------------------------------------
#-------------MYSQL part 2- Q10-----------#
select pc.PRODUCT_CLASS_DESC,sum(oi.product_quantity) as TOTAL_QUANTITY, sum(oi.product_quantity*p.product_price) as TOTAL_VALUE from
online_customer oc
inner join address ad
on oc.address_id = ad.address_id
inner join order_header oh
on oc.customer_id = oh.customer_id
inner join order_items oi
on oh.order_id = oi.order_id
inner join product p
on oi.product_id = p.product_id
inner join product_class pc
on p.product_class_code = pc.product_class_code
where oh.order_status = 'Shipped'
and ad.country not in ('India','USA')
group by pc.product_class_desc
order by TOTAL_QUANTITY desc limit 1;
