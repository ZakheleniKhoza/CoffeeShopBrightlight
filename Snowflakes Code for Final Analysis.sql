-----Final code for analysis -----------------------------------------------------
SELECT SUM(UNIT_PRICE*transaction_qty) AS Total_revenue,
       COUNT(TRANSACTION_ID) AS Sales_Number,
       SUM (TRANSACTION_QTY) AS Total_Unit_Sold,
       TO_CHAR(TRANSACTION_DATE,'YYYYMM') AS Month_Id,
       MONTHNAME(TRANSACTION_DATE) AS Month_name,
       DAYNAME(TRANSACTION_DATE) AS Day_of_Week,
       PRODUCT_ID,
       PRODUCT_TYPE,
       PRODUCT_CATEGORY,
       PRODUCT_DETAIL,
       store_location,

--Create the time buckets for day periods
    CASE
      WHEN TRANSACTION_TIME BETWEEN '07:00:00' AND '11:59:59' THEN 'Morning'
      WHEN TRANSACTION_TIME BETWEEN '12:00:00' AND '15:59:59' THEN 'Afrernoon'
      WHEN TRANSACTION_TIME BETWEEN '16:00:00' AND '19:59:59' THEN 'Evening'
      ELSE 'Night'
    END AS Time_buckets,
--Categories spenders by revenue------------------------------------------------
    CASE
        WHEN total_revenue < 20 THEN 'Low Spender'
        WHEN Total_revenue BETWEEN 20 AND 50 THEN 'Med Spender' 
        ELSE 'High spender'
    END AS Spending_Buckets,
------Named Database as Coffee_shop, Schema as Coffee and Table as Shop_Sales----- 
FROM COFFEE_SHOP.COFFEE.SHOP_SALES
GROUP BY PRODUCT_CATEGORY,
PRODUCT_TYPE,
PRODUCT_ID,
PRODUCT_DETAIL,
store_location,
Time_buckets,
Month_Id,
Month_name,
Day_of_week;
