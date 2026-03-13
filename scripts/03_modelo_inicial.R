library(dplyr)
library(ggplot2)
library(readr)

source("scripts/99_funcoes_auxiliares.R")

dir.create("figures", recursive = TRUE, showWarnings = FALSE)
dir.create("tables", recursive = TRUE, showWarnings = FALSE)

dados <- carregar_dados_tratados()

cat("Resumo geral da base:\n")
print(summary(dados))

resumo_nas <- data.frame(
  variavel = names(dados),
  n_na = sapply(dados, function(x) sum(is.na(x))),
  perc_na = sapply(dados, function(x) mean(is.na(x)) * 100)
)

salvar_tabela_csv(resumo_nas, "tables/resumo_ausencias.csv")

variaveis_numericas <- dados |> select(where(is.numeric))

if (ncol(variaveis_numericas) > 0) {
  resumo_numerico <- data.frame(
    variavel = names(variaveis_numericas),
    media = sapply(variaveis_numericas, mean, na.rm = TRUE),
    mediana = sapply(variaveis_numericas, median, na.rm = TRUE),
    desvio_padrao = sapply(variaveis_numericas, sd, na.rm = TRUE),
    minimo = sapply(variaveis_numericas, min, na.rm = TRUE),
    maximo = sapply(variaveis_numericas, max, na.rm = TRUE)
  )

  salvar_tabela_csv(resumo_numerico, "tables/resumo_variaveis_numericas.csv")
}

if (ncol(variaveis_numericas) > 0) {
  for (nome_coluna in names(variaveis_numericas)) {
    p <- ggplot(dados, aes_string(x = nome_coluna)) +
      geom_histogram(bins = 30) +
      labs(
        title = paste("Histograma de", nome_coluna),
        x = nome_coluna,
        y = "Frequência"
      ) +
      theme_minimal()

    salvar_plot(
      p,
      paste0("figures/hist_", nome_coluna, ".png")
    )
  }
}

cat("Análise exploratória concluída.\n")