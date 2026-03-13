library(ggplot2)
library(dplyr)

dir.create("figures", showWarnings = FALSE)

gerar_graficos <- function(modelo){

  dados <- modelo$model
  resposta <- names(dados)[1]

  cat("Variável resposta detectada:", resposta, "\n")

  #-----------------------------
  # Histograma da variável resposta
  #-----------------------------

  g1 <- ggplot(dados, aes_string(x = resposta)) +
    geom_histogram(bins = 20) +
    labs(
      title = "Distribuição da variável resposta",
      x = resposta,
      y = "Frequência"
    )

  ggsave("figures/hist_resposta.png", g1, width = 6, height = 4)

  #-----------------------------
  # Gráficos resposta vs variáveis
  #-----------------------------

  variaveis <- names(dados)[-1]

  for(v in variaveis){

    g <- ggplot(dados, aes_string(x = v, y = resposta)) +
      geom_point() +
      geom_smooth(method = "lm") +
      labs(
        title = paste(resposta, "vs", v),
        x = v,
        y = resposta
      )

    nome <- paste0("figures/", resposta, "_vs_", v, ".png")

    ggsave(nome, g, width = 6, height = 4)
  }

  #-----------------------------
  # Resíduos vs ajustados
  #-----------------------------

  residuos <- resid(modelo)
  ajustados <- fitted(modelo)

  df <- data.frame(ajustados, residuos)

  g2 <- ggplot(df, aes(x = ajustados, y = residuos)) +
    geom_point() +
    geom_hline(yintercept = 0) +
    labs(
      title = "Resíduos vs valores ajustados",
      x = "Valores ajustados",
      y = "Resíduos"
    )

  ggsave("figures/residuos_vs_ajustados.png", g2, width = 6, height = 4)

  #-----------------------------
  # QQ plot
  #-----------------------------

  png("figures/qqplot_residuos.png")

  qqnorm(residuos)
  qqline(residuos)

  dev.off()

  cat("✔ Gráficos gerados em /figures\n")

}