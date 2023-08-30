-- SQL order: Satan Finds Joy When God Hurts Obedient Listeners

-- Overall Profit
SELECT
    sum(profit)
FROM
    student.limit;

-- Checking max profit without discounts
SELECT
    sum(profit)
FROM
    student.limit
WHERE discount > 0;

--Max profit with discounts It is in the negatives. :O
SELECT
    min(discount)
FROM
    student.limit
WHERE discount > 0;

--minimum discount
SELECT
    min(discount)
FROM
    student.limit
WHERE discount > 0;


-- discoutn that gave the most profit

SELECT
    distinct(discount),
    SUM(profit) as profit,
    sum(quantity) quantity
FROM
    student.limit

GROUP BY discount
ORDER BY profit DESC;


-- LIST OF PROFIT for all types of discounts dive deeper into products that are losing money/gaining money
SELECT
    distinct(discount) discount,
    sum(profit) profit,
    sum(quantity) quant,
    product_name,
    category

FROM student.limit
WHERE profit <0
GROUP BY discount, product_name, category
ORDER BY sum(profit) DESC;

SELECT * FROM STUDENT.LIMIT;


-- need to change data type of date column from varchar to date to query dates correctly.
ALTER TABLE student.limit ALTER COLUMN order_date TYPE DATE
    using to_date(order_date, 'DD/MM/YYYY');

-- profit for 2013 - can be used for each year, quarter or month. just change "where" part.
select
    sum(profit) as Profit_For_2013,
    sum(sales) as sales_for_2013
from student.limit
where order_date between '2013-01-01' and '2013-12-31';

-- Sales for 2013 - can be used for each year, quarter or month. just change "where" part.
select
    sum(sales) as Profit_For_2013
from student.limit
where order_date between '2013-01-01' and '2013-12-31';

SELECT
    distinct(category), sum(shipping_cost)
from
    student.limit
group by category



-- Vruti's Code
---calculating the total sales and profit for each category
SELECT category, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM  student.limit
GROUP BY Category;


--Amrit's code

-- Creating queries in sql and tableau to find information about offuture to start finding insights for our presentation
----- Total Profit Per Region

SELECT
    market, sum(profit) AS profit_per_region
FROM
    student.limit
Group BY
    market;

-- now that we seen that APAC is the most profitable region, and Canada as this is because there are less people orders from Canada
-- I wanted to see what is the Profit Per Customer. i.e dividing the total profit per region by number of people ordering from that region
SELECT
    market, sum(profit) AS profit_per_region, count(row_id) AS orders_per_region, sum(profit)/count(row_id) AS profit_per_customer
FROM
    student.limit
Group BY
    market
ORDER BY
    profit_per_customer, count(row_id);


----- Most Profitable Product

SELECT
    product_id, product_name, sum(profit) AS total_profit_per_product
FROM
    student.limit
GROUP BY
    product_id, product_name
ORDER BY total_profit_per_product DESC;

-----Most Sold Product
-- had to do the sum of the quantity instead of the count of quantity as count gave me the  number of instances the product was sold
-- but sum of the quantity shows me the total quantity sold for all instances

SELECT
    product_name, SUM(quantity) AS total_quantity_sold_per_product
FROM
    student.limit
GROUP BY
    product_name
ORDER BY total_quantity_sold_per_product DESC;


----- Least Profitable Product

SELECT
    product_id, product_name, sum(profit) AS total_profit_per_product
FROM
    student.limit
GROUP BY
    product_id, product_name
ORDER BY total_profit_per_product;

----- Least Sold Product

SELECT
    product_name, SUM(quantity) AS total_quantity_sold_per_product
FROM
    student.limit
GROUP BY
    product_name
ORDER BY total_quantity_sold_per_product;


----- Total Sales per Year
-- 2011 sales
SELECT
    SUM(sales)
FROM
    student.limit
WHERE order_date BETWEEN '2011-01-01' AND '2011-12-31';

-- 2012 sales
SELECT
    SUM(sales)
FROM
    student.limit
WHERE order_date BETWEEN '2012-01-01' AND '2012-12-31';

-- 2013 sales
SELECT
    SUM(sales)
FROM
    student.limit
WHERE order_date BETWEEN '2013-01-01' AND '2013-12-31';

-- 2014 sales
SELECT
    SUM(sales)
FROM
    student.limit
WHERE order_date BETWEEN '2014-01-01' AND '2014-12-31';

----- Total profit by Year
-- 2011 profits
SELECT
    SUM(profit)
FROM
    student.limit
WHERE order_date BETWEEN '2011-01-01' AND '2011-12-31';

-- 2012 profits
SELECT
    SUM(profit)
FROM
    student.limit
WHERE order_date BETWEEN '2012-01-01' AND '2012-12-31';

-- 2013 profits
SELECT
    SUM(profit)
FROM
    student.limit
WHERE order_date BETWEEN '2013-01-01' AND '2013-12-31';

-- 2014 profits
SELECT
    SUM(profit)
FROM
    student.limit
WHERE order_date BETWEEN '2014-01-01' AND '2014-12-31';






--- calculating the churn rate
-- number of customers at the start
SELECT
    COUNT(order_id)
FROM
    student.limit
WHERE order_date BETWEEN  '2011-01-01' AND '2011-01-31';  -- 433

--number of customers at the end
SELECT
    COUNT(order_id)
FROM
    student.limit
