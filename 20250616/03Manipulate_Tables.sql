-- 🟩 Problem 1
-- Manipulate Tables
-- Problem Statement
-- Create a table named data_science_jobs that will hold information about job postings. 
-- Include the following columns: job_id (integer and primary key), job_title (text), company_name (text), and post_date (date).

CREATE table data_science_jobs(
    job_id int primary key,
    job_title text,
    company_name text,
    post_date date
)
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟩 Problem 2
-- Manipulate Tables
-- Problem Statement
-- Insert three job postings into the data_science_jobs table. 
-- Make sure each job posting has a unique job_id, a job_title, a company_name, and a post_date.

-- Example data to insert:

-- job_id  job_title	                company_name	            post_date
-- 1	    Data Scientist	            Tech Innovations	        January 1, 2023
-- 2	    Machine Learning Engineer	Data Driven Co	            January 15, 2023
-- 3	    AI Specialist	            Future Tech	                February 1, 2023


INSERT into data_science_jobs(
    job_id,job_title,company_name,post_date
)
values
    (1,'Data Scientist', 'Tech Innovations','2023-01-01'),
    (2, 'Machine Learning Engineer','Data Driven Co','2023-01-15'),
    (3,'AI Specialist','Future Tech','2023-02-01')
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟩 Problem 3
-- Manipulate Tables
-- Problem Statement
-- Alter the data_science_jobs table to add a new boolean column (uses True or False values) named remote.

alter Table data_science_jobs
add column remote boolean


select * 
from data_science_jobs
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟩 Problem 4
-- Manipulate Tables
-- Problem Statement
-- Rename the post_date column to posted_on from the data_science_job table.

alter table data_science_jobs
rename column post_date to posted_on
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- 🟨 Problem 5
-- Manipulate Tables
-- Problem Statement
-- Modify the remote column so that it defaults to FALSE in the data_science_job table.

alter table data_science_jobs
alter column remote set DEFAULT FALSE
insert into data_science_jobs(
    job_id,
    job_title,
    company_name,
    posted_on
)
values(
    4,'Data Scientist','Google','February 5,2023'
)
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
🟩 Problem 6
Manipulate Tables
Problem Statement
Drop the company_name column from the data_science_jobs table.

alter table data_science_jobs
drop column company_name
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
🟩 Problem 7
Manipulate Tables
Problem Statement
Update the job posting with the job_id = 2 . 
Update the remote column for this job posting to TRUE in data_science_jobs.

update data_science_jobs
set remote=TRUE where job_id=2
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
🟩 Problem 8
Manipulate Tables
Problem Statement
Drop the data_science_jobs table.

drop table data_science_jobs
