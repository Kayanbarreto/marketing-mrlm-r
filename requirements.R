pacotes <- c(
  "dplyr",
  "readxl",
  "janitor",
  "broom",
  "car",
  "lmtest",
  "ggplot2",
  "GGally",
  "reshape2",
  "MASS"
)

options(repos = c(CRAN = "https://cloud.r-project.org"))

instalar <- pacotes[!(pacotes %in% installed.packages()[, "Package"])]

if (length(instalar) > 0) {
  install.packages(instalar)
}

cat("Dependencias verificadas com sucesso.\n")
