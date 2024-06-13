# International Marriage and Divorce Landspace and Trends in Taiwan (2021-2023)

## Project Description

Over time, Taiwan's demographic landscape has shifted significantly with the addition of 570,000 new immigrants, including migrant workers and international marriages (Guo, 2022). Taiwan once had the highest rate of international marriage in Asia, comprising nearly 15.9% of all marriages (Economist, 2022). International marriages are crucial to Taiwan's demographic landscape. However, the trends in international marriages have been seldom discussed in recent years, particularly after the pandemic.

In this study, we aim to explore the evolving landscape and trends of international marriages in Taiwan post-pandemic. Specifically, our objectives are to better understand the key nationalities within International marriages in Taiwan, their marriage and divorce trends over years, and the gender dynamic within each nationality. We will incorporate the environmental and cultural factors of each nationality and consider policy contexts in our research. This study seeks to provide valuable insights for Taiwan's international marriage policy by addressing the following questions:

1. What is the overall landscape of international marriages in Taiwan?
2. What are the trends of international marriages among different nationalities in the post-pandemic years?
3. What are the gender dynamics of international marriages between major nationalities?

Initially, we planned to analyze the marriage and marriage termination data from the Department of Household Registration available on the Open Government Data platform. However, this database consists of two separate monthly files for marriages and marriage terminations. Each file contains conditional data rather than personal data, with information subdivided to the le level in each city and county, as well as various nationalities with three years. This resulted in an excessively large volume of data, including many irrelevant observations. Consequently, we modified our analysis approach to focus on data cleaning and valid observations, concentrating primarily on the major nationalities.

## Getting Started (data source, original data evaluation(what each col and data obs means), what we plan to do)

1. Download the raw data on divorce and marriage for the years 2021-2023 from the Taiwanese government website at https://data.gov.tw/dataset/32969.
2. Download and install RStudio (we will be using R version 4.3.2).
3. Install the necessary libraries in RStudio using the install.packages() command. The required libraries include readr, dplyr, ggplot2, readxl, jsonlite, tidyr, stringr, and scales.
4. Due to the large size of the raw data from the Taiwanese government website and the use of Traditional Chinese, data cleaning is necessary. This involves removing some data such as small cities, islands, and certain nationalities that are not needed. Additionally, the data should be translated into English for better usability and understanding.
5. Eliminated nationalities : 史瓦帝尼, 賴索托, 模里西斯, 其他
6. Eliminated cities : 連江縣東引鄉, 連江縣北竿鄉, 連江縣莒光鄉, 連江縣南竿鄉, 金門縣金寧鄉, 金門縣烈嶼鄉, 金門縣烏坵鄉, 金門縣金沙鎮, 金門縣金城鎮, 金門縣金湖鎮, 澎湖縣湖西鄉, 澎湖縣白沙鄉, 澎湖縣七美鄉, 澎湖縣馬公市, 澎湖縣望安鄉, 澎湖縣馬公市, 澎湖縣西嶼鄉
7. Then translate the data from Traditional Chinese to English, including household_registration_status, marriage_type, sex, original_nationality, city, and district.

## File Structure (data cleaning and what does data means, each cols obs and how to are going to use them)

During the data cleaning process, we organized the monthly .csv files of marriage and divorce data for the 3 targeted years into 6 folders. These folders are named: "2021_divorce," "2022_divorce," "2023_divorce," "2021_marriage," "2022_marriage," and "2023_marriage."

After completing the data cleaning, we merged the divorce and marriage data for each respective year, saved them as .csv files, and named the resulting files: "mix_2021," "mix_2022," and "mix_2023." Subsequently, we merged the data for all 3 years into a single file named "mix_110_112_all."

Finally, with the data prepared, we created a data visualization and analysis R script named "Finally_done." This script contains code for visualizing the "mix_110_112_all" file, including map plotting, line graphs, distribution graphs, and donut charts.

### Data and Methodology

We systematically cleaned the data by looping through marriage and divorce CSV files from each month over three years, from 2021 to 2023. We read all CSV files in the specified directories for each year and combined them into a single data frame. Then, we standardized the column names to clearly represent the content of each column, including year-month, district code, city/district, village, marriage type, sex, original nationality, household registration status, marriage count, and divorce count.

Next, we defined lists containing the names of different levels of administrative divisions for subsequent data processing and converted the divorce count column to numeric type for accurate calculations and analysis. We re-coded columns such as household registration status, marriage type, sex, and original nationality to English.

For better data evaluation, we removed irrelevant and unnecessary data, excluding nationalities such as Eswatini, Lesotho, Mauritius, and "Other," which account for less than 1% of the total, as well as data related to the outlying islands. Rows containing specific keywords (such as "统计年月") were also removed. We extracted the year and month from the year-month column, creating new year and month columns. Additionally, city and district names were separated from the city/district column and re-coded to English.

