library(readr)
library(dplyr)
library(xtable)

dir.create("tables_latex", showWarnings = FALSE)

##################################################
# COEFICIENTES DO MODELO
##################################################

coef <- read.csv("tables/04_coeficientes_modelo.csv")

tabela_coef <- xtable(coef)

print(
  tabela_coef,
  file = "tables_latex/tabela_coeficientes.tex",
  include.rownames = FALSE
)

##################################################
# TESTES DE PRESSUPOSTOS
##################################################

pressupostos <- read.csv("tables/05_testes_pressupostos.csv")

tabela_press <- xtable(pressupostos)

print(
  tabela_press,
  file = "tables_latex/tabela_pressupostos.tex",
  include.rownames = FALSE
)

##################################################
# VIF
##################################################

vif <- read.csv("tables/05_vif_modelo.csv")

tabela_vif <- xtable(vif)

print(
  tabela_vif,
  file = "tables_latex/tabela_vif.tex",
  include.rownames = FALSE
)

##################################################
# PREVISÕES
##################################################

prev <- read.csv("tables/06_previsoes_intervalos_modelo_final.csv")

tabela_prev <- xtable(prev)

print(
  tabela_prev,
  file = "tables_latex/tabela_previsoes.tex",
  include.rownames = FALSE
)

cat("✔ Tabelas LaTeX geradas\n")