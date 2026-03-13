salvar_plot <- function(plot, caminho, largura = 8, altura = 5, dpi = 300) {

  dir.create(dirname(caminho), recursive = TRUE, showWarnings = FALSE)

  ggplot2::ggsave(
    filename = caminho,
    plot = plot,
    width = largura,
    height = altura,
    dpi = dpi
  )

}

salvar_tabela_csv <- function(df, caminho) {

  dir.create(dirname(caminho), recursive = TRUE, showWarnings = FALSE)

  write.csv(df, caminho, row.names = FALSE)

}

carregar_dados_tratados <- function(
  caminho = "data/processed/02_dados_limpos.rds"
) {

  readRDS(caminho)

}

remover_nas_modelo <- function(df) {

  df[stats::complete.cases(df), ]

}