The marriage and divorce datasets were then merged using a left join based on common columns, creating a comprehensive data frame that includes both marriage and divorce information for each year. The merged data for each year was written to CSV files for final use.

After merging, the data from years 110 to 112 were grouped by key columns such as year, month, city, district, city level, marriage type, sex, original nationality, and household registration status. The total marriage and divorce counts were summarized for each group. This process resulted in three new data frames for years 110 to 112, each containing aggregated marriage and divorce counts. Finally, we used rbind to merge all three years' data into one complete data frame.

Through these steps, we successfully cleaned and processed the data, extracting key information (year, month, city, marriage type, sex, original nationality, marriage count, divorce count) and grouping observations by city to keep them concise. This approach ensured the data was ready for further analysis and visualization, providing a clear and organized dataset for our project.

### Visualiztion Methodology

1. Marriage and Divorce Count by Nationality Group (Including Taiwan)

We use the dual-axis line charts display the marriage and divorce counts for different nationality groups, including Taiwan, over the months from January 2021 to December 2023. The main axis shows the counts for non-Taiwanese groups, while a secondary axis scales the counts for Taiwanese. The chart helps us illustrates the trends in marriage and divorce counts across different nationality groups, providing a comparative view between Taiwanese and non-Taiwanese marriage and divorce patterns.

Calculation Methods:
- Filtered and grouped the data by year, month, and nationality group.
- Summed the marriage and divorce counts for each group.
- Created a dual-axis plot with the total marriage counts for non-Taiwanese groups on one axis and scaled marriage counts for Taiwanese on the secondary axis(reduced by 20 times for better review) .


2. The Divorce and Marriage Ratio of Different Nationalities in Taiwan's international marriage 

we use two pie charts displays the proportions of divorces and marriage among different nationalities, excluding Taiwanese, in Taiwan. Each segment represents a nationality, and its size indicates the proportion of divorces within that group compared to the total divorces among all non-Taiwanese nationalities. these two plots provides a clear visual representation of the distribution of divorces and marriages among different nationalities in Taiwan. They identifies the nationalities with higher proportions of marriages and  highlights the nationalities with higher proportions of divorces and offers insights into the marital stability of various non-Taiwanese groups and the popularity and prevalence of marriages among various non-Taiwanese groups.

Calculation Methods:

- Filtered the dataset to include only non-Taiwanese individuals.
- Grouped the data by nationality and summed the divorce and the marriage counts.
- Calculated the proportion of divorces and marriages for each nationality relative to the total divorces among non-Taiwanese individuals.
- Sorted the nationalities by their proportion of divorces and marriages in descending order.
- Used a larger color palette to ensure distinct colors for each nationality.
- Created a pie chart with sorted segments, displaying the proportion of divorces and marriages for each nationality.


3. Divorce Gender Ratio by Nationality (Calculated by Marriage Count)
 
we use the horizontal bar chart displays the gender ratio of divorces by nationality, normalized by the marriage count. It shows the proportion of divorces by gender for each nationality and reveals gender-specific divorce patterns among major nationalities, normalized by marriage counts to provide a balanced view of gender disparities in divorce rates.

Calculation Methods:

Filtered the dataset to include seven major nationalities.
Grouped the data by nationality and sex, summing the divorce and marriage counts.
Calculated the divorce proportion relative to the marriage count for normalization.
Created a horizontal bar chart with proportions, showing the gender ratio of divorces.

4. Marriage Gender Ratio by Nationality

We use the  horizontal bar chart illustrates the gender ratio of marriages by nationality, focusing on seven major nationalities. The chart shows the proportion of marriages by gender for each nationality and highlights the gender distribution of marriages among major nationalities, providing insights into cultural and social factors influencing marriage practices.

Calculation Methods:

- Filtered the dataset to include seven major nationalities.
- Grouped the data by nationality and sex, summing the marriage counts.
- Calculated the proportion of marriage counts for each sex within each nationality.
- Created a horizontal bar chart with proportions, sorted by the female proportions.

5. Average Marriage and Divorce Rate Distrubution Map (2021-2023)

we use two choropleth maps shows the average marriage rate and divorce rate by city in Taiwan over three years (2021 to 2023). The color gradient indicates the marriage and divorce rate, with darker shades representing higher rates. The maps provide a visual representation of marriage and divorce rates across different cities in Taiwan, highlighting regional variations and identifying areas with higher or lower rates.

Calculation Methods:

