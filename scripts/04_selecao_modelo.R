library(dplyr)
library(broom)

source("scripts/99_funcoes_auxiliares.R")

dir.create("outputs", recursive = TRUE, showWarnings = FALSE)
dir.create("tables", recursive = TRUE, showWarnings = FALSE)

dados <- carregar_dados_tratados()

variavel_resposta <- "receita_mil"

dados_modelo <- dados |>
  select(
    receita_mil,
    invest_digital,
    invest_tradicional,
    num_promotores,
    taxa_conversao,
    impressoes_mil,
    num_cliques_mil,
    duracao_dias
  )

dados_modelo <- remover_nas_modelo(dados_modelo)

formula_modelo <- receita_mil ~
  invest_digital +
  invest_tradicional +
  num_promotores +
  taxa_conversao +
  impressoes_mil +
  num_cliques_mil +
  duracao_dias

modelo_inicial <- lm(formula_modelo, data = dados_modelo)

print(summary(modelo_inicial))

saveRDS(modelo_inicial, "outputs/modelo_selecionado.rds")

write.csv(
  tidy(modelo_inicial),
  "tables/04_coeficientes_modelo.csv",
  row.names = FALSE
)

cat("✔ Etapa 04 concluída\n")