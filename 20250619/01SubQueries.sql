-- ❓**Question:** 

-- - Find the count of the number of remote job postings per skill
--     - Display the top 5 skills in descending order by their demand in remote jobs
--     - Include skill ID, name, and count of postings requiring the skill
--     - Why? Identify the top 5 skills in demand for remote jobs
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟩 Problem 1
-- Subqueries
-- Problem Statement
-- Identify the top 5 skills that are most frequently mentioned in job postings. 
-- Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table 
-- and then join this result with the skills_dim table to get the skill names.

WITH skill_count as 
    (SELECT skills, count(skills)
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        on skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim
        on skills_dim.skill_id = skills_job_dim.skill_id
    GROUP BY 
        skills
    ORDER BY count(skills) desc)

select *
from skill_count
LIMIT 5

SELECT skills_dim.skills
FROM skills_dim
INNER JOIN (
    SELECT 
        skill_id,
        COUNT(job_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(job_id) DESC
    LIMIT 5
) AS top_skills ON skills_dim.skill_id = top_skills.skill_id
ORDER BY top_skills.skill_count DESC;

——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟨 Problem 2
-- Subqueries
-- Problem Statement
-- Determine the size category ('Small', 'Medium', or 'Large') for each company 
-- by first identifying the number of job postings they have. 
-- Use a subquery to calculate the total job postings per company. 
-- A company is considered 'Small' if it has less than 10 job postings, 
-- 'Medium' if the number of job postings is between 10 and 50, 
-- and 'Large' if it has more than 50 job postings. 
-- Implement a subquery to aggregate job counts per company before classifying them based on size.

with company_job_count as (
    select company_dim.company_id,company_dim.name,count(*) as job_count
    from company_dim
    inner join job_postings_fact on
        job_postings_fact.company_id =company_dim.company_id
    group by company_dim.company_id,company_dim.name
)

select company_id,name,
    case 
        when job_count>50 then 'Large'
        when job_count<10 then 'Small'
        else 'Medium'
        end as size_category
from company_job_count
order by company_id



select company_id,name,
    case 
        when job_count>50 then 'Large'
        when job_count<10 then 'Small'
        else 'Medium'
        end as size_category
from  (
    select company_dim.company_id,company_dim.name,count(*) as job_count
    from company_dim
    inner join job_postings_fact on
        job_postings_fact.company_id =company_dim.company_id
    group by company_dim.company_id,company_dim.name
    ) as company_job_count
order by company_id

——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
🟥 Problem 3
Subqueries
Problem Statement
Find companies that offer an average salary above the overall average yearly salary of all job postings. 
Use subqueries to select companies with an average salary higher than the overall average salary (which is another subquery).


with company_salary_avg as (
    select company_dim.name,company_dim.company_id,avg(salary_year_avg) as company_avg
    from job_postings_fact
    inner join company_dim on company_dim.company_id = job_postings_fact.company_id
    group by company_dim.company_id,company_dim.name
),
    salary_avg as (
    select avg(salary_year_avg) as salary_avg
    from job_postings_fact
)
select *
from company_salary_avg,salary_avg
where salary_avg < company_avg



SELECT 
    company_dim.name,company_dim.company_id
FROM 
    company_dim
INNER JOIN (
    -- Subquery to calculate average salary per company
    SELECT 
        company_id, 
        AVG(salary_year_avg) AS avg_salary
    FROM job_postings_fact
    GROUP BY company_id
    ) AS company_salaries ON company_dim.company_id = company_salaries.company_id
-- Filter for companies with an average salary greater than the overall average
WHERE company_salaries.avg_salary > (
    -- Subquery to calculate the overall average salary
    SELECT AVG(salary_year_avg)
    FROM job_postings_fact
)

