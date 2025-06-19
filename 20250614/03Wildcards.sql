-- 🟩 Problem 1
-- Wildcards
-- Problem Statement
-- In the company_dim table, find all company names that include ‘Tech’ immediately followed by any single character. (e.g., "Lego Techs" or "Mario SuperTech.")
-- Return only the name column and return it in ascending order by the company name.

SELECT 
	name
FROM 
	company_dim

WHERE 
	name LIKE '%Tech_'

ORDER BY
    name
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟩 Problem 2
-- Wildcards
-- Problem Statement
-- Find all job postings in the job_postings_fact where the job_title includes "Engineer" in it 
-- with ONLY one character followed after the term. Get the job_id , job_title, and job_posted_date. Order by job_id in ascending order.

SELECT 
    job_id,
    job_title,
    job_posted_date

FROM 
    job_postings_fact

WHERE 
    job_title LIKE '%Engineer_'
ORDER BY
    job_id

——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟨 Problem 3
-- Wildcards
-- Problem Statement
-- Identify job postings in the job_postings_fact table where the job_title contains the pattern 
-- "a_a" anywhere in the title. Return the job_id and job_title columns. Order by job_id in ascending order.

SELECT 
    job_id,
    job_title,
    job_posted_date

FROM 
    job_postings_fact

WHERE 
    job_title LIKE '%a_a%'
ORDER BY
    job_id

