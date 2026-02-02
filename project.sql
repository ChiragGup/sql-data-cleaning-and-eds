select * from layoff_statging;

with staging as(
select * ,
row_number() over(partition by company, location, industry,
 total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as rowNum
 from  layoff_statging
)
select * from staging
where rowNum > 1;

select * from layoff_statging
where company = 'Aware'; 



CREATE TABLE `layoff_statging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rowNum` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoff_statging_2;

insert into layoff_statging_2
select * ,
row_number() over(partition by company, location, industry,
 total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as rowNum
 from  layoff_statging
;

DELETE FROM layoff_statging_2
WHERE rowNum > 1;

select * from layoff_statging_2; 

select * FROM layoff_statging_2
WHERE rowNum > 1;


#standartlize
update layoff_statging_2
set company = trim(company);

select industry from layoff_statging_2
where industry like 'crypto%';

update layoff_statging_2
set industry = 'Crypto'
where industry like 'crypto%';

select * from layoff_statging_2
where industry like 'crypto%';

select country FROM layoff_statging_2
where country like 'United States%'
;

update layoff_statging_2
set country = 'United States'
where country like 'United States%';

select `date`, str_to_date(`date`, '%m/%d/%Y') from layoff_statging_2;

update layoff_statging_2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select `date` from layoff_statging_2;

alter table layoff_statging_2
modify column `date` date;







SET SQL_SAFE_UPDATES = 0;






