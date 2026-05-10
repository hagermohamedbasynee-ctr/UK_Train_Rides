
SELECT * FROM Railway

--- Average Delay Time by Reason

SELECT
    Reason_for_Delay,

    COUNT(*)                  AS Total_Delayed,
    ROUND(AVG([ Delay_Time]),2)      AS Avg_Delay_Mins,
    ROUND(MAX([ Delay_Time]),2)     AS Max_Delay_Mins
FROM Railway
WHERE Journey_Status = 'Delayed'
GROUP BY Reason_for_Delay
ORDER BY Avg_Delay_Mins DESC;
