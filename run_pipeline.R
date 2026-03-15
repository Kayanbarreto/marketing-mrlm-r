#source("requirements.R")

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

modelo_final <- readRDS("outputs/modelo_selecionado.rds")

gerar_graficos(modelo_final)

source("scripts/08_tabelas_latex.R")

cat("=====================================\n")
cat("Pipeline executada com sucesso\n")
cat("=====================================\n")