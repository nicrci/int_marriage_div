library(readr)
library(dplyr)
library(ggplot2)
library(readxl)
library(jsonlite)
library(tidyr)
library(stringr)
library(scales)


setwd("/Users/wubingli/Desktop/政大2023學期/RRRRRR coding /final project")


#data cleaning and merge preparation 

mix_2021_new <- mix_2021_all%>%
  group_by(year, month, city, district, city_level, marriage_type, sex, original_nationality, household_registration_status) %>%
  summarise(
    marry_count_sum = sum(marry_count, na.rm = TRUE),
    divorce_count_sum = sum(divorce_count, na.rm = TRUE)
  )

mix_2022_new <- mix_2022_all%>%
  group_by(year, month, city, district, city_level, marriage_type, sex, original_nationality, household_registration_status) %>%
  summarise(
    marry_count_sum = sum(marry_count, na.rm = TRUE),
    divorce_count_sum = sum(divorce_count, na.rm = TRUE)
  )

mix_2023_new <- mix_2023_all%>%
  group_by(year, month, city, district, city_level, marriage_type, sex, original_nationality, household_registration_status) %>%
  summarise(
    marry_count_sum = sum(marry_count, na.rm = TRUE),
    divorce_count_sum = sum(divorce_count, na.rm = TRUE)
  )


mix_all_all <- rbind(mix_2021_new, mix_2022_new, mix_2023_new)

write.csv(mix_all_all, "mix_2021_2023_all.csv", row.names = FALSE)


# data check
mix_all_all_mon <- mix_all_all %>%
  group_by(year,sex) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count_sum), na.rm = TRUE))


ggplot(mix_all_all_mon, aes(x = year, y = sum_divorce_count, fill=sex)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

mix_all_all_yr <- mix_all_all %>%
  group_by(year,sex) %>%
  summarise(sum_marry_count = sum(as.numeric(marry_count_sum), na.rm = TRUE))


ggplot(mix_all_all_yr, aes(x = year, y = sum_marry_count, fill=sex)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



mix_all_sum <- mix_all %>%
  group_by(city) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count_sum), na.rm = TRUE), .groups = 'drop')

ggplot(mix_all_all_sum, aes(x = city, y = sum_divorce_count, fill = sex)) +
  geom_col(position = position_dodge()) +  
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  


mix_all_all_sum <- mix_all_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(city, sex) %>%
  summarise(sum_marry_count = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

ggplot(mix_all_all_sum, aes(x = city, y = sum_marry_count, fill = sex)) +
  geom_col(position = position_dodge()) +  
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  



mix_all_ci <- mix_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(original_nationality, sex) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count_sum), na.rm = TRUE), .groups = 'drop')

ggplot(mix_all_ci, aes(x = original_nationality, y = sum_divorce_count, fill = sex)) +
  geom_col(position = position_dodge()) +  
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  


