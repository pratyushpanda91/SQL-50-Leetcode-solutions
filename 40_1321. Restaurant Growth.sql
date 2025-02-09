WITH TotalAmount AS (
    SELECT visited_on, SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
),
MovingAvg AS (
    SELECT t1.visited_on, 
           SUM(t2.amount) AS amount,
           ROUND(AVG(t2.amount), 2) AS average_amount
    FROM TotalAmount t1
    JOIN TotalAmount t2
    ON t2.visited_on BETWEEN DATE_SUB(t1.visited_on, INTERVAL 6 DAY) AND t1.visited_on
    GROUP BY t1.visited_on
    HAVING COUNT(t2.visited_on) = 7
)
SELECT visited_on, amount, average_amount
FROM MovingAvg
ORDER BY visited_on;
