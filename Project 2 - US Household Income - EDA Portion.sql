
# Project 2b: US Household Income Data EDA-------------------------------------------------------------------

SELECT * 
FROM us_household_income
;

SELECT * 
FROM us_household_income_statistics
;

# 1.) Who has the most area of land and water for each state?-----------------------

SELECT * 
FROM us_household_income
;

SELECT State_Name, SUM(ALand) AS Total_Land
FROM us_household_income
GROUP BY State_Name
ORDER BY Total_Land DESC
;

# Texas and California make sense, surpised to see Missouri as # 3 here, kind of makes me question this data but I will go with this for now

# What about water?

SELECT State_Name, SUM(AWater) AS Total_Water
FROM us_household_income
GROUP BY State_Name
ORDER BY Total_Water DESC
;

# Michigan makes sense becase of the Great Lakes, with Texas and Florida coming in at 2 and 3 respectively; surpised about Texas for sure 

# What about the least amount of land and water?

SELECT State_Name, SUM(ALand) AS Total_Land
FROM us_household_income
GROUP BY State_Name
ORDER BY Total_Land 
;

# DC, Rhode Island and Deleware for the least amount of land, in that order

SELECT State_Name, SUM(AWater) AS Total_Water
FROM us_household_income
GROUP BY State_Name
ORDER BY Total_Water 
;

# DC, Wyoming and New Mexico for least amount of water, in that order 


# 2.) Tying the two tables together to look at income data - when we imported we had all of the statistics but not all of the income date, so let's do a RIGHT JOIN----------------------
# so that we get everything from the statistics table and can see where the gaps are in the other table 

SELECT *
FROM us_household_income uhi 
RIGHT JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE uhi.id IS NULL
;

# A lot of states with missing data; we'll stick with an inner join to we don't have to worry about that for now 

SELECT *
FROM us_household_income uhi 
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean != 0
;

# 3.) Isolating some columns that we want to work with in this combined view------------------------------------------------

SELECT uhi.State_Name, County, Type, `Primary`, Mean, Median 
FROM us_household_income uhi 
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean != 0
;

# Looking at Mean and Median household income on a State Level

SELECT uhi.State_Name, ROUND(AVG(Mean), 2) AS Rounded_Avg_Mean, ROUND(AVG(Median), 2) AS Rounded_Avg_Median 
FROM us_household_income uhi 
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean != 0
GROUP BY uhi.State_Name
ORDER BY Rounded_Avg_Mean
;

# Puerto Rico has the lowest average household income, followed by Mississippi and Arkansas

SELECT uhi.State_Name, ROUND(AVG(Mean), 2) AS Rounded_Avg_Mean, ROUND(AVG(Median), 2) AS Rounded_Avg_Median 
FROM us_household_income uhi 
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean != 0
GROUP BY uhi.State_Name
ORDER BY Rounded_Avg_Mean DESC
;

# On the flip slide we have DC at the highest average household income, followed by Connecticut and New Jersery

# Do we see similar patterns for median household income, which the salary that shows up the most

SELECT uhi.State_Name, ROUND(AVG(Mean), 2) AS Rounded_Avg_Mean, ROUND(AVG(Median), 2) AS Rounded_Avg_Median 
FROM us_household_income uhi 
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean != 0
GROUP BY uhi.State_Name
ORDER BY Rounded_Avg_Median
;

# In the case of median household income, Arkansas is above Mississippi - Mississippi has a higher average household income, but Arkansas has 
# a higher median household income - This could indicate that there is a greater wealth disparity in missippi, with wealthy families bringing the average up, whereas 
# in Arkansas there may not be as many wealthy families but a higher number of families in the upper middle class as compared to Mississippi 
# Louisiana was in the bottom 5 states for median household income but not average household income - I wonder why?

SELECT uhi.State_Name, ROUND(AVG(Mean), 2) AS Rounded_Avg_Mean, ROUND(AVG(Median), 2) AS Rounded_Avg_Median 
FROM us_household_income uhi 
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean != 0
GROUP BY uhi.State_Name
ORDER BY Rounded_Avg_Median DESC
;

# Wyoming makes in apperance in the top 5 for highest median income, interesting. 

# 4.) Looking at household income data broken down by Type

SELECT Type, COUNT(Type), ROUND(AVG(Mean), 2) AS Rounded_Avg_Mean, ROUND(AVG(Median), 2) AS Rounded_Avg_Median 
FROM us_household_income uhi 
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean != 0
GROUP BY Type
ORDER BY 3 DESC
;

# Municipality only has 1, which is why the average household income is so high compared to borough and track
# (not sure what a track is but there are ~29,000 of them in this dataset, by far the most frequent

# Dramatically lower average household incomes for "Urban" and "Community"

# What about Median?

SELECT Type, COUNT(Type), ROUND(AVG(Mean), 2) AS Rounded_Avg_Mean, ROUND(AVG(Median), 2) AS Rounded_Avg_Median 
FROM us_household_income uhi 
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean != 0
GROUP BY Type
ORDER BY 4 DESC
;

# Interestingly, CDP and track have the highest median household incomes, with the median household income for 
# CDP being over $116,000 a year 

# Community is at the bottom for both average and median household income;
# What states have them?

SELECT State_Name, County, City, Type
FROM us_household_income
WHERE Type = 'Community'
;

# It's all Puerto Rico, so likely the Community Type represent impoverished areas there

# 5.) Looking at this household income data on a city level----------------------------------------------------

SELECT uhi.State_Name, City,  
ROUND(AVG(Mean), 2) AS Rounded_Avg_Mean
FROM us_household_income uhi 
JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
GROUP BY uhi.State_Name, City
ORDER BY 3 DESC
;

# Wow what is going on in Delta Junction, Alaska??
# Makes sense to see Darien in top 5, I know that is a super wealthy area 
# Surpised to see Pelham so high up there
















