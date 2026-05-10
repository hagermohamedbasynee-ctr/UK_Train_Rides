SELECT * FROM Railway

--- On-Time Rate by Route

SELECT
    Route,
    COUNT(*)                                                            AS Total_Journeys,
    SUM(CASE WHEN Journey_Status = 'On Time' THEN 1 ELSE 0 END)       AS On_Time_Count
FROM railway
GROUP BY Route
ORDER BY Total_Journeys DESC;