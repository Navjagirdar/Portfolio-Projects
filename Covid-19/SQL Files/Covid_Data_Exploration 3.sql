/*
  Covid-19 Data Exploration 
  Table: dbo.CovidDeaths
  Skills Used: CTE, Aggregated Functions, Temp Table, Converting Data type, and Windows Function

*/

-- Confirming Table got imported properly 
select * from dbo.CovidDeaths
where continent is not null
order by 2,3 ;


-- Showing countries with highest hospitalized people
Select location, population, max(cast(hosp_patients as int)) As HospitalizedPeople
from dbo.CovidDeaths
where hosp_patients is not null
and continent is not null
group by location, population
order by 3 desc;

-- Highest Hospitalize People Vs Population 
-- Showing what percentage of peoeple got hospitalized 
Select location, population, max(cast(hosp_patients as int)) As HospitalizedPeople, 
(max(cast(hosp_patients as int)) / population) * 100 As PercentHopitalized 
from dbo.CovidDeaths
where hosp_patients is not null
group by location, population
order by 4 desc;


-- Looking for Countries with highest people hospitalized compared to highest infection rate 
Select location, population, Max(total_cases) as MaxTotalCases, Max(cast(hosp_patients as int)) as MaxHospitalizedPatients
from dbo.CovidDeaths
where hosp_patients is not null
and continent is not null
group by location, population
order by MaxHospitalizedPatients desc;

---Created CTE to perform calculation on previous query
--what percent of infected people got hospitalized 
with HosVsCas(location, population, Max_Cases, MaxHospitalizedPatients)
as (
Select location, population, Max(total_cases) as MaxTotalCases, Max(cast(hosp_patients as int)) as MaxHospitalizedPatients
from dbo.CovidDeaths
where hosp_patients is not null
and continent is not null
group by location, population
)
Select *, (MaxHospitalizedPatients/Max_Cases)* 100 As PercentMaxHospitalized
from HosVsCas
where location like '%states'
order by 5 desc;


-- Countries with highest death compared to highest people hospitalized 
Select location, population, Max(cast(total_deaths as float)) as MaxTotalDeath, Max(cast(hosp_patients as float)) as MaxHospitalizedPatients
from dbo.CovidDeaths
where hosp_patients is not null
and continent is not null
group by location, population
order by MaxHospitalizedPatients desc;

--- Created temp table to perform calculation on previous query 
Drop table if exists #HosVsDea;
Create table #HosVsDea(
location nvarchar(255), population float, MaxTotalDeath float);
Insert into #HosVsDea 
Select location, population, Max(cast(total_deaths as float)) as MaxTotalDeath
from dbo.CovidDeaths
where continent is not null
group by location, population;

Select *, (MaxTotalDeath/population) *100 As PercentMaxDeath
from #HosVsDea
where location like '%states'
Order by 4 desc;

-- Total Population Vs Total New Cases
-- Shows the sum of Rolling New Cases in each countries by date 
Select location, date, population, new_cases, 
Sum(cast(new_cases as int)) over (Partition by location order by location, date) As RollingNewCases 
from dbo.CovidDeaths
where continent is not null
order by 1,2 ;

--- Created Temp table to perform calculation on Partition By in previous query
--- Shows highest percentage of Roling New Cases for each Countries
Drop table if exists #PopVsNC;
Create table #PopVsNC(
location nvarchar(255), population float, RollingNewCases int); 
Insert into #PopVsNC
Select location, population, 
Sum(cast(new_cases as int)) over (Partition by location order by location, date) As RollingNewCases 
from dbo.CovidDeaths
where continent is not null;

select location, population, Max(RollingNewCases) As MaxRollingNewCases, 
(Max(RollingNewCases) / population) * 100  As PercentRollingNewCases from #PopVsNC
where location like '%states'
group by location, population
order by 4 desc


--Ranking the countries by highest percent of new cases 
--Create Temp table
Drop table if exists #Ranking;
Create table #Ranking(
location nvarchar(255), population nvarchar(255), MaxRollingNewCases int, PercentRollingNewCases float
);

Insert into #Ranking
select location, population, Max(RollingNewCases) As MaxRollingNewCases, 
(Max(RollingNewCases) / population) * 100  As PercentRollingNewCases from #PopVsNC
group by location, population;

Select*, ROW_NUMBER() over( order by PercentRollingNewCases) As Ranking
from #Ranking
where PercentRollingNewCases is not null
Order by 5 desc



