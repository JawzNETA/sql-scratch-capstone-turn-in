SELECT COUNT (DISTINCT utm_campaign) AS 'Campaign Count'
FROM page_visits;

SELECT COUNT (DISTINCT utm_source) AS 'Source Count'
FROM page_visits;

SELECT DISTINCT utm_campaign AS 'Campaigns', utm_source AS 'Sources'
FROM page_visits;

SELECT DISTINCT page_name AS 'Page Names'
FROM page_visits;

--goal of question 3 - count first touches per campaign

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) AS first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
  SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp)
  SELECT ft_attr.utm_source, 
  ft_attr.utm_campaign, 
  COUNT (*)
  From ft_attr
  GROUP BY 1,2
  ORDER BY 3 DESC;
  
  
  --question 4 
  
  WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp)
  SELECT lt_attr.utm_source, 
  lt_attr.utm_campaign, 
  COUNT (*)
  From lt_attr
  GROUP BY 1,2
  ORDER BY 3 DESC;
  
  --question 5 - how many visitors make a purchase
  SELECT COUNT (DISTINCT user_id) 
  AS 'Customers That Purchase'
  FROM page_visits
  WHERE page_name = '4 - purchase';
  
  --question 6 - how many lt on purchase page per campaign
  
  WITH last_touch AS (SELECT user_id, MAX(timestamp) AS last_touch_at
 FROM page_visits
WHERE page_name = '4 - purchase'
  GROUP BY user_id),
  ft_attr AS (SELECT lt.user_id, lt.last_touch_at, pv.utm_source, pv.utm_campaign
  FROM last_touch lt
   JOIN page_visits pv
   ON lt.user_id = pv.user_id
   AND lt.last_touch_at=pv.timestamp)
 SELECT ft_attr.utm_source AS 'Source',
 ft_attr.utm_campaign AS 'Campaign', 
 COUNT(*) AS 'Count'
 FROM ft_attr
 GROUP By 1,2
 ORDER BY 3 DESC;
  
  
