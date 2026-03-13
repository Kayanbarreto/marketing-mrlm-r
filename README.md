# 📊 Relatório Final de Regressão Linear Múltipla – Projeto de Estatística: Campanhas de Marketing

Este repositório contém a solução do projeto final da disciplina de **Estatística Aplicada**, com foco na investigação dos determinantes da **receita mensal gerada por campanhas de marketing** de uma empresa de e-commerce varejista ao longo de 24 meses, utilizando **técnicas estatísticas** e **Regressão Linear Múltipla** em **R**.

---

# 👥 Integrantes

- **Kayan Marques Barreto** — 122210250  
- **Pedro Felipe Alves Bezerra** — 122210824  
- **Levi Queiroz de Assunção** — 121210923  

---

# 📚 Informações da disciplina

- **Disciplina:** Estatística Aplicada  
- **Docente:** Prof. Gilberto S. Matos  
- **Período:** 2025.2  
- **Data:** 13 de março de 2026  

---

# 🎯 Objetivo do Projeto

O objetivo deste projeto é investigar quais fatores influenciam a **receita mensal gerada por campanhas de marketing**, por meio de:

- ✅ análise exploratória dos dados  
- ✅ estatísticas descritivas  
- ✅ ajuste de modelo inicial de regressão linear múltipla  
- ✅ seleção do melhor modelo  
- ✅ verificação dos pressupostos do MRLM  
- ✅ geração de previsões e intervalos  
- ✅ elaboração de relatório final em LaTeX/Quarto  

---

# 🛠 Tecnologias Utilizadas

## 📈 Linguagem e análise estatística
- R

## 📦 Pacotes principais
- readxl
- dplyr
- janitor
- ggplot2
- broom
- MASS
- car
- lmtest

## 🧰 Ferramentas de desenvolvimento
- Git
- GitHub

---

# 📁 Estrutura do Projeto

> Estrutura geral do repositório:

```bash
.
├── data/
│   ├── raw/
│   │   └── 03_Cenario 03 - Marketing - Disponibilizar.xlsx
│   └── processed/
│       ├── dados_tratados_inicial.csv
│       └── dados_tratados_inicial.rds
│
├── scripts/
│   ├── 01_importacao_limpeza.R
│   ├── 02_analise_exploratoria.R
│   ├── 03_modelo_inicial.R
│   ├── 04_selecao_modelo.R
│   ├── 05_diagnostico_modelo.R
│   ├── 06_previsoes_intervalos.R
│   └── 99_funcoes_auxiliares.R
│
├── figures/
│   └── (gráficos gerados pelos scripts)
│
├── tables/
│   └── (tabelas exportadas em .csv)
│
├── outputs/
│   └── (modelos salvos, objetos .rds e saídas intermediárias)
│
├── report/
│   ├── relatorio.tex
│   └── relatorio.qmd
│
├── run_pipeline.R
│
├── .gitignore
└── README.md
```
# 📂 Descrição das Pastas
`data/raw/`

Contém a base original, sem alterações.

`data/processed/`

Contém os dados tratados gerados após a etapa de importação e limpeza.

`scripts/`

Contém os scripts principais da análise, organizados por ordem lógica de execução.

`figures/`

Armazena gráficos gerados durante a análise, como histogramas, boxplots e diagnósticos do modelo.

`tables/`

Armazena tabelas exportadas em .csv, como resumos descritivos, coeficientes, VIF e previsões.

`outputs/`

Armazena objetos salvos em .rds, como modelos ajustados e resultados intermediários.

`report/`

Contém os arquivos do relatório final do projeto.

# ✅ Pré-requisitos

Antes de executar o projeto, é recomendado ter instalado:

- R


# ⚙️ Configuração Inicial
## 1) Clonar o repositório
git clone `https://github.com/SEU-USUARIO/marketing-mrlm-r.git`
`cd marketing-mrlm-r`
## 2) Garantir que a base esteja no caminho correto

A planilha utilizada no projeto deve estar em:

`data/raw/03_Cenario 03 - Marketing - Disponibilizar.xlsx`
## 3) Instalar os pacotes necessários no R

No console do R, execute:

install.packages(c(
  "readxl",
  "dplyr",
  "janitor",
  "ggplot2",
  "broom",
  "MASS",
  "car",
  "lmtest"
))

# 🚀 Como Rodar o Projeto (Ordem Recomendada)
## ✅ 1) Rodar tudo de uma vez (recomendado)
`Rscript run_pipeline.R`

Esse arquivo executa todos os scripts principais em sequência, do `01` ao `06`, garantindo o fluxo completo da análise em uma única execução.

