library(readr)
library(dplyr)
library(ggplot2)
library(readxl)
library(jsonlite)
library(tidyr)
library(stringr)

setwd("/Users/wubingli/Desktop/政大112學期/RRRRRR coding /final project")

# divorce 

mix_di_112_list <-list.files("divorce112")

mix_di_112 <-data.frame()

for (i in 1:length(mix_di_112_list)) {
  file_path <- paste0("divorce112/", mix_di_112_list[i])
  temp_df <- read.csv(file_path)
  mix_di_112 <- rbind(mix_di_112, temp_df)
}


colnames(mix_di_112) <- c("yearmonth", "district_code", "city_district", "village_li", "marriage_type", "sex", "original_nationality", "household_registration_status", "divorce_count")


# 建立各層級的鄉鎮縣市區名單
level_1_districts <- c("臺北市松山區", "臺北市信義區", "臺北市大安區", "臺北市中山區", "臺北市中正區",
                       "臺北市大同區", "臺北市萬華區", "新北市板橋區", "新北市三重區", "新北市中和區",
                       "新北市永和區", "新北市新莊區", "新北市蘆洲區", "臺中市中區", "臺中市南區",
                       "臺中市西區", "臺中市北區", "高雄市鹽埕區", "高雄市新興區", "高雄市前金區",
                       "高雄市苓雅區")

level_2_districts <- c("臺北市士林區", "臺北市內湖區", "臺北市文山區", "臺北市南港區", "臺北市北投區",
                       "新北市新店區", "桃園市桃園區", "桃園市中壢區", "新竹市東區", "新竹市北區",
                       "新竹縣竹北市", "臺中市東區", "臺中市西屯區", "臺中市南屯區", "臺南市東區",
                       "臺南市北區", "臺南市安平區", "臺南市中西區", "高雄市三民區", "高雄市鼓山區",
                       "高雄市左營區", "高雄市楠梓區", "高雄市鳳山區", "高雄市鳥松區")

level_3_districts <- c("新北市淡水區", "新北市林口區", "新北市三峽區", "新北市土城區", "新北市樹林區",
                       "新北市五股區", "新北市鶯歌區", "新北市八里區", "桃園市楊梅區", "桃園市蘆竹區",
                       "桃園市龜山區", "桃園市八德區", "桃園市龍潭區", "桃園市平鎮區", "新竹市香山區",
                       "新竹縣竹東鎮", "新竹縣新埔鎮", "新竹縣湖口鄉", "新竹縣新豐鄉", "新竹縣芎林鄉",
                       "新竹縣寶山鄉", "苗栗縣竹南鎮", "苗栗縣頭份市", "臺中市北屯區", "臺中市清水區",
                       "臺中市沙鹿區", "臺中市梧棲區", "臺中市潭子區", "臺中市大雅區", "臺中市烏日區",
                       "臺中市龍井區", "臺中市太平區", "臺中市大里區", "臺南市善化區", "臺南市新市區",
                       "臺南市仁德區", "臺南市永康區", "臺南市安南區", "高雄市仁武區", "高雄市橋頭區")

level_4_districts <- c("新北市汐止區", "新北市泰山區", "新北市深坑區", "新北市烏來區", "基隆市中正區",
                       "基隆市七堵區", "基隆市暖暖區", "基隆市仁愛區", "基隆市中山區", "基隆市安樂區",
                       "基隆市信義區", "桃園市大溪區", "桃園市大園區", "苗栗縣苗栗市", "臺中市豐原區",
                       "臺中市霧峰區", "彰化縣彰化市", "彰化縣員林市", "彰化縣北斗鎮", "南投縣南投市",
                       "南投縣埔里鎮", "南投縣草屯鎮", "雲林縣斗六市", "雲林縣斗南鎮", "雲林縣虎尾鎮",
                       "嘉義市東區", "嘉義市西區", "嘉義縣太保市", "嘉義縣朴子市", "嘉義縣民雄鄉",
                       "臺南市新營區", "臺南市佳里區", "臺南市新化區", "臺南市歸仁區", "臺南市南區",
                       "高雄市前鎮區", "高雄市小港區", "高雄市大寮區", "高雄市大社區", "高雄市岡山區",
                       "屏東縣屏東市", "屏東縣潮州鎮", "屏東縣東港鎮", "屏東縣恆春鎮", "屏東縣長治鄉",
                       "屏東縣琉球鄉", "屏東縣霧臺鄉", "屏東縣牡丹鄉", "澎湖縣馬公市", "宜蘭縣宜蘭市",
                       "宜蘭縣羅東鎮", "宜蘭縣頭城鎮", "宜蘭縣礁溪鄉", "宜蘭縣壯圍鄉", "宜蘭縣員山鄉",
                       "宜蘭縣冬山鄉", "宜蘭縣五結鄉", "花蓮縣花蓮市", "花蓮縣新城鄉", "花蓮縣吉安鄉",
                       "臺東縣臺東市", "臺東縣綠島鄉", "臺東縣達仁鄉")

level_5_districts <- c("桃園市新屋區", "苗栗縣苑裡鎮", "臺中市大甲區", "臺中市后里區", "臺中市神岡區",
                       "臺中市外埔區", "臺中市大安區", "臺中市大肚區", "彰化縣鹿港鎮", "彰化縣和美鎮",
                       "彰化縣線西鄉", "彰化縣伸港鄉", "彰化縣福興鄉", "彰化縣秀水鄉", "彰化縣花壇鄉",
                       "彰化縣溪湖鎮", "彰化縣埔鹽鄉", "彰化縣埔心鄉", "彰化縣社頭鄉", "臺南市西港區",
                       "臺南市安定區", "臺南市山上區", "臺南市關廟區", "高雄市林園區", "高雄市阿蓮區",
                       "高雄市路竹區", "高雄市湖內區", "高雄市茄萣區", "高雄市永安區", "高雄市彌陀區",
                       "高雄市梓官區")

level_6_districts <- c("新北市瑞芳區", "新北市石碇區", "新北市坪林區", "新北市三芝區", "新北市石門區",
                       "新北市平溪區", "新北市雙溪區", "新北市貢寮區", "新北市金山區", "新北市萬里區",
                       "新竹縣關西鎮", "新竹縣橫山鄉", "新竹縣北埔鄉", "苗栗縣通霄鎮", "苗栗縣後龍鎮",
                       "苗栗縣公館鄉", "苗栗縣銅鑼鄉", "苗栗縣南庄鄉", "苗栗縣頭屋鄉", "苗栗縣三義鄉",
                       "苗栗縣西湖鄉", "苗栗縣造橋鄉", "苗栗縣三灣鄉", "臺中市石岡區", "彰化縣芬園鄉",
                       "彰化縣田中鎮", "彰化縣永靖鄉", "彰化縣田尾鄉", "彰化縣埤頭鄉", "南投縣竹山鎮",
                       "南投縣集集鎮", "南投縣魚池鄉", "雲林縣北港鎮", "雲林縣莿桐鄉", "雲林縣林內鄉",
                       "嘉義縣大林鎮", "嘉義縣水上鄉", "嘉義縣中埔鄉", "臺南市鹽水區", "臺南市柳營區",
                       "臺南市麻豆區", "臺南市下營區", "臺南市六甲區", "臺南市官田區", "臺南市學甲區",
                       "臺南市七股區", "臺南市將軍區", "高雄市旗津區", "高雄市大樹區", "高雄市燕巢區",
                       "高雄市旗山區", "屏東縣萬丹鄉", "屏東縣麟洛鄉", "屏東縣九如鄉", "屏東縣內埔鄉",
                       "屏東縣竹田鄉", "屏東縣新園鄉", "屏東縣崁頂鄉", "屏東縣車城鄉", "屏東縣滿州鄉",
                       "澎湖縣西嶼鄉", "澎湖縣望安鄉", "澎湖縣七美鄉", "澎湖縣白沙鄉", "宜蘭縣蘇澳鎮",
                       "宜蘭縣三星鄉", "花蓮縣鳳林鎮", "花蓮縣玉里鎮", "花蓮縣壽豐鄉", "花蓮縣光復鄉",
                       "花蓮縣豐濱鄉", "花蓮縣瑞穗鄉", "花蓮縣富里鄉", "臺東縣成功鎮", "臺東縣關山鎮",
                       "臺東縣鹿野鄉", "臺東縣池上鄉", "臺東縣長濱鄉", "臺東縣大武鄉")

level_7_districts <- c("新竹縣峨眉鄉", "苗栗縣卓蘭鎮", "苗栗縣大湖鄉", "苗栗縣獅潭鄉", "臺中市東勢區",
                       "臺中市新社區", "彰化縣二水鄉", "彰化縣二林鎮", "彰化縣芳苑鄉", "彰化縣大城鄉",
                       "彰化縣竹塘鄉", "彰化縣溪州鄉", "南投縣名間鄉", "南投縣鹿谷鄉", "南投縣中寮鄉",
                       "南投縣國姓鄉", "南投縣水里鄉", "雲林縣西螺鎮", "雲林縣土庫鎮", "雲林縣古坑鄉",
                       "雲林縣大埤鄉", "雲林縣二崙鄉", "雲林縣崙背鄉", "雲林縣東勢鄉", "雲林縣褒忠鄉",
                       "雲林縣臺西鄉", "雲林縣元長鄉", "雲林縣四湖鄉", "雲林縣口湖鄉", "雲林縣水林鄉",
                       "嘉義縣布袋鎮", "嘉義縣溪口鄉", "嘉義縣新港鄉", "嘉義縣六腳鄉", "嘉義縣東石鄉",
                       "嘉義縣義竹鄉", "嘉義縣鹿草鄉", "嘉義縣竹崎鄉", "嘉義縣梅山鄉", "嘉義縣番路鄉",
                       "嘉義縣大埔鄉", "臺南市白河區", "臺南市後壁區", "臺南市東山區", "臺南市大內區",
                       "臺南市北門區", "臺南市玉井區", "臺南市楠西區", "臺南市南化區", "臺南市左鎮區",
                       "臺南市龍崎區", "高雄市田寮區", "高雄市美濃區", "高雄市六龜區", "高雄市甲仙區",
                       "高雄市杉林區", "高雄市內門區", "屏東縣里港鄉", "屏東縣鹽埔鄉", "屏東縣高樹鄉",
                       "屏東縣萬巒鄉", "屏東縣新埤鄉", "屏東縣枋寮鄉", "屏東縣林邊鄉", "屏東縣南州鄉",
                       "屏東縣佳冬鄉", "屏東縣枋山鄉", "臺東縣卑南鄉", "臺東縣東河鄉", "臺東縣太麻里鄉")

level_8_districts <- c("桃園市觀音區", "桃園市復興區", "新竹縣尖石鄉", "新竹縣五峰鄉", "苗栗縣泰安鄉",
                       "臺中市和平區", "彰化縣大村鄉", "南投縣信義鄉", "南投縣仁愛鄉", "雲林縣麥寮鄉",
                       "嘉義縣阿里山鄉", "高雄市茂林區", "高雄市桃源區", "高雄市那瑪夏區", "屏東縣三地門鄉",
                       "屏東縣瑪家鄉", "屏東縣泰武鄉", "屏東縣來義鄉", "屏東縣春日鄉", "屏東縣獅子鄉",
                       "澎湖縣湖西鄉", "宜蘭縣大同鄉", "宜蘭縣南澳鄉", "花蓮縣秀林鄉", "花蓮縣萬榮鄉",
                       "花蓮縣卓溪鄉", "臺東縣海端鄉", "臺東縣延平鄉", "臺東縣金峰鄉", "臺東縣蘭嶼鄉")

# 假設你的數據框名為 'df'
mix_di_112 <- mix_di_112 %>%
  mutate(city_level = case_when(
    city_district %in% level_1_districts ~ 1,
    city_district %in% level_2_districts ~ 2,
    city_district %in% level_3_districts ~ 3,
    city_district %in% level_4_districts ~ 4,
    city_district %in% level_5_districts ~ 5,
    city_district %in% level_6_districts ~ 6,
    city_district %in% level_7_districts ~ 7,
    city_district %in% level_8_districts ~ 8,
    TRUE ~ NA_real_  # 其他區域目前設置為NA
  ))

# 將divorce_count列轉換為數值型
mix_di_112 <- mix_di_112 %>%
  mutate(divorce_count = as.numeric(divorce_count))

# 按city_level分組並計算離婚數量總和
mix_di_112_test <- mix_di_112 %>%
  group_by(city_level) %>%
  summarise(
    divorce_count_sum = sum(divorce_count, na.rm = TRUE)
  )





mix_di_112 <- mix_di_112 %>%
  mutate(
  household_registration_status = recode(household_registration_status, "已設籍" = "Registered", "未設籍" = "Not register"),
  marriage_type = recode(marriage_type, "不同性別" = "Different-Sex", "相同性別" = "Same-Sex"),
  sex = recode(sex, "男" = "M", "女" = "F"),
  original_nationality = recode(original_nationality,
                                "本國" = "Taiwan",
                                "大陸地區" = "China",
                                "港澳地區" = "Hong Kong and Macao",
                                "日本" = "Japan",
                                "韓國" = "Korea",
                                "美國" = "US",
                                "加拿大" = "Canada",
                                "澳大利亞" = "Australia",
                                "紐西蘭" = "New Zealand",
                                "英國" = "UK",
                                "法國" = "France",
                                "德國" = "Germany",
                                "南非" = "South Africa",
                                "東南亞泰國" = "Thailand",
                                "東南亞寮國" = "Laos",
                                "東南亞柬埔寨" = "Cambodia",
                                "東南亞越南" = "Vietnam",
                                "東南亞緬甸" = "Myanmar",
                                "東南亞菲律賓" = "Philippines",
                                "東南亞新加坡" = "Singapore",
                                "東南亞馬來西亞" = "Malaysia",
                                "東南亞印尼" = "Indonesia",
                                "史瓦帝尼" = "Eswatini",
                                "賴索托" = "Lesotho",
                                "模里西斯" = "Mauritius",
                                "其他" = "Other"
  )
)



mix_di_112 <- mix_di_112 %>%
  filter(
    !original_nationality %in% c("Eswatini", "Lesotho", "Mauritius", "Other"),
    !city_district %in% c("連江縣東引鄉", "連江縣北竿鄉", "連江縣莒光鄉",
                          "連江縣南竿鄉", "金門縣金寧鄉", "金門縣烈嶼鄉",
                          "金門縣烏坵鄉", "金門縣金沙鎮", "金門縣金城鎮",
                          "金門縣金湖鎮", "澎湖縣湖西鄉", "澎湖縣白沙鄉",
                          "澎湖縣七美鄉", "澎湖縣馬公市", "澎湖縣望安鄉", "澎湖縣馬公市","澎湖縣西嶼鄉")
  )


mask <- grepl("統計年月", mix_di_112$yearmonth)

# 使用這個 mask 來過濾出不包含 '統計年月' 的行
mix_di_112_filtered <- mix_di_112[!mask, ]


mix_di_112_test2 <- mix_di_112_filtered %>%
  group_by(city_level) %>%
  summarise(
    divorce_count_sum = sum(divorce_count, na.rm = TRUE)
  )



mix_di_112_filtered <- mix_di_112_filtered %>%
  mutate(
    year = str_extract(yearmonth, "^\\d{3}"),   # 使用正則表達式提取前三位數字作為年份
    month = str_extract(yearmonth, "\\d{2}$")  # 使用正則表達式提取最後兩位數字作為月份
  )



# Function for divide city and district
city <- regexpr("市|縣", mix_di_112_filtered$city_district)
mix_di_112_filtered$city <- substr(mix_di_112_filtered$city_district, 1, city )
mix_di_112_filtered$district <- substr(mix_di_112_filtered$city_district, city+1, nchar(mix_di_112_filtered$city_district))


# Function for change city and district to en
mix_di_112_done <- mix_di_112_filtered %>%
  mutate(
    city = recode(city,
                  "臺北市" = "Taipei City",
                  "新北市" = "New Taipei City",
                  "桃園市" = "Taoyuan City",
                  "臺中市" = "Taichung City",
                  "臺南市" = "Tainan City",
                  "高雄市" = "Kaohsiung City",
                  "基隆市" = "Keelung City",
                  "新竹市" = "Hsinchu City",
                  "新竹縣" = "Hsinchu County",
                  "苗栗縣" = "Miaoli County",
                  "彰化縣" = "Changhua County",
                  "南投縣" = "Nantou County",
                  "雲林縣" = "Yunlin County",
                  "嘉義市" = "Chiayi City",
                  "嘉義縣" = "Chiayi County",
                  "屏東縣" = "Pingtung County",
                  "宜蘭縣" = "Yilan County",
                  "花蓮縣" = "Hualien County",
                  "臺東縣" = "Taitung County",
                  "澎湖縣" = "Penghu County",
                  "金門縣" = "Kinmen County",
                  "連江縣" = "Lienchiang County"
    ))


mix_di_112_done <- mix_di_112_done %>%
  mutate(
    district = recode(district,
                      "中正區"="Zhongzheng Dist.",
                      "大同區"="Datong Dist.",
                      "中山區"="Zhongshan Dist.",
                      "松山區"="Songshan Dist.",
                      "大安區"="Da’an Dist.",
                      "萬華區"="Wanhua Dist.",
                      "信義區"="Xinyi Dist.",
                      "士林區"="Shilin Dist.",
                      "北投區"="Beitou Dist.",
                      "內湖區"="Neihu Dist.",
                      "南港區"="Nangang Dist.",
                      "文山區"="Wenshan Dist.",
                      "仁愛區"="Ren’ai Dist.",
                      "中正區"="Zhongzheng Dist.",
                      "中山區"="Zhongshan Dist.",
                      "安樂區"="Anle Dist.",
                      "暖暖區"="Nuannuan Dist.",
                      "七堵區"="Qidu Dist.",
                      "萬里區"="Wanli Dist.",
                      "金山區"="Jinshan Dist.",
                      "板橋區"="Banqiao Dist.",
                      "汐止區"="Xizhi Dist.",
                      "深坑區"="Shenkeng Dist.",
                      "石碇區"="Shiding Dist.",
                      "瑞芳區"="Ruifang Dist.",
                      "平溪區"="Pingxi Dist.",
                      "雙溪區"="Shuangxi Dist.",
                      "貢寮區"="Gongliao Dist.",
                      "新店區"="Xindian Dist.",
                      "坪林區"="Pinglin Dist.",
                      "烏來區"="Wulai Dist.",
                      "永和區"="Yonghe Dist.",
                      "中和區"="Zhonghe Dist.",
                      "土城區"="Tucheng Dist.",
                      "三峽區"="Sanxia Dist.",
                      "樹林區"="Shulin Dist.",
                      "鶯歌區"="Yingge Dist.",
                      "三重區"="Sanchong Dist.",
                      "新莊區"="Xinzhuang Dist.",
                      "泰山區"="Taishan Dist.",
                      "林口區"="Linkou Dist.",
                      "蘆洲區"="Luzhou Dist.",
                      "五股區"="Wugu Dist.",
                      "八里區"="Bali Dist.",
                      "淡水區"="Tamsui Dist.",
                      "三芝區"="Sanzhi Dist.",
                      "石門區"="Shimen Dist.",
                      "宜蘭市"="Yilan City",
                      "頭城鎮"="Toucheng Township",
                      "礁溪鄉"="Jiaoxi Township",
                      "壯圍鄉"="Zhuangwei Township",
                      "員山鄉"="Yuanshan Township",
                      "羅東鎮"="Luodong Township",
                      "三星鄉"="Sanxing Township",
                      "大同鄉"="Datong Township",
                      "五結鄉"="Wujie Township",
                      "冬山鄉"="Dongshan Township",
                      "蘇澳鎮"="Su’ao Township",
                      "南澳鄉"="Nan’ao Township",
                      "東區"="East Dist.",
                      "北區"="North Dist.",
                      "香山區"="Xiangshan Dist.",
                      "竹北市"="Zhubei City",
                      "湖口鄉"="Hukou Township",
                      "新豐鄉"="Xinfeng Township",
                      "新埔鎮"="Xinpu Township",
                      "關西鎮"="Guanxi Township",
                      "芎林鄉"="Qionglin Township",
                      "寶山鄉"="Baoshan Township",
                      "竹東鎮"="Zhudong Township",
                      "五峰鄉"="Wufeng Township",
                      "橫山鄉"="Hengshan Township",
                      "尖石鄉"="Jianshi Township",
                      "北埔鄉"="Beipu Township",
                      "峨眉鄉"="Emei Township",
                      "中壢區"="Zhongli Dist.",
                      "平鎮區"="Pingzhen Dist.",
                      "龍潭區"="Longtan Dist.",
                      "楊梅區"="Yangmei Dist.",
                      "新屋區"="Xinwu Dist.",
                      "觀音區"="Guanyin Dist.",
                      "桃園區"="Taoyuan Dist.",
                      "龜山區"="Guishan Dist.",
                      "八德區"="Bade Dist.",
                      "大溪區"="Daxi Dist.",
                      "復興區"="Fuxing Dist.",
                      "大園區"="Dayuan Dist.",
                      "蘆竹區"="Luzhu Dist.",
                      "竹南鎮"="Zhunan Township",
                      "三灣鄉"="Sanwan Township",
                      "南庄鄉"="Nanzhuang Township",
                      "獅潭鄉"="Shitan Township",
                      "後龍鎮"="Houlong Township",
                      "通霄鎮"="Tongxiao Township",
                      "苑裡鎮"="Yuanli Township",
                      "苗栗市"="Miaoli City",
                      "造橋鄉"="Zaoqiao Township",
                      "頭屋鄉"="Touwu Township",
                      "公館鄉"="Gongguan Township",
                      "大湖鄉"="Dahu Township",
                      "泰安鄉"="Tai’an Township",
                      "銅鑼鄉"="Tongluo Township",
                      "三義鄉"="Sanyi Township",
                      "西湖鄉"="Xihu Township",
                      "卓蘭鎮"="Zhuolan Township",
                      "中區"="Central Dist.",
                      "東區"="East Dist.",
                      "南區"="South Dist.",
                      "西區"="West Dist.",
                      "北區"="North Dist.",
                      "北屯區"="Beitun Dist.",
                      "西屯區"="Xitun Dist.",
                      "南屯區"="Nantun Dist.",
                      "太平區"="Taiping Dist.",
                      "大里區"="Dali Dist.",
                      "霧峰區"="Wufeng Dist.",
                      "烏日區"="Wuri Dist.",
                      "豐原區"="Fengyuan Dist.",
                      "后里區"="Houli Dist.",
                      "石岡區"="Shigang Dist.",
                      "東勢區"="Dongshi Dist.",
                      "和平區"="Heping Dist.",
                      "新社區"="Xinshe Dist.",
                      "潭子區"="Tanzi Dist.",
                      "大雅區"="Daya Dist.",
                      "神岡區"="Shengang Dist.",
                      "大肚區"="Dadu Dist.",
                      "沙鹿區"="Shalu Dist.",
                      "龍井區"="Longjing Dist.",
                      "梧棲區"="Wuqi Dist.",
                      "清水區"="Qingshui Dist.",
                      "大甲區"="Dajia Dist.",
                      "外埔區"="Waipu Dist.",
                      "大安區"="Da’an Dist.",
                      "彰化市"="Changhua City",
                      "芬園鄉"="Fenyuan Township",
                      "花壇鄉"="Huatan Township",
                      "秀水鄉"="Xiushui Township",
                      "鹿港鎮"="Lukang Township",
                      "福興鄉"="Fuxing Township",
                      "線西鄉"="Xianxi Township",
                      "和美鎮"="Hemei Township",
                      "伸港鄉"="Shengang Township",
                      "社頭鄉"="Shetou Township",
                      "永靖鄉"="Yongjing Township",
                      "埔心鄉"="Puxin Township",
                      "溪湖鎮"="Xihu Township",
                      "大村鄉"="Dacun Township",
                      "埔鹽鄉"="Puyan Township",
                      "田中鎮"="Tianzhong Township",
                      "北斗鎮"="Beidou Township",
                      "田尾鄉"="Tianwei Township",
                      "埤頭鄉"="Pitou Township",
                      "溪州鄉"="Xizhou Township",
                      "竹塘鄉"="Zhutang Township",
                      "二林鎮"="Erlin Township",
                      "大城鄉"="Dacheng Township",
                      "芳苑鄉"="Fangyuan Township",
                      "二水鄉"="Ershui Township",
                      "南投市"="Nantou City",
                      "中寮鄉"="Zhongliao Township",
                      "草屯鎮"="Caotun Township",
                      "國姓鄉"="Guoxing Township",
                      "埔里鎮"="Puli Township",
                      "仁愛鄉"="Ren’ai Township",
                      "名間鄉"="Mingjian Township",
                      "集集鎮"="Jiji Township",
                      "水里鄉"="Shuili Township",
                      "魚池鄉"="Yuchi Township",
                      "信義鄉"="Xinyi Township",
                      "竹山鎮"="Zhushan Township",
                      "鹿谷鄉"="Lugu Township",
                      "東區"="East Dist.",
                      "西區"="West Dist.",
                      "番路鄉"="Fanlu Township",
                      "梅山鄉"="Meishan Township",
                      "竹崎鄉"="Zhuqi Township",
                      "阿里山鄉"="Alishan Township",
                      "中埔鄉"="Zhongpu Township",
                      "大埔鄉"="Dapu Township",
                      "水上鄉"="Shuishang Township",
                      "鹿草鄉"="Lucao Township",
                      "太保市"="Taibao City",
                      "朴子市"="Puzi City",
                      "東石鄉"="Dongshi Township",
                      "六腳鄉"="Liujiao Township",
                      "新港鄉"="Xingang Township",
                      "民雄鄉"="Minxiong Township",
                      "大林鎮"="Dalin Township",
                      "溪口鄉"="Xikou Township",
                      "義竹鄉"="Yizhu Township",
                      "布袋鎮"="Budai Township",
                      "斗南鎮"="Dounan Township",
                      "大埤鄉"="Dapi Township",
                      "虎尾鎮"="Huwei Township",
                      "土庫鎮"="Tuku Township",
                      "褒忠鄉"="Baozhong Township",
                      "東勢鄉"="Dongshi Township",
                      "臺西鄉"="Taixi Township",
                      "崙背鄉"="Lunbei Township",
                      "麥寮鄉"="Mailiao Township",
                      "斗六市"="Douliu City",
                      "林內鄉"="Linnei Township",
                      "古坑鄉"="Gukeng Township",
                      "莿桐鄉"="Citong Township",
                      "西螺鎮"="Xiluo Township",
                      "二崙鄉"="Erlun Township",
                      "北港鎮"="Beigang Township",
                      "水林鄉"="Shuilin Township",
                      "口湖鄉"="Kouhu Township",
                      "四湖鄉"="Sihu Township",
                      "元長鄉"="Yuanchang Township",
                      "中西區"="West Central Dist.",
                      "東區"="East Dist.",
                      "南區"="South Dist.",
                      "北區"="North Dist.",
                      "安平區"="Anping Dist.",
                      "安南區"="Annan Dist.",
                      "永康區"="Yongkang Dist.",
                      "歸仁區"="Guiren Dist.",
                      "新化區"="Xinhua Dist.",
                      "左鎮區"="Zuozhen Dist.",
                      "玉井區"="Yujing Dist.",
                      "楠西區"="Nanxi Dist.",
                      "南化區"="Nanhua Dist.",
                      "仁德區"="Rende Dist.",
                      "關廟區"="Guanmiao Dist.",
                      "龍崎區"="Longqi Dist.",
                      "官田區"="Guantian Dist.",
                      "麻豆區"="Madou Dist.",
                      "佳里區"="Jiali Dist.",
                      "西港區"="Xigang Dist.",
                      "七股區"="Qigu Dist.",
                      "將軍區"="Jiangjun Dist.",
                      "學甲區"="Xuejia Dist.",
                      "北門區"="Beimen Dist.",
                      "新營區"="Xinying Dist.",
                      "後壁區"="Houbi Dist.",
                      "白河區"="Baihe Dist.",
                      "東山區"="Dongshan Dist.",
                      "六甲區"="Liujia Dist.",
                      "下營區"="Xiaying Dist.",
                      "柳營區"="Liuying Dist.",
                      "鹽水區"="Yanshui Dist.",
                      "善化區"="Shanhua Dist.",
                      "大內區"="Danei Dist.",
                      "山上區"="Shanshang Dist.",
                      "新市區"="Xinshi Dist.",
                      "安定區"="Anding Dist.",
                      "新興區"="Xinxing Dist.",
                      "前金區"="Qianjin Dist.",
                      "苓雅區"="Lingya Dist.",
                      "鹽埕區"="Yancheng Dist.",
                      "鼓山區"="Gushan Dist.",
                      "旗津區"="Qijin Dist.",
                      "前鎮區"="Qianzhen Dist.",
                      "三民區"="Sanmin Dist.",
                      "楠梓區"="Nanzi Dist.",
                      "小港區"="Xiaogang Dist.",
                      "左營區"="Zuoying Dist.",
                      "仁武區"="Renwu Dist.",
                      "大社區"="Dashe Dist.",
                      "東沙群島"="Dongsha Islands",
                      "南沙群島"="Nansha Islands",
                      "岡山區"="Gangshan Dist.",
                      "路竹區"="Luzhu Dist.",
                      "阿蓮區"="Alian Dist.",
                      "田寮區"="Tianliao Dist.",
                      "燕巢區"="Yanchao Dist.",
                      "橋頭區"="Qiaotou Dist.",
                      "梓官區"="Ziguan Dist.",
                      "彌陀區"="Mituo Dist.",
                      "永安區"="Yong’an Dist.",
                      "湖內區"="Hunei Dist.",
                      "鳳山區"="Fengshan Dist.",
                      "大寮區"="Daliao Dist.",
                      "林園區"="Linyuan Dist.",
                      "鳥松區"="Niaosong Dist.",
                      "大樹區"="Dashu Dist.",
                      "旗山區"="Qishan Dist.",
                      "美濃區"="Meinong Dist.",
                      "六龜區"="Liugui Dist.",
                      "內門區"="Neimen Dist.",
                      "杉林區"="Shanlin Dist.",
                      "甲仙區"="Jiaxian Dist.",
                      "桃源區"="Taoyuan Dist.",
                      "那瑪夏區"="Namaxia Dist.",
                      "茂林區"="Maolin Dist.",
                      "茄萣區"="Qieding Dist.",
                      "屏東市"="Pingtung City",
                      "三地門鄉"="Sandimen Township",
                      "霧臺鄉"="Wutai Township",
                      "瑪家鄉"="Majia Township",
                      "九如鄉"="Jiuru Township",
                      "里港鄉"="Ligang Township",
                      "高樹鄉"="Gaoshu Township",
                      "鹽埔鄉"="Yanpu Township",
                      "長治鄉"="Changzhi Township",
                      "麟洛鄉"="Linluo Township",
                      "竹田鄉"="Zhutian Township",
                      "內埔鄉"="Neipu Township",
                      "萬丹鄉"="Wandan Township",
                      "潮州鎮"="Chaozhou Township",
                      "泰武鄉"="Taiwu Township",
                      "來義鄉"="Laiyi Township",
                      "萬巒鄉"="Wanluan Township",
                      "崁頂鄉"="Kanding Township",
                      "新埤鄉"="Xinpi Township",
                      "南州鄉"="Nanzhou Township",
                      "林邊鄉"="Linbian Township",
                      "東港鎮"="Donggang Township",
                      "琉球鄉"="Liuqiu Township",
                      "佳冬鄉"="Jiadong Township",
                      "新園鄉"="Xinyuan Township",
                      "枋寮鄉"="Fangliao Township",
                      "枋山鄉"="Fangshan Township",
                      "春日鄉"="Chunri Township",
                      "獅子鄉"="Shizi Township",
                      "車城鄉"="Checheng Township",
                      "牡丹鄉"="Mudan Township",
                      "恆春鎮"="Hengchun Township",
                      "滿州鄉"="Manzhou Township",
                      "臺東市"="Taitung City",
                      "綠島鄉"="Ludao Township",
                      "蘭嶼鄉"="Lanyu Township",
                      "延平鄉"="Yanping Township",
                      "卑南鄉"="Beinan Township",
                      "鹿野鄉"="Luye Township",
                      "關山鎮"="Guanshan Township",
                      "海端鄉"="Haiduan Township",
                      "池上鄉"="Chishang Township",
                      "東河鄉"="Donghe Township",
                      "成功鎮"="Chenggong Township",
                      "長濱鄉"="Changbin Township",
                      "太麻里鄉"="Taimali Township",
                      "金峰鄉"="Jinfeng Township",
                      "大武鄉"="Dawu Township",
                      "達仁鄉"="Daren Township",
                      "蘭屿鄉"="Lanyu Township",
                      "花蓮市"="Hualien City",
                      "新城鄉"="Xincheng Township",
                      "秀林鄉"="Xiulin Township",
                      "吉安鄉"="Ji’an Township",
                      "壽豐鄉"="Shoufeng Township",
                      "鳳林鎮"="Fenglin Township",
                      "光復鄉"="Guangfu Township",
                      "豐濱鄉"="Fengbin Township",
                      "瑞穗鄉"="Ruisui Township",
                      "萬榮鄉"="Wanrong Township",
                      "玉里鎮"="Yuli Township",
                      "卓溪鄉"="Zhuoxi Township",
                      "富里鄉"="Fuli Township"
    ))

mix_di_112_sum <- mix_di_112_done %>%
  group_by(city,sex) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count)))

ggplot(mix_di_112_sum, aes(x = city, y = sum_divorce_count, fill = sex)) +
  geom_col(position = position_dodge()) +  # 使用 position_dodge() 來分隔不同性別的柱子
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # 將 x 軸的文字旋轉 90 度

mix_di_112_na <- mix_di_112_done %>%
  group_by(original_nationality,sex) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count)))

ggplot(mix_di_112_na, aes(x = reorder(original_nationality, -sum_divorce_count), y = sum_divorce_count, fill = sex)) +
  geom_col(position = position_dodge()) +
  scale_y_log10() +  # 使用對數尺度，如果仍需要的話
  labs(x = "Original Nationality", y = "Sum of Divorce Count") +  # 添加軸標籤
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # 將 x 軸的文字旋轉 90 度


# 确保只按月份分组
unique(mix_di_112_done$month)

mix_di_112_mon <- mix_di_112_done %>%
  group_by(month) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count), na.rm = TRUE))


ggplot(mix_di_112_mon, aes(x = month, y = sum_divorce_count)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# marry


mix_ma_112_list <-list.files("marriage112")

mix_ma_112 <-data.frame()

for (i in 1:length(mix_ma_112_list)) {
  file_path <- paste0("marriage112/", mix_ma_112_list[i])
  temp_df <- read.csv(file_path)
  mix_ma_112 <- rbind(mix_ma_112, temp_df)
}


colnames(mix_ma_112) <- c("yearmonth", "district_code", "city_district", "village_li", "marriage_type", "sex", "original_nationality", "household_registration_status", "marry_count")


mix_ma_112 <- mix_ma_112 %>%
  mutate(city_level = case_when(
    city_district %in% level_1_districts ~ 1,
    city_district %in% level_2_districts ~ 2,
    city_district %in% level_3_districts ~ 3,
    city_district %in% level_4_districts ~ 4,
    city_district %in% level_5_districts ~ 5,
    city_district %in% level_6_districts ~ 6,
    city_district %in% level_7_districts ~ 7,
    city_district %in% level_8_districts ~ 8,
    TRUE ~ NA_real_  # 其他區域目前設置為NA
  ))

# 將divorce_count列轉換為數值型
mix_ma_112 <- mix_ma_112 %>%
  mutate(marry_count = as.numeric(marry_count))

# 按city_level分組並計算離婚數量總和
mix_ma_112_test <- mix_ma_112 %>%
  group_by(city_district, city_level) %>%
  summarise(
    marry_count_sum = sum(marry_count, na.rm = TRUE)
  )




mix_ma_112 <- mix_ma_112 %>%
  mutate(
    household_registration_status = recode(household_registration_status, "已設籍" = "Registered", "未設籍" = "Not register"),
    marriage_type = recode(marriage_type, "不同性別" = "Different-Sex", "相同性別" = "Same-Sex"),
    sex = recode(sex, "男" = "M", "女" = "F"),
    original_nationality = recode(original_nationality,
                                  "本國" = "Taiwan",
                                  "大陸地區" = "China",
                                  "港澳地區" = "Hong Kong and Macao",
                                  "日本" = "Japan",
                                  "韓國" = "Korea",
                                  "美國" = "US",
                                  "加拿大" = "Canada",
                                  "澳大利亞" = "Australia",
                                  "紐西蘭" = "New Zealand",
                                  "英國" = "UK",
                                  "法國" = "France",
                                  "德國" = "Germany",
                                  "南非" = "South Africa",
                                  "東南亞泰國" = "Thailand",
                                  "東南亞寮國" = "Laos",
                                  "東南亞柬埔寨" = "Cambodia",
                                  "東南亞越南" = "Vietnam",
                                  "東南亞緬甸" = "Myanmar",
                                  "東南亞菲律賓" = "Philippines",
                                  "東南亞新加坡" = "Singapore",
                                  "東南亞馬來西亞" = "Malaysia",
                                  "東南亞印尼" = "Indonesia",
                                  "史瓦帝尼" = "Eswatini",
                                  "賴索托" = "Lesotho",
                                  "模里西斯" = "Mauritius",
                                  "其他" = "Other"
    )
  )



mix_ma_112 <- mix_ma_112 %>%
  filter(
    !original_nationality %in% c("Eswatini", "Lesotho", "Mauritius", "Other"),
    !city_district %in% c("連江縣東引鄉", "連江縣北竿鄉", "連江縣莒光鄉",
                          "連江縣南竿鄉", "金門縣金寧鄉", "金門縣烈嶼鄉",
                          "金門縣烏坵鄉", "金門縣金沙鎮", "金門縣金城鎮",
                          "金門縣金湖鎮", "澎湖縣湖西鄉", "澎湖縣白沙鄉",
                          "澎湖縣七美鄉", "澎湖縣馬公市", "澎湖縣望安鄉", "澎湖縣馬公市","澎湖縣西嶼鄉")
  )


mask <- grepl("統計年月", mix_ma_112$yearmonth)

# 使用這個 mask 來過濾出不包含 '統計年月' 的行
mix_ma_112_filtered <- mix_ma_112[!mask, ]


mix_ma_112_test2 <- mix_ma_112_filtered %>%
  group_by(city_level) %>%
  summarise(
    marry_count_sum = sum(marry_count, na.rm = TRUE)
  )



mix_ma_112_filtered <- mix_ma_112_filtered %>%
  mutate(
    year = str_extract(yearmonth, "^\\d{3}"),   # 使用正則表達式提取前三位數字作為年份
    month = str_extract(yearmonth, "\\d{2}$")  # 使用正則表達式提取最後兩位數字作為月份
  )



# Function for divide city and district
city <- regexpr("市|縣", mix_ma_112_filtered$city_district)
mix_ma_112_filtered$city <- substr(mix_ma_112_filtered$city_district, 1, city )
mix_ma_112_filtered$district <- substr(mix_ma_112_filtered$city_district, city+1, nchar(mix_ma_112_filtered$city_district))



# Function for change city and district to en
mix_ma_112_done <- mix_ma_112_filtered %>%
  mutate(
    city = recode(city,
                  "臺北市" = "Taipei City",
                  "新北市" = "New Taipei City",
                  "桃園市" = "Taoyuan City",
                  "臺中市" = "Taichung City",
                  "臺南市" = "Tainan City",
                  "高雄市" = "Kaohsiung City",
                  "基隆市" = "Keelung City",
                  "新竹市" = "Hsinchu City",
                  "新竹縣" = "Hsinchu County",
                  "苗栗縣" = "Miaoli County",
                  "彰化縣" = "Changhua County",
                  "南投縣" = "Nantou County",
                  "雲林縣" = "Yunlin County",
                  "嘉義市" = "Chiayi City",
                  "嘉義縣" = "Chiayi County",
                  "屏東縣" = "Pingtung County",
                  "宜蘭縣" = "Yilan County",
                  "花蓮縣" = "Hualien County",
                  "臺東縣" = "Taitung County",
                  "澎湖縣" = "Penghu County",
                  "金門縣" = "Kinmen County",
                  "連江縣" = "Lienchiang County"
    ))


mix_ma_112_done <- mix_ma_112_done %>%
  mutate(
    district = recode(district,
                      "中正區"="Zhongzheng Dist.",
                      "大同區"="Datong Dist.",
                      "中山區"="Zhongshan Dist.",
                      "松山區"="Songshan Dist.",
                      "大安區"="Da’an Dist.",
                      "萬華區"="Wanhua Dist.",
                      "信義區"="Xinyi Dist.",
                      "士林區"="Shilin Dist.",
                      "北投區"="Beitou Dist.",
                      "內湖區"="Neihu Dist.",
                      "南港區"="Nangang Dist.",
                      "文山區"="Wenshan Dist.",
                      "仁愛區"="Ren’ai Dist.",
                      "中正區"="Zhongzheng Dist.",
                      "中山區"="Zhongshan Dist.",
                      "安樂區"="Anle Dist.",
                      "暖暖區"="Nuannuan Dist.",
                      "七堵區"="Qidu Dist.",
                      "萬里區"="Wanli Dist.",
                      "金山區"="Jinshan Dist.",
                      "板橋區"="Banqiao Dist.",
                      "汐止區"="Xizhi Dist.",
                      "深坑區"="Shenkeng Dist.",
                      "石碇區"="Shiding Dist.",
                      "瑞芳區"="Ruifang Dist.",
                      "平溪區"="Pingxi Dist.",
                      "雙溪區"="Shuangxi Dist.",
                      "貢寮區"="Gongliao Dist.",
                      "新店區"="Xindian Dist.",
                      "坪林區"="Pinglin Dist.",
                      "烏來區"="Wulai Dist.",
                      "永和區"="Yonghe Dist.",
                      "中和區"="Zhonghe Dist.",
                      "土城區"="Tucheng Dist.",
                      "三峽區"="Sanxia Dist.",
                      "樹林區"="Shulin Dist.",
                      "鶯歌區"="Yingge Dist.",
                      "三重區"="Sanchong Dist.",
                      "新莊區"="Xinzhuang Dist.",
                      "泰山區"="Taishan Dist.",
                      "林口區"="Linkou Dist.",
                      "蘆洲區"="Luzhou Dist.",
                      "五股區"="Wugu Dist.",
                      "八里區"="Bali Dist.",
                      "淡水區"="Tamsui Dist.",
                      "三芝區"="Sanzhi Dist.",
                      "石門區"="Shimen Dist.",
                      "宜蘭市"="Yilan City",
                      "頭城鎮"="Toucheng Township",
                      "礁溪鄉"="Jiaoxi Township",
                      "壯圍鄉"="Zhuangwei Township",
                      "員山鄉"="Yuanshan Township",
                      "羅東鎮"="Luodong Township",
                      "三星鄉"="Sanxing Township",
                      "大同鄉"="Datong Township",
                      "五結鄉"="Wujie Township",
                      "冬山鄉"="Dongshan Township",
                      "蘇澳鎮"="Su’ao Township",
                      "南澳鄉"="Nan’ao Township",
                      "東區"="East Dist.",
                      "北區"="North Dist.",
                      "香山區"="Xiangshan Dist.",
                      "竹北市"="Zhubei City",
                      "湖口鄉"="Hukou Township",
                      "新豐鄉"="Xinfeng Township",
                      "新埔鎮"="Xinpu Township",
                      "關西鎮"="Guanxi Township",
                      "芎林鄉"="Qionglin Township",
                      "寶山鄉"="Baoshan Township",
                      "竹東鎮"="Zhudong Township",
                      "五峰鄉"="Wufeng Township",
                      "橫山鄉"="Hengshan Township",
                      "尖石鄉"="Jianshi Township",
                      "北埔鄉"="Beipu Township",
                      "峨眉鄉"="Emei Township",
                      "中壢區"="Zhongli Dist.",
                      "平鎮區"="Pingzhen Dist.",
                      "龍潭區"="Longtan Dist.",
                      "楊梅區"="Yangmei Dist.",
                      "新屋區"="Xinwu Dist.",
                      "觀音區"="Guanyin Dist.",
                      "桃園區"="Taoyuan Dist.",
                      "龜山區"="Guishan Dist.",
                      "八德區"="Bade Dist.",
                      "大溪區"="Daxi Dist.",
                      "復興區"="Fuxing Dist.",
                      "大園區"="Dayuan Dist.",
                      "蘆竹區"="Luzhu Dist.",
                      "竹南鎮"="Zhunan Township",
                      "三灣鄉"="Sanwan Township",
                      "南庄鄉"="Nanzhuang Township",
                      "獅潭鄉"="Shitan Township",
                      "後龍鎮"="Houlong Township",
                      "通霄鎮"="Tongxiao Township",
                      "苑裡鎮"="Yuanli Township",
                      "苗栗市"="Miaoli City",
                      "造橋鄉"="Zaoqiao Township",
                      "頭屋鄉"="Touwu Township",
                      "公館鄉"="Gongguan Township",
                      "大湖鄉"="Dahu Township",
                      "泰安鄉"="Tai’an Township",
                      "銅鑼鄉"="Tongluo Township",
                      "三義鄉"="Sanyi Township",
                      "西湖鄉"="Xihu Township",
                      "卓蘭鎮"="Zhuolan Township",
                      "中區"="Central Dist.",
                      "東區"="East Dist.",
                      "南區"="South Dist.",
                      "西區"="West Dist.",
                      "北區"="North Dist.",
                      "北屯區"="Beitun Dist.",
                      "西屯區"="Xitun Dist.",
                      "南屯區"="Nantun Dist.",
                      "太平區"="Taiping Dist.",
                      "大里區"="Dali Dist.",
                      "霧峰區"="Wufeng Dist.",
                      "烏日區"="Wuri Dist.",
                      "豐原區"="Fengyuan Dist.",
                      "后里區"="Houli Dist.",
                      "石岡區"="Shigang Dist.",
                      "東勢區"="Dongshi Dist.",
                      "和平區"="Heping Dist.",
                      "新社區"="Xinshe Dist.",
                      "潭子區"="Tanzi Dist.",
                      "大雅區"="Daya Dist.",
                      "神岡區"="Shengang Dist.",
                      "大肚區"="Dadu Dist.",
                      "沙鹿區"="Shalu Dist.",
                      "龍井區"="Longjing Dist.",
                      "梧棲區"="Wuqi Dist.",
                      "清水區"="Qingshui Dist.",
                      "大甲區"="Dajia Dist.",
                      "外埔區"="Waipu Dist.",
                      "大安區"="Da’an Dist.",
                      "彰化市"="Changhua City",
                      "芬園鄉"="Fenyuan Township",
                      "花壇鄉"="Huatan Township",
                      "秀水鄉"="Xiushui Township",
                      "鹿港鎮"="Lukang Township",
                      "福興鄉"="Fuxing Township",
                      "線西鄉"="Xianxi Township",
                      "和美鎮"="Hemei Township",
                      "伸港鄉"="Shengang Township",
                      "社頭鄉"="Shetou Township",
                      "永靖鄉"="Yongjing Township",
                      "埔心鄉"="Puxin Township",
                      "溪湖鎮"="Xihu Township",
                      "大村鄉"="Dacun Township",
                      "埔鹽鄉"="Puyan Township",
                      "田中鎮"="Tianzhong Township",
                      "北斗鎮"="Beidou Township",
                      "田尾鄉"="Tianwei Township",
                      "埤頭鄉"="Pitou Township",
                      "溪州鄉"="Xizhou Township",
                      "竹塘鄉"="Zhutang Township",
                      "二林鎮"="Erlin Township",
                      "大城鄉"="Dacheng Township",
                      "芳苑鄉"="Fangyuan Township",
                      "二水鄉"="Ershui Township",
                      "南投市"="Nantou City",
                      "中寮鄉"="Zhongliao Township",
                      "草屯鎮"="Caotun Township",
                      "國姓鄉"="Guoxing Township",
                      "埔里鎮"="Puli Township",
                      "仁愛鄉"="Ren’ai Township",
                      "名間鄉"="Mingjian Township",
                      "集集鎮"="Jiji Township",
                      "水里鄉"="Shuili Township",
                      "魚池鄉"="Yuchi Township",
                      "信義鄉"="Xinyi Township",
                      "竹山鎮"="Zhushan Township",
                      "鹿谷鄉"="Lugu Township",
                      "東區"="East Dist.",
                      "西區"="West Dist.",
                      "番路鄉"="Fanlu Township",
                      "梅山鄉"="Meishan Township",
                      "竹崎鄉"="Zhuqi Township",
                      "阿里山鄉"="Alishan Township",
                      "中埔鄉"="Zhongpu Township",
                      "大埔鄉"="Dapu Township",
                      "水上鄉"="Shuishang Township",
                      "鹿草鄉"="Lucao Township",
                      "太保市"="Taibao City",
                      "朴子市"="Puzi City",
                      "東石鄉"="Dongshi Township",
                      "六腳鄉"="Liujiao Township",
                      "新港鄉"="Xingang Township",
                      "民雄鄉"="Minxiong Township",
                      "大林鎮"="Dalin Township",
                      "溪口鄉"="Xikou Township",
                      "義竹鄉"="Yizhu Township",
                      "布袋鎮"="Budai Township",
                      "斗南鎮"="Dounan Township",
                      "大埤鄉"="Dapi Township",
                      "虎尾鎮"="Huwei Township",
                      "土庫鎮"="Tuku Township",
                      "褒忠鄉"="Baozhong Township",
                      "東勢鄉"="Dongshi Township",
                      "臺西鄉"="Taixi Township",
                      "崙背鄉"="Lunbei Township",
                      "麥寮鄉"="Mailiao Township",
                      "斗六市"="Douliu City",
                      "林內鄉"="Linnei Township",
                      "古坑鄉"="Gukeng Township",
                      "莿桐鄉"="Citong Township",
                      "西螺鎮"="Xiluo Township",
                      "二崙鄉"="Erlun Township",
                      "北港鎮"="Beigang Township",
                      "水林鄉"="Shuilin Township",
                      "口湖鄉"="Kouhu Township",
                      "四湖鄉"="Sihu Township",
                      "元長鄉"="Yuanchang Township",
                      "中西區"="West Central Dist.",
                      "東區"="East Dist.",
                      "南區"="South Dist.",
                      "北區"="North Dist.",
                      "安平區"="Anping Dist.",
                      "安南區"="Annan Dist.",
                      "永康區"="Yongkang Dist.",
                      "歸仁區"="Guiren Dist.",
                      "新化區"="Xinhua Dist.",
                      "左鎮區"="Zuozhen Dist.",
                      "玉井區"="Yujing Dist.",
                      "楠西區"="Nanxi Dist.",
                      "南化區"="Nanhua Dist.",
                      "仁德區"="Rende Dist.",
                      "關廟區"="Guanmiao Dist.",
                      "龍崎區"="Longqi Dist.",
                      "官田區"="Guantian Dist.",
                      "麻豆區"="Madou Dist.",
                      "佳里區"="Jiali Dist.",
                      "西港區"="Xigang Dist.",
                      "七股區"="Qigu Dist.",
                      "將軍區"="Jiangjun Dist.",
                      "學甲區"="Xuejia Dist.",
                      "北門區"="Beimen Dist.",
                      "新營區"="Xinying Dist.",
                      "後壁區"="Houbi Dist.",
                      "白河區"="Baihe Dist.",
                      "東山區"="Dongshan Dist.",
                      "六甲區"="Liujia Dist.",
                      "下營區"="Xiaying Dist.",
                      "柳營區"="Liuying Dist.",
                      "鹽水區"="Yanshui Dist.",
                      "善化區"="Shanhua Dist.",
                      "大內區"="Danei Dist.",
                      "山上區"="Shanshang Dist.",
                      "新市區"="Xinshi Dist.",
                      "安定區"="Anding Dist.",
                      "新興區"="Xinxing Dist.",
                      "前金區"="Qianjin Dist.",
                      "苓雅區"="Lingya Dist.",
                      "鹽埕區"="Yancheng Dist.",
                      "鼓山區"="Gushan Dist.",
                      "旗津區"="Qijin Dist.",
                      "前鎮區"="Qianzhen Dist.",
                      "三民區"="Sanmin Dist.",
                      "楠梓區"="Nanzi Dist.",
                      "小港區"="Xiaogang Dist.",
                      "左營區"="Zuoying Dist.",
                      "仁武區"="Renwu Dist.",
                      "大社區"="Dashe Dist.",
                      "東沙群島"="Dongsha Islands",
                      "南沙群島"="Nansha Islands",
                      "岡山區"="Gangshan Dist.",
                      "路竹區"="Luzhu Dist.",
                      "阿蓮區"="Alian Dist.",
                      "田寮區"="Tianliao Dist.",
                      "燕巢區"="Yanchao Dist.",
                      "橋頭區"="Qiaotou Dist.",
                      "梓官區"="Ziguan Dist.",
                      "彌陀區"="Mituo Dist.",
                      "永安區"="Yong’an Dist.",
                      "湖內區"="Hunei Dist.",
                      "鳳山區"="Fengshan Dist.",
                      "大寮區"="Daliao Dist.",
                      "林園區"="Linyuan Dist.",
                      "鳥松區"="Niaosong Dist.",
                      "大樹區"="Dashu Dist.",
                      "旗山區"="Qishan Dist.",
                      "美濃區"="Meinong Dist.",
                      "六龜區"="Liugui Dist.",
                      "內門區"="Neimen Dist.",
                      "杉林區"="Shanlin Dist.",
                      "甲仙區"="Jiaxian Dist.",
                      "桃源區"="Taoyuan Dist.",
                      "那瑪夏區"="Namaxia Dist.",
                      "茂林區"="Maolin Dist.",
                      "茄萣區"="Qieding Dist.",
                      "屏東市"="Pingtung City",
                      "三地門鄉"="Sandimen Township",
                      "霧臺鄉"="Wutai Township",
                      "瑪家鄉"="Majia Township",
                      "九如鄉"="Jiuru Township",
                      "里港鄉"="Ligang Township",
                      "高樹鄉"="Gaoshu Township",
                      "鹽埔鄉"="Yanpu Township",
                      "長治鄉"="Changzhi Township",
                      "麟洛鄉"="Linluo Township",
                      "竹田鄉"="Zhutian Township",
                      "內埔鄉"="Neipu Township",
                      "萬丹鄉"="Wandan Township",
                      "潮州鎮"="Chaozhou Township",
                      "泰武鄉"="Taiwu Township",
                      "來義鄉"="Laiyi Township",
                      "萬巒鄉"="Wanluan Township",
                      "崁頂鄉"="Kanding Township",
                      "新埤鄉"="Xinpi Township",
                      "南州鄉"="Nanzhou Township",
                      "林邊鄉"="Linbian Township",
                      "東港鎮"="Donggang Township",
                      "琉球鄉"="Liuqiu Township",
                      "佳冬鄉"="Jiadong Township",
                      "新園鄉"="Xinyuan Township",
                      "枋寮鄉"="Fangliao Township",
                      "枋山鄉"="Fangshan Township",
                      "春日鄉"="Chunri Township",
                      "獅子鄉"="Shizi Township",
                      "車城鄉"="Checheng Township",
                      "牡丹鄉"="Mudan Township",
                      "恆春鎮"="Hengchun Township",
                      "滿州鄉"="Manzhou Township",
                      "臺東市"="Taitung City",
                      "綠島鄉"="Ludao Township",
                      "蘭嶼鄉"="Lanyu Township",
                      "延平鄉"="Yanping Township",
                      "卑南鄉"="Beinan Township",
                      "鹿野鄉"="Luye Township",
                      "關山鎮"="Guanshan Township",
                      "海端鄉"="Haiduan Township",
                      "池上鄉"="Chishang Township",
                      "東河鄉"="Donghe Township",
                      "成功鎮"="Chenggong Township",
                      "長濱鄉"="Changbin Township",
                      "太麻里鄉"="Taimali Township",
                      "金峰鄉"="Jinfeng Township",
                      "大武鄉"="Dawu Township",
                      "達仁鄉"="Daren Township",
                      "蘭屿鄉"="Lanyu Township",
                      "花蓮市"="Hualien City",
                      "新城鄉"="Xincheng Township",
                      "秀林鄉"="Xiulin Township",
                      "吉安鄉"="Ji’an Township",
                      "壽豐鄉"="Shoufeng Township",
                      "鳳林鎮"="Fenglin Township",
                      "光復鄉"="Guangfu Township",
                      "豐濱鄉"="Fengbin Township",
                      "瑞穗鄉"="Ruisui Township",
                      "萬榮鄉"="Wanrong Township",
                      "玉里鎮"="Yuli Township",
                      "卓溪鄉"="Zhuoxi Township",
                      "富里鄉"="Fuli Township"
    ))


# combine 


merge_di_112 <- mix_di_112_done %>%
  select(year, month, district_code, city, district, marriage_type, sex, original_nationality, household_registration_status, divorce_count, city_level)

merge_ma_112 <- mix_ma_112_done %>%
  select(year, month, district_code, city, district, marriage_type, sex, original_nationality, household_registration_status, marry_count, city_level)

write.csv(merge_di_112, "merge_di_112.csv", row.names = FALSE)
write.csv(merge_ma_112, "merge_ma_112.csv", row.names = FALSE)

names(merge_di_112) 
names(merge_ma_112)
class(merge_di_112$district_code)
class(merge_ma_112$district_code)

summary(merge_di_112)
summary(merge_ma_112)

str(merge_di_112) 
str(merge_ma_112) 


# 假設 df_married 是包含結婚資料的資料集，df_divorced 是包含離婚資料的資料集


mix_112_all <- left_join(merge_di_112, merge_ma_112, 
                         by = c("year", "month", "district_code", "city", "district", "city_level", "marriage_type", "sex", "original_nationality", "household_registration_status"))



write.csv(mix_112_all, "mix_112_all.csv", row.names = FALSE)






# plot



mix_112_all_sum <- mix_112_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(city, sex) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count), na.rm = TRUE), .groups = 'drop')

ggplot(mix_112_all_sum, aes(x = city, y = sum_divorce_count, fill = sex)) +
  geom_col(position = position_dodge()) +  # 使用 position_dodge() 來分隔不同性別的柱子
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # 將 x 軸的文字旋轉 90 度


mix_112_all_na <- mix_112_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(original_nationality,sex) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count)))

ggplot(mix_112_all_na, aes(x = reorder(original_nationality, -sum_divorce_count), y = sum_divorce_count, fill = sex)) +
  geom_col(position = position_dodge()) +
  scale_y_log10() +  # 使用對數尺度，如果仍需要的話
  labs(x = "Original Nationality", y = "Sum of Divorce Count") +  # 添加軸標籤
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # 將 x 軸的文字旋轉 90 度


mix_112_all_nama <- mix_112_all %>%
  filter(original_nationality != "Taiwan") %>%
  group_by(original_nationality, sex) %>%
  summarise(sum_marry_count = sum(as.numeric(marry_count), na.rm = TRUE), .groups = 'drop')

ggplot(mix_112_all_nama, aes(x = reorder(original_nationality, -sum_marry_count), y = sum_marry_count, fill = sex)) +
  geom_col(position = position_dodge()) +
  scale_y_log10() +  # 使用對數尺度，如果仍需要的話
  labs(x = "Original Nationality", y = "Sum of Marry Count") +  # 添加軸標籤
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # 將 x 軸的文字旋轉 90 度

# 确保只按月份分组


mix_112_all_mon <- mix_112_all %>%
  group_by(month) %>%
  summarise(sum_divorce_count = sum(as.numeric(divorce_count), na.rm = TRUE))


ggplot(mix_112_all_mon, aes(x = month, y = sum_divorce_count)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

