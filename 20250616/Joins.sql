🟩 Problem 1
JOINs
Problem Statement
Retrieve a list of job titles (job_title from the job_posting_fact table) with 
their corresponding company names (name from the company_dim table). 
Also, get the job_id, job_location, and job_posted_date. 
Only return job postings that have the 'Data Scientist' as the job title (job_title_short). Order by the job posted date in descending order.

SELECT 
	job_postings_fact.job_id,
    job_postings_fact.job_location,
    job_postings_fact.job_posted_date,
    job_postings_fact.job_title,
    company_dim.name
    
FROM job_postings_fact

LEFT JOIN 
	company_dim ON company_dim.company_id = job_postings_fact.company_id

WHERE 
	job_title_short ='Data Scientist'
    
ORDER BY
	job_posted_date DESC
   
-- 🟨 Problem 2
-- JOINs
-- Problem Statement
-- Fetch all job postings, including their job_id, job_title, job_locaiton and the names of the skills required (skills); 
-- even if no skills are listed for a job.

-- Ensure that the job has a location that includes the words 'New York' and also offers health insurance.
-- Use the job_postings_fact, skills_job_dim, and skills_dim tables.
-- Order by job_id in descending order.

SELECT 
	job_postings_fact.job_id,
    job_postings_fact.job_location,
    job_postings_fact.job_posted_date,
    job_postings_fact.job_title,
    skills_dim.skills,
    job_postings_fact.job_health_insurance
FROM job_postings_fact

LEFT JOIN 
	skills_job_dim on skills_job_dim.job_id=job_postings_fact.job_id
    
LEFT JOIN 
	skills_dim on skills_job_dim.skill_id= skills_dim.skill_id
    
where 
	job_location like '%New York%' and job_health_insurance =TRUE
    
ORDER by
	job_postings_fact.job_id desc
   
🟥 Problem 3
JOINs
Problem Statement
Identify the most in-demand skills for jobs that offer remote work and have an average yearly salary above $100,000. 
Focus on counting how many job postings mention each skill, so you can determine which skills are most valuable 
in the high-paying remote job market. Return the skill name (skills) and the number of job postings that mention each skill, 
ordered by the number of job postings in descending order.

select
	job_postings_fact.job_id,
    job_postings_fact.job_work_from_home,
    skills_dim.skills as skills_name,
    count(job_postings_fact.job_id) as number_job_postings

from 
	job_postings_fact

left join 
	skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    
left join
	skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where 
	job_work_from_home is TRUE and salary_year_avg >100000 and skills_dim.skills is not NULL
    
group by
	skills_dim.skills
having
	count(job_postings_fact.job_id)

order by 
	number_job_postings desc
    
