create database hr_analytics;
use hr_analytics;


# Total Employee
select count(EmployeeNumber) 'Total Employee'
from hr_1;

# Attrition Rate 
select concat(round(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)*100,2),' %') AS Attrition_Rate
from hr_1;

# Total Hourly Rate
select round(avg(hourlyrate),2) 'Avg hourly Rate' 
from hr_1;


# KPI-1  Average Attrition rate for all Departments

select 
	Department,
	count(attrition) 'Total Employee',
    sum( case when attrition = 'yes' then 1 else 0 end) as 'Total Employee Left', 
	concat(round(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)*100,2),' %') AS Attrition_Rate
from hr_1
group by department;


# KPI-2   Average Hourly rate of Male Research Scientist

select 
	Jobrole, Gender, 
	round(avg(hourlyrate),2) 'Avg hourly Rate' 
from hr_1
where jobrole = 'research scientist' and  gender = 'male';



# KPI-3   Attrition rate Vs Monthly income stats

select 
	Department,
    count(attrition) 'Total Employee', concat(round(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)*100,2),' %') AS Attrition_Rate,
    round(avg(monthlyincome),2) 'Monthly Income'
from hr_1 
join hr_2 
on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by department;


# KPI-4   Average working years for each Department

select 
	Department,
    round(avg(totalworkingyears),2) 'Avg Working Years'
from hr_1
join hr_2
on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by department;


# KPI-5   Job Role Vs Work life balance

select 
	Jobrole,
    round(avg(worklifebalance),2) 'Avg Work-Life Balance'
from hr_1 
join hr_2 
on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by Jobrole;


# KPI-6   Attrition rate Vs Year since last promotion relation

select 
	YearsSinceLastPromotion,
    count(*) 'Count of Employee',
    concat(round(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)*100,2),' %') AS Attrition_Rate
from hr_1 
join hr_2 
on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by YearsSinceLastPromotion
order by YearsSinceLastPromotion;


