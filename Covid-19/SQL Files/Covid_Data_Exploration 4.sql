/*
  Covid-19 Data Exploration 
  Table: dbo.CovidDeaths
         dbo.CovidVaccinations
  Skills Used: Joins, CTE, Aggregated Functions, Temp Table, Converting Data type, and Windows Function
 
*/
--- Basic Select query to check the data 
select location, date, positive_rate, diabetes_prevalence 
from dbo.CovidVaccinations
where continent is not null
order by 4 desc;

-- Avg positivity rate vs diabetes prevalence 
-- Shows the Average positivity rate and Diabetes commonness in a population 
select dea.location, dea.date, dea.population,  positive_rate, diabetes_prevalence, 
Avg(cast(vac.positive_rate as float)) over (Partition by dea.location order by dea.location, dea.date) as AvgPositiveRate
from dbo.CovidDeaths as dea
join dbo.CovidVaccinations as vac on dea.location = vac.location
and dea.date = vac.date 
where vac.positive_rate is not null
order by 1, 2;

--Use CTE to calculate the highest Average positivity rate for each country 
with PosVsDp(location, population, diabetes_prevalence, AvgPositiveRate)
as (
select dea.location, dea.population, diabetes_prevalence, 
Avg(cast(vac.positive_rate as float)) over (Partition by dea.location order by dea.location, dea.date) as AvgPositiveRate
from dbo.CovidDeaths as dea
join dbo.CovidVaccinations as vac on dea.location = vac.location
and dea.date = vac.date 
where vac.positive_rate is not null
)
select location, population, diabetes_prevalence, max(AvgPositiveRate) As MaxAvgPositiveRate from PosVsDp
--where location like '%states'
group by location, population, diabetes_prevalence
order by 4 desc;


-- Looking for countries with highest Positivity rate 
Select dea.location, dea.population, Max(cast(vac.positive_rate as float)) As MaxPositiveRate
 from dbo.CovidDeaths as dea 
join  dbo.CovidVaccinations as vac on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
group by dea.location, dea.population
order by 3 desc; 

--Looking for countries with highest life expectancy per PercentPopulation infected 
select dea.location, dea.population, max(total_cases) as MaxTotalCases,
Max(vac.life_expectancy) as MaxLifeExpectancy
from dbo.CovidDeaths as dea 
join  dbo.CovidVaccinations as vac on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
group by dea.location, dea.population
order by 4 desc;

with LexVsPpi (location, population, MaxTotalCases, MaxLifeExpectancy)
as(
select dea.location, dea.population, max(total_cases) as MaxTotalCases,
Max(vac.life_expectancy) as MaxLifeExpectancy
from dbo.CovidDeaths as dea 
join  dbo.CovidVaccinations as vac on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
group by dea.location, dea.population
)
Select *, (MaxTotalCases/population) * 100 As PercentPopulationInfected from LexVsPpi
order by 4 desc;


