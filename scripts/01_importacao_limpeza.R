library(readxl)
library(dplyr)
library(janitor)

caminho_arquivo <- "data/raw/03_Cenario 03 - Marketing - Disponibilizar.xlsx"

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
dir.create("outputs", recursive = TRUE, showWarnings = FALSE)
dir.create("tables", recursive = TRUE, showWarnings = FALSE)
dir.create("figures", recursive = TRUE, showWarnings = FALSE)

dados <- read_excel(caminho_arquivo) |>
  clean_names()

cat("Dimensões da base:\n")
print(dim(dados))

cat("\nNomes das colunas:\n")
print(names(dados))

cat("\nEstrutura:\n")
glimpse(dados)

cat("\nResumo estatístico:\n")
print(summary(dados))

write.csv(dados, "data/processed/dados_tratados_inicial.csv", row.names = FALSE)
saveRDS(dados, "data/processed/dados_tratados_inicial.rds")

cat("\nArquivos salvos em data/processed/\n")