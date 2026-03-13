library(dplyr)

dir.create("outputs", recursive = TRUE, showWarnings = FALSE)
dir.create("tables", recursive = TRUE, showWarnings = FALSE)

modelo <- readRDS("outputs/modelo_selecionado.rds")

dados_modelo <- model.frame(modelo)

novo1 <- dados_modelo[1, , drop = FALSE]
novo2 <- dados_modelo[2, , drop = FALSE]

novos_dados <- bind_rows(novo1, novo2)

previsao_media <- predict(modelo, newdata = novos_dados, interval = "confidence")
previsao_individual <- predict(modelo, newdata = novos_dados, interval = "prediction")

resultado_previsoes <- cbind(
  cenario = c("cenario_1", "cenario_2"),
  as.data.frame(previsao_media),
  pred_lwr = previsao_individual[, "lwr"],
  pred_upr = previsao_individual[, "upr"]
)

write.csv(resultado_previsoes, "tables/previsoes_intervalos.csv", row.names = FALSE)

cat("Previsões e intervalos salvos.\n")