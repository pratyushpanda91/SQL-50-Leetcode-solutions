SELECT 
    id, 
    movie, 
    description, 
    rating
FROM 
    Cinema
WHERE 
    id % 2 != 0 AND  -- Only odd-numbered IDs
    description != 'boring'  -- Exclude "boring" description
GROUP BY 
    id, movie, description, rating
HAVING 
    COUNT(id) > 0  -- Aggregate function to ensure valid rows
ORDER BY 
    rating DESC;  -- Sort by rating in descending order
