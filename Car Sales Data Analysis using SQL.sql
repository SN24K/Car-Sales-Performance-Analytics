--- Analysis of cars sales data

--- 1. Total Sales by Year

select year(Date) as year, 
sum(price) as TotalSales
from cleaned_Car_Sales 
group by year(Date)
order by year;

--- 2. Total Sales by month and year

select year(Date) as year, MONTH(Date) as Month,
sum(price) as TotalSales
from cleaned_Car_Sales
Group by year(Date), MONTH(Date)
order by year, Month;

--- 3. Total Sales by Country

select company, sum(Price) as TotalSales
from Cleaned_Car_Sales 
Group by company
order by TotalSales Desc;

--- 4. Total Sales by Dealer

select [Dealer_Name], sum(price) as TotalSales 
from Cleaned_Car_Sales
group by [Dealer_Name]
order by TotalSales DESc;

--- 5. Average Sales Price by Car Model

select [Model], AVG(Price) as AveragePrice
from Cleaned_Car_Sales
Group by [Model]
order by AveragePrice DESC;

--- 6. Total Number of cars sold by Engine Type

select [Engine], count([Car_id])as CarsSold
from Cleaned_Car_Sales
group by [Engine]
order by CarsSold DESC;

--- 7. Total Sales by Body Style

select [Body_Style], sum(Price) as TotalSales
from CLeaned_Car_Sales
group by [Body_Style]
order by TotalSales DESC;

--- Analysis of Sales Data Using Advanced SQL techniques

--- 8. Total Sales by Year Using CTE

with YearlySales as (
     SELECt year(Date) as year, SUM(Price) as TotalSales
	 from CLeaned_Car_Sales
	 Group By Year(Date)
)

Select Year, TotalSales
From YearlySales
Order by Year;

--- 9. Total Numbers of Cars Sold by Engine Type Using Window Functions

select [Engine], COUNT([Car_id]) over (Partition by [Engine]) as CarsSold
from Cleaned_Car_Sales
group by [Engine] 
ORDER by CarsSold DESC;

--- 10. Sales and Profit by Transmission Type Using Window Function

SELECT transmission,
     SUM(Price) as TotalSales
from Cleaned_Car_Sales
group by transmission
order by TotalSales DESC;

--- Analysis Scenarios and Queries Using the three Tables --------------------------------------------------------------

--- 1. Total Sales by Year

with YearlySales as (
     SELECT year(s.Date) as year,SUM(s.Price)as TotalSales
	 FROM Sales s
	 Group by Year(s.Date)
)
SELECT Year, TotalSales
From YearlySales
Order By year;

--- 2. Total Slaes by Month and Year

WITH MonthlySales as (
     SELECT year(s.Date) as year, MONTH(s.Date) as Month, SUM(s.Price) as TotalSales
	 FROM Sales s
	 Group By Year(s.Date), MONTH(s.Date)
)
SELECT Year, Month, TotalSales
FROM MonthlySales
ORDER by year, month;

--- 3. Total Sales by Dealer

WITH DealerSales as(
     SELECT d.Dealer_Name, sum(s.Price) as TotalSales
	 From Sales s
	 join DealershipInfo d on s.Car_id = d.Car_id
	 Group by d.Dealer_Name
)
SELECT Dealer_Name, TotalSales
From DealerSales
order by TotalSales DESC;


--- 4. Sales Performance by Dealer Region

WITH RegionSales as (
     SELECT d.Dealer_Region, SUM(s.Price) as TotalSales
	 FROM Sales s
	 Join DealershipInfo d on s.Car_id = d.Car_id
	 Group by d.Dealer_Region
)
SELECT Dealer_Region, TotalSales
From RegionSales
Order by TotalSales DESC;

--- 5. Sales and Profit by Transmission Type

WITH TransmissionSales as (
     SELECT c.Transmission, SUM(s.Price) as TotalSales
	 From Sales s
	 join CarDetails c on s.Car_id = c.Car_id
	 Group by c.Transmission
)
SELECT Transmission, TotalSales
from TransmissionSales
Order By TotalSales Desc;

