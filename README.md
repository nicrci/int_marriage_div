# International Marriage and Divorce Landspace and Trends in Taiwan (2021-2023)

## Project Description

Over time, Taiwan's demographic landscape has shifted significantly with the addition of 570,000 new immigrants, including migrant workers and international marriages (Guo, 2022). Taiwan once had the highest rate of international marriage in Asia, comprising nearly 15.9% of all marriages (Economist, 2022). International marriages are crucial to Taiwan's demographic landscape. However, the trends in international marriages have been seldom discussed in recent years, particularly after the pandemic.

In this study, we aim to explore the evolving landscape and trends of international marriages in Taiwan post-pandemic. Specifically, our objectives are to better understand the key nationalities within International marriages in Taiwan, their marriage and divorce trends over years, and the gender dynamic within each nationality. We will incorporate the environmental and cultural factors of each nationality and consider policy contexts in our research. This study seeks to provide valuable insights for Taiwan's international marriage policy by addressing the following questions:

1. What is the overall landscape of international marriages in Taiwan?
2. What are the trends of international marriages among different nationalities in the post-pandemic years?
3. What are the gender dynamics of international marriages between major nationalities?

Initially, we planned to analyze the marriage and marriage termination data from the Department of Household Registration available on the Open Government Data platform. However, this database consists of two separate monthly files for marriages and marriage terminations. Each file contains conditional data rather than personal data, with information subdivided to the le level in each city and county, as well as various nationalities with three years. This resulted in an excessively large volume of data, including many irrelevant observations. Consequently, we modified our analysis approach to focus on data cleaning and valid observations, concentrating primarily on the major nationalities.

## Getting Started

[Provide instructions on how to get started with your project, including any necessary software or data. Include installation instructions and any prerequisites or dependencies that are required.]

## File Structure

[Describe the file structure of your project, including how the files are organized and what each file contains. Be sure to explain the purpose of each file and how they are related to one another.]

## Analysis and Finding 

### Data Cleaning 


We systematically cleaned the data by looping through marriage and divorce CSV files from each month over three years, from 2021 to 2023. We read all CSV files in the specified directories for each year and combined them into a single data frame. Then, we standardized the column names to clearly represent the content of each column, including year-month, district code, city/district, village, marriage type, sex, original nationality, household registration status, marriage count, and divorce count.

Next, we defined lists containing the names of different levels of administrative divisions for subsequent data processing and converted the divorce count column to numeric type for accurate calculations and analysis. We re-coded columns such as household registration status, marriage type, sex, and original nationality to English.

For better data evaluation, we removed irrelevant and unnecessary data, excluding nationalities such as Eswatini, Lesotho, Mauritius, and "Other," which account for less than 1% of the total, as well as data related to the outlying islands. Rows containing specific keywords (such as "统计年月") were also removed. We extracted the year and month from the year-month column, creating new year and month columns. Additionally, city and district names were separated from the city/district column and re-coded to English.

The marriage and divorce datasets were then merged using a left join based on common columns, creating a comprehensive data frame that includes both marriage and divorce information for each year. The merged data for each year was written to CSV files for final use.

After merging, the data from years 110 to 112 were grouped by key columns such as year, month, city, district, city level, marriage type, sex, original nationality, and household registration status. The total marriage and divorce counts were summarized for each group. This process resulted in three new data frames for years 110 to 112, each containing aggregated marriage and divorce counts. Finally, we used rbind to merge all three years' data into one complete data frame.

Through these steps, we successfully cleaned and processed the data, extracting key information (year, month, city, marriage type, sex, original nationality, marriage count, divorce count) and grouping observations by city to keep them concise. This approach ensured the data was ready for further analysis and visualization, providing a clear and organized dataset for our project.


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

