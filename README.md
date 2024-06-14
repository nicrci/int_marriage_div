## Project Description

Over time, Taiwan's demographic landscape has shifted significantly with the addition of 570,000 new immigrants, including migrant workers and international marriages (Guo, 2022). Taiwan once had the highest rate of international marriage in Asia, comprising nearly 15.9% of all marriages (Economist, 2022). International marriages are crucial to Taiwan's demographic landscape. However, the trends in international marriages have been seldom discussed in recent years, particularly after the pandemic.

In this study, we aim to explore the evolving landscape and trends of international marriages in Taiwan post-pandemic. Specifically, our objectives are to better understand the key nationalities within International marriages in Taiwan, their marriage and divorce trends over years, and the gender dynamic within each nationality. We will incorporate the environmental and cultural factors of each nationality and consider policy contexts in our research. This study seeks to provide valuable insights for Taiwan's international marriage policy by addressing the following questions:

1. What is the overall landscape of international marriages in Taiwan?
2. What are the gender dynamics of international marriages between major nationalities?
3. What are the trends of international marriages among different nationalities in the post-pandemic years?

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

### Data Cleaning and Methodology

We conducted a systematic data cleaning process involving monthly marriage and divorce CSV files over three years, from 2021 to 2023. This process included reading all CSV files in the specified directories for each year and combining them into a single data frame. The column names were standardized to clearly represent the content of each column, including year-month, district code, city/district, village, marriage type, sex, original nationality, household registration status, marriage count, and divorce count.

Subsequently, we defined lists containing the names of different levels of administrative divisions for data processing and converted the divorce count column to numeric type for accurate calculations and analysis. Columns such as household registration status, marriage type, sex, and original nationality were re-coded to English.

To improve data evaluation, irrelevant and unnecessary data were removed, including nationalities such as Eswatini, Lesotho, Mauritius, and "Other," which account for less than 1% of the total, as well as data related to the outlying islands. Rows containing specific keywords (such as "统计年月") were also excluded. We extracted the year and month from the year-month column, creating new year and month columns. Additionally, city and district names were separated from the city/district column and re-coded to English.

The marriage and divorce datasets were merged using a left join based on common columns, resulting in a comprehensive data frame that includes both marriage and divorce information for each year. The merged data for each year was then written to CSV files for final use.

After merging, the data from 2021 to 2023 were grouped by key columns such as year, month, city, district, city level, marriage type, sex, original nationality, and household registration status. The total marriage and divorce counts were summarized for each group. This process produced three new data frames for 2021, 2022, and 2023, each containing aggregated marriage and divorce counts. Finally, we used rbind to merge all three years' data into one complete data frame.

Through these steps, we successfully cleaned and processed the data, extracting key information (year, month, city, marriage type, sex, original nationality, marriage count, divorce count) and grouping observations by city to maintain conciseness. This approach ensured the data was ready for further analysis and visualization, providing a clear and organized dataset for our project.

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

- Aggregated marriage and divorce counts and population data by city and average of three years.
- Calculated the marriage and divorce rate as a percentage of the population.
- Computed the three-year average marriage and divorce rate for each city.
- Merged the data with geographical map data of Taiwan and created choropleth maps.


## Analysis

### 1-1 What is the overall landscape of international marriages in Taiwan?

To better understand the landscape of international marriages in Taiwan, this study calculates the average population of each county and city in Taiwan from 2021 to 2023. The marriage and divorce rates over the three years are then determined based on the number of marriages and divorces among foreign nationals in each county and city. The data is presented on a map of Taiwan, allowing for a detailed examination of the geographic distribution and trends in the marriage and divorce rates of international marriages. This also helps to assess the stability of international marriages across different counties and cities. The results are illustrated in Figures 1 and 2.

![1](https://github.com/nicrci/int_marriage_div/assets/172574448/eff5d443-0eb0-4447-ac07-8c12c0791555)
The Figures 1 is the Taiwan map that illustrates a concentration of higher marriage rates in the more modern and northern parts of Taiwan, particularly in Taipei (0.07%) and New Taipei City (0.06%). This trend is likely influenced by the higher population density and better economic conditions in these urban centers compared to rural areas like Hualien County (0.03%) and Taitung County (0.03%). Notably, Taoyuan City (0.06%) stands out as a major hub for migrant workers in Taiwan, which significantly contributes to its elevated marriage rate. Interestingly, some isolated regions in the central area like Nantou County (0.05%) also show higher marriage rates.

![2](https://github.com/nicrci/int_marriage_div/assets/172574448/9cc9687a-2ed5-4b91-ba09-566739ba12a9)
Although the marriage rate map shows that marriage rates directly correlate with the population within cities, divorce rates, shown in Figures 2, are more varied and spread across the country. Surprisingly, the map reveals that less urban areas like Taoyuan City (0.03%) and Miaoli County (0.03%) tend to have higher divorce rates compared to more urban areas like Taipei City (0.02%). This disparity can be attributed to differences in lifestyle, economic pressures, and social dynamics in each city. In less urban areas, the economic challenges, such as lower employment opportunities and income instability, often contribute to financial stress within households, leading to higher divorce rates. Additionally, social isolation due to geographical distance and less developed social infrastructure in rural communities can result in a lack of social support networks, which are crucial for maintaining strong marital relationships. These factors collectively contribute to the higher divorce rates observed in less urbanized areas. 


### 1-2 What is the overall landscape of international marriages in Taiwan?

After understanding the geographic distribution and trends of international marriages in Taiwan, this study further examines the composition and nationality ratios within these marriages. To gain insights into the key nationalities involved in international marriages in Taiwan and to refine the research focus, we calculate the proportion of marriages and divorces for each nationality. This data is visually represented using hollow pie charts, providing an intuitive view of the nationality proportions. This approach helps to better understand the key nationalities, their significance, and the stability of international marriages in Taiwan. The results are illustrated in Figures 3 and 4.

![3](https://github.com/nicrci/int_marriage_div/assets/172574448/172feb76-6ba5-4d2d-be5c-d085dba1e6ea)
Figure 3 reveals that the top six countries for marriages with Taiwanese nationals are China (1.17%), Vietnam (1.42%), Hong Kong and Macao (0.51%), the United States (0.35%), Japan (0.29%), and Malaysia (0.25%). Several factors explain why these countries are predominant in cross-border marriages with Taiwan. Many Chinese individuals come to Taiwan for study and work, and over time, establish long-term relationships that contribute to a high ratio of cross-border marriages. Economic motivations also drive many of these unions. For individuals from Vietnam and China, marrying a Taiwanese national often promises better economic opportunities and living standards. Geographical proximity and historical ties further facilitate these marriages, making international unions more accessible and common. Taiwan's closeness to China, Hong Kong, Macao, and Vietnam, along with shared historical and cultural connections, plays a significant role.

For individuals from the United States, educational and professional opportunities also contribute to the high marriage ratio. Many Taiwanese students pursue higher education in the U.S., creating opportunities for cross-cultural relationships. Additionally, the growth of globalized industries and multinational companies leads to more Taiwanese professionals working in the United States, and vice versa, resulting in more opportunities for relationships and marriages between nationals of the two countries.

![4](https://github.com/nicrci/int_marriage_div/assets/172574448/4b68e83a-ead7-4c47-aa64-9313b32fdd16)
On the other hand, the divorce ratio graph shows the top six countries with the highest divorce rates: China (3.25%), Vietnam (2.26%), Indonesia (0.29%), Hong Kong and Macao (0.24%), Japan (0.2%), and Thailand (0.2%). The high divorce rates for China and Vietnam can be related to issues such as fake marriages and the effects of labor migration. Additionally, there is a substantial flow of labor migration from Vietnam and China to Taiwan. Marriage brokerage agencies often facilitate these unions, particularly in rural areas where there is a shortage of local brides. Interestingly, Figure 4 shows that China (3.25%) and Vietnam (2.26%) have the highest divorce rates, which can be related to fake marriages and labor migration problems. Furthermore, as shown in Figure 4, marriages with U.S. spouses appear stable, as they do not rank high in the divorce rate, while Japan ranks relatively high in both marriage and divorce figures.


 ### 2 What are the gender dynamics of international marriages between major nationalities?

 After gaining a deeper understanding of the key nationalities and geographic distribution of international marriages in Taiwan, this study further examines the gender ratios in marriages and divorces among the top six nationalities. Additionally, data for Taiwanese nationals is included as a control group. This analysis allows for a more comprehensive understanding of the gender dynamics among the main nationalities in international marriages in Taiwan and the stability of these marriages between foreign nationals and Taiwanese citizens.

Since the data used in this study is conditional rather than personal, to better analyze the gender dynamics in marriage and divorce among the main nationalities, the divorce rates are calculated based on the number of marriages for each nationality's gender. The results are illustrated in Figures 5 and 6.

![5](https://github.com/nicrci/int_marriage_div/assets/172574448/bc2b5539-2b69-441c-88e3-5d0f81ad137a)
Figure 5 highlights significant gender imbalances among various nationalities in Taiwan. Vietnamese marriages show 88.1% women and 11.9% men, a result influenced by historical and socio-economic factors. Chinese marriages display a similar pattern, with 81.2% women and 18.8% men. In contrast, Japanese marriages show 37.0% women and 62.9% men, while U.S. marriages have 15.7% women and 84.3% men. These trends reflect patterns of hypergamy and hypogamy, with Taiwanese men, especially in rural areas, struggling to find local spouses and increasingly marrying foreign brides from China and Vietnam for better economic prospects.

![6](https://github.com/nicrci/int_marriage_div/assets/172574448/c6998e9a-6995-4f34-b392-d8347cfed73b)
Figure 6, on the other hand, highlights significant gender imbalances in divorce rates among various nationalities in Taiwan, based on the ratio of divorces to marriages over a three-year period. Vietnamese marriages show that 83.35% of divorces involve women, influenced by socio-economic challenges such as lack of legal awareness and support. Chinese marriages similarly show a high female divorce rate of 73.67%. Taiwanese men marrying Chinese and Southeast Asian women tend to be older, less educated, and more likely to have had prior marriages, contributing to higher divorce rates. Conversely, Japanese divorces are more skewed towards men, with 59.18% involving males, while Thai marriages show a higher male divorce rate of 65.18%.


 ### 3 What are the trends of international marriages among different nationalities in the post-pandemic years?

Based on the data presented in Figures 3 and 4, this study identifies the key nationalities involved in international marriages in Taiwan. Considering Taiwan's long-standing stereotypes of foreign brides from Southeast Asian countries, its historical bilateral relations with China, and the differing regulations of Taiwan's international marriage policies, this study aims to provide a more detailed analysis of marriage and divorce trends and patterns for these nationalities from 2021 to 2023, post-pandemic.

To achieve this, the study categorizes foreign nationals into groups: those from Southeast Asian countries, China, Hong Kong and Macao, and other nationalities. The marriage and divorce trends for these groups over the three years following the pandemic are presented using line charts. Additionally, data for Taiwanese nationals is included as a control group. The results for Taiwanese nationals are scaled down by a factor of 20 to clearly examine and compare the trends and patterns of marriage and divorce among the different nationality groups against those of Taiwanese nationals. The results are illustrated in Figures 7 and 8.

![7](https://github.com/nicrci/int_marriage_div/assets/172574448/89aba8ad-d1f3-48c3-a933-9651441eb36c)
Figure 7 illustrates the notable impact of the COVID-19 pandemic on international marriages. Travel restrictions and quarantine measures complicated cross-border relationships, leading to delays in marriages and reunifications. However, after 2022, as more countries emerged from lockdown and international travel resumed, the number of marriages significantly increased, especially among Southeast Asian and Chinese nationals. The marriage count for Southeast Asian countries spiked between 2022 and 2023, while the increase for Chinese nationals was more gradual, with a notable spike at the end of 2022 due to differences in border release policies for the two groups. Within Taiwan, the marriage count is significantly higher than in other countries, so the data has been scaled down by a factor of 20 for comparison. Additionally, it is a common belief in Taiwan that getting married during the New Year brings good luck, leading to a rise in the number of marriages around Chinese New Year. Conversely, during Ghost Month, which falls in the seventh month of the lunar calendar, some couples in Taiwan avoid getting married due to the belief that it will bring bad luck. This avoidance is reflected in the decreased number of marriages during this period each year (Halla et al., 2019).

![8](https://github.com/nicrci/int_marriage_div/assets/172574448/70aaaf64-68a8-4cb9-87da-7225fe6b617e)
In Figures 8, divorces with Southeast Asian countries and China show a slight upward trend, while those with Hong Kong, Macao, and other countries remain stable. Overall, the divorce trends in Taiwan are similar for both local and foreign couples. After the pandemic, divorce rates increased due to the lockdown effect, which forced couples to spend more time together. This intensified close quarters led to many couples realizing they could not get along, resulting in a divorce (Surpressed Divorce) (Su, 2024). Additionally, there is a notable spike in divorces following Chinese New Year. Many people believe that divorcing shortly before or during the New Year brings bad luck, so they wait until after the holiday to proceed with their separations (Halla et al., 2019).

## Results

The marriage ratio graph reveals that the top six countries for marriages with Taiwanese nationals are China (1.17%), Vietnam (1.42%), Hong Kong and Macao (0.51%), the United States (0.35%), Japan (0.29%), and Malaysia (0.25%). On the other hands, divorce ratio graph shows the top 6 countries that have the most divorce rate which are China (3.25%), Vietnam (2.26%), Indonesia (0.29%), Hong Kong and Macao (0.24%), Japan (0.2%), and Thailand (0.2%). 

A significant insight that this project has provided has a lot to do with gender imbalances and socio-economic challenges, which has been found to be largely due to hypergamy and hypogamy (Su et al, 2024). In the light of hypergamy, Japanese and U.S. marriages involve more men than women who are married to Taiwanese women. We can also see the influence of hypogamy among Vietnamese and Chinese female nationals who are married with Taiwanese males.

This project has also provided insights in regards to border policy differences. International marriages, driven by historical and economic ties, increased post-pandemic as travel resumed, but divorce rates also rose due to lockdown stress. This has been noted to be suppressed marriages and divorces (Su et al, 2024)

This project has provided insights regarding the marriage and divorce landscape in Taiwan, including its potential influencers such as urbanization, international migration, cultural beliefs, and socio-economic factors.

## Conclusion

This study has provided valuable insights into the evolving landscape of international marriages in Taiwan, highlighting the significance of demographic shifts, nationality compositions, gender dynamics, and socio-economic challenges. By analyzing data from 2021 to 2023, we have gained a comprehensive understanding of the key nationalities involved in international marriages, their marriage and divorce trends, and the gender ratios within these marriages.

Our analysis indicates that international marriages are predominantly concentrated in urban centers such as Taipei and New Taipei City, driven by higher population densities and better economic conditions. Taoyuan City also emerges as a significant hub due to its large migrant worker population. Conversely, rural areas like Hualien and Taitung Counties show lower marriage rates but higher divorce rates, likely influenced by economic challenges and social isolation.

The nationality composition of international marriages shows that the top six countries involved are China, Vietnam, Hong Kong and Macao, the United States, Japan, and Malaysia. These trends are influenced by economic motivations, geographical proximity, and historical ties. The data also reveals significant gender imbalances, with a higher proportion of Vietnamese and Chinese women marrying Taiwanese men, reflecting patterns of hypergamy. In contrast, marriages involving Japanese and U.S. nationals show a higher proportion of men marrying Taiwanese women.

The divorce data reveals that China and Vietnam have the highest divorce rates, potentially due to issues such as fake marriages and the effects of labor migration. The socio-economic challenges faced by women from these countries contribute to higher divorce rates, particularly among older and less-educated Taiwanese men who tend to marry Southeast Asian women. The data also highlights that marriages involving U.S. nationals are relatively stable, while Japanese marriages show high divorce rates among men.

Post-pandemic trends reveal an increase in international marriages as travel restrictions ease, particularly with Southeast Asian and Chinese nationals. However, the pandemic has also led to a rise in divorce rates, reflecting the stress and close quarters experienced during lockdowns. The seasonal patterns of marriage and divorce, influenced by cultural beliefs such as the avoidance of Ghost Month and the preference for marrying around Chinese New Year, further underscore the complex interplay of cultural and socio-economic factors.

In conclusion, this study provides critical insights into the dynamics of international marriages in Taiwan. The findings emphasize the importance of understanding geographic, economic, and cultural factors in shaping marriage and divorce trends. These insights are vital for policymakers, researchers, and social organizations aiming to support international couples and address the challenges they face. The results of this study underscore the need for targeted policies and interventions to promote the stability and well-being of international marriages in Taiwan.

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

