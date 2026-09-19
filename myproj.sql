use db_august;
select * from online_food;

-- 1. find total orders by income
SELECT `Monthly Income`, COUNT(*) AS total, SUM(CASE WHEN Output='Yes' THEN 1 ELSE 0 END) AS orders 
FROM online_food GROUP BY `Monthly Income`;

-- 2. What is the total order volume broken down by gender and age group?
SELECT Gender, CASE WHEN Age < 22 THEN '18-21' WHEN Age BETWEEN 22 AND 25 THEN '22-25' ELSE '26+' END AS age_grp, 
       SUM(CASE WHEN Output='Yes' THEN 1 ELSE 0 END) AS orders 
FROM online_food GROUP BY Gender, age_grp;

-- 3. Find customer distribution based on occupation and marital status:
SELECT Occupation, `Marital Status`, COUNT(*) AS total 
FROM online_food GROUP BY Occupation, `Marital Status`;

-- 4. What are the top 5 pin codes with the highest number of active orders?
SELECT `Pin code`, COUNT(*) AS orders 
FROM online_food WHERE Output='Yes' GROUP BY `Pin code` ORDER BY orders DESC LIMIT 5;

-- 5. Find average latitude and longitude for customers who order vs those who do not:
SELECT Output, AVG(latitude) AS avg_lat, AVG(longitude) AS avg_lng 
FROM online_food GROUP BY Output;

-- 6. What is total customer count categorized by customer type and family size?
SELECT `Customer Type`, `Family size`, COUNT(*) AS total 
FROM online_food GROUP BY `Customer Type`, `Family size`;

-- 7. Find distribution of customer types across educational qualifications:
SELECT `Educational Qualifications`, `Customer Type`, COUNT(*) AS total 
FROM online_food GROUP BY `Educational Qualifications`, `Customer Type`;

-- 8. What is the count of active orders from customers who gave negative feedback?
SELECT Occupation, COUNT(*) AS count 
FROM online_food WHERE Feedback='Negative' AND Output='Yes' GROUP BY Occupation;

-- 9. Find positive feedback percentage for each occupation category:
SELECT Occupation, ROUND(AVG(CASE WHEN Feedback='Positive' THEN 1.0 ELSE 0 END)*100, 1) AS happy_pct 
FROM online_food GROUP BY Occupation;

--- 10. What is total count of high-risk churn customers (No Order + Negative Feedback)?
SELECT Occupation, `Monthly Income`, COUNT(*) AS total 
FROM online_food WHERE Output='No' AND Feedback='Negative' GROUP BY Occupation, `Monthly Income`;