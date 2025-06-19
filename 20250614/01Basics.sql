-- 🟩 Problem 1
-- Basics
-- Problem Statement
-- In the job_postings_fact table get the columns job_id, job_title_short , 
-- job_location , and job_via columns. And order it in ascending order by job_location.

SELECT
	job_id,
	job_title_short,
	job_location,
	job_via
FROM
	job_postings_fact
ORDER BY
	job_location;

——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟩 Problem 2
-- Basics
-- Problem Statement
-- In the job_postings_fact table get the columns job_id, job_title_short , job_location , 
-- and job_via columns. And order it in descending order by job_title_short.

SELECT
	job_id,
	job_title_short,
	job_location,
	job_via
FROM
	job_postings_fact
ORDER BY
	job_title_short DESC;
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟩 Problem 3
-- Basics
-- Problem Statement
-- Look at only the first 10 entries for a query in the job_postings_fact table that returns job_id, 
-- job_title_short, job_location, job_via columns. Order by the job_location in ascending order.

SELECT
	job_id,
	job_title_short,
	job_location,
	job_via
FROM
	job_postings_fact
ORDER BY
	job_location
LIMIT 10;
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟨 Problem 4
-- Basics
-- Problem Statement
-- Get the unique job locations in the job_postings_fact table. 
-- Return the results in alphabetical order.

SELECT DISTINCT
	job_location
FROM
	job_postings_fact
ORDER BY
	job_location;
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟨 Problem 5
-- Basics
-- Problem Statement
-- In the job_postings_fact table get the columns job_id, job_title_short , job_location , job_via , and salary_year_avg columns. Order by job_id in ascending order. 
-- And only look at rows where job_title_short is ‘Data Engineer’.

SELECT job_id,
	job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM job_postings_fact
WHERE job_title_short='Data Engineer'
ORDER BY job_id 
