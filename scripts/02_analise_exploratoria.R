library(dplyr)

dir.create("tables", recursive = TRUE, showWarnings = FALSE)

dados <- readRDS("data/processed/01_dados_importados.rds")

dados_limpos <- dados %>%
  filter(!is.na(receita_mil))

saveRDS(
  dados_limpos,
  "data/processed/02_dados_limpos.rds"
)

write.csv(
  summary(dados_limpos),
  "tables/02_resumo_dados.csv"
)

cat("✔ Etapa 02 concluída\n")