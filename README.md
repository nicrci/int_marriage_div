# International Marriage and Divorce Landscape and Trends in Taiwan (2021-2023)

## Project Description

Over time, Taiwan's demographic landscape has shifted significantly with the addition of 570,000 new immigrants, including migrant workers and international marriages (Guo, 2022). Taiwan once had the highest rate of international marriage in Asia, comprising nearly 15.9% of all marriages (Economist, 2022). International marriages are crucial to Taiwan's demographic landscape. However, the trends in international marriages have been seldom discussed in recent years, particularly after the pandemic.

In this study, we aim to explore the evolving landscape and trends of international marriages in Taiwan post-pandemic. Specifically, our objectives are to better understand the key nationalities within International marriages in Taiwan, their marriage and divorce trends over years, and the gender dynamic within each nationality. We will incorporate the environmental and cultural factors of each nationality and consider policy contexts in our research. This study seeks to provide valuable insights for Taiwan's international marriage policy by addressing the following questions:

1. What is the overall landscape of international marriages in Taiwan?
2. What are the gender dynamics of international marriages between major nationalities?
3. What are the trends of international marriages among different nationalities in the post-pandemic years?

Initially, we planned to analyze the marriage and marriage termination data from the Department of Household Registration available on the Open Government Data platform. However, this database consists of two separate monthly files for marriages and marriage terminations. Each file contains conditional data rather than personal data, with information subdivided to the le level in each city and county, as well as various nationalities with three years. This resulted in an excessively large volume of data, including many irrelevant observations. Consequently, we modified our analysis approach to focus on data cleaning and valid observations, concentrating primarily on the major nationalities.

## Getting Started
Based on our research questions and data investigation, we have decided to examine data on international marriages and divorces in Taiwan from 2021 to 2023. Our aim is to analyze the overall landscape and trends of international marriages in Taiwan, as well as the cultural and economic factors influencing these trends. Additionally, we will look into the patterns of international marriages and divorces during and after the pandemic.

We have conducted a thorough review of literature, data analysis, news and online information, and government records on immigration and international marriage policies from 2021 to 2023, as well as over the past 40 years (details in Appendices A and B). This review has helped us identify further research directions and contexts.

In light of Taiwan's long-standing policies on international marriage, key nationalities involved, and social perceptions, we will also explore the trends and relationships of  international marriages between Taiwan and China and Southeast Asian countries. Additionally, we will examine stereotypes of foreign countries brides regarding Taiwanese men and foreign grooms regarding Taiwanese women. This analysis will enable us to observe significant changes in marriages and divorces involving people of different nationalities.

To begin, download the raw data on divorce and marriage termination data from the Department of Household Registration available on the Open Government Data platform at https://data.gov.tw/dataset/131137, https://data.gov.tw/dataset/131136. They are .csv files. Each files contains column name and we changed it for a better understanding as below.

| Original column name | New column name | Description |
| ------------- | ------------- | ------------- |
| statistic_yyymm | yearmonth | Taiwanese year and month |
| district_code | district_code | District code number |
| site_id | city_district | City and district name |
| village | village_li | Village name |
| marriage_type | marriage_type | Marriage type including same-sex marriage and different-sex marrage |
| sex | sex | Male and Female |
| nation | original_nationality | Original nationality of that person in the data |
| registration | household_registration_status | Household registration in Taiwan including registered or not regirster |
| marry_count / divorce_count | marry_count / divorce_count | Number of marry and divorce count |

Next, download and install RStudio, ensuring to have R version 4.3.2. Once RStudio is set up, install the necessary libraries using the install.packages() command. The required libraries include readr, dplyr, ggplot2, readxl, jsonlite, tidyr, stringr, and scales.
```
install.packages(readr)       # For reading .csv file
install.packages(dplyr)       # For data manipulation
install.packages(ggplot2)     # For plotting graph for data visualization
install.packages(readxl)      # For reading .xl file
install.packages(jsonlite)    # For JSON data processing
install.packages(tidyr)       # For tidying data
install.packages(stringr)     # For string manipulation
install.packages(scales)      # For scaling and formatting data for visualization
```
Due to the large size of the raw data and its use of Traditional Chinese, data cleaning is necessary. This involves removing data from certain small cities, islands, and specific nationalities that are not needed (the detailed method is under section Data Cleaning and Methodology).

The eliminated nationalities are :

| Traditional Chinese | English |
| ------------- | ------------- |
| 史瓦帝尼 | Eswatini |
| 賴索托 | Lesotho |
| 模里西斯 | Mauritius |
| 其他 | Others |

The eliminated cities are :

| Traditional Chinese | English |
| ------------- | ------------- |
| 連江縣東引鄉 | Dongyin Township, Lienchiang County |
| 連江縣北竿鄉 | Beigan Township, Lienchiang County |
| 連江縣莒光鄉 | Juguang Township, Lienchiang County |
| 連江縣南竿鄉 | Nangan Township, Lienchiang County |
| 金門縣金寧鄉 | Jinning Township, Kinmen County |
| 金門縣烈嶼鄉 | Lieyu Township, Kinmen County |
| 金門縣烏坵鄉 | Wuqiu Township, Kinmen County |
| 金門縣金沙鎮 | Jinsha Township, Kinmen County |
| 金門縣金城鎮 | Jincheng Township, Kinmen County |
| 金門縣金湖鎮 | Jinhu Township, Kinmen County |
| 澎湖縣湖西鄉 | Huxi Township, Penghu County |
| 澎湖縣白沙鄉 | Baisha Township, Penghu County |
| 澎湖縣七美鄉 | Qimei Township, Penghu County |
| 澎湖縣馬公市 | Magong City, Penghu County |
| 澎湖縣望安鄉 | Wang'an Township, Penghu County |
| 澎湖縣西嶼鄉 | Xiyu Township, Penghu County |

Finally, translate all the data contained in each file from Traditional Chinese to English for greater convenience and usability (the detailed method is under section Data Cleaning and Methodology).

## File Structure

