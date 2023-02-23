-- DATE OF HIGHEST USER ACTIVITY

-- Tiktok wanted to find out what were the top two most active user days during an advertising campaign they ran in the first week of August 2022 
-- (between the 1st to the 7th).
-- Identify the two days with the highest user activity during the advertising campaign. 
-- They've also specified that user activity must be measured in terms of unique users.
-- Output the day, date, and number of users.

-- This medium-level question recently asked by Tiktok, asks us to find the top two most active user days during an advertising campaign that 
-- ran during the first week of August.
-- To approach this solution with SQL, we can use the following functions:
-- COUNT(DISTINCT col): The question specifies the number of unique customers therefore we must remove duplicates.
-- RANK() Windows Function: By ranking in DESC order we can find the busiest days for user activity.
-- BETWEEN Filter: The question specifies dates between August 1st and 7th therefore we must apply a filter.
-- TO_CHAR: This function returns a weekday, as requested in the question.


-- CREATING DATABASE

CREATE DATABASE Daily_Questions;

-- CREATING TABLE

CREATE TABLE user_streaks (
							user_id varchar(255),
							date_visited date
							);


INSERT INTO Daily_Questions.dbo.user_streaks (user_id, date_visited)
VALUES
('u001','2022-08-01'),
('u001','2022-08-01'),
('u004','2022-08-01'),
('u005','2022-08-01'),
('u005','2022-08-01'),
('u003','2022-08-02'),
('u004','2022-08-02'),
('u004','2022-08-02'),
('u004','2022-08-02'),
('u004','2022-08-02'),
('u005','2022-08-02'),
('u005','2022-08-02'),
('u001','2022-08-03'),
('u002','2022-08-03'),
('u002','2022-08-03'),
('u004','2022-08-03'),
('u005','2022-08-03'),
('u001','2022-08-04'),
('u004','2022-08-04'),
('u005','2022-08-04'),
('u001','2022-08-05'),
('u004','2022-08-05'),
('u005','2022-08-05'),
('u006','2022-08-05'),
('u004','2022-08-05'),
('u005','2022-08-05'),
('u006','2022-08-06'),
('u006','2022-08-06'),
('u003','2022-08-06'),
('u003','2022-08-06'),
('u003','2022-08-06'),
('u004','2022-08-06'),
('u005','2022-08-06'),
('u006','2022-08-07'),
('u001','2022-08-07'),
('u001','2022-08-07'),
('u001','2022-08-07'),
('u003','2022-08-07'),
('u004','2022-08-07'),
('u005','2022-08-07'),
('u006','2022-08-08'),
('u001','2022-08-08'),
('u002','2022-08-08'),
('u002','2022-08-08'),
('u002','2022-08-08'),
('u003','2022-08-08'),
('u003','2022-08-08'),
('u004','2022-08-08'),
('u005','2022-08-08'),
('u005','2022-08-08'),
('u001','2022-08-09'),
('u003','2022-08-09'),
('u003','2022-08-09'),
('u004','2022-08-09'),
('u005','2022-08-09'),
('u001','2022-08-10'),
('u002','2022-08-10'),
('u003','2022-08-10'),
('u004','2022-08-10'),
('u005','2022-08-10'),
('u001','2022-08-11'),
('u002','2022-08-11'),
('u003','2022-08-11'),
('u004','2022-08-11'),
('u005','2022-08-11')


SET DATEFIRST 7
SELECT DISTINCT 
    'week '+ CAST(DATEPART(WEEK, date_visited)AS NVARCHAR(10)) AS weeknumber,
    COUNT(DISTINCT user_id)
   --I need to get the distinct count of users within this week as weekloggedcount
FROM 
    user_streaks    
WHERE
    date_visited > '2022-07-31' AND date_visited < '2022-08-12'
GROUP BY 'week '+ CAST(DATEPART(WEEK, date_visited)AS NVARCHAR(10))
ORDER BY
    weeknumber




SET DATEFIRST 7
SELECT  TOP 2
	'week '+ CAST(DATEPART(WEEK, date_visited)AS NVARCHAR(10)) AS weeknumber,
	DATENAME(WEEKDAY, date_visited) AS day,
	date_visited,
    COUNT(DISTINCT user_id) AS num_of_users
   --I need to get the distinct count of users within this week as weekloggedcount
FROM 
    user_streaks    
GROUP BY date_visited
ORDER BY
    COUNT(DISTINCT user_id) DESC