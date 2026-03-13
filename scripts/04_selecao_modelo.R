library(dplyr)
library(broom)

source("scripts/99_funcoes_auxiliares.R")

dir.create("outputs", recursive = TRUE, showWarnings = FALSE)
dir.create("tables", recursive = TRUE, showWarnings = FALSE)

dados <- carregar_dados_tratados()

# AJUSTE AQUI O NOME DA VARIÁVEL RESPOSTA
variavel_resposta <- "receita"

if (!(variavel_resposta %in% names(dados))) {
  stop(paste(
    "A variável resposta", variavel_resposta,
    "não foi encontrada. Verifique os nomes das colunas."
  ))
}

dados_modelo <- dados |>
  select(where(function(x) is.numeric(x) || is.factor(x) || is.character(x)))

dados_modelo[[variavel_resposta]] <- dados[[variavel_resposta]]

dados_modelo <- remover_nas_modelo(dados_modelo)

preditoras <- setdiff(names(dados_modelo), variavel_resposta)
formula_modelo <- as.formula(
  paste(variavel_resposta, "~", paste(preditoras, collapse = " + "))
)

modelo_inicial <- lm(formula_modelo, data = dados_modelo)

print(summary(modelo_inicial))

saveRDS(modelo_inicial, "outputs/modelo_inicial.rds")
write.csv(tidy(modelo_inicial), "tables/coeficientes_modelo_inicial.csv", row.names = FALSE)

cat("Modelo inicial ajustado e salvo.\n")