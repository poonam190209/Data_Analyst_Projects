use adventurework;
#Calculate unitdiscount
select 
    f.SalesOrderNumber,
    f.UnitPrice,
    f.OrderQuantity,
    f.SalesAmount,
    (1 - (f.SalesAmount / (f.UnitPrice * f.OrderQuantity))) as UnitDiscount
from
    factsaleinternet f;

# Q.4 Calculate sales amount
select 
    f.SalesOrderNumber,
    f.UnitPrice * f.OrderQuantity  as SALESAMOUNT
from 
    factsaleinternet f;
select * from factsaleinternet;

#Q.5 Calculate the ProductionCost
select 
    f.SalesOrderNumber,
    p.StandardCost * f.OrderQuantity as ProductionCost
from 
    factsaleinternet f
join
    dimproduct p on f.ProductKey = p.ProductKey;
    
#Q.6 Calculate the Profit
select
    f.SalesOrderNumber,
    (f.UnitPrice * f.OrderQuantity ) - (p.StandardCost * f.OrderQuantity) as PROFIT
from 
    factsaleinternet f
join
    dimproduct p on f.ProductKey = p.ProductKey;
    
# A pivot table in SQL can be done using GROUP BY and conditional aggregation
select 
    d.EnglishMonthName as Month,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from 
    factsaleinternet f
join
    dimdate d on f.OrderDateKey = d.DateKey
group by 
    d.EnglishMonthName;

# yearwise sales
select 
    d.CalendarYear as Year,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from 
    factsaleinternet f
join
    dimdate d on f.OrderDateKey = d.DateKey
group by 
    d.CalendarYear;

# monthwise sales
select 
    d.EnglishMonthName as Month,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from 
    factsaleinternet f
join 
    dimdate d on f.OrderDateKey = d.DateKey
group by
    d.EnglishMonthName;
    
# Quaterwise sales
select case when d.MonthNumberOfYear between 1 and 3 then 'Q1'
			when d.MonthNumberOfYear between 4 and 6 then 'Q2'
			when d.MonthNumberOfYear between 7 and 9 then 'Q3'
        else 'Q4'
    end as QUATER,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from factsaleinternet f
join 
    dimdate d on f.OrderDateKey = d.DateKey
group by
    QUATER;
    
# Salesamount and production cost together
select 
    d.EnglishMonthName as Month,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales,
    SUM(p.StandardCost * f.OrderQuantity) as TotalProductionCost
from factsaleinternet f
join
    dimdate d on f.OrderDateKey = d.DateKey
join 
    dimproduct p on f.ProductKey = p.ProductKey
group by 
    d.EnglishMonthName;
    
# additinal KPIs 
# Sales by product TOP 5 PRODUCT 
select
    p.EnglishProductName,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from
    factsaleinternet f
join 
    dimproduct p on f.ProductKey = p.ProductKey
group by
    p.EnglishProductName
order by
    TotalSales DESC
limit 5;

# Sales by customer
select 
    c.Name as CustomerFullName,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from 
    factsaleinternet f
join
    dimcustomer c on f.CustomerKey = c.CustomerKey
group by 
    c.Name;
    
# Sales by Region
select 
    st.SalesTerritoryRegion,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from
    factsaleinternet f
join 
    dimsalesterritory st on f.SalesTerritoryKey = st.SalesTerritoryKey
group by 
    st.SalesTerritoryRegion;





