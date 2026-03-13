library(readxl)
library(dplyr)
library(janitor)

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

dados_raw <- read_excel("data/raw/marketing.xlsx")

dados_importados <- dados_raw %>%
  clean_names()

saveRDS(
  dados_importados,
  "data/processed/01_dados_importados.rds"
)

write.csv(
  dados_importados,
  "data/processed/01_dados_importados.csv",
  row.names = FALSE
)

cat("✔ Etapa 01 concluída\n")