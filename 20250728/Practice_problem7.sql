-- find the count of the number of remote job postings per skill
-- display the top 5 skills by their demand in remote jobs
-- include skill id, name, and count of postings requiring the skill

WITH skill_counts as(
    SELECT sjd.skill_id,count(*) AS skill_count
    FROM skills_job_dim AS sjd 
    INNER JOIN job_postings_fact AS jpf 
    ON jpf.job_id = sjd.job_id
    WHERE jpf.job_work_from_home=TRUE AND jpf.job_title_short='Data Analyst'
    GROUP BY
        skill_id
)

SELECT sd.skill_id,skills,skill_count
FROM skill_counts
INNER JOIN skills_dim as sd
ON sd.skill_id = skill_counts.skill_id
ORDER BY skill_count DESC
limit 5