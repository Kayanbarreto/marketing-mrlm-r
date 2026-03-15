cat("Limpando arquivos gerados...\n")

args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)

if (length(file_arg) > 0) {
	script_path <- normalizePath(sub("^--file=", "", file_arg), winslash = "/", mustWork = FALSE)
	project_root <- normalizePath(file.path(dirname(script_path), ".."), winslash = "/", mustWork = FALSE)
} else {
	project_root <- if (basename(getwd()) == "scripts") normalizePath("..", winslash = "/", mustWork = FALSE) else normalizePath(".", winslash = "/", mustWork = FALSE)
}

path_in_root <- function(...) file.path(project_root, ...)

unlink(path_in_root("data", "processed"), recursive = TRUE, force = TRUE)
unlink(path_in_root("figures"), recursive = TRUE, force = TRUE)
unlink(path_in_root("tables"), recursive = TRUE, force = TRUE)
unlink(path_in_root("outputs"), recursive = TRUE, force = TRUE)

dir.create(path_in_root("data", "processed"), recursive = TRUE, showWarnings = FALSE)
dir.create(path_in_root("figures"), recursive = TRUE, showWarnings = FALSE)
dir.create(path_in_root("tables"), recursive = TRUE, showWarnings = FALSE)
dir.create(path_in_root("outputs"), recursive = TRUE, showWarnings = FALSE)

cat("✔ Limpeza concluída\n")