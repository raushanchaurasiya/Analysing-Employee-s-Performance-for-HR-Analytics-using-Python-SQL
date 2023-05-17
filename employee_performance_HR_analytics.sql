/*
Task-1 :- Find the average age of employees in each department and gender group. ( Round average  age up to two decimal places if needed)
*/

select department ,gender , round(avg(age),2) as avg_age
from employee
group by department , gender;

/*
Task-2 :- List the top 3 departments with the highest average training scores. ( Round average scores up to two decimal places if needed)
*/

select department , round(avg(avg_training_score),2) as average_training_score
from employee
group by department
order by average_training_score desc
limit 3;

/*
Task-3 :- Find the percentage of employees who have won awards in each region. (Round percentages up to two decimal places if needed)
*/

select region , round(count(*)*100/(select sum(awards_won) from employee),2) as award_percentage
from employee
where awards_won!=0
group by region;

/*
Task-4 :-Show the number of employees who have met more than 80% of KPIs for each recruitment channel and education level.
*/

select recruitment_channel,
education,
count(employee_id) as employee_count 
from employee 
where KPIs_met_more_than_80 = 1
group by recruitment_channel,education;

/*
Task-5 :-Find the average length of service for employees in each department, considering only employees with previous year ratings greater than or equal to 4. ( Round average length up to two decimal places if needed)
*/

select department,round(avg(length_of_service),2) as avgservice
from employee
where previous_year_rating >= 4
group by department;

/*
Task-6 :-List the top 5 regions with the highest average previous year ratings. ( Round average ratings up to two decimal places if needed)
*/

select region , round(avg(previous_year_rating),2) as avg_rating from employee
group by region
order by avg_rating desc
limit 5;

/*
Task-7 :- List the departments with more than 100 employees having a length of service greater than 5 years.
*/

select department , count(employee_id) from (select * from employee where length_of_service>5) a 
group by department 
having count(employee_id)>100;

/*
Task-8 :- Show the average length of service for employees who have attended more than 3 trainings, grouped by department and gender. ( Round average length up to two decimal places if needed)
*/

select department,gender,round(avg(length_of_service),2) as avg_service
from (select * from employee where no_of_trainings>3) a 
group by department,gender;

/*
Task-9 :- Find the percentage of female employees who have won awards, per department. Also show the number of female employees who won awards and total female employees. ( Round percentage up to two decimal places if needed)
*/

select department ,
round(sum(awards_won)*100/count(employee_id),2) female_award_winners_percentage ,
sum(awards_won) as female_won_award ,
count(employee_id) as total_females
from (select * from employee where gender = "f") a
group by department;

/*
Task : - 10 Calculate the percentage of employees per department who have a length of service between 5 and 10 years. ( Round percentage up to two decimal places if needed)
*/

select department, round(count(*)/(select count(*) from employee where department=e.department)*100,2) as emp_per
from employee e
where length_of_service between 5 and 10
group by department;

/*
Task :- 11 Find the top 3 regions with the highest number of employees who have met more than 80% of their KPIs and received at least one award, grouped by department and region.
*/

select department , region , count(employee_id) as total_employees
from employee 
where KPIs_met_more_than_80 = 1 and awards_won>0
group by department , region
order by total_employees desc
limit 3;

/*
Task :- 12 Calculate the average length of service for employees per education level and gender, considering only those employees who have completed more than 2 trainings and have an average training score greater than 75 ( Round average length up to two decimal places if needed)
*/

select education , gender ,round(avg(length_of_service),2) as avg_service
from employee
where no_of_trainings > 2 and avg_training_score>75
group by education , gender;

/*
Task :- 13 For each department and recruitment channel, find the total number of employees who have met more than 80% of their KPIs, have a previous_year_rating of 5, and have a length of service greater than 10 years.
*/

select department , recruitment_channel ,count(employee_id) as total_employees
from employee 
where KPIs_met_more_than_80 = 1 and previous_year_rating =5 and length_of_service >10
group by department , recruitment_channel;

/*
Task:- 14 Calculate the percentage of employees in each department who have received awards, have a previous_year_rating of 4 or 5, and an average training score above 70, grouped by department and gender ( Round percentage up to two decimal places if needed).
*/

select department,gender,
round((count(case when awards_won = 1 and previous_year_rating in (4,5)
and avg_training_score >70 then 1 end)/count(*)*100),2) as award_percentage
from employee group by department,gender;

/*
Task:- 15 List the top 5 recruitment channels with the highest average length of service for employees who have met more than 80% of their KPIs, have a previous_year_rating of 5, and an age between 25 and 45 years, grouped by department and recruitment channel. ( Round average length up to two decimal places if needed).
*/

select round(avg(length_of_service),2) avrg,department,recruitment_channel from employee
where KPIs_met_more_than_80 = 1 and previous_year_rating=5 and age between 25 and 45 group by department,recruitment_channel
order by avrg desc limit 5;
