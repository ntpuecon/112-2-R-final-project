# 從HTML提取href網址 -----

# 讀取需要的套件
library(tidyverse)
library(rvest)

# 讀取html.txt文件
html_content <- read_file("html.txt")

# 解析HTML並提取所有<a>標籤的href網址
href_links <- read_html(html_content) %>%
  html_nodes("a") %>%
  html_attr("href")

# 顯示提取的href網址
href_links %>% head()

# 初始化一個list來收錄所有引入的資料
data_list <- list()

# 遍歷每個href連結
for (link in href_links) {
  # 判斷是否包含"DownloadFile"字眼
  if (str_detect(link, "DownloadFile")) {
    # 下載CSV文件
    download.file(link, destfile = "temp.csv")
    
    # 將下載的CSV文件引入到R
    temp_data <- read_csv("temp.csv")
    
    # 將引入的數據框存入list
    data_list[[link]] <- temp_data
  }
}
