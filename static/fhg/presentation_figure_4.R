# presentation_figure_4.R
library(readxl)
library(tidyverse)
library(janitor)
library(cowplot)


wealth <- read_xlsx("./Data/AnalysisFile.xlsx", sheet = "Analysis") %>%
  clean_names()

lh_parliaments <- read_csv("./Data/lh_parliaments.csv") %>%
  clean_names() %>%
  select(-1)

lh_parliaments <- left_join(lh_parliaments, wealth,
                            by = c("b1_nummer" = "indexnummer"))

meanmedw_lh <- lh_parliaments %>%
  group_by(parliament) %>%
  summarize(p50 = median(w_deflated, na.rm = T),
            p25 = quantile(w_deflated, 0.25, na.rm = T),
            p75 = quantile(w_deflated, 0.75, na.rm = T),
            p90 = quantile(w_deflated, 0.90, na.rm = T),
            count = sum(!is.na(w_deflated)))

p1 <- meanmedw_lh %>%
  pivot_longer(c(p25, p50, p75, p90),
               names_to = "Statistic", 
               values_to = "Wealth") %>%
  ggplot(aes(x = parliament, 
             y = Wealth, 
             group = Statistic, 
             linetype = Statistic)) + 
  geom_line() + 
  theme_minimal() + 
  xlab("Parliament") +
  ylab("Wealth (guilders)") +
  theme(axis.text.x = element_text(angle = 45), 
        text = element_text(size=13),
        legend.position = c(0.9, 0.8),
        #panel.border = element_rect(colour = "black", fill=NA),
        legend.background = element_blank(),
        legend.box.background = element_rect(colour = "black")
  ) +
  ggtitle("Panel A: Lower House") + 
  scale_y_continuous(labels = scales::number_format(accuracy = 1),
                     limits=c(0,12e5)) +
  guides(linetype=guide_legend(title="Quantile"))

#now, read uh
uh_parliaments <- read_csv("./Data/uh_parliaments.csv") %>%
  clean_names() %>%
  select(-1)

uh_parliaments <- left_join(uh_parliaments, wealth,
                            by = c("b1_nummer" = "indexnummer"))

meanmedw_uh <- uh_parliaments %>%
  group_by(parliament) %>%
  summarize(p50 = median(w_deflated, na.rm = T),     
            p25 = quantile(w_deflated, 0.25, na.rm = T),
            p75 = quantile(w_deflated, 0.75, na.rm = T),
            p90 = quantile(w_deflated, 0.90, na.rm = T),
            count = sum(!is.na(w_deflated)))

p2 <- meanmedw_uh %>%
  pivot_longer(c(p25, p50, p75, p90),
               names_to = "Statistic", 
               values_to = "Wealth") %>%
  ggplot(aes(x = parliament, 
             y = Wealth, 
             group = Statistic, 
             linetype = Statistic)) + 
  geom_line() + 
  theme_minimal() + 
  xlab("Parliament") +
  ylab("Wealth (guilders)") +
  theme(axis.text.x = element_text(angle = 45)) +
  ggtitle("Panel B: Upper House") + 
  scale_y_continuous(labels = scales::number_format(accuracy = 1),
                     limits = c(0, 20e5)) +
  theme(legend.position = "none", text = element_text(size=13)) +
  guides(linetype=guide_legend(title="Quantile"))


fig <- cowplot::plot_grid(p1, p2, nrow = 2, rel_heights = c(55,45))