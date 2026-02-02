# EDA
select company , sum(total_laid_off)
from layoff_statging_2
group by company
order by 2 desc;

SELECT MIN(`date`), max(`date`) 
from layoff_statging_2;

select industry , sum(total_laid_off)
from layoff_statging_2
group by industry
order by 2 desc;

select country , sum(total_laid_off)
from layoff_statging_2
group by country
order by 2 desc;

select year(`date`) , sum(total_laid_off)
from layoff_statging_2
group by year(`date`) 
order by 1 desc;

select stage ,  sum(total_laid_off)
from layoff_statging_2
group by stage
order by 2 desc;

select company , avg(percentage_laid_off)
from layoff_statging_2
group by company
order by 2 desc;

select substring(`date`, 6, 2) as `Month`, sum(total_laid_off)
from layoff_statging_2
group by `Month`
order by 2 desc;

select substring(`date`, 1, 7) as `Month`, sum(total_laid_off)
from layoff_statging_2
where substring(`date`, 1, 7) is not null
group by `Month`
order by 2 desc;

WITH rolling_total AS (
  SELECT 
    SUBSTRING(`date`, 1, 7) AS `Month`,
    SUM(total_laid_off) AS total_off
  FROM layoff_statging_2
  WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
  GROUP BY `Month`
  ORDER BY 1
)
SELECT 
  `Month`,
  total_off,
  SUM(total_off) OVER (order by `Month`) AS rolling_sum
FROM rolling_total;

with comapny_year as(
select company , year(`date`) as `year` , sum(total_laid_off) as total_off
from layoff_statging_2 
group by company, year(`date`)
), company_year_ranking as(
	select *,
    dense_rank() over(partition by `year` order by total_off desc) as ranking
    from comapny_year
    where `year` is not null 
)
select * from company_year_ranking
where ranking <= 5;


select * from layoff_statging_2;