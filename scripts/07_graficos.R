library(ggplot2)
library(dplyr)
library(reshape2)

dir.create("figures", showWarnings = FALSE)

gerar_graficos <- function(modelo){

  # Limpa apenas os gráficos que este script gera
  arquivos_figuras <- list.files("figures", pattern = "\\.png$", full.names = TRUE)
  nomes_figuras <- basename(arquivos_figuras)
  padroes_permitidos <- c(
    "^hist_",
    "^boxplot_bivariado\\.png$",
    "^scatter_",
    "^correlation_heatmap\\.png$",
    "^residuos_vs_ajustados\\.png$",
    "^qqplot_residuos\\.png$",
    "^scale_location\\.png$",
    "^residuos_vs_leverage_cook\\.png$"
  )

  arquivos_obsoletos <- arquivos_figuras[!sapply(nomes_figuras, function(nome) {
    any(grepl(padroes_permitidos, nome))
  })]

  if(length(arquivos_obsoletos) > 0){
    unlink(arquivos_obsoletos)
  }

  dados <- modelo$model
  resposta <- names(dados)[1]
  explicativas <- names(dados)[-1]

  cat("Gerando gráficos para:", resposta, "\n")

  #################################################
  # 1) HISTOGRAMAS DAS VARIÁVEIS NUMÉRICAS
  #################################################

  num_vars <- dados %>% select(where(is.numeric))

  for(v in names(num_vars)){

    g <- ggplot(dados, aes_string(x = v)) +
      geom_histogram(bins = 20) +
      labs(
        title = paste("Histograma de", v),
        x = v,
        y = "Frequência"
      ) +
      theme_minimal()

    ggsave(
      paste0("figures/hist_", v, ".png"),
      g, width = 6, height = 4
    )
  }

  #################################################
  # 2) BOXPLOT BIVARIADO
  # resposta vs explicativa categórica
  # ou resposta vs faixas de uma explicativa contínua
  #################################################

  candidatos_bivariado <- explicativas[sapply(dados[explicativas], function(x) {
    is.factor(x) || is.character(x) || (is.numeric(x) && dplyr::n_distinct(x) <= 10)
  })]

  var_bivariada <- if(length(candidatos_bivariado) > 0) candidatos_bivariado[1] else NA

  dados_box_bivariado <- dados
  eixo_x <- ""

  if(!is.na(var_bivariada)){
    dados_box_bivariado <- dados_box_bivariado %>%
      mutate(grupo_box_bivariado = as.factor(.data[[var_bivariada]]))
    eixo_x <- var_bivariada

  } else if(length(explicativas) > 0){

    explicativas_numericas <- explicativas[sapply(dados[explicativas], is.numeric)]

    if(length(explicativas_numericas) > 0){
      var_continua <- explicativas_numericas[1]

      cortes <- unique(quantile(
        dados_box_bivariado[[var_continua]],
        probs = seq(0, 1, 0.25),
        na.rm = TRUE
      ))

      if(length(cortes) >= 3){
        dados_box_bivariado <- dados_box_bivariado %>%
          mutate(grupo_box_bivariado = cut(
            .data[[var_continua]],
            breaks = cortes,
            include.lowest = TRUE
          ))
      } else {
        mediana_var <- median(dados_box_bivariado[[var_continua]], na.rm = TRUE)
        dados_box_bivariado <- dados_box_bivariado %>%
          mutate(grupo_box_bivariado = ifelse(
            .data[[var_continua]] <= mediana_var,
            "baixo", "alto"
          ))
      }

      eixo_x <- paste(var_continua, "(faixas)")
    }
  }

  if("grupo_box_bivariado" %in% names(dados_box_bivariado)){

    g <- ggplot(
      dados_box_bivariado,
      aes(x = factor(grupo_box_bivariado), y = .data[[resposta]])
    ) +
      geom_boxplot() +
      labs(
        title = "Boxplot bivariado",
        x = eixo_x,
        y = resposta
      ) +
      theme_minimal()

    ggsave(
      "figures/boxplot_bivariado.png",
      g, width = 6, height = 4
    )
  }

  #################################################
  # 3) DISPERSÃO: RESPOSTA VS EXPLICATIVAS NUMÉRICAS
  #################################################

  for(v in explicativas){

    if(is.numeric(dados[[v]])){

      g <- ggplot(dados, aes_string(x = v, y = resposta)) +
        geom_point() +
        geom_smooth(method = "lm", se = FALSE) +
        labs(
          title = paste("Dispersão de", resposta, "vs", v),
          x = v,
          y = resposta
        ) +
        theme_minimal()

      ggsave(
        paste0("figures/scatter_", resposta, "_vs_", v, ".png"),
        g, width = 6, height = 4
      )
    }
  }

  #################################################
  # 4) HEATMAP DE CORRELAÇÃO
  #################################################

  if(ncol(num_vars) >= 2){
    cor_matrix <- cor(num_vars, use = "pairwise.complete.obs")
    cor_melt <- melt(cor_matrix)

    g <- ggplot(cor_melt, aes(x = Var1, y = Var2, fill = value)) +
      geom_tile(color = "white") +
      geom_text(aes(label = sprintf("%.2f", value)), size = 3.5) +
      scale_fill_gradient2(
        low = "red",
        mid = "white",
        high = "blue",
        midpoint = 0,
        limits = c(-1, 1)
      ) +
      labs(
        title = "Matriz de correlação",
        x = NULL,
        y = NULL,
        fill = "Correlação"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
        axis.text.y = element_text(size = 10),
        panel.grid = element_blank()
      )
      coord_fixed()

    ggsave(
      "figures/correlation_heatmap.png",
      g,
      width = 9,
      height = 7,
      dpi = 300
    )
  }

  #################################################
  # 5) GRÁFICOS DE DIAGNÓSTICO DO MODELO
  #################################################

  residuos <- rstandard(modelo)
  ajustados <- fitted(modelo)
  leverage <- hatvalues(modelo)
  cook <- cooks.distance(modelo)

  g <- ggplot(data.frame(ajustados, residuos), aes(x = ajustados, y = residuos)) +
    geom_point() +
    geom_hline(yintercept = 0) +
    labs(
      title = "Resíduos vs valores ajustados",
      x = "Valores ajustados",
      y = "Resíduos padronizados"
    ) +
    theme_minimal()

  ggsave(
    "figures/residuos_vs_ajustados.png",
    g, width = 6, height = 4
  )

  png("figures/qqplot_residuos.png", width = 1600, height = 1200, res = 200)
  qqnorm(residuos, main = "QQ-plot dos resíduos")
  qqline(residuos, col = 2)
  dev.off()

  sqrt_res <- sqrt(abs(residuos))

  g <- ggplot(data.frame(ajustados, sqrt_res), aes(x = ajustados, y = sqrt_res)) +
    geom_point() +
    geom_smooth(se = FALSE) +
    labs(
      title = "Scale-Location Plot",
      x = "Valores ajustados",
      y = "sqrt(|resíduos padronizados|)"
    ) +
    theme_minimal()

  ggsave(
    "figures/scale_location.png",
    g, width = 6, height = 4
  )

  g <- ggplot(
    data.frame(leverage, residuos, cook),
    aes(x = leverage, y = residuos, size = cook)
  ) +
    geom_point(alpha = 0.7) +
    geom_hline(yintercept = 0) +
    labs(
      title = "Resíduos vs leverage / Distância de Cook",
      x = "Leverage",
      y = "Resíduos padronizados",
      size = "Cook"
    ) +
    theme_minimal()

  ggsave(
    "figures/residuos_vs_leverage_cook.png",
    g, width = 6, height = 4
  )

  cat("✔ Gráficos essenciais gerados com sucesso\n")
}