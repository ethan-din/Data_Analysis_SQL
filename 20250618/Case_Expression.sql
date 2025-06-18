🟩 Problem 1
CASE Statements
Problem Statement
From the job_postings_fact table, categorize the salaries from job postings that are data analyst jobs, 
and that have yearly salary information. Put salary into 3 different categories:

If the salary_year_avg is greater than or equal to $100,000, then return ‘high salary’.
If the salary_year_avg is greater than or equal to $60,000 but less than $100,000, then return ‘Standard salary.’
If the salary_year_avg is below $60,000 return ‘Low salary’.
Also, order from the highest to the lowest salaries.

select 
    job_id,
    job_title,
    salary_year_avg,
    CASE 
        when salary_year_avg >=10000 then 'High salary'
        when salary_year_avg < 60000 then 'Low salary'
        else 'Standard salary'
        end as salary_categories
from job_postings_fact
where job_title_short='Data Analyst' and salary_year_avg is not NULL
order by salary_year_avg desc

🟨 Problem 2
CASE Statements
Problem Statement
Count the number of unique companies that offer work from home (WFH) 
versus those requiring work to be on-site. 
Use the job_postings_fact table to count and compare the distinct companies 
based on their WFH policy (job_work_from_home).

select 
    count(distinct case when job_work_from_home is TRUE then company_id end) as wfh,
    count(distinct case when job_work_from_home is FALSE then company_id end) as numbr
from job_postings_fact

🟥 Problem 3
CASE Statements
Problem Statement
Write a SQL query using the job_postings_fact table that returns the following columns:
job_id
salary_year_avg
experience_level (derived using a CASE WHEN)
remote_option (derived using a CASE WHEN)
Only include rows where salary_year_avg is not null.

Instructions
Experience Level
Create a new column called experience_level based on keywords in the job_title column:
Contains "Senior" → 'Senior'
Contains "Manager" or "Lead" → 'Lead/Manager'
Contains "Junior" or "Entry" → 'Junior/Entry'
Otherwise → 'Not Specified'
Use ILIKE instead of LIKE to perform case-insensitive matching (PostgreSQL-specific).
Remote Option
Create a new column called remote_option:
If job_work_from_home is true → 'Yes'
Otherwise → 'No'
Filter and Order
Filter out rows where salary_year_avg is NULL
Order the results by job_id



select 
    job_id,
    salary_year_avg,
    case when job_title ilike '%Senior%' then 'Senior'
     when job_title ilike '%Manager%'or job_title like '%Lead%' then 'Lead/Manager'
     when job_title ilike '%Junior%'or job_title Like'%Entry%' then 'Junior/Entry'
     else 'Not Specified'
    end as experience_level,
    case 
        when job_work_from_home is TRUE then 'Yes'
        else 'No'
    end as remote_option

from job_postings_fact
where salary_year_avg is not NULL
ORDER by job_id 
limit 1000



