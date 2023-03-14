-- ANALYZING WEBSITE PERFORMANCE

/* Analyzing Top Website Pages & Entry Pages */

-- Top Content Overall 
SELECT 
    pageview_url, COUNT(DISTINCT website_pageview_id) AS pvs
FROM
    website_pageviews
WHERE
    website_pageview_id < 1000
GROUP BY 1
ORDER BY pvs DESC;

-- Creating Temporary Tables
-- Find the first page a user landed on 
CREATE TEMPORARY TABLE first_pageview
SELECT 
    website_session_id,
    MIN(website_pageview_id) AS min_pv_id
FROM
    website_pageviews
WHERE
    website_pageview_id < 1000
GROUP BY 1;

-- Use your Temp Tabnle in a Join Statement 
SELECT 
    website_pageviews.pageview_url AS landing_page,
    COUNT(DISTINCT first_pageview.website_session_id) AS sessions_hitting_this_lander
FROM
    first_pageview
        LEFT JOIN
    website_pageviews ON first_pageview.min_pv_id = website_pageviews.website_pageview_id
GROUP BY website_pageviews.pageview_url;

-- ASSIGNMENT: Finding Top Website Pages
/*  Could you help me get my head around the site by pulling the most_viewed website pages, ranked by session volume? */

SELECT 
    pageview_url,
    COUNT(DISTINCT website_pageview_id) AS sessions
FROM
    website_pageviews
WHERE
    created_at < '2012-06-09'
GROUP BY 1
ORDER BY 2 DESC;

/* It definitely seems like the homepage, the product page, and the Mr.Fuzzy page get the bulk of our traffic. I would 
like to understand traffic pattern more */ 