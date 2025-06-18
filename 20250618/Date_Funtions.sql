-- 🟩 Problem 1
-- Date Functions
-- Problem Statement
-- Find the average salary both yearly (salary_year_avg) and hourly (salary_hour_avg) 
-- for job postings using the job_postings_fact table that were posted after 
-- June 1, 2023. Group the results by job schedule type. Order by the job_schedule_type in ascending order.

select 
    job_schedule_type,
    AVG(salary_year_avg) as avg_salary_year,
    AVG(salary_hour_avg) as salary_hour
    
from 
    job_postings_fact

-- where 
--     EXTRACT(month from job_posted_date)>=6
where 
    job_posted_date::date >'2023-06-01'
GROUP BY 
    job_schedule_type
ORDER BY 
    job_schedule_type
limit 
    100

🟨 Problem 2
Date Functions
Problem Statement
Count the number of job postings for each month, adjusting the job_posted_date to 
be in 'America/New_York' time zone before extracting the month. 
Assume the job_posted_date is stored in UTC. Group by and order by the month.

select 
    EXTRACT(month from job_posted_date at time zone 'UTC' at time zone 'America/New_York') as month,
    count(*) as job_count

from 
    job_postings_fact

GROUP BY 
    month
order BY
    month

🟥 Problem 3
Date Functions
Problem Statement
Find companies (include company name) that have posted jobs offering health insurance, 
where these postings were made in the second quarter of 2023. 
Use date extraction to filter by quarter. And order by the job postings count from highest to lowest.

select 
    company_dim.name,
    count(*) as job_postings_count

from
    job_postings_fact

left join 
    company_dim on job_postings_fact.company_id=company_dim.company_id

where
    EXTRACT(quarter from job_posted_date)=2 
    and job_postings_fact.job_health_insurance=TRUE

GROUP BY 
    company_dim.name
Order BY
    job_postings_count desc