Aggregated marriage and divorce counts and population data by city and average of three years.
Calculated the marriage and divorce rate as a percentage of the population.
Computed the three-year average marriage and divorce rate for each city.
Merged the data with geographical map data of Taiwan and created choropleth maps.


## Analysis

### 1-1 What is the overall landscape of international marriages in Taiwan?


The map illustrates a concentration of higher marriage rates in the more modern and northern parts of Taiwan, particularly in Taipei (0.07%) and New Taipei City (0.06%). This trend is likely influenced by the higher population density and better economic conditions in these urban centers compared to rural areas like Hualien County (0.03%) and Taitung County (0.03%). Notably, Taoyuan City (0.06%) stands out as a major hub for migrant workers in Taiwan, which significantly contributes to its elevated marriage rate. Interestingly, some isolated regions in the central area like Nantou County (0.05%) also show higher marriage rates.

![未命名設計](https://github.com/nicrci/int_marriage_div/assets/172574448/76270de0-933f-47e6-893a-0baf5f6fbc2f)
Although the marriage rate map shows that marriage rates directly correlate with the population within cities, divorce rates are more varied and spread across the country. Surprisingly, the map reveals that less urban areas like Taoyuan City (0.03%) and Miaoli County (0.03%) tend to have higher divorce rates compared to more urban areas like Taipei City (0.02%). This disparity can be attributed to differences in lifestyle, economic pressures, and social dynamics in each city. In less urban areas, the economic challenges, such as lower employment opportunities and income instability, often contribute to financial stress within households, leading to higher divorce rates. Additionally, social isolation due to geographical distance and less developed social infrastructure in rural communities can result in a lack of social support networks, which are crucial for maintaining strong marital relationships. These factors collectively contribute to the higher divorce rates observed in less urbanized areas. 




## Results

The marriage ratio graph reveals that the top six countries for marriages with Taiwanese nationals are China (1.17%), Vietnam (1.42%), Hong Kong and Macao (0.51%), the United States (0.35%), Japan (0.29%), and Malaysia (0.25%). On the other hands, divorce ratio graph shows the top 6 countries that have the most divorce rate which are China (3.25%), Vietnam (2.26%), Indonesia (0.29%), Hong Kong and Macao (0.24%), Japan (0.2%), and Thailand (0.2%). 

A significant insight that this project has provided has a lot to do with gender imbalances and socio-economic challenges, which has been found to be largely due to hypergamy and hypogamy (Su et al, 2024). In the light of hypergamy, Japanese and U.S. marriages involve more men than women who are married to Taiwanese women. We can also see the influence of hypogamy among Vietnamese and Chinese female nationals who are married with Taiwanese males.

This project has also provided insights in regards to border policy differences. International marriages, driven by historical and economic ties, increased post-pandemic as travel resumed, but divorce rates also rose due to lockdown stress. This has been noted to be suppressed marriages and divorces (Su et al, 2024)

This project has provided insights regarding the marriage and divorce landscape in Taiwan, including its potential influencers such as urbanization, international migration, cultural beliefs, and socio-economic factors.

## Contributors

The members of this project include Billy, Nicole, and Sinaee.

## Acknowledgments

We would like to thank Professor Pien Chung-Pei for his guidance throughout the semester. For insights into our results, we would also like to thank Professor Ou Tzu-chi and Professor Su Yu-hsuan.

For the raw data, we would like to thank the specialist in the Department of Household Regiration, Ms. Lai.

Special thanks to Izz for the visual aids and support.

## References

Economist. (2011, November 15). Integration vs. conflict: Do cross-border marriages last longer? CommonWealth Magazine. Retrieved from https://www.cw.com.tw/article/5027932

Guo, Q. L. (2022, January 31). Taiwan's ethnic groups as one family 1: Passersby become locals! New residents and their children surpass one million, becoming the fourth largest ethnic group in the country. Wealth Magazine. Retrieved from https://www.wealth.com.tw/articles/9f4dae5a-aa5d-466e-a4dc-754bba352498

Halla, M., Liu, C. L., & Liu, J. T. (2019). The effect of superstition on health: Evidence from the Taiwanese Ghost month (No. w25474). National Bureau of Economic Research.

Hieu, L. T. (2015). Confucian influences on Vietnamese culture. Vietnam Social Sciences, 5(169), 71-82.

Jones, G., & Shen, H. H. (2008). International marriage in East and Southeast Asia: Trends and research emphases. Citizenship studies, 12(1), 9-25.

Yu-hsuan Su, Chi-Feng Cho, Jin-Tan Liu. (2024). Marital Stability of Transnational Couples and Chinese Bride Interview Policy: Evidence from Taiwan. Unpublished manuscript, Graduate Institute of Development Studies, National Chengchi University, Taipei, Taiwan

