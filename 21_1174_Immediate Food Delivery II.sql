WITH FirstOrders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM
        Delivery
    GROUP BY
        customer_id
),
FirstOrderDetails AS (
    SELECT
        F.customer_id,
        D.order_date,
        D.customer_pref_delivery_date
    FROM
        FirstOrders F
    JOIN
        Delivery D
    ON
        F.customer_id = D.customer_id AND F.first_order_date = D.order_date
),
ImmediateOrders AS (
    SELECT
        COUNT(*) AS immediate_count
    FROM
        FirstOrderDetails
    WHERE
        order_date = customer_pref_delivery_date
),
TotalCustomers AS (
    SELECT
        COUNT(*) AS total_count
    FROM
        FirstOrderDetails
)
SELECT
    ROUND((I.immediate_count * 100.0) / T.total_count, 2) AS immediate_percentage
FROM
    ImmediateOrders I, TotalCustomers T;
