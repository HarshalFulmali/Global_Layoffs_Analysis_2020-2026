-- Data Cleaning

select * from  layoffs;

select count(*) from layoffs;

-- 1. Remove Duplicate
-- 2. Standardize the Data
-- 3. Null Value or blank values
-- 4. Remove any columns

create table layoffs_staging 
like layoffs;


select count(*) from layoffs_staging;

insert layoffs_staging 
select * from layoffs;


select * from layoffs_staging;

select *,
row_number() over(partition by company,location, total_laid_off, `date`, 
percentage_laid_off, industry, `source`, stage, funds_raised, country, date_added) as row_num
from layoffs_staging;

with duplicate_cte as (
select *,
row_number() over(partition by company,location, total_laid_off, `date`, 
percentage_laid_off, industry, `source`, stage,funds_raised,country,date_added) as row_num
from layoffs_staging
)
select * from duplicate_cte where row_num > 1;

update layoffs_staging 
set company = trim(company),
location = trim(location),
industry = trim(industry),
`source` = trim(`source`),
stage = trim(stage),
country = trim(country);

select count(distinct company) from layoffs_staging;

select count(company) from layoffs_staging;

select company from layoffs_staging order by company;

select * from layoffs_staging order by company;

select distinct country from layoffs_staging order by 1;


select * from layoffs_staging where company like "Flatiron%";

update layoffs_staging set
company = "Built Technologies"
where company like "Built Technologies%";


select `date` from layoffs_staging;

update layoffs_staging set `date` = str_to_date(`date`,"%m/%d/%Y");

alter table layoffs_staging modify column `date` date;

select * from layoffs_staging where total_laid_off = '' and percentage_laid_off = '';

select * from layoffs_staging where industry = '';
select * from layoffs_staging where company = 'Appsmith';

select distinct industry from layoffs_staging order by 1;

update layoffs_staging set industry = 'Software' where company = 'Appsmith';

select * from layoffs_staging where total_laid_off = '' and percentage_laid_off = '';

delete from layoffs_staging where total_laid_off = '' and percentage_laid_off = ''; 

select count(total_laid_off) from layoffs_staging where total_laid_off is null;

update layoffs_staging set total_laid_off = null where trim(total_laid_off) = '';

select count(*) from layoffs_staging where total_laid_off is null;

alter table layoffs_staging modify column total_laid_off int;
















