library(car)
library(lmtest)

dir.create("figures", recursive = TRUE, showWarnings = FALSE)
dir.create("tables", recursive = TRUE, showWarnings = FALSE)

modelo <- readRDS("outputs/modelo_selecionado.rds")

residuos <- residuals(modelo)
ajustados <- fitted(modelo)

png("figures/residuos_vs_ajustados.png", width = 1600, height = 1200, res = 200)

plot(
  ajustados,
  residuos,
  main = "Resíduos vs Ajustados",
  xlab = "Valores ajustados",
  ylab = "Resíduos"
)

abline(h = 0, lty = 2)

dev.off()

png("figures/qqplot_residuos.png", width = 1600, height = 1200, res = 200)

qqnorm(residuos)
qqline(residuos, col = 2)

dev.off()

teste_bp <- bptest(modelo)
teste_dw <- dwtest(modelo)
valores_vif <- vif(modelo)

resultado_pressupostos <- data.frame(
  metrica = c("Breusch-Pagan p-valor", "Durbin-Watson p-valor"),
  valor = c(teste_bp$p.value, teste_dw$p.value)
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