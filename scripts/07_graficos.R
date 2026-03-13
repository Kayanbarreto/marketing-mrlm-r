library(ggplot2)
library(dplyr)
library(GGally)
library(reshape2)

dir.create("figures", showWarnings = FALSE)

gerar_graficos <- function(modelo){

  dados <- modelo$model
  resposta <- names(dados)[1]

  cat("Gerando gráficos para:", resposta, "\n")

  #################################################
  # HISTOGRAMA DA RESPOSTA
  #################################################

  g <- ggplot(dados, aes_string(x=resposta)) +
    geom_histogram(bins=20) +
    labs(title="Distribuição da variável resposta")

  ggsave("figures/hist_resposta.png", g, width=6, height=4)

  #################################################
  # BOXPLOTS UNIVARIADOS
  #################################################

  num_vars <- dados %>% select(where(is.numeric))

  for(v in names(num_vars)){

    g <- ggplot(dados, aes_string(y=v)) +
      geom_boxplot() +
      labs(title=paste("Boxplot de", v))

    ggsave(paste0("figures/boxplot_",v,".png"), g, width=5, height=4)
  }

  #################################################
  # BOXPLOT RECEITA vs NUM_PROMOTORES
  #################################################

  if("num_promotores" %in% names(dados)){

    g <- ggplot(dados,
                aes(x=factor(num_promotores),
                    y=.data[[resposta]])) +
      geom_boxplot() +
      labs(title="Receita por número de promotores",
           x="Número de promotores",
           y=resposta)

    ggsave("figures/boxplot_receita_promotores.png", g,
           width=6, height=4)
  }

  #################################################
  # MATRIZ DE CORRELAÇÃO
  #################################################

  cor_matrix <- cor(num_vars)

  cor_melt <- melt(cor_matrix)

  g <- ggplot(cor_melt,
              aes(Var1,Var2,fill=value)) +
    geom_tile() +
    scale_fill_gradient2(
      low="blue",
      high="red",
      mid="white",
      midpoint=0
    ) +
    theme(axis.text.x = element_text(angle=45,hjust=1)) +
    labs(title="Matriz de Correlação")

  ggsave("figures/correlation_heatmap.png", g, width=7, height=6)

  #################################################
  # PAIRS PLOT
  #################################################

  g <- ggpairs(num_vars)

  ggsave("figures/pairs_plot.png", g, width=8, height=8)

  #################################################
  # HISTOGRAMA DOS RESÍDUOS
  #################################################

  residuos <- rstandard(modelo)

  g <- ggplot(data.frame(residuos),
              aes(x=residuos)) +
    geom_histogram(bins=20) +
    labs(title="Histograma dos resíduos padronizados")

  ggsave("figures/hist_residuos.png", g, width=6, height=4)

  #################################################
  # RESÍDUOS vs AJUSTADOS
  #################################################

  ajustados <- fitted(modelo)

  g <- ggplot(data.frame(ajustados,residuos),
              aes(x=ajustados,y=residuos)) +
    geom_point() +
    geom_hline(yintercept=0) +
    labs(title="Resíduos vs valores ajustados")

  ggsave("figures/residuos_vs_ajustados.png", g,
         width=6,height=4)

  #################################################
  # SCALE LOCATION PLOT
  #################################################

  sqrt_res <- sqrt(abs(residuos))

  g <- ggplot(data.frame(ajustados,sqrt_res),
              aes(x=ajustados,y=sqrt_res)) +
    geom_point() +
    geom_smooth(se=FALSE) +
    labs(title="Scale-Location Plot",
         y="sqrt(|resíduos padronizados|)")

  ggsave("figures/scale_location.png", g,
         width=6,height=4)

  #################################################
  # RESÍDUOS vs CADA PREDITOR
  #################################################

  preds <- names(dados)[-1]

  for(v in preds){

    g <- ggplot(data.frame(dados,residuos),
                aes_string(x=v,y="residuos")) +
      geom_point() +
      geom_hline(yintercept=0) +
      labs(title=paste("Resíduos vs",v))

    ggsave(paste0("figures/residuos_vs_",v,".png"),
           g,width=6,height=4)
  }

  #################################################
  # COOKS DISTANCE
  #################################################

  cooks <- cooks.distance(modelo)

  g <- ggplot(data.frame(cooks),
              aes(x=seq_along(cooks),y=cooks)) +
    geom_bar(stat="identity") +
    labs(title="Cook's Distance",
         x="Observação",
         y="Cook's distance")

  ggsave("figures/cooks_distance.png", g,
         width=7,height=4)

  #################################################
  # RESIDUALS vs LEVERAGE
  #################################################

  png("figures/residuals_vs_leverage.png")

  plot(modelo, which=5)

  dev.off()

  cat("✔ Todos os gráficos foram gerados\n")

}