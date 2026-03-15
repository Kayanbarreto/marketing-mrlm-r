library(car)
library(lmtest)

dir.create("tables", recursive = TRUE, showWarnings = FALSE)

modelo <- readRDS("outputs/modelo_selecionado.rds")

teste_bp <- bptest(modelo)
teste_dw <- dwtest(modelo)
teste_shapiro <- shapiro.test(residuals(modelo))
valores_vif <- vif(modelo)

resultado_pressupostos <- data.frame(
  metrica = c("Breusch-Pagan p-valor", "Durbin-Watson p-valor", "Shapiro-Wilk p-valor"),
  valor = c(teste_bp$p.value, teste_dw$p.value, teste_shapiro$p.value)
)

write.csv(
  resultado_pressupostos,
  "tables/05_testes_pressupostos.csv",
  row.names = FALSE
)

vif_df <- data.frame(
  variavel = names(valores_vif),
  vif = as.numeric(valores_vif)
)

write.csv(
  vif_df,
  "tables/05_vif_modelo.csv",
  row.names = FALSE
)

cat("✔ Etapa 05 concluída\n")