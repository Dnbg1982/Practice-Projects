SELECT * FROM PortfolioCOVID..CovidDeaths ORDER BY 3,4
--SELECT * FROM PortfolioCOVID..CovidTestVacci ORDER BY 3,4

SELECT location, continent, date, total_cases, new_cases, total_deaths, population
FROM PortfolioCOVID..CovidDeaths Where continent IS NOT Null
ORDER BY 1,2


SELECT location, AVG(total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioCOVID..CovidDeaths 
GROUP BY location 
ORDER BY 2 DESC

SELECT location, date ,total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_vs_Cases
FROM PortfolioCOVID..CovidDeaths
WHERE location like '%ecuador%'
ORDER BY 1,2

SELECT location, date ,total_cases, population, (total_cases/population)*100 AS Cases_vs_Population
FROM PortfolioCOVID..CovidDeaths
WHERE location like '%ecuador%'
ORDER BY 1,2

SELECT location, population ,MAX(total_cases) AS HighestInfect, MAX(total_cases/population)*100 AS Cases_max_Population
FROM PortfolioCOVID..CovidDeaths
GROUP BY location, population
ORDER BY 4 DESC

SELECT location, MAX(CONVERT(int,total_deaths)) AS HighestDeaths
FROM PortfolioCOVID..CovidDeaths
Where continent is null
GROUP BY location
ORDER BY 2 DESC

WITH PopulavsVacci (continent, location, date, population, new_vaccinations, RollingVaccination) 
as
(SELECT dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations, SUM(CONVERT(int,vacc.new_vaccinations)) 
OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVaccination  
FROM PortfolioCOVID..CovidDeaths dea JOIN PortfolioCOVID..CovidTestVacci vacc ON dea.location = vacc.location AND dea.date = vacc.date
WHERE dea.continent is not NULL)
SELECT *, (RollingVaccination/population)*100 AS PopuVaccPercent FROM PopulavsVacci 
WHERE PopulavsVacci.location like 'ecuador'

-- Temp Table
DROP TABLE IF EXISTS #PercentPopulaVacc
Create Table #PercentPopulaVacc
(Continent NVARCHAR(225), location NVARCHAR(255), DATE datetime, population NUMERIC, new_vaccinations numeric, RollingVaccination NUMERIC)

Insert into #PercentPopulaVacc
SELECT dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations, SUM(CAST(vacc.new_vaccinations as numeric)) 
OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVaccination  
FROM PortfolioCOVID..CovidDeaths dea JOIN PortfolioCOVID..CovidTestVacci vacc ON dea.location = vacc.location AND dea.date = vacc.date
WHERE dea.continent is not NULL

SELECT *, (RollingVaccination/population)*100 AS PopuVaccPercent FROM #PercentPopulaVacc
WHERE #PercentPopulaVacc.location like 'ecuador'

Create VIEW PercentPopulaVacc AS
SELECT dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations, SUM(CAST(vacc.new_vaccinations as numeric)) 
OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVaccination  
FROM PortfolioCOVID..CovidDeaths dea JOIN PortfolioCOVID..CovidTestVacci vacc ON dea.location = vacc.location AND dea.date = vacc.date
WHERE dea.continent is not NULL

SELECT *, (RollingVaccination/population)*100 AS PopuVaccPercent FROM PercentPopulaVacc


