library(tidyverse)
dat <- "rawdata/GSPC.csv" %>%
  read_csv(col_types = cols()) %>%
  mutate(
    change = c(NA_real_, diff(Close)),
    pct.change =  change / lag(Close, 1),
    mult = 1 + pct.change
  )
stopifnot(dat$Close == dat$`Adj Close`)

ggplot(dat, aes(x = Date, y = Close)) +
  geom_line()
ggplot(dat, aes(x = Date, y = change)) +
  geom_line()
ggplot(dat, aes(x = Date, y = pct.change)) +
  geom_line()
tibble(
  yesterday = head(dat$pct.change, -1),
  today = dat$pct.change[-1]
) %>%
  ggplot(aes(x = yesterday, y = today)) +
  geom_point()

yearly <- dat %>%
  group_by(yr = lubridate::year(Date)) %>%
  summarize(pct.change = prod(mult, na.rm = TRUE) - 1)
ggplot(yearly, aes(x = yr, y = pct.change)) +
  geom_line()
mean(yearly$pct.change)