## ✅ 2) Importação e limpeza dos dados
````bash
Rscript scripts/01_importacao_limpeza.R
`````
Esse script:

- lê a planilha Excel;

- padroniza os nomes das colunas;

- mostra uma visão inicial da base;

- salva os dados `tratados em data/processed/`.

## ✅ 3) Análise exploratória
`Rscript scripts/02_analise_exploratoria.R`

Esse script:

- gera resumos estatísticos;

- verifica valores ausentes;

- cria histogramas;

salva tabelas e gráficos iniciais.

## ✅ 4) Ajuste do modelo inicial
`Rscript scripts/03_modelo_inicial.R`

Esse script:

- ajusta o modelo inicial de regressão linear múltipla;

- salva os coeficientes;

- salva o modelo em `.rds`.

⚠️ Observação: esse script pode exigir ajuste no nome da variável resposta, dependendo do nome real da coluna na planilha.

## ✅ 5) Seleção do melhor modelo
`Rscript scripts/04_selecao_modelo.R`

Esse script:

- realiza seleção de variáveis/modelo;

- compara modelo inicial e modelo final;

- salva o modelo selecionado.

## ✅ 6) Verificação dos pressupostos
`Rscript scripts/05_diagnostico_modelo.R`

Esse script verifica:

- homocedasticidade;

- independência dos resíduos;

- multicolinearidade;

- normalidade dos resíduos;

observações influentes.

## ✅ 7) Previsões e intervalos
`Rscript scripts/06_previsoes_intervalos.R`

Esse script:

- gera previsões com o modelo final;

- calcula intervalos de confiança;

- calcula intervalos de predição.

# 📜 Scripts do Projeto
##`01_importacao_limpeza.R`

Responsável por:

- importar a base;

- padronizar colunas;

- inspecionar a estrutura dos dados;

- salvar arquivos tratados.

##`02_analise_exploratoria.R`

Responsável por:

- gerar resumos estatísticos;

- analisar ausências;

- construir gráficos exploratórios.

##`03_modelo_inicial.R`

Responsável por:

- ajustar o modelo inicial de regressão linear múltipla.

##`04_selecao_modelo.R`

Responsável por:

- selecionar o melhor modelo;

- comparar ajustes;

- salvar resultados.

##`05_diagnostico_modelo.R`

Responsável por:

- realizar diagnósticos do modelo final;

- testar pressupostos da regressão.

##`06_previsoes_intervalos.R`

Responsável por:

- gerar previsões;

- calcular intervalos estatísticos.

##`99_funcoes_auxiliares.R`

Responsável por:

- concentrar funções auxiliares reutilizadas ao longo dos scripts.

# 📊 Arquivos Gerados ao Longo da Execução
Em `data/processed/`

`dados_tratados_inicial.csv`

`dados_tratados_inicial.rds`

Em `figures/`

- histogramas

- gráficos diagnósticos

- QQ-plot

- resíduos vs ajustados

Em `tables/`

- resumo de ausências

- resumo estatístico das variáveis

- coeficientes do modelo inicial

- coeficientes do modelo selecionado

- comparação entre modelos

- VIF

- previsões e intervalos

Em `outputs/`

- modelo_inicial.rds

- modelo_selecionado.rds

# 📝 Relatório Final

A estrutura prevista do relatório inclui:

- Introdução

- Descrição da Base de Dados

- Análise Exploratória

- Modelo Inicial

- Seleção do Melhor Modelo

- Verificação dos Pressupostos

- Previsões e Intervalos

- Conclusão

# 🔄 Rodar em Outra Máquina
## 1) Clonar o repositório
`git clone https://github.com/SEU-USUARIO/marketing-mrlm-r.git`
`cd marketing-mrlm-r`
## 2) Instalar os pacotes do R
```bashinstall.packages(c(
  "readxl",
  "dplyr",
  "janitor",
  "ggplot2",
  "broom",
  "MASS",
  "car",
  "lmtest"
))
```
## 3) Verificar se a base está em data/raw/
`data/raw/03_Cenario 03 - Marketing - Disponibilizar.xlsx`
## 4) Rodar tudo de uma vez (recomendado)
```bash
Rscript run_pipeline.R
```

## 5) Executar os scripts na ordem
```bash
Rscript scripts/01_importacao_limpeza.R
Rscript scripts/02_analise_exploratoria.R
Rscript scripts/03_modelo_inicial.R
Rscript scripts/04_selecao_modelo.R
Rscript scripts/05_diagnostico_modelo.R
Rscript scripts/06_previsoes_intervalos.R
```
# ⚠️ Observações Importantes

- A base original não deve ser modificada manualmente.

- Os scripts devem ser executados na ordem recomendada.

- Algumas partes da modelagem dependem do nome exato da variável resposta na planilha.

- O projeto foi estruturado para facilitar organização, reprodutibilidade e versionamento.

# 📄 
