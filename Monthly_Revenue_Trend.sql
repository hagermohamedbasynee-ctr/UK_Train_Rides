-- Monthly Revenue Trend

SELECT
    MONTH(Date_of_Journey)    AS Journey_Month,
    YEAR(Date_of_Journey)     AS Journey_Year,
    COUNT(*)                  AS Total_Journeys,
    SUM(Revenue)                AS Total_Revenue,
    ROUND(AVG(Revenue),2)                AS Avg_Ticket_Price

FROM Railway
GROUP BY YEAR(Date_of_Journey), MONTH(Date_of_Journey)
ORDER BY Journey_Year, Journey_Month;
