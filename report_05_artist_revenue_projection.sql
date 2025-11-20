USE mangomusic;

-- REPORT 5: Artist Revenue Projection
-- Business need: Calculate estimated revenue per artist based on plays
-- Premium plays = $0.004 per play, Free plays = $0.001 per play

SELECT 
    ar.name AS artist_name,
    ar.primary_genre,
    COUNT(ap.play_id) AS total_plays,
    SUM(CASE WHEN u.subscription_type = 'premium' THEN 1 ELSE 0 END) AS premium_plays,
    SUM(CASE WHEN u.subscription_type = 'free' THEN 1 ELSE 0 END) AS free_plays,
    ROUND(
        SUM(
            CASE 
                WHEN u.subscription_type = 'premium' THEN 0.004
                WHEN u.subscription_type = 'free' THEN 0.001
            END
        ), 2
    ) AS estimated_revenue_usd
FROM album_plays ap
JOIN albums al ON ap.album_id = al.album_id
JOIN artists ar ON al.artist_id = ar.artist_id
JOIN users u ON ap.user_id = u.user_id
GROUP BY ar.artist_id, ar.name, ar.primary_genre
ORDER BY estimated_revenue_usd DESC
LIMIT 50;
