WITH RankedSalaries AS (
    SELECT 
        e.name AS Employee, 
        d.name AS Department, 
        e.salary, 
        DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS rnk
    FROM Employee e
    JOIN Department d ON e.departmentId = d.id
)
SELECT Department, Employee, salary
FROM RankedSalaries
WHERE rnk <= 3;