```
📦 Project
├─ Raw Data
│  ├─ 2021
│  │  ├─ marriage_2021 folder (opendata11001M051.csv - opendata11012M051.csv)
│  │  └─ divorce_2021 folder (opendata11001M061.csv - opendata11012M061.csv)
│  ├─ 2022
│  │  ├─ marriage_2022 folder (opendata11101M051.csv - opendata11112M051.csv)
│  │  └─ divorce_2022 folder (opendata11201M061.csv - opendata11112M061.csv)
│  └─ 2023
│     ├─ marriage_2023 folder (opendata11201M051.csv - opendata11212M051.csv)
│     └─ divorce_2023 folder (opendata11201M061.csv - opendata11212M061.csv)
├─ Data Cleaning and Merge
│  ├─ DataCleaning_divorce_marriage_2021.R
│  ├─ DataCleaning_divorce_marriage_2022.R
│  ├─ DataCleaning_divorce_marriage_2023.R
│  └─ mix_110_112_all.csv
└─ Data Merge and Visualization
   └─ Datamerge_visulization_2021_2023.R
```
©generated by [Project Tree Generator](https://woochanleee.github.io/project-tree-generator)

The folder named "Raw Data" contains marriage and divorce data from the years 2021 to 2023. Within each yearly folder—"2021," "2022," and "2023"—there are 12 monthly subfolders from January to December, each containing raw .csv files with marriage and divorce data. For example, the file "opendata11001M051.csv" includes records with information such as city, nationality, sex, and the count of divorces/marriages, etc.

The files "DataCleaning_divorce_marriage_2021.R," "DataCleaning_divorce_marriage_2022.R," and "DataCleaning_divorce_marriage_2023.R" located in the "Data Cleaning and Merge" folder contain code for cleaning and merging the files in the "Raw Data" folder.

The file "Datamerge_visualization_2021_2023.R" contains all the data visualizations, including plots for the Marriage and Divorce Count by Nationality Group, the Divorce and Marriage Ratio of Different Nationalities in Taiwan's international marriages, the Divorce Gender Ratio by Nationality, the Marriage Gender Ratio by Nationality, and the Average Marriage and Divorce Rate Distribution Map. (More details can be found in the Visualization Methodology section)

## Analysis

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

![6](https://github.com/nicrci/int_marriage_div/assets/172574448/fcc3433e-5459-448a-aa4e-d0a08d25258c)
Figure 6, on the other hand, highlights significant gender imbalances in divorce rates among various nationalities in Taiwan, based on the ratio of divorces to marriages over a three-year period. Vietnamese marriages show that 83.35% of divorces involve women, influenced by socio-economic challenges such as lack of legal awareness and support. Chinese marriages similarly show a high female divorce rate of 73.67%. Taiwanese men marrying Chinese and Southeast Asian women tend to be older, less educated, and more likely to have had prior marriages, contributing to higher divorce rates. Conversely, Japanese divorces are more skewed towards men, with 59.18% involving males, while Thai marriages show a higher male divorce rate of 65.18%.


 ### 3 What are the trends of international marriages among different nationalities in the post-pandemic years?

Based on the data presented in Figures 3 and 4, this study identifies the key nationalities involved in international marriages in Taiwan. Considering Taiwan's long-standing stereotypes of foreign brides from Southeast Asian countries, its historical bilateral relations with China, and the differing regulations of Taiwan's international marriage policies, this study aims to provide a more detailed analysis of marriage and divorce trends and patterns for these nationalities from 2021 to 2023, post-pandemic.

To achieve this, the study categorizes foreign nationals into groups: those from Southeast Asian countries, China, Hong Kong and Macao, and other nationalities. The marriage and divorce trends for these groups over the three years following the pandemic are presented using line charts. Additionally, data for Taiwanese nationals is included as a control group. The results for Taiwanese nationals are scaled down by a factor of 20 to clearly examine and compare the trends and patterns of marriage and divorce among the different nationality groups against those of Taiwanese nationals. The results are illustrated in Figures 7 and 8.

![7](https://github.com/nicrci/int_marriage_div/assets/172574448/89aba8ad-d1f3-48c3-a933-9651441eb36c)
Figure 7 illustrates the notable impact of the COVID-19 pandemic on international marriages. Travel restrictions and quarantine measures complicated cross-border relationships, leading to delays in marriages and reunifications. However, after 2022, as more countries emerged from lockdown and international travel resumed, the number of marriages significantly increased, especially among Southeast Asian and Chinese nationals. The marriage count for Southeast Asian countries spiked between 2022 and 2023, while the increase for Chinese nationals was more gradual, with a notable spike at the end of 2022 due to differences in border release policies for the two groups. Within Taiwan, the marriage count is significantly higher than in other countries, so the data has been scaled down by a factor of 20 for comparison. Additionally, it is a common belief in Taiwan that getting married during the New Year brings good luck, leading to a rise in the number of marriages around Chinese New Year. Conversely, during Ghost Month, which falls in the seventh month of the lunar calendar, some couples in Taiwan avoid getting married due to the belief that it will bring bad luck. This avoidance is reflected in the decreased number of marriages during this period each year (Halla et al., 2019).

![8](https://github.com/nicrci/int_marriage_div/assets/172574448/70aaaf64-68a8-4cb9-87da-7225fe6b617e)
In Figures 8, divorces with Southeast Asian countries and China show a slight upward trend, while those with Hong Kong, Macao, and other countries remain stable. Overall, the divorce trends in Taiwan are similar for both local and foreign couples. After the pandemic, divorce rates increased due to the lockdown effect, which forced couples to spend more time together. This intensified close quarters led to many couples realizing they could not get along, resulting in a divorce (Surpressed Divorce) (Su, 2024). Additionally, there is a notable spike in divorces following Chinese New Year. Many people believe that divorcing shortly before or during the New Year brings bad luck, so they wait until after the holiday to proceed with their separations (Halla et al., 2019).

## Results: The Dynamics of International Marriages and Divorces in Taiwan: Gender Imbalances, Socio-Economic Challenges, and Post-Pandemic Trends

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

## Project Limitation and Future Research Possibilities

### Project Limitation

This study utilizes two major datasets from the Department of Household Registration, Ministry of the Interior: "Number of Divorces/Terminated Marriages by Marriage Type and Nationality of Both Parties" and "Number of Marriages by Marriage Type and Nationality of Both Parties." While the raw data includes significant information from all cities, counties, towns, and districts across Taiwan, as well as various nationalities involved in cross-national marriages, it is conditional data rather than personal data. Consequently, despite the valuable information within these datasets, the study cannot delve deeper into individual-level trend analyses. For instance, the marriage and divorce columns do not provide the exact month and year of the original marriage for divorced individuals, nor do they indicate if the divorce involved the same couple or the number of marriages and divorces for a particular individual. This limitation restricts the study's ability to conduct more in-depth analyses and research on divorce and marriage trends for specific nationalities. Additionally, the absence of personal-level data prevents the precise calculation of divorce rates, which may result in distorted outcomes. This limitation significantly impacts the accuracy and applicability of the divorce rate calculations in this study.

Although the dataset includes information on whether foreign nationals have naturalized, the conditional nature of the data prevents a deeper examination of the relationship between naturalization and divorce rates. This also hinders the study's ability to analyze long-standing societal impressions of cross-national marriages in Taiwan, such as sham marriages and marriage transactions. Furthermore, the study analyzes and visualizes the geographical distribution of cross-national marriages at the county and city levels in Taiwan. However, this method does not account for the urban-rural divide and developmental differences within these regions. Certain areas, such as Zhonghe and Yonghe Districts in New Taipei City, are popular for foreign nationals' immigration and residence. Due to the study's focus and presentation considerations, these areas were not examined and analyzed in greater detail, which may result in potential errors and distortions in the preliminary analysis and findings presented in this study.

### Future Research Possibilities

This study has identified several phenomena worthy of further investigation through the analysis of marriage and divorce rates by specific nationalities, as well as the gender dynamics within these marriages and divorces.

Japanese nationals are prominently featured in both the marriage and divorce statistics for international marriages in Taiwan, ranking among the top six nationalities. This indicates that while Japanese nationals constitute a significant proportion of international marriages in Taiwan, they also experience a high divorce rate. Therefore, the marital stability of Japanese nationals in Taiwan's international marriages appears relatively unstable. When examining the gender dynamics within these marriages, the study found that approximately 60% involve Taiwanese marrying Japanese men, and about 60% of the divorces also involve this group. This preliminary observation has not been extensively studied in current international marriage research, suggesting that future research could benefit from detailed case studies to provide deeper insights into the dynamics of Taiwanese-Japanese international marriages.

Similarly, the study found that American nationals rank high in the marriage statistics, being among the top six nationalities. However, they do not appear in the top six nationalities in the divorce statistics, indicating a significantly lower divorce rate compared to their marriage rate. This suggests that American nationals exhibit a relatively high level of marital stability in Taiwan's international marriages. Further examination of the gender dynamics revealed that about 84% of these marriages involve Taiwanese marrying American men, showing a strong tendency for Taiwanese individuals to marry American men. This phenomenon has also not been thoroughly researched, suggesting that future studies could benefit from more detailed case analyses to gain deeper insights.

![Figure 1  The averge Marriage Rate(%) of International Marriage (1)](https://github.com/nicrci/int_marriage_div/assets/172574448/b166fb9a-6e0f-4fcd-931d-251866545b91)
Finally, the study's dataset includes data on same-sex marriages. Preliminary analysis reveals that the proportion of international same-sex marriages in Taiwan has been increasing annually. Following a new interpretation of Taiwan's same-sex marriage policy in January 2023 (detailed in Appendix A), which removed certain barriers for international same-sex marriages and allowed Taiwanese citizens to marry foreign same-sex partners (including residents of Hong Kong and Macau, but excluding mainland Chinese), there was a noticeable increase, as shown in Figure 9, in the proportion of these marriages, rising from 0.1% to over 0.3%. As Taiwan is a relatively progressive and liberal country in Asia regarding same-sex marriage policies, further examination and research into this trend are crucial for understanding the landscape and development of same-sex marriages in Taiwan.

## Contributors

The members of this project include Billy, Nicole, and Sinaee.

## Acknowledgments

We would like to thank Professor Pien Chung-Pei for his guidance throughout the semester. For insights into our results, we would also like to thank Professor Ou Tzu-chi and Professor Su Yu-hsuan.

For the raw data, we would like to thank the specialist in the Department of Household Regiration, Ms. Lai.

Special thanks to Izz for the visual aids and support.

## References

### Research

Zeng, Z. X. (2021). Research on the current legal status and policy direction of cross-border marriage matchmaking organizations in Taiwan. National Immigration Agency, Ministry of the Interior.

Halla, M., Liu, C. L., & Liu, J. T. (2019). The effect of superstition on health: Evidence from the Taiwanese Ghost month (No. w25474). National Bureau of Economic Research.

Yu-hsuan Su, Chi-Feng Cho, Jin-Tan Liu. (2024). Marital Stability of Transnational Couples and Chinese Bride Interview Policy: Evidence from Taiwan. Unpublished manuscript, Graduate Institute of Development Studies, National Chengchi University, Taipei, Taiwan.

Jones, G., & Shen, H. H. (2008). International marriage in East and Southeast Asia: Trends and research emphases. Citizenship studies, 12(1), 9-25.

Hieu, L. T. (2015). Confucian influences on Vietnamese culture. Vietnam Social Sciences, 5(169), 71-82.

Wang, H.-R., & Zhang, S.-M. (2003). The Commodification of the Taiwan-Vietnam Transnational Marriage Market. Taiwan Sociology, (6), 177-221. https://doi.org/10.6676/TS.2003.6.177

Hsia, H.-C. (2000). International Marriages under Capital Internationalization: The Case of “Foreign Brides” in Taiwan. Taiwan: A Radical Quarterly in Social Studies, (39), 45-92. https://doi.org/10.29816/TARQSS.200009.0002

Wang, H.-R. (2001). Marriage Migration and the Domestic Labor Market under Social Stratification: The Case of Vietnamese Brides. Taiwan: A Radical Quarterly in Social Studies, (41), 99-127. https://doi.org/10.29816/TARQSS.200103.0003

### Data

Department of Household Registration, Ministry of the Interior. (2020-2024). Number of divorces/terminated marriages by type of marriage and nationality of both parties (Version varies) [2021.1-2023.12]. Retrieved from https://data.gov.tw/dataset/131137
Department of Household Registration, Ministry of the Interior. (2020-2024). Number of marriages by type of marriage and nationality of both parties (Version varies) [2021.1-2023.12]. Retrieved from https://data.gov.tw/dataset/131136

### Online Resource

Chen, K., & Chang, T. (2022, December 31). 2023 Entry and exit quarantine regulations: “0+7” quick test rules, cancellation of saliva PCR screening for passengers from China... all in one read! Harper's BAZAAR. Retrieved from https://www.harpersbazaar.com/tw/beauty/bodyandhealth/g42365092/2023-quarantine-abroad/

Economist. (2011, November 15). Integration vs. conflict: Do cross-border marriages last longer? CommonWealth Magazine. Retrieved from https://www.cw.com.tw/article/5027932

Guo, Q. L. (2022, January 31). Taiwan's ethnic groups as one family 1: Passersby become locals! New residents and their children surpass one million, becoming the fourth largest ethnic group in the country. Wealth Magazine. Retrieved from https://www.wealth.com.tw/articles/9f4dae5a-aa5d-466e-a4dc-754bba352498

KKday Editorial Team. (2022, October 3). Entry restrictions by country 2022: From 10/13, Taiwan implements “0+7” quarantine-free! Travel restrictions in Japan, Korea, Hong Kong, Europe, the US, and Southeast Asia. KKday Blog. Retrieved from https://www.kkday.com/zh-tw/blog/92436/global-covid19-entry-restrictions

Lin, I. (2020, December 3). [Infographic] In 2020, fewer people got married in Taiwan, and fewer got divorced. The News Lens. Retrieved from https://www.thenewslens.com/article/144037

Liu, L. (2022, March). 2022 Travel guide: See all the quarantine-free vaccination rules for different countries! FETnet. Retrieved from https://www.fetnet.net/content/cbu/tw/lifecircle/travel/2022/03/lift_restrictions.html

Michelle. (2021, October 5). [Summary of entry and exit restrictions during the pandemic] Taiwan’s latest entry and exit regulations and flight information in 2021. Calling Taiwan. Retrieved from https://www.callingtaiwan.com.tw/%E3%80%90%E7%96%AB%E6%83%85%E5%87%BA%E5%85%A5%E5%A2%83%E9%99%90%E5%88%B6%E7%B8%BD%E6%95%B4%E7%90%86%E3%80%912021%E5%8F%B0%E7%81%A3%E6%9C%80%E6%96%B0%E5%87%BA%E5%85%A5%E5%A2%83%E8%A6%8F%E5%AE%9A/

Press Release from Ministry of Health and Welfare. (2021-2023). Ministry of Health and Welfare. Retrieved from https://www.mohw.gov.tw/np-16-1.html

Wu, S. Y. (2022, May 2). Pandemic blocks love! Cross-border marriages face difficulties, and the number of marriage registrations drops sharply. TVBS. Retrieved from https://www.tvbs.com.tw/

Chenhuifangnccu. (2018, December 25). [Infographic] Observing new immigrants in Taiwan through data. Life Wanderer. Retrieved from https://stoi087163.wordpress.com/2018/12/25/taiwan-immigrant-data/

Liu, Y. S. (2022, February 24). Southeast Asian immigrant workers: Stop calling them foreign brides! Taiwan’s new residents, new immigrants, and multiculturalism. CommonWealth Magazine. Retrieved from https://opinion.cw.com.tw/blog/profile/31/article/11972

Li, W. X. (2024, May 3). Post-pandemic phenomenon! Taiwan’s cross-border marriage registrations increase by 77.6%, mostly from Southeast Asia. Zhiyin Foreign Marriage Association. Retrieved from https://www.zhiyin.com.tw/index.php?do=news&act=info&pid=0&id=85

## Appendix

### A. Summary of Taiwan's Marriage and Work-Related Immigration Policies Over the Past Forty Years

#### Immigration Policy (Related to Work)

| Time Period | Important Events and Policies |
|-------------|-------------------------------|
| 1980s       | Mid-to-late 1980s: Influx of illegal migrant workers, highlighting labor supply-demand imbalance. <br> October 27, 1989: First official policy to legally introduce migrant workers for low-skill, labor-intensive jobs. |
| 1990s       | October 11, 1990: Six major industries allowed to hire migrant workers. <br> 1992: Employment Service Act passed, establishing legal framework for hiring foreign nationals; more industries and jobs opened to migrant workers. <br> 1992: Policy stance of "relaxed emigration, strict immigration". <br> 1993: Further expanded to 73 industries allowed to hire migrant workers. <br> 1994: First "Southbound Policy" launched to strengthen economic and trade ties with Southeast Asia. |
| 2000s       | 2001: Amended regulations to protect migrant worker rights, such as banning excessive brokerage fees. <br> 2002-2003: Resumption of Southbound Policy, emphasizing economic and trade cooperation with Southeast Asia and Australia/New Zealand. <br> Late 2003 to 2005: Interview policies for mainland Chinese and foreign spouses from specific countries, impacting some genuine cross-national marriages. <br> 2006: Policy shift towards actively supporting immigrants, enhancing social integration and labor protections. <br> 2007: Establishment of Direct Hiring Service Center to reduce dependence on brokerage firms. |
| 2010s to Present | 2014-2016: Implementation of 7th Southbound Policy program. <br> 2016: Tsai Ing-wen administration's New Southbound Policy to reduce overdependence on China. <br> 2017: Act for the Recruitment and Employment of Foreign Professional Talent passed, relaxing work conditions for foreign professionals. <br> 2018: Online application and one-stop service launched to improve hiring efficiency. <br> 2018: Act for Recruitment and Employment of Foreign Professionals took effect, attracting more foreign talent. <br> 2018: Premier Lai Ching-te proposed draft "New Economic Immigration Act". <br> 2019: Amendments to increase penalties for illegal brokerage. <br> Late 2019: COVID-19 pandemic impacted global labor market. <br> 2020-2021: Temporary extension of work permits for migrant workers during pandemic. <br> 2021: Review of New Southbound Policy, initiatives to retain foreign mid-level technical workforce. <br> February 2022: Approval of "Retaining Migrant Talent Program", allowing foreign technical personnel working in Taiwan for 6 years to apply for permanent residency. <br> April 2022: Implementation of "Retaining Foreign Mid-level Technical Workforce Program", providing pathway for migrant workers to transition to mid-level technical roles. |

#### Immigration Policy (Related to Marriage)

| Time Period | Events and Policy Developments |
|-------------|--------------------------------|
| 1980s       | Emergence of cross-national marriages and issues: Illegal brokers lured Thai and Indonesian women to Taiwan under the pretense of job opportunities, leading to high rates of runaway brides due to language and cultural barriers - a temporary phenomenon. <br> Rise of marriage immigration: As Taiwan's economy took off, cross-national marriages with Southeast Asian countries increased, mainly Taiwanese men marrying foreign brides. <br> Policy shift from exclusion to greater openness towards marriage immigration, leading to a gradual increase. |
| 1986-1991   | Investment and cross-national marriages: Taiwanese investment concentrated in Thailand, Malaysia, and the Philippines, coupled with increased expatriate workers, drove a new wave of cross-national marriages, with Thailand becoming the main source of foreign spouses. |
| 1987        | Post-martial law impact: After the lifting of martial law, the number of immigrants from mainland China to Taiwan increased yearly. |
| 1990s       | Impact of Southbound Policy: With the implementation of the Southbound Policy, the number of people from Southeast Asia immigrating to Taiwan through marriage rapidly increased, marking the start of a new era of immigration. <br> Economic interactions and marriage market: As Asia-Pacific economies rose, interactions between Taiwan, Vietnam, and Indonesia grew frequent. In 1999, Taiwan became Vietnam's second-largest investor. During this period, foreign spouses mainly came from Vietnam and Indonesia. |
| 1992        | Implementation of policies for mainland Chinese spouses: Formal policies established regarding residency and settlement for mainland Chinese spouses in Taiwan. |
| 2000s       | Statistics and policies: In 2005, a survey on the living conditions of foreign and mainland Chinese spouses was conducted, covering those in Taiwan from 1986 to 2003. <br> As of late 2006, there were approximately 80,221 female spouses from Southeast Asia, accounting for 9.3% of all marriages. <br> Establishment of the National Immigration Agency and policy reforms: In 2007, the National Immigration Agency was established as the central authority for new immigrants, strengthening management and support policies for foreign spouses, such as setting up a consultation hotline. <br> In 2009, the Ma Ying-jeou administration shortened the required residency period for mainland Chinese spouses to obtain ID cards from 8 years to 6 years. |
| 2014-2023   | 2015: Implementation of overseas interview policy, requiring couples involving nationals from specific countries to complete an interview at a foreign mission after marriage registration before the foreign spouse can obtain a visa to Taiwan. <br> 2016: Amendment to the Nationality Act exempted those with exceptional contributions from renouncing their original nationality when naturalizing. <br> Around 50 high-level professionals, including soccer coaches, have naturalized under this provision. <br> Nationality Act amendment allowed applicants to delay renunciation of original nationality until after naturalization approval, preventing them from becoming stateless if rejected. <br> 2017: The Ministry of Interior requested local governments to identify individuals with exceptional contributions interested in naturalization. <br> Streamlined naturalization process, taking approximately 10 days to complete. <br> 2018: Foreign spouses no longer required to provide financial proof for naturalization applications. Divorced or widowed applicants granted same 3-year residency requirement as foreign spouses, without financial thresholds. <br> 2019: While Taiwan legalized same-sex marriage, cross-national same-sex couples faced challenges in marriage registration due to legal inconsistencies. <br> January 2023: New interpretation removed some barriers for cross-national same-sex marriages, allowing Taiwanese citizens to register marriages with same-sex foreign partners (including Hong Kong and Macau residents but excluding mainland Chinese), regardless of their home country's stance on same-sex marriage. <br> March 2023: Revision of overseas interview guidelines removed obstacles, facilitating marriage registration for cross-national same-sex couples in Taiwan. |

### B. Taiwan's Entry and Exit Regulations and Changes from 2021 to 2023

| Year | Category                   | Regulation Details                                                                                          |
|------|----------------------------|------------------------------------------------------------------------------------------------------------|
| 2021 | Entry Regulations          | - Starting from March 19, 2020: 14-day home quarantine required for all entrants.<br>- Starting from December 1, 2020: Negative COVID-19 nucleic acid test report and proof of quarantine accommodation required.<br>- Starting from May 4, 2021: Travelers from high-risk countries (e.g., India, Brazil) must stay in centralized quarantine facilities and undergo testing.<br>- Starting from June 27, 2021: All entrants must stay in quarantine hotels or centralized quarantine facilities and use quarantine taxis to reach the location. |
| 2021 | Exit Regulations           | - All global destinations under "Red Alert," advising against non-essential travel abroad.                 |
| 2021 | Foreign Nationals Entry    | - Starting from July 26, 2021: Foreign nationals without valid residence permits are temporarily banned from entering Taiwan, except for humanitarian considerations. |
| 2021 | Flight Operations          | - Some airlines resumed partial international flights, including China Airlines, EVA Air, and Cathay Pacific. |
| 2022 | Entry Regulations          | - Starting from September 29, 2022: Quarantine period adjusted to 3 days of home quarantine followed by 4 days of self-health management.<br>- Starting from August 15, 2022: Requirement for a negative COVID-19 PCR report within 2 days before boarding lifted. |
| 2022 | Border Control Measures    | - Expected implementation from October 13, 2022: New 0+7 policy introduced, replacing home quarantine with 7 days of self-health management.<br>- From October 13, 2022: Borders will reopen, lifting the group travel ban and entry quota.<br>- Requirement for deep throat saliva PCR testing on arrival canceled, replaced by distributing 4 rapid test kits. |
| 2022 | International Travel & Vaccine Quarantine-Free Regulations | - Japan: From October 11, 2022, short-term visa-free travel and individual tourism reopened.<br>- South Korea: From September 26, 2022, outdoor mask mandates lifted.<br>- Europe: Most countries fully reopened, no quarantine required for travelers with two doses of recognized vaccines.<br>- Canada: From October 1, 2022, all COVID-19 entry restrictions lifted.<br>- Australia: From July 6, 2022, international travelers no longer need to provide proof of vaccination.<br>- New Zealand: From September 12, 2022, no proof of vaccination required.<br>- Thailand: From October 1, 2022, all entry restrictions lifted.<br>- Vietnam: From May 15, 2022, no negative SARS-CoV-2 test certificate required. |
| 2022 | Exit Regulations           | - Continued advice against non-essential travel abroad.                                                    |
| 2022 | Foreign Nationals Entry    | - Strict border control measures continued, with foreign nationals without valid residence permits temporarily banned from entering Taiwan. |
| 2022 | Flight Operations          | - Some airlines resumed flights, including Singapore Airlines restoring flights to Taiwan.                  |
| 2023 | Entry Regulations          | - Starting from February 7, 2023: Requirement for saliva PCR testing for arrivals from China and 48-hour rapid test proof canceled.<br>- Starting from October 13, 2023: "0+7" entry policy implemented, replacing home quarantine with 7 days of self-health management. |
| 2023 | Exit Regulations           | - Visa-free entry restored, and the group travel restriction lifted.                                       |
| 2023 | Foreign Nationals Entry    | - Foreign nationals must bear the cost of COVID-19 treatment if diagnosed.                                 |
| 2023 | Flight Operations          | - Quarantine taxi services continued, but asymptomatic travelers could choose public transportation.        |

These regulations reflect Taiwan's measures to cope with the COVID-19 pandemic from 2021 to 2023, with adjustments and relaxations made in response to the global pandemic situation. These changes not only impacted daily life for the general public but also had significant implications for international students and workers.

### C. Naturalization Process for Foreign Spouses in Taiwan

| Step | Description |
|------|-------------|
| **Register Marriage** | Complete the marriage registration at the local Household Registration Office to establish a legal marital relationship. |
| **Apply for a Residency Visa** | Foreign spouses can apply for a long-term residency visa for family reunion purposes. |
| **Apply for a Foreign Resident Certificate** | After legally residing in Taiwan and meeting the residency qualifications, apply at the local service stations of the National Immigration Agency. |
| **Legal Residence of 3 Years** | After legally residing for at least 183 days each year, one can apply for naturalization at the Household Registration Office. |
| **Apply for Naturalization Proof and Renounce Original Nationality** | Before applying for naturalization, one must first apply to renounce their original nationality. |
| **Apply for a Taiwan Residency Card** | After successful naturalization, apply for a Taiwan area residency card. |
| **Apply for a Settlement Certificate** | After meeting certain conditions such as residing continuously for 1 year, or residing for 2 years with at least 270 days each year, one can apply for a settlement certificate. |
| **Household Registration and National ID** | With a settlement certificate, proceed to register a new household at the Household Registration Office and apply for a national ID card. |




