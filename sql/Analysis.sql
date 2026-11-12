-- Exploratory Data Analysis

select * from layoffs_staging;

-- Max total laid off
select max(total_laid_off), max(percentage_laid_off) from layoffs_staging;

select * from layoffs_staging where percentage_laid_off = 1 order by total_laid_off desc;

SELECT 
    company,
    location,
    total_laid_off,
    date,
    industry,
    stage,
    funds_raised
FROM
    layoffs_staging
WHERE
    percentage_laid_off = 1
ORDER BY funds_raised DESC;

select company, sum(total_laid_off) from layoffs_staging group by company order by 2 desc;

select min(`date`), max(`date`) from layoffs_staging;

select industry, sum(total_laid_off) from layoffs_staging group by industry order by 2 desc;

select country, sum(total_laid_off) from layoffs_staging group by country order by 2 desc;

select company, location, industry, sum(total_laid_off) from layoffs_staging where year(`date`) = 2022 
group by company, location, industry order by sum(total_laid_off) desc;

select * from layoffs_staging where total_laid_off = (select max(total_laid_off) from layoffs_staging);
select * from layoffs_staging where total_laid_off = (select min(total_laid_off) from layoffs_staging);

select company,location,industry, sum(total_laid_off) from layoffs_staging group by company,location,industry order by
sum(total_laid_off) desc;

select year(`date`), sum(total_laid_off) from layoffs_staging group by year(`date`) order by 1;

select stage, sum(total_laid_off) from layoffs_staging group by stage order by 2 desc;

select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging group by `month` order by 1;

select date_format(`date`,"%Y-%m-01") as `month`, sum(total_laid_off)
from layoffs_staging group by `month` order by 1 asc;

with rolling_total as (
select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_laid
from layoffs_staging group by `month` order by 1 asc
)
select `month`, total_laid, sum(total_laid) over(order by `month`) as rolling_laid from rolling_total;

 
with company_year(company,years, total_laid_off) as (
select company, year(`date`),sum(total_laid_off) 
from layoffs_staging group by company, year(`date`) 
),
company_year_rank as (
select * , dense_rank() over(partition by years order by total_laid_off desc) as ranks 
from company_year
)
select * from company_year_rank where ranks <= 5;


select count(*) from layoffs_staging;