WHERE order_date BETWEEN '2014-12-01' AND '2014-12-31'; -- 2153



-- using CASE to split shipping_costs into categories
SELECT
    shipping_cost, category,
    CASE WHEN shipping_cost <100 THEN 'cheap'
         WHEN shipping_cost < 500 THEN 'Medium'
         WHEN shipping_cost < 1000 THEN 'Expensive'
         WHEN shipping_cost >= 1000 THEN 'Very Expensive'
         ELSE 'error'
        END AS Shipping_cost_info
FROM
    student.limit;


----- looking at the relationship between category and shipping costs
SELECT
    distinct(category), SUM(shipping_cost)
FROM
    student.limit
GROUP BY
    category;


----- looking at the relationship between profit and category

SELECT
    SUM(profit), category
FROM
    student.limit
Group by category;

-- combining two queries together
SELECT
    distinct(category), SUM(shipping_cost) as shipping_cost_total, SUM(profit) as total_profits, category
FROM
    student.limit
GROUP BY
    category;

----- Calculating the number of orders and quantity for each year
--2011
SELECT
    COUNT(order_id), sum(quantity)
FROM
    student.limit
WHERE order_date between '2011-01-01' AND '2011-12-31'; -- number of users - 8998 and quantity is 31443

--2012
SELECT
    COUNT(order_id), sum(quantity)
FROM
    student.limit
WHERE order_date between '2012-01-01' AND '2012-12-31'; -- number of users - 10962 and quantity is 38111

--2013
SELECT
    COUNT(order_id), SUM(quantity)
FROM
    student.limit
WHERE order_date between '2013-01-01' AND '2013-12-31'; -- -- number of users - 13799 and quantity is 48136

--2014
SELECT
    COUNT(order_id), sum(quantity)
FROM
    student.limit
WHERE order_date between '2014-01-01' AND '2014-12-31'; -- number of users - 17531 and quantity is 60622


----- checking to see the total profit for an item, to see if it matched with Tableau
SELECT
    product_name, sum(profit)
FROM
    student.limit
where product_name like 'Canon imageCLASS 2200 Advanced Copier%'
GROUP BY
    product_name;





-- Ka Hei

-------------------------------------------------------------------------------------------------------
--- list top 10 countries by sales
SELECT
    Country, round(SUM(sales),2 ) AS TotalSales
FROM
    student.limit
GROUP BY
    Country
ORDER BY
    TotalSales DESC
LIMIT 10;
----------------------------------------------------------------
---total sales
SELECT
    round(SUM(sales),2 ) AS TotalSales
FROM
    student.limit;
----------------------------------------------------------------------------------
---show how countries there are in a market
SELECT
    COUNT(DISTINCT country) AS country_count
FROM
    student.limit
WHERE
        market = 'Canada';
-------------------------------------------------------------------------------------------------
---calculate profit contribution in percentage from top 10 countries.
SELECT
    country,
    SUM(profit) AS total_profit,
    (SUM(profit) / (SELECT SUM(profit) FROM student.limit)) * 100 AS profit_percentage
FROM
    student.limit
GROUP BY
    country
ORDER BY
    profit_percentage desc
LIMIT 10;
---------------------------------------------------------------------------------------------------
---calculate sales percentage for top 10 countries
SELECT
    country,
    SUM(sales) AS total_sales,
    (SUM(sales) / (SELECT SUM(sales) FROM student.limit)) * 100 AS sales_percentage
FROM
    student.limit
GROUP BY
    country
ORDER BY
    sales_percentage desc
LIMIT 10;
------------------------------------------------------------------------
---list top 10 countries with most profit
SELECT
    Country, round(SUM(profit),2) AS Totalprofit
FROM
    student.limit
GROUP BY
    Country
ORDER BY
    Totalprofit DESC
LIMIT 10;
----------------------------------------------------------------------------------
---total profit
SELECT
    round(SUM(profit),2) AS Totalprofit
FROM
    student.limit;
--------------------------------------------------------------------------------------
---list markets and total profit made
SELECT
    market, round(SUM(profit),2) AS Totalprofit
FROM
    student.limit
GROUP BY
    market
ORDER BY
    Totalprofit DESC;
----------------------------------------------------------------------
---list top 10 countries that lost most profit
SELECT
    Country, round(SUM(profit), 2) AS Totallossprofit
FROM
    student.limit
GROUP BY
    Country
ORDER BY
    Totallossprofit asc
LIMIT 10;
---------------------------------------------------------------------
---list top 10 products for each country
SELECT
    product_name, Country,SUM(profit) AS Totalprofit
FROM
    student.limit
WHERE
        country = 'Chad'   ---change to country you want to find
GROUP BY
    Country, product_name
ORDER BY
    Totalprofit DESC
LIMIT 10;
-----------------------------------------------------------------
---product that made most profit
SELECT
    product_id,
    product_name,
    sum(profit) AS total_profit_per_product
FROM
    student.limit
GROUP BY
    product_id,
    product_name
ORDER BY
    total_profit_per_product DESC;
-----------------------------------------------------------------------------------
---list top 10 products that made most profit
SELECT
    product_id,
    product_name,
    sum(profit) AS total_profit_per_product,
    Country,
    round(SUM(profit),2) AS Totalprofit
FROM
    student.limit
GROUP BY
    Country,
    product_id,
    product_name
ORDER BY
    Totalprofit DESC
LIMIT 10;




