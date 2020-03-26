library(tidyverse)
opts <- options(scipen = 100)
dat <- as.POSIXct(Sys.Date() - 1) %>%
  as.numeric() %>%
  paste0("https://query1.finance.yahoo.com/v7/finance/download/^GSPC?period1=-1325635200&period2=", ., "&interval=1d&events=history") %>%
  read_csv() %>%
  mutate_at(vars(Open, High, Low, Close, `Adj Close`), formatC, digits = 6, format = "f") %>%
  write.csv("rawdata/GSPC.csv", row.names = FALSE, quote = FALSE, na = '')
options(opts)
