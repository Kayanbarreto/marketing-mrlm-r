library(dplyr)

dir.create("outputs", recursive = TRUE, showWarnings = FALSE)
dir.create("tables", recursive = TRUE, showWarnings = FALSE)

dados <- readRDS("data/processed/02_dados_limpos.rds")

modelo_inicial <- lm(
  receita_mil ~ invest_digital + invest_tradicional +
    impressoes_mil + num_cliques_mil + taxa_conversao +
    num_promotores + duracao_dias,
  data = dados
)

saveRDS(
  modelo_inicial,
  "outputs/03_modelo_inicial.rds"
)

coeficientes <- summary(modelo_inicial)$coefficients

write.csv(
  coeficientes,
  "tables/03_coeficientes_modelo_inicial.csv"
)

cat("✔ Etapa 03 concluída\n")