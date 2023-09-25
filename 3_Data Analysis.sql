
-- Below are the queries for "E-commerce Website Usage" Data Analysis

-- find the month in which most sales occured and the month in which lowest sales occured
select year(event_time) as year, month(event_time) as month, monthname(event_time) as month_name,
count(product_id) as net_sales, round(sum(price), 0) as revenue
from events
where event_type = 'purchase'
group by 1, 2, 3
order by net_sales desc;


-- find the top 5 hours of the day when user interact with the product but not purchase it
select hour(event_time) as hour_utc, count(*) as times_interact_but_not_purchase
from events
where event_type in ('view', 'cart')
group by 1
order by times_interact_but_not_purchase desc
limit 5;


-- find the top 5 hours of the day when user purchase the most products
select hour(event_time) as hour_utc, count(*) as times_purchase_products
from events
where event_type = 'purchase'
group by 1
order by times_purchase_products desc
limit 5;


-- top 5 brands by sales (number of products sold) 
select brand, count(product_id) as total_sales
from events
where event_type = 'purchase' and brand != ''
group by 1
order by total_sales desc
limit 5;


-- top 5 categories by sales (number of products sold) 
select category_code, count(product_id) as total_sales
from events
where event_type = 'purchase' and category_code != ''
group by 1
order by total_sales desc
limit 5;


-- top 5 customers by total items purchased in the last 6 months 
-- (here in this case we do not need to filter by date bcz we only have 6 months data)
select user_id, count(product_id) as total_items_purchased
from events
where event_type = 'purchase'
group by 1
order by total_items_purchased desc
limit 5;


-- total users by quantity of total purchase
with user_quantities as
(select user_id, count(product_id) as times
from events
where event_type = 'purchase'
group by 1)
select times, count(*) as total_users
from user_quantities
group by 1
order by 1
limit 10;


-- find the total number of users who purchased after view the item
select count(*) as total_users_purchase_after_view
from events
where event_type = 'purchase'
and (user_id, product_id) in
(select user_id, product_id 
from events where event_type = 'view');


-- how many times the customers only view but not purchase
select count(*) as total_views
from events
where event_type = 'view';


-- total cart
select count(*) as total_add_to_cart
from events
where event_type = 'cart';


-- total purchase
select count(*) as total_purchase
from events
where event_type = 'purchase';

