-- 🟩 Problem 1
-- UNION Operators
-- Problem Statement
-- Create a unified query that categorizes job postings into two groups: 
-- those with salary information (salary_year_avg or salary_hour_avg is not null) 
-- and those without it. Each job posting should be listed with its job_id, job_title, 
-- and an indicator of whether salary information is provided.

select job_id,job_title,'without salary info' salary_info

from job_postings_fact
where salary_year_avg is NULL and salary_hour_avg is NULL

union ALL
select job_id,job_title,'with salary info' salary_info

from job_postings_fact
where salary_year_avg is not NULL or salary_hour_avg is not NULL

ORDER BY 
    salary_info DESC, 
    job_id; 

——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

-- 🟨 Problem 2
-- UNION Operators
-- Problem Statement
-- Retrieve the job id, job title short, job location, job via, skill 
-- and skill type for each job posting from the first quarter (January to March). 
-- Using a subquery to combine job postings from the first quarter (these tables were created 
-- in the Advanced Section - Practice Problem 6 [include timestamp of Youtube video]) 
-- Only include postings with an average yearly salary greater than $70,000.
SELECT  j.job_id,
        job_title_short,
        job_location,
        job_via,
        skills_dim.skills,
        skills_dim.type
from job_postings_fact as j

left join skills_job_dim on j.job_id=skills_job_dim.job_id

left join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
where EXTRACT(MONTH from job_posted_date)<=3 and salary_year_avg>70000
ORDER BY j.job_id





——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟥 Problem 3
-- UNION Operators
-- Problem Statement
-- Analyze the monthly demand for skills by counting the number of job postings for each skill 
-- in the first quarter (January to March), utilizing data from separate tables for each month. 
-- Ensure to include skills from all job postings across these months. The tables for the first 
-- quarter job postings were created in Practice Problem 6.

select EXTRACT(year from job_posted_date)as year,
        EXTRACT(month from job_posted_date) as month,
        skills,count(f.job_id)
from job_postings_fact f

left join skills_job_dim jd on jd.job_id=f.job_id
left join skills_dim sd on sd.skill_id=jd.skill_id
where EXTRACT(month from f.job_posted_date)<4

GROUP BY year,month,skills
ORDER BY skills,year,month



-- CTE for combining job postings from January, February, and March
WITH combined_job_postings AS (
    SELECT job_id, job_posted_date
    FROM january_jobs
    UNION ALL
    SELECT job_id, job_posted_date
    FROM february_jobs
    UNION ALL
    SELECT job_id, job_posted_date
    FROM march_jobs
),
-- CTE for calculating monthly skill demand based on the combined postings
monthly_skill_demand AS (
    SELECT
        skills_dim.skills,  
        EXTRACT(YEAR FROM combined_job_postings.job_posted_date) AS year,  
        EXTRACT(MONTH FROM combined_job_postings.job_posted_date) AS month,  
        COUNT(combined_job_postings.job_id) AS postings_count 
    FROM
        combined_job_postings
    INNER JOIN skills_job_dim ON combined_job_postings.job_id = skills_job_dim.job_id  
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id  
    GROUP BY
        skills_dim.skills, 
        year, 
        month
)
-- Main query to display the demand for each skill during the first quarter
SELECT
    skills,  
    year,  
    month,  
    postings_count 
FROM
    monthly_skill_demand
ORDER BY
    skills, 
    year,
    month;  