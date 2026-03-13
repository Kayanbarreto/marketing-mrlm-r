cat("Limpando arquivos gerados...\n")

unlink("data/processed", recursive = TRUE)
unlink("figures", recursive = TRUE)
unlink("tables", recursive = TRUE)
unlink("outputs", recursive = TRUE)

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
dir.create("figures", recursive = TRUE, showWarnings = FALSE)
dir.create("tables", recursive = TRUE, showWarnings = FALSE)
dir.create("outputs", recursive = TRUE, showWarnings = FALSE)

cat("✔ Limpeza concluída\n")