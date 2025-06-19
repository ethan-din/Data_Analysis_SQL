-- 🟩 Problem 1
-- CTEs
-- Problem Statement
-- Identify companies with the most diverse (unique) job titles. 
-- Use a CTE to count the number of unique job titles per company, 
-- then select companies with the highest diversity in job titles.

with company_unique_titles as (
    select company_dim.company_id,name,job_title,count(*) as count_unique_titles
    from job_postings_fact
    inner join company_dim on 
    company_dim.company_id = job_postings_fact.company_id
    group by company_dim.company_id,company_dim.name,job_title
    
)
select name,count(*)
from company_unique_titles
group by name
order by count(*) desc
limit 10



-- Define a CTE named title_diversity to calculate unique job titles per company
WITH title_diversity AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS unique_titles  
    FROM job_postings_fact
    GROUP BY company_id  
)
-- Get company name and count of how many unique titles each company has
SELECT
    company_dim.name,  
    title_diversity.unique_titles  
FROM title_diversity
	INNER JOIN company_dim ON title_diversity.company_id = company_dim.company_id  
ORDER BY 
	unique_titles DESC  
LIMIT 10;  

——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

🟨 Problem 2
CTEs
Problem Statement
Explore job postings by listing job id, job titles, company names, 
and their average salary rates, while categorizing these salaries relative to the average 
in their respective countries. Include the month of the job posted date. 
Use CTEs, conditional logic, and date functions, to compare individual salaries with national averages.


with country_salary_avg 
    as (
        select job_country,avg(salary_year_avg) as country_salary_avg
        from job_postings_fact
        group by job_country
    )

select job_id,job_title,name,
    case 
        when salary_year_avg>country_salary_avg then 'Above Average'
        else 'Below Average' 
        end as salary_rate,
    extract(month from job_posted_date ) as job_posted_month

from job_postings_fact
inner join company_dim on company_dim.company_id =job_postings_fact.company_id
inner join country_salary_avg on country_salary_avg.job_country = job_postings_fact.job_country
order by job_id asc
limit 445



-- gets average job salary for each country
WITH avg_salaries AS (
    SELECT 
        job_country, 
        AVG(salary_year_avg) AS avg_salary
    FROM job_postings_fact
    GROUP BY job_country
)
SELECT
    -- Gets basic job info
    job_postings.job_id,
    job_postings.job_title,
    companies.name AS company_name,
    -- job_postings.salary_year_avg AS salary_rate,
    -- categorizes the salary as above or below average the average salary for the country
    CASE
        WHEN job_postings.salary_year_avg > avg_salaries.avg_salary
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_category,
    -- gets the month and year of the job posting date
    EXTRACT(MONTH FROM job_postings.job_posted_date) AS posting_month
FROM
    job_postings_fact as job_postings
INNER JOIN
    company_dim as companies ON job_postings.company_id = companies.company_id
INNER JOIN
    avg_salaries ON job_postings.job_country = avg_salaries.job_country
ORDER BY
    -- Sorts it by the most recent job postings
    job_id asc
limit 445


——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

🟥 Problem 3
CTEs
Problem Statement
Calculate the number of unique skills required by each company. 
Aim to quantify the unique skills required per company and identify which of 
these companies offer the highest average salary for positions necessitating at least one skill. 
For entities without skill-related job postings, list it as a zero skill requirement and a null salary. 
Use CTEs to separately assess the unique skill count and the maximum average salary offered by these companies.


with unique_skills as (
    select company_id,count(distinct sd.skill_id) as unique_skill
    from job_postings_fact as jpf
    left join skills_job_dim as sjd on
        sjd.job_id=jpf.job_id
    left join skills_dim as sd on 
        sd.skill_id = sjd.skill_id
    group by company_id
),
highest_salary as(
    select company_id,max(salary_year_avg) as highest_salary
    from job_postings_fact as jpf
    where jpf.job_id in (select job_id from skills_job_dim)
    group by company_id
)
select name,unique_skill,highest_salary
from company_dim cd

left join unique_skills us on 
    us.company_id = cd.company_id
left join highest_salary hs on
    hs.company_id =cd.company_id
ORDER BY cd.name
limit 10





-- Counts the distinct skills required for each company's job posting
WITH required_skills AS (
    SELECT
        companies.company_id,
        COUNT(DISTINCT skills_to_job.skill_id) AS unique_skills_required
    FROM
        company_dim AS companies 
    LEFT JOIN job_postings_fact as job_postings ON companies.company_id = job_postings.company_id
    LEFT JOIN skills_job_dim as skills_to_job ON job_postings.job_id = skills_to_job.job_id
    GROUP BY
        companies.company_id
),
-- Gets the highest average yearly salary from the jobs that require at least one skills 
max_salary AS (
    SELECT
        job_postings.company_id,
        MAX(job_postings.salary_year_avg) AS highest_average_salary
    FROM
        job_postings_fact AS job_postings
    WHERE
        job_postings.job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP BY
        job_postings.company_id
)
-- Joins 2 CTEs with table to get the query
SELECT
    companies.name,
    required_skills.unique_skills_required as unique_skills_required, --handle companies w/o any skills required
    max_salary.highest_average_salary
FROM
    company_dim AS companies
LEFT JOIN required_skills ON companies.company_id = required_skills.company_id
LEFT JOIN max_salary ON companies.company_id = max_salary.company_id
ORDER BY
    companies.name
limit 100;


——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————