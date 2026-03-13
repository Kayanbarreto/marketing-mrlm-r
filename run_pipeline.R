pacotes <- c("dplyr","readxl","janitor","broom","car","lmtest","ggplot2","GGally","reshape2")

# Define um mirror padrão do CRAN
options(repos = c(CRAN = "https://cloud.r-project.org"))

instalar <- pacotes[!(pacotes %in% installed.packages()[,"Package"])]

if(length(instalar)) install.packages(instalar)

lapply(pacotes, library, character.only = TRUE)

cat("=====================================\n")
cat("Pipeline do Projeto de Estatística\n")
cat("=====================================\n")

source("scripts/01_importacao_limpeza.R")

source("scripts/02_analise_exploratoria.R")

source("scripts/03_modelo_inicial.R")

source("scripts/04_selecao_modelo.R")

source("scripts/05_diagnostico_modelo.R")

source("scripts/06_previsoes_intervalos.R")

source("scripts/07_graficos.R")

# Carregar o modelo final
modelo_final <- readRDS("outputs/modelo_selecionado.rds")

gerar_graficos(modelo_final)

cat("=====================================\n")
cat("Pipeline executada com sucesso\n")
cat("=====================================\n")