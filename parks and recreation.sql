SELECT 
* FROM parks_and_recreation.employee_demographics;
#pemdas
SELECT first_name,
last_name,
birth_date,
age,
age+10
FROM parks_and_recreation.employee_demographics;

SELECT first_name,
last_name,
birth_date,
age,
(age+10)*10+10
FROM parks_and_recreation.employee_demographics;
#distinct
SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT first_name ,gender
FROM parks_and_recreation.employee_demographics;


SELECT 
* FROM parks_and_recreation.employee_salary;
#where function

SELECT *
FROM employee_salary
where first_name ='leslie'
;
SELECT *
FROM employee_salary
where salary>50000
;
SELECT 
* FROM employee_demographics
where gender ='female'
;
SELECT 
* FROM employee_demographics
where gender !='female'
;
SELECT 
* FROM employee_demographics
where birth_date > '1985-01-01'
;
#and or not --logical operaters
SELECT 
* FROM employee_demographics
where birth_date > '1985-01-01'
And gender="male";

SELECT 
* FROM employee_demographics
where birth_date > '1985-01-01'
Or not gender="male";

SELECT 
* FROM employee_demographics
where (first_name="lesile"and age=44)or age>55
;
#like statement
#% and _ function
SELECT 
* FROM employee_demographics
where first_name like 'jer%';
SELECT 
* FROM employee_demographics
where first_name like '%er%';

SELECT 
* FROM employee_demographics
where first_name like 'a%';

SELECT 
* FROM employee_demographics
where first_name like 'a__';
#group by function
SELECT gender
FROM employee_demographics
group by gender;

SELECT gender,avg(age)
FROM employee_demographics
group by gender;

SELECT gender,max(age)
FROM employee_demographics
group by gender;

SELECT gender,min(age)
FROM employee_demographics
group by gender;

SELECT gender,count(age)
FROM employee_demographics
group by gender;

SELECT gender,count(age),max(age),min(age),avg(age)
FROM employee_demographics
group by gender;

#order by function is to sort it ascending or descending
select *
from employee_demographics
order by first_name;

select *
from employee_demographics
order by first_name desc;

#having vs where
SELECT gender,AVG(age)
FROM employee_demographics
group by gender
having AVG(age) >40
;

select occupation,avg(salary)
from employee_salary
where occupation like'%manager%'
group by occupation
having Avg(salary)>75000;

#limit& aliasing
select *
from employee_demographics
order by age desc
limit 2,1;

#aliasing to change the of the column
SELECT gender,AVG(age) as avg_age
FROM employee_demographics
group by gender
having AVG_age >40
;
#joins

select dem.employee_id,age,occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id=sal.employee_id;
    
#outer joins
	#left joins
select *
from employee_demographics as dem
left join employee_salary as sal
	on dem.employee_id=sal.employee_id;
		#right joins
 select *
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id=sal.employee_id;       
#self join
select*
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id+1=emp2.employee_id
;
select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_santa,
emp2.first_name as first_name_santa,
emp2.last_name as last_name_santa
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id+1=emp2.employee_id
;
#joining mutiple tables together

select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id=sal.employee_id
inner join parks_departments pd
	on sal.dept_id=pd.department_id;
#unions
select first_name,last_name
from employee_demographics
union distinct
select first_name,last_name
from employee_salary;

select first_name,last_name
from employee_demographics
union all
select first_name,last_name
from employee_salary;

select first_name,last_name,'old' as label
from employee_demographics
where age>50;

select first_name,last_name,'old' as label
from employee_demographics
where age>50
union 
select first_name,last_name,'highly paid emplyee' as label
from employee_salary
where salary>70000;

select first_name,last_name,'old man' as label
from employee_demographics
where age>40 and gender='male'
union
select first_name,last_name,'old lady' as label
from employee_demographics
where age>40 and gender='female'
union 
select first_name,last_name,'highly paid emplyee' as label
from employee_salary
where salary>70000
order by first_name,last_name;

#string functions
select first_name, length(first_name)
from employee_demographics
order by 2;

select upper('Sky');
select lower('SkY');

select first_name, UPPER(first_name)
from employee_demographics
;

SELECT TRIM('       SKY'        );

SELECT LTRIM('       SKY'        );
SELECT RTRIM('       SKY'        );

SELECT 
    first_name, LEFT(first_name, 4), RIGHT(first_name, 3),
substring(first_name,4,1)
birth_date,
substring(birth_date,6,2) as birth_month
FROM
    employee_demographics;

select first_name,replace(first_name,'s','e')
from employee_demographics;

select locate('s','leslie');
select first_name,locate('an',first_name)
from employee_demographics;

select first_name,last_name,
concat(first_name,' ',last_name)
from employee_demographics;

#case statement
select first_name,
last_name,age,
case
	when age <=30 then 'young'
end
from employee_demographics;

#pay  increase  and bonus
#<50000=5%
#>50000=7%
#finance =10% of the bonus

select first_name,last_name,salary,
case
	when salary<50000 then salary*1.05
    when salary>50000 then salary*1.07 
   end as new_salary,
case
	when dept_id= 6 then salary*.10
end as bonus
    from employee_salary;
    
#subqueries
select*
from employee_demographics
where employee_id in
					(select employee_id
                    from employee_salary
                    where dept_id=1)
;

select first_name,salary,
(select avg(salary)
from employee_salary)
from employee_salary;
	
SELECT 
    AVG(max_age)
FROM
    (SELECT 
        gender,
            AVG(age) AS avg_age,
            MAX(age) AS max_age,
            MIN(age) AS min_age,
            COUNT(age)
    FROM
        employee_demographics
    GROUP BY gender) AS agg_table
;

