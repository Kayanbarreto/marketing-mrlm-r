salvar_plot <- function(plot, caminho, largura = 8, altura = 5, dpi = 300) {
  ggplot2::ggsave(
    filename = caminho,
    plot = plot,
    width = largura,
    height = altura,
    dpi = dpi
  )
}

salvar_tabela_csv <- function(df, caminho) {
  write.csv(df, caminho, row.names = FALSE)
}

carregar_dados_tratados <- function(caminho = "data/processed/dados_tratados_inicial.rds") {
  readRDS(caminho)
}

remover_nas_modelo <- function(df) {
  df[stats::complete.cases(df), ]
}