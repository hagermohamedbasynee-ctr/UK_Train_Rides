-- Top 5 Most Delayed Routes

SELECT TOP 5
    Route,
    COUNT(*)              AS Total_Delayed,
    ROUND(AVG([ Delay_Time]),2)  AS Avg_Delay_Mins
FROM Railway
WHERE Journey_Status = 'Delayed'
GROUP BY Route
ORDER BY Total_Delayed DESC;