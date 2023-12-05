library(ggplot2)
library(readr)
library(dplyr)

historic = read_csv("historic.csv") %>% mutate(group="historic", yhat=y)
forecast = read_csv("forecast.csv") %>% mutate(group="forecast")
data = bind_rows(historic, forecast)

plot = ggplot(data=data, aes(x=ds, y=yhat, color=group)) +
geom_line() +
geom_point()

ggsave("plot.png")