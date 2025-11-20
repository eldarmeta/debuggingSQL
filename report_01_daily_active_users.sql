USE mangomusic;

-- REPORT 1: Daily Active Users Report
-- Business need: Track platform engagement day-by-day
-- Shows unique users who played at least one album each day for the past 30 days


SELECT 
    DATE(played_at) AS activity_date,
    COUNT(DISTINCT user_id) AS daily_active_users
FROM album_plays
WHERE played_at >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY DATE(played_at)
ORDER BY activity_date DESC;
