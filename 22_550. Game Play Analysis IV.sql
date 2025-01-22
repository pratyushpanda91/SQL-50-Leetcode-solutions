WITH FirstLoginDate AS (
    SELECT
        player_id,
        MIN(event_date) AS first_login_date
    FROM
        Activity
    GROUP BY
        player_id
),
NextDayLogins AS (
    SELECT
        A.player_id
    FROM
        Activity A
    JOIN
        FirstLoginDate F
    ON
        A.player_id = F.player_id
        AND A.event_date = DATE_ADD(F.first_login_date, INTERVAL 1 DAY)
),
TotalPlayers AS (
    SELECT
        COUNT(DISTINCT player_id) AS total_players
    FROM
        Activity
),
PlayersWithNextDayLogin AS (
    SELECT
        COUNT(DISTINCT player_id) AS players_with_next_day_login
    FROM
        NextDayLogins
)
SELECT
    ROUND((P.players_with_next_day_login * 1.0) / T.total_players, 2) AS fraction
FROM
    PlayersWithNextDayLogin P, TotalPlayers T;
