-----------------------------------------------MYSQL Project : Pizza Sales Analysis------------------------------------------------

SELECT * FROM pizza_db.order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;

create view pizza_details as
select p.pizza_id,p.pizza_type_id,p.size,p.price,pt.name,pt.category,pt.ingredients
from pizzas as p
join pizza_types as pt
on pt.pizza_type_id=p.pizza_type_id;

select * from pizza_details;
SELECT * FROM order_details;
select * from orders;


/*Q1: Total Revenue*/
select round(sum(od.quantity*p.price),2)AS total_revenue
from order_details od
join pizza_details p
on od.pizza_id=p.pizza_id;

/*Q2: Total Pizzas Sold*/
select sum(od.quantity) as pizza_sold
from order_details od

/*Q3: Average Order Value*/
select sum(od.quantity*p.price)/count(distinct(od.order_id)) as avg_order
from order_details od
join pizza_details p
on od.pizza_id=p.pizza_id;

/*Q4: Total Orders*/
Select count(distinct(od.order_id)) as total_order
from order_details od

/*Q5: Average Pizza Per Order*/
select round(sum(od.quantity)/count(distinct(od.order_id)),0) avg_no_pizza_per_order 
from order_details od

/*Q6:Total Revenue and No of Order Per Category*/
select p.category,sum(od.quantity*p.price) as total_revenue,
count(distinct(od.order_id))as total_order
from order_details od
join pizza_details p
on od.pizza_id=p.pizza_id
group by p.category

/*Q7:Total Revenue and No of Order Per Size*/
select p.size,sum(od.quantity*p.price) as total_revenue,count(distinct(od.order_id))as total_order
from order_details od
join pizza_details p
on od.pizza_id=p.pizza_id
group by p.size

/*Q8: Hourly Trends In Orders*/
select case
when hour(o.time) between 9 and 12 then 'late morning'
when hour(o.time) between 12 and 15 then 'lunch'
when hour(o.time) between 15 and 18 then 'mid afternoon'
when hour(o.time) between 18 and 21 then 'dinner'
when hour(o.time) between 21 and 23 then 'late night'
else 'others'
end as meal_time,
count(distinct(od.order_id))as total_order
from order_details od
join orders o
on od.order_id=o.order_id
group by meal_time
order by total_order desc;

/*Q9:Daily Trend for Total Orders*/
select dayname(o.date) as day_name,count(distinct(od.order_id))as total_order
from order_details od
join orders o
on od.order_id=o.order_id
group by dayname(o.date)
order by total_order desc;

/*Q10: Monthly Trend for Total Orders*/
select monthname(o.date) as month_name ,count(distinct(od.order_id))as total_order                          
from order_details od
join orders o
on od.order_id=o.order_id
group by monthname(o.date)
order by total_order desc

/*Q11: Most Ordered Pizza */
select p.name,p.size,count(od.order_id) as count_pizza
from order_details od
join pizza_details p
on od.pizza_id=p.pizza_id
group by p.name,p.size
order by count_pizza desc;

/*Q12: Total 5 Pizza by Total Revenue*/
 select p.name,sum(od.quantity * p.price) as total_revenue
 from order_details od
 join pizza_details p
 on od.pizza_id=p.pizza_id
 group by p.name
 order by total_revenue desc
 limit 5;
 
/*Q13: Total 5 Pizza by Total Qunatity*/
select p.name,sum(od.quantity) as pizza_sold
from order_details od
join pizza_details p
on od.pizza_id=p.pizza_id
group by p.name
order by pizza_sold desc
limit 5

/*Q14: Total 5 Pizza by Category*/
select p.category,sum(od.quantity) as pizza_sold
from order_details od
join pizza_details p
on od.pizza_id=p.pizza_id
group by p.category
order by pizza_sold desc
limit 5

-----PIZZA ANALYSIS
/*Q15: Max Pizza Price*/
select name,price
from pizza_details
order by price desc;