mix_all_all_cit <- mix_all_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(city_level, sex) %>%
  summarise(sum_marry_count = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

ggplot(mix_all_all_cit, aes(x = city_level, y = sum_marry_count, fill = sex)) +
  geom_col(position = position_dodge()) +  
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  




#visualization

mix_all <- read.csv("mix_110_112_all.csv")

mix_all <-mix_all %>%
  mutate(year=1911+year)


#image for H5
same_sex_data <- mix_all %>%
  filter(original_nationality != "Taiwan" & marriage_type == "Same-Sex" & year %in% c(2022, 2023)) %>%
  group_by(year, month) %>%
  summarise(same_sex_count = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

# 计算所有人的 total_count
total_data <- mix_all %>%
  filter(year %in% c(2022, 2023)) %>%
  group_by(year, month) %>%
  summarise(total_count = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

# 合并数据
mix_all_sameyr <- same_sex_data %>%
  left_join(total_data, by = c("year", "month")) %>%
  mutate(
    same_sex_ratio = (same_sex_count / total_count) * 100,  # 转换为百分比
    year_month = factor(paste(year, month, sep = "-"), levels = paste(rep(2022:2023, each = 12), 1:12, sep = "-"))
  )

# 自定义颜色
line_color <- "#00FFFF"
point_color <- "#1f78b4"

ggplot(mix_all_sameyr, aes(x = year_month, y = same_sex_ratio, group = 1)) +
  geom_line(color = line_color, size = 1.2) +  
  geom_point(color = point_color, size = 2) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    plot.title = element_text(size = 14, face = "bold")
  ) +
  labs(x = "Year-Month", y = "Same-Sex Marriage Ratio (%)", title = "Ratio of Same-Sex Marriages to Total Marriages") +
  scale_y_continuous(labels = scales::percent_format(scale = 1))


#image for H7-H8

#marry
# 定义国家分组
southeast_asia <- c("Thailand", "Laos", "Cambodia", "Vietnam", "Myanmar", "Philippines", "Singapore", "Malaysia", "Indonesia")
china_hk_macao <- c("China", "Hong Kong and Macao")
other_countries <- c("Japan", "Korea", "US", "Canada", "Australia", "New Zealand", "UK", "France", "Germany", "South Africa")

# 创建分组列
mix_all_nama <- mix_all %>%
  filter(original_nationality != "Taiwan" & year %in% c(2021, 2022, 2023)) %>%
  mutate(
    group = case_when(
      original_nationality %in% southeast_asia ~ "Southeast Asia",
      original_nationality %in% china_hk_macao ~ "China, Hong Kong, and Macao",
      TRUE ~ "Other Countries"
    )
  )

# 计算每个分组在每个月份的结婚人数
grouped_data <- mix_all_nama%>%
  group_by(year, month, group) %>%
  summarise(marry_count = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

# 创建 year_month 列
grouped_data <- grouped_data %>%
  mutate(
    year_month = factor(paste(year, month, sep = "-"), levels = paste(rep(2021:2023, each = 12), 1:12, sep = "-"))
  )

# 绘制图表
ggplot(grouped_data, aes(x = year_month, y = marry_count, color = group, group = group)) +
  geom_line(size = 1.2) +
  geom_point(size = 1) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    plot.title = element_text(size = 14, face = "bold")
  ) +
  labs(x = "Year-Month", y = "Total Marriage Count", title = "Marriage Count by Nationality Group") +
  scale_color_manual(values = c("Southeast Asia" = "#c1e291", "China, Hong Kong, and Macao" = "#8f97d5", "Other Countries" = "#f0aa2a"))

#divorce

# 创建分组列
mix_all_nadi <- mix_all %>%
  filter(original_nationality != "Taiwan" & year %in% c(2021, 2022, 2023)) %>%
  mutate(
    group = case_when(
      original_nationality %in% southeast_asia ~ "Southeast Asia",
      original_nationality %in% china_hk_macao ~ "China, Hong Kong, and Macao",
      TRUE ~ "Other Countries"
    )
  )

# 计算每个分组在每个月份的离婚人数
grouped_data2 <- mix_all_nadi %>%
  group_by(year, month, group) %>%
  summarise(divorce_count = sum(as.numeric(divorce_count_sum), na.rm = TRUE), .groups = 'drop')

# 创建 year_month 列
grouped_data2 <- grouped_data2 %>%
  mutate(
    year_month = factor(paste(year, month, sep = "-"), levels = paste(rep(2021:2023, each = 12), 1:12, sep = "-"))
  )

# 绘制图表
ggplot(grouped_data2, aes(x = year_month, y = divorce_count, color = group, group = group)) +
  geom_line(size = 1.2) +
  geom_point(size = 1) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    plot.title = element_text(size = 14, face = "bold")
  ) +
  labs(x = "Year-Month", y = "Total Divorce Count", title = "Divorce Count by Nationality Group") +
  scale_color_manual(values = c("Southeast Asia" = "#c1e291", "China, Hong Kong, and Macao" = "#8f97d5", "Other Countries" = "#f0aa2a"))


#for H1

# 计算非台湾人的结婚数
marriage_counts_exc_tw <- mix_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(city_level) %>%
  summarise(sum_marry_count_exc_tw = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

# 计算非台湾人的离婚数
divorce_counts_exc_tw <- mix_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(city_level) %>%
  summarise(sum_divorce_count_exc_tw = sum(as.numeric(divorce_count_sum), na.rm = TRUE), .groups = 'drop')

# 准备绘图数据
marriage_divorce_counts <- marriage_counts_exc_tw %>%
  rename(count = sum_marry_count_exc_tw) %>%
  mutate(type = "Marriage") %>%
  bind_rows(
    divorce_counts_exc_tw %>%
      rename(count = sum_divorce_count_exc_tw) %>%
      mutate(type = "Divorce")
  )

# 绘制柱状图
plot <- ggplot(marriage_divorce_counts, aes(x = city_level, y = count, fill = type)) +
  geom_col(position = position_dodge()) +
  geom_text(aes(label = count), 
            position = position_dodge(width = 0.9), vjust = -0.5, size = 6) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 16),
        axis.text.y = element_text(size = 16),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        plot.title = element_text(size = 22, face = "bold"),
        legend.title = element_text(size = 18),
        legend.text = element_text(size = 16)) +
  labs(title = "Non-Taiwanese Marriages and Divorces by City Level",
       x = "City Level",
       y = "Count",
       fill = "Type") +
  scale_fill_manual(values = c("Marriage" = "#00BFC4", "Divorce" = "#F8766D"))

# 保存图表
ggsave("H1_bar_diandma.png", plot = plot, width = 30, height = 18)


#raio
# 计算非台湾人的结婚数
marriage_counts_exc_tw <- mix_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(city_level) %>%
  summarise(sum_marry_count_exc_tw = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

# 计算非台湾人的离婚数
divorce_counts_exc_tw <- mix_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(city_level) %>%
  summarise(sum_divorce_count_exc_tw = sum(as.numeric(divorce_count_sum), na.rm = TRUE), .groups = 'drop')

# 计算所有人的结婚数（包括台湾人）
marriage_counts_total <- mix_all %>%
  group_by(city_level) %>%
  summarise(sum_marry_count_total = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

# 计算所有人的离婚数（包括台湾人）
divorce_counts_total <- mix_all %>%
  group_by(city_level) %>%
  summarise(sum_divorce_count_total = sum(as.numeric(divorce_count_sum), na.rm = TRUE), .groups = 'drop')

# 合并结婚数据并计算比例
marriage_counts <- marriage_counts_exc_tw %>%
  full_join(marriage_counts_total, by = "city_level") %>%
  mutate(marry_ratio = sum_marry_count_exc_tw / sum_marry_count_total * 100)

# 合并离婚数据并计算比例
divorce_counts <- divorce_counts_exc_tw %>%
  full_join(divorce_counts_total, by = "city_level") %>%
  mutate(divorce_ratio = sum_divorce_count_exc_tw / sum_divorce_count_total * 100)

# 准备绘图数据
marriage_divorce_ratios <- marriage_counts %>%
  select(city_level, marry_ratio) %>%
  rename(ratio = marry_ratio) %>%
  mutate(type = "Marriage") %>%
  bind_rows(
    divorce_counts %>%
      select(city_level, divorce_ratio) %>%
      rename(ratio = divorce_ratio) %>%
      mutate(type = "Divorce")
  )

# 绘制柱状图
ggplot(marriage_divorce_ratios, aes(x = city_level, y = ratio, fill = type)) +
  geom_col(position = position_dodge()) +
  geom_text(aes(label = paste0(round(ratio, 1), "%")), 
            position = position_dodge(width = 0.9), vjust = -0.5, size = 3) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Ratio of Non-Taiwanese Marriages and Divorces by City Level",
       x = "City Level",
       y = "Ratio (%)",
       fill = "Type") +
  scale_fill_manual(values = c("Marriage" = "#00BFC4", "Divorce" = "#F8766D"))


#for basic des

#divorce
# Your existing data preparation code
mix_all_naba <- mix_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(original_nationality) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count_sum), na.rm = TRUE), .groups = 'drop')

divorce_counts_totalna <- mix_all %>%
  summarise(sum_divorce_count_total = sum(as.numeric(divorce_count_sum), na.rm = TRUE))

mix_all_naba <- mix_all_naba %>%
  mutate(proportion = sum_divorce_count / divorce_counts_totalna$sum_divorce_count_total * 100) %>%
  arrange(desc(proportion))

# Define a larger color palette or manually set colors
colors <- c("#FFD700", "#8A2BE2", "#D3D3D3", "#FF4500", "#FF8C00", "#FFA500",
            "#00FF00", "#00CED1", "#1E90FF", "#A9A9A9", "#FF1493", "#DC143C", 
            "#ADFF2F", "#FF00FF", "#BA55D3", "#87CEEB", "#7FFF00", "#FF6347", 
            "#FF69B4", "#FFDAB9", "#CD5C5C")

# Ensure there are enough colors for each nationality
if (length(colors) < nrow(mix_all_naba)) {
  colors <- colorRampPalette(colors)(nrow(mix_all_naba))
}

# Reordering the factor levels
mix_all_naba <- mix_all_naba %>%
  mutate(original_nationality = factor(original_nationality, levels = original_nationality[order(proportion, decreasing = TRUE)]))

# Plotting the sorted pie chart with distinct colors
plot2 <- ggplot(mix_all_naba, aes(x = 2, y = proportion, fill = original_nationality)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  xlim(0.5, 2.5) +
  theme_minimal() +
  labs(title = "The Divorce Ratio in Different Nationality",
       x = NULL, y = NULL) +
  theme(axis.text.x = element_blank(),  # Remove X-axis text labels
        axis.ticks = element_blank(),  # Remove X-axis and Y-axis ticks
        panel.grid = element_blank(),  # Remove background grid lines
        plot.title = element_text(hjust = 0.5)) +  # Center the title horizontally
  scale_fill_manual(values = colors) +
  geom_text(aes(label = ifelse(proportion > 5, paste0(round(proportion, 1), "%"), "")), 
            position = position_stack(vjust = 0.5))

ggsave("basic_donut_divorce.png", plot = plot2, width = 10, height = 6, bg = "white")

#marry


# Your data preparation code for marriage counts
mix_all_nabama <- mix_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(original_nationality) %>%
  summarise(sum_marry_count = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

marry_counts_totalna <- mix_all %>%
  summarise(sum_marry_count_total = sum(as.numeric(marry_count_sum), na.rm = TRUE))

mix_all_nabama <- mix_all_nabama %>%
  mutate(proportion = sum_marry_count / marry_counts_totalna$sum_marry_count_total * 100) %>%
  arrange(desc(proportion))

# Define a larger color palette or manually set colors
colors2 <- c("#FFD700", "#8A2BE2", "#D3D3D3", "#FF4500", "#FF8C00", "#FFA500",
             "#00FF00", "#00CED1", "#1E90FF", "#A9A9A9", "#FF1493", "#DC143C", 
             "#ADFF2F", "#FF00FF", "#BA55D3", "#87CEEB", "#7FFF00", "#FF6347", 
             "#FF69B4", "#FFDAB9", "#CD5C5C")

# Ensure there are enough colors for each nationality
if (length(colors2) < nrow(mix_all_nabama)) {
  colors2 <- colorRampPalette(colors2)(nrow(mix_all_nabama))
}

# Reordering the factor levels
mix_all_nabama <- mix_all_nabama %>%
  mutate(original_nationality = factor(original_nationality, levels = original_nationality[order(proportion, decreasing = TRUE)]))

# Plotting the sorted pie chart with distinct colors
plot3 <- ggplot(mix_all_nabama, aes(x = 2, y = proportion, fill = original_nationality)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  xlim(0.5, 2.5) +
  theme_minimal() +
  labs(title = "The Marriage Ratio in Different Nationality",
       x = NULL, y = NULL) +
  theme(axis.text.x = element_blank(),  # Remove X-axis text labels
        axis.ticks = element_blank(),  # Remove X-axis and Y-axis ticks
        panel.grid = element_blank(),  # Remove background grid lines
        plot.title = element_text(hjust = 0.5)) +  # Center the title horizontally
  scale_fill_manual(values = colors2) +
  geom_text(aes(label = ifelse(proportion > 5, paste0(round(proportion, 1), "%"), "")), 
            position = position_stack(vjust = 0.5))

ggsave("basic_donut_marriage.png", plot = plot3, width = 10, height = 6, bg = "white")



#H2
#divorce
library(dplyr)
library(ggplot2)
library(scales)

# Marriage and Divorce ratio by sex, including Taiwan
mix_bysex_di <- mix_all %>%
  filter(original_nationality %in% c("China", "Vietnam", "Hong Kong and Macao",
                                     "Indonesia", "Japan", "Thailand", "Taiwan")) %>%
  group_by(original_nationality, sex) %>%
  summarise(
    divorce_count = sum(as.numeric(divorce_count_sum), na.rm = TRUE),
    marry_count = sum(as.numeric(marry_count_sum), na.rm = TRUE)
  ) %>%
  mutate(proportion = divorce_count / marry_count)

# Normalize the proportion to make the sum of proportions for each nationality equal to 1
mix_bysex_di <- mix_bysex_di %>%
  group_by(original_nationality) %>%
  mutate(total_proportion = sum(proportion)) %>%
  mutate(normalized_proportion = proportion / total_proportion)

# Manually set the order of original_nationality in reverse
mix_bysex_di$original_nationality <- factor(mix_bysex_di$original_nationality,
                                            levels = rev(c("Vietnam", "China", "Indonesia", 
                                                           "Hong Kong and Macao", "Taiwan", 
                                                           "Japan", "Thailand")))

# Plot proportional horizontal bar plot
plot7 <- ggplot(mix_bysex_di, aes(x = normalized_proportion, y = original_nationality, fill = sex)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_x_continuous(labels = percent_format()) +
  labs(
    title = "Divorce Gender Ratio by Nationality (Calculated by Marriage Count)",
    x = "Divorce Gender Ratio (Calculated by Marriage Count)",
    y = "Seven Major Nationalities",
    fill = "Sex"
  ) +
  theme_minimal() +
  theme(axis.text.y = element_text(hjust = 0))

ggsave("h2_divorce.png", plot = plot7, width = 10, height = 6, bg = "white")


#marry

# Marriage ratio by sex, including Taiwan
mix_bysex_marry <- mix_all %>%
  filter(original_nationality %in% c("China", "Vietnam", "Hong Kong and Macao", "US", "Japan", "Malaysia", "Taiwan")) %>%
  group_by(original_nationality, sex) %>%
  summarise(marry_count = sum(as.numeric(marry_count_sum), na.rm = TRUE))

# Calculate total marry count for each original nationality
total_marry <- mix_bysex_marry %>%
  group_by(original_nationality) %>%
  summarise(total_marry_count = sum(marry_count))

# Calculate proportion of marry counts for each sex within each original nationality
proportions_marry <- mix_bysex_marry %>%
  left_join(total_marry, by = "original_nationality") %>%
  mutate(proportion = marry_count / total_marry_count)

# Separate female data for sorting
female_proportions <- proportions_marry %>%
  filter(sex == "F") %>%
  arrange(proportion)

# Reorder original_nationality based on female proportions
proportions_marry$original_nationality <- factor(proportions_marry$original_nationality,
                                                 levels = female_proportions$original_nationality)

# Plot proportional horizontal bar plot
plot6 <- ggplot(proportions_marry, aes(x = proportion, y = original_nationality, fill = sex)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_x_continuous(labels = scales::percent_format()) +
  labs(
    title = "Marriage Gender Ratio by Nationality",
    x = "Marriage Gender Ratio",
    y = "Seven Major Nationalities",
    fill = "Sex"
  ) +
  theme_minimal() +
  theme(axis.text.y = element_text(hjust = 0))

ggsave("h2_marriage.png", plot = plot6, width = 10, height = 6, bg = "white")



#image2 for H7-H8

#marry
library(ggplot2)
library(dplyr)

southeast_asia <- c("Thailand", "Laos", "Cambodia", "Vietnam", "Myanmar", "Philippines", "Singapore", "Malaysia", "Indonesia")
china <- "China"
hong_kong_macao <- "Hong Kong and Macao"
other_countries <- c("Japan", "Korea", "US", "Canada", "Australia", "New Zealand", "UK", "France", "Germany", "South Africa")

# 创建分组列
mix_all_nadi <- mix_all %>%
  filter(year %in% c(2021, 2022, 2023)) %>%
  mutate(
    group = case_when(
      original_nationality %in% southeast_asia ~ "Southeast Asia",
      original_nationality == china ~ "China",
      original_nationality == hong_kong_macao ~ "Hong Kong and Macao",
      original_nationality %in% other_countries ~ "Other Countries",
      original_nationality == "Taiwan" ~ "Taiwan",
      TRUE ~ "Other Countries"
    )
  )

# 计算每个分组在每个月份的结婚人数
grouped_data2 <- mix_all_nadi %>%
  group_by(year, month, group) %>%
  summarise(marry_count = sum(as.numeric(marry_count_sum), na.rm = TRUE), .groups = 'drop')

# 创建 year_month 列
grouped_data2 <- grouped_data2 %>%
  mutate(
    year_month = factor(paste(year, month, sep = "-"), levels = paste(rep(2021:2023, each = 12), 1:12, sep = "-"))
  )

# 分离台灣和其他國家的數據
data_taiwan <- grouped_data2 %>% filter(group == "Taiwan")
data_others <- grouped_data2 %>% filter(group != "Taiwan")

# 绘制图表
plot4 <- ggplot() +
  geom_line(data = data_others, aes(x = year_month, y = marry_count, color = group, group = group), linewidth = 1.2) +
  geom_point(data = data_others, aes(x = year_month, y = marry_count, color = group, group = group), size = 1) +
  geom_line(data = data_taiwan, aes(x = year_month, y = marry_count / 20, color = group, group = group), linewidth = 1.2, linetype = "dashed") +  # 台灣的數據除以20來縮放
  geom_point(data = data_taiwan, aes(x = year_month, y = marry_count / 20, color = group, group = group), size = 1) +
  scale_y_continuous(
    name = "Total Marry Count (Other Countries)",
    sec.axis = sec_axis(~.*20, name = "Total Marry Count (Taiwan)")  # 台灣數據的Y軸
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    axis.title.x = element_text(size = 12),
    axis.title.y.left = element_text(size = 12, color = "black"),
    axis.title.y.right = element_text(size = 12, color = "#BEBEBE"),
    plot.title = element_text(size = 14, face = "bold"),
    legend.title = element_blank()
  ) +
  labs(x = "Year-Month", y = "Total Marry Count", title = "Marry Count by Nationality Group (Including Taiwan)") +
  scale_color_manual(values = c("Southeast Asia" = "#c1e291", "China" = "#8f97d5", "Hong Kong and Macao" = "#f0aa2a", "Other Countries" = "#d55e00", "Taiwan" = "#BEBEBE"))

# 保存图表
ggsave("New H7-8 marry dual axis.png", plot = plot4, width = 10, height = 6, bg = "white")


#divorce
library(ggplot2)
library(dplyr)

southeast_asia <- c("Thailand", "Laos", "Cambodia", "Vietnam", "Myanmar", "Philippines", "Singapore", "Malaysia", "Indonesia")
china <- "China"
hong_kong_macao <- "Hong Kong and Macao"
other_countries <- c("Japan", "Korea", "US", "Canada", "Australia", "New Zealand", "UK", "France", "Germany", "South Africa")

# 创建分组列
mix_all_nadi <- mix_all %>%
  filter(year %in% c(2021, 2022, 2023)) %>%
  mutate(
    group = case_when(
      original_nationality %in% southeast_asia ~ "Southeast Asia",
      original_nationality == china ~ "China",
      original_nationality == hong_kong_macao ~ "Hong Kong and Macao",
      original_nationality %in% other_countries ~ "Other Countries",
      original_nationality == "Taiwan" ~ "Taiwan",
      TRUE ~ "Other Countries"
    )
  )

# 计算每个分组在每个月份的离婚人数
grouped_data2 <- mix_all_nadi %>%
  group_by(year, month, group) %>%
  summarise(divorce_count = sum(as.numeric(divorce_count_sum), na.rm = TRUE), .groups = 'drop')

# 创建 year_month 列
grouped_data2 <- grouped_data2 %>%
  mutate(
    year_month = factor(paste(year, month, sep = "-"), levels = paste(rep(2021:2023, each = 12), 1:12, sep = "-"))
  )

# 分离台灣和其他國家的數據
data_taiwan <- grouped_data2 %>% filter(group == "Taiwan")
data_others <- grouped_data2 %>% filter(group != "Taiwan")

# 绘制图表
plot5 <- ggplot() +
  geom_line(data = data_others, aes(x = year_month, y = divorce_count, color = group, group = group), linewidth = 1.2) +
  geom_point(data = data_others, aes(x = year_month, y = divorce_count, color = group, group = group), size = 1) +
  geom_line(data = data_taiwan, aes(x = year_month, y = divorce_count / 20, color = group, group = group), linewidth = 1.2, linetype = "dashed") +  # 台灣的數據除以20來縮放
  geom_point(data = data_taiwan, aes(x = year_month, y = divorce_count / 20, color = group, group = group), size = 1) +
  scale_y_continuous(
    name = "Total Divorce Count (Other Countries)",
    sec.axis = sec_axis(~.*20, name = "Total Divorce Count (Taiwan)")  # 台灣數據的Y軸
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    axis.title.y.right = element_text(size = 12, color = "#BEBEBE"),
    axis.title.y.left = element_text(size = 12, color = "black"),
    plot.title = element_text(size = 14, face = "bold"),
    legend.title = element_blank()
  ) +
  labs(x = "Year-Month", y = "Total Divorce Count", title = "Divorce Count by Nationality Group (Including Taiwan)") +
  scale_color_manual(values = c("Southeast Asia" = "#c1e291", "China" = "#8f97d5", "Hong Kong and Macao" = "#f0aa2a", "Other Countries" = "#d55e00", "Taiwan" = "#BEBEBE"))

# 保存图表
ggsave("New H7-8 divorce dual axis.png", plot = plot5, width = 10, height = 6, bg = "white")

#Basic map

# 安裝和加載必要的包
remotes::install_github("ropensci/rnaturalearthhires")

library(remotes)
library(sf)
library(ggplot2)
library(dplyr)
library(rnaturalearth)
library(rnaturalearthdata)
library(rnaturalearthhires)

# 下載台灣的地圖數據
taiwan <- ne_download(scale = "large", type = "states",
                      category = "cultural", returnclass = "sf")
taiwan <- taiwan %>% filter(admin == "Taiwan")

# 更改地名以匹配數據
taiwan <- taiwan %>%
  mutate(name = case_when(
    name == "Taoyuan" ~ "Taoyuan City",
    name == "Hsinchu" ~ "Hsinchu County",
    name == "Miaoli" ~ "Miaoli County",
    name == "Changhua" ~ "Changhua County",
    name == "Chiayi" ~ "Chiayi County",
    name == "Pingtung" ~ "Pingtung County",
    name == "Taitung" ~ "Taitung County",
    name == "Hualien" ~ "Hualien County",
    name == "Yilan" ~ "Yilan County",
    name == "Nantou" ~ "Nantou County",
    name == "Yunlin" ~ "Yunlin County",
    TRUE ~ name
  ))

# 讀取婚姻和離婚數據
mix_all <- read.csv("mix_2021_2023_all.csv")

# 排除台灣人的數據
mix_all_foreigners <- mix_all %>% filter(original_nationality != "Taiwan")

# 讀取人口數據
tw_population <- read.csv("taiwan_population2021_2023.csv")

# 整合婚姻和離婚數據
mix_all_ciyr <- mix_all_foreigners %>%
  group_by(year, city) %>%
  summarise(marry_count = sum(as.numeric(marry_count_sum), na.rm = TRUE),
            divorce_count = sum(as.numeric(divorce_count_sum), na.rm = TRUE))

# 將婚姻和離婚數據與人口數據合併
mix_all_ciyr <- mix_all_ciyr %>%
  left_join(tw_population, by = c("city", "year")) %>%
  mutate(divorce_rate = (divorce_count / population) * 100,
         marriage_rate = (marry_count / population) * 100)

# 計算三年平均結婚率和離婚率
average_rates <- mix_all_ciyr %>%
  group_by(city) %>%
  summarise(avg_divorce_rate = mean(divorce_rate, na.rm = TRUE),
            avg_marriage_rate = mean(marriage_rate, na.rm = TRUE))

# 將數據與地圖數據合併
taiwan_merge <- taiwan %>%
  left_join(average_rates, by = c("name" = "city"))

# 繪製結婚率地圖（紅色調）
plot8 <- ggplot(taiwan_merge) +
  geom_sf(aes(fill = avg_marriage_rate), color = "black") +
  scale_fill_gradient(low = "lightpink", high = "#b30000", na.value = "grey50", labels = scales::percent_format(scale = 1)) +
  theme_minimal() +
  labs(title = "Average Marriage Rate (%)",
       fill = "Rate (%)")

ggsave("Average Marriage Rate (Percentage, 2021-2023).png", plot = plot8, width = 10, height = 6, bg = "white")

# 繪製離婚率地圖（紫色調）
plot9 <- ggplot(taiwan_merge) +
  geom_sf(aes(fill = avg_divorce_rate), color = "black") +
  scale_fill_gradient(low = "lavender", high = "#371F76", na.value = "grey50", labels = scales::percent_format(scale = 1)) +
  theme_minimal() +
  labs(title = "Average Divorce Rate (%)",
       fill = "Rate (%)")

ggsave("Average Divorce Rate (Percentage, 2021-2023).png", plot = plot9, width = 10, height = 6, bg = "white")
