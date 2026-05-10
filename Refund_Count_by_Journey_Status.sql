-- Refund Count by Journey Status

SELECT
    Journey_Status,
    COUNT(*)                                                      AS Total_Journeys,
    SUM(CASE WHEN Refund_Request = 'Yes' THEN 1 ELSE 0 END)     AS Refund_Count
FROM Railway
GROUP BY Journey_Status
ORDER BY Journey_Status;