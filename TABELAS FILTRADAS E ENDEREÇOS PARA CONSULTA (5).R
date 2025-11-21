##Filtrando tabelas das ocorr�ncias selecionadas para o projeto efeitos de vizinhan�a e resultados escolares
##Periodo: 01/2019-10/2023
##Crimes selecionados: "HOMICIDIO","ESTUPRO",
##"ESTUPRO DE VULNERAVEL",
#"DISPARO DE ARMA DE FOGO/ACIONAM DE MUNICAO",
#"POSSE ILEGAL ARMA DE FOGO/ACESSÓRIO/MUNIÇÃO DE USO",
#"PORTE ILEGAL ARMA DE FOGO/ACESSÓRIO/MUNIÇÃO DE USO",
#"ARMA DE FOGO C/SINAL DE IDENTIFIC MODIFICADO",
#"COMERCIO ILEGAL DE ARMA DE FOGO/ACESSORIO/MUNICAO",
#"MUDA CARACT. DE ARMA, P/ IGUALAR A PROIBIDO",
#"POSSE/PORTE ILEGAL ARMA FOGO/MUNIC/ACESSO USO PROI",
#"USO E CONSUMO DE DROGAS",
#"ASSOCIACAO PARA O TRAFICO DE DROGAS",
#"INCENTIVO AO USO OU CONSUMO DE DROGAS",
#"TRAFICO ILICITO DE DROGAS",
#"TRAFICO ILICITO MATERIAS PRIMAS USO PREPARO DROGAS",
#"UTILIZ/CONSENTIMENTO USO LOCAL/BEM TRAFICO DROGAS",
#"ASSOCIACAO P/ FINANCIAMENTO/CUSTEIO TRAFICO DROGAS",
#"VIAS DE FATO / AGRESSAO",
#"LESAO CORPORAL"
##Recorte: Casos sem XY /com logradouro ou Bairro 
##Fonte: Registro de Eventos de Defesa Social (REDS)


# CARREGAR PACOTES------------


if(!require(pacman)){install.packages("pacman")}
pacman::p_load(haven, dplyr, RCurl, ggplot2, devtools, pkgconfig, tidyverse, data.table,ggmap, readxl,janitor,openxlsx)


options(scipen = 999)       #força o R a não usar notação científica
Sys.setlocale("LC_CTYPE", "pt_BR.UTF-8") # Identificando caracteres especiais no texto
rm(list = ls())             #limpa todas as variáveis criadas
getwd()                     #indica o diretório que está sendo utilizado pelo R
setwd("C:/Users/valcr/OneDrive - Universidade Federal de Minas Gerais/Documentos/Pós-Doc/Parte 2 - IESP/Dados")


# Carregando tabelas de Ocorrencias: 
#necessario especificar qual o tipo de variavel para que as tabelas possam se juntar- devem ser todos iguais! (pode ser modificado em "col_types")
#Rodar função primeiro, depois adicionar o nome da tabela<- abre_tabela(nome da tabela no seu computador)-> tomar cuidado com o caminho base (deve ser como está no seu computador)
library(readxl)
library(dplyr)
library(janitor)
library(tidyverse)
library(openxlsx)

abre_tabela <- function(nome_do_arquivo) {
  
  caminho_base <- "~/VIOLENCIA_ESCOLAR/TABELAS_OCORRENCIAS/"
  extensao <- ".xlsx"
  
  caminho_arquivo <- paste(caminho_base,nome_do_arquivo,extensao,sep="")
  
  
  tabela<- read_excel(caminho_arquivo, 
                      col_types = c("text", "date", "numeric", 
                                    "numeric", "numeric", "text", "text", 
                                    "numeric", "numeric", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "text", "text", "text", 
                                    "text", "text", "text"))
  return(tabela)
}
-------#2019#--------
OcorrenciasVCO_2019_1 <- abre_tabela("OcorrenciasVCO 2019 1")
OcorrenciasVCO_2019_2 <- abre_tabela("OcorrenciasVCO 2019 2")
OcorrenciasVCO_2019_3 <- abre_tabela("OcorrenciasVCO 2019 3")
OcorrenciasVCO_2019_4 <- abre_tabela("OcorrenciasVCO 2019 4")
OcorrenciasVCO_2019_5 <- abre_tabela("OcorrenciasVCO 2019 5")
OcorrenciasVCO_2019_6 <- abre_tabela("OcorrenciasVCO 2019 6")

-------#2020#--------
OcorrenciasVCO_2020_1 <- abre_tabela("OcorrenciasVCO 2020 1")
OcorrenciasVCO_2020_2 <- abre_tabela("OcorrenciasVCO 2020 2")
OcorrenciasVCO_2020_3 <- abre_tabela("OcorrenciasVCO 2020 3")
OcorrenciasVCO_2020_4 <- abre_tabela("OcorrenciasVCO 2020 4")
OcorrenciasVCO_2020_5 <- abre_tabela("OcorrenciasVCO 2020 5")
OcorrenciasVCO_2020_6 <- abre_tabela("OcorrenciasVCO 2020 6")

-------#2021#--------
OcorrenciasVCO_2021_1 <- abre_tabela("OcorrenciasVCO 2021 1")
OcorrenciasVCO_2021_2 <- abre_tabela("OcorrenciasVCO 2021 2")
OcorrenciasVCO_2021_3 <- abre_tabela("OcorrenciasVCO 2021 3")
OcorrenciasVCO_2021_4 <- abre_tabela("OcorrenciasVCO 2021 4")
OcorrenciasVCO_2021_5 <- abre_tabela("OcorrenciasVCO 2021 5")
OcorrenciasVCO_2021_6 <- abre_tabela("OcorrenciasVCO 2021 6")

-------#2022#--------
OcorrenciasVCO_2022_1 <- abre_tabela("OcorrenciasVCO 2022 1")
OcorrenciasVCO_2022_2 <- abre_tabela("OcorrenciasVCO 2022 2")
OcorrenciasVCO_2022_3 <- abre_tabela("OcorrenciasVCO 2022 3")
OcorrenciasVCO_2022_4 <- abre_tabela("OcorrenciasVCO 2022 4")
OcorrenciasVCO_2022_5 <- abre_tabela("OcorrenciasVCO 2022 5")
OcorrenciasVCO_2022_6 <- abre_tabela("OcorrenciasVCO 2022 6")

-------#2023#--------
OcorrenciasVCO_2023_1 <- abre_tabela("OcorrenciasVCO 2023 1")
OcorrenciasVCO_2023_2 <- abre_tabela("OcorrenciasVCO 2023 2")
OcorrenciasVCO_2023_3 <- abre_tabela("OcorrenciasVCO 2023 3")
OcorrenciasVCO_2023_4 <- abre_tabela("OcorrenciasVCO 2023 4")
OcorrenciasVCO_2023_5 <- abre_tabela("OcorrenciasVCO 2023 5")

------#Juntar tabelas por ano#------
Ocorrencias_2019 <- bind_rows(OcorrenciasVCO_2019_1, OcorrenciasVCO_2019_2,OcorrenciasVCO_2019_3, OcorrenciasVCO_2019_4,OcorrenciasVCO_2019_5,OcorrenciasVCO_2019_6)
Ocorrencias_2020 <- bind_rows(OcorrenciasVCO_2020_1, OcorrenciasVCO_2020_2, OcorrenciasVCO_2020_3, OcorrenciasVCO_2020_4, OcorrenciasVCO_2020_5, OcorrenciasVCO_2020_6)
Ocorrencias_2021 <- bind_rows(OcorrenciasVCO_2021_1, OcorrenciasVCO_2021_2, OcorrenciasVCO_2021_3, OcorrenciasVCO_2021_4, OcorrenciasVCO_2021_5, OcorrenciasVCO_2021_6)
Ocorrencias_2022 <- bind_rows(OcorrenciasVCO_2022_1, OcorrenciasVCO_2022_2, OcorrenciasVCO_2022_3, OcorrenciasVCO_2022_4, OcorrenciasVCO_2022_5, OcorrenciasVCO_2022_6)
Ocorrencias_2023 <- bind_rows(OcorrenciasVCO_2023_1, OcorrenciasVCO_2023_2, OcorrenciasVCO_2023_3, OcorrenciasVCO_2023_4, OcorrenciasVCO_2023_5)


------------------------# Filtrando ocorrencias e suas porcentagens"---------------------------

#Usando função para filtrar as subclasses de interesse:
sub_nat_principal <- function(Ocorrencias) {
  descricao <- Ocorrencias %>%
    dplyr::filter(
      `Descri��o Subclasse Nat Principal` %in% c(
        "HOMICIDIO",
        "ESTUPRO",
        "ESTUPRO DE VULNERAVEL",
        "DISPARO DE ARMA DE FOGO/ACIONAM DE MUNICAO",
        "POSSE ILEGAL ARMA DE FOGO/ACESS�RIO/MUNI��O DE USO",
        "PORTE ILEGAL ARMA DE FOGO/ACESS�RIO/MUNI��O DE USO",
        "ARMA DE FOGO C/SINAL DE IDENTIFIC MODIFICADO",
        "COMERCIO ILEGAL DE ARMA DE FOGO/ACESSORIO/MUNICAO",
        "MUDA CARACT. DE ARMA, P/ IGUALAR A PROIBIDO",
        "POSSE/PORTE ILEGAL ARMA FOGO/MUNIC/ACESSO USO PROIB",
        "USO E CONSUMO DE DROGAS",
        "ASSOCIACAO PARA O TRAFICO DE DROGAS",
        "INCENTIVO AO USO OU CONSUMO DE DROGAS",
        "TRAFICO ILICITO DE DROGAS",
        "TRAFICO ILICITO MATERIAS PRIMAS USO PREPARO DROGAS",
        "UTILIZ/CONSENTIMENTO USO LOCAL/BEM TRAFICO DROGAS",
        "ASSOCIACAO P/ FINANCIAMENTO/CUSTEIO TRAFICO DROGAS",
        "VIAS DE FATO / AGRESSAO",
        "LESAO CORPORAL"
      )
    )
  
  return(descricao)
}

#Criando tabelas que possuem apenas as naturezas principais escolhidas: 
ocorrencias19<- sub_nat_principal(Ocorrencias_2019)
ocorrencias20<-sub_nat_principal(Ocorrencias_2020)
ocorrencias21<-sub_nat_principal(Ocorrencias_2021)
ocorrencias22<-sub_nat_principal(Ocorrencias_2022)
ocorrencias23<-sub_nat_principal(Ocorrencias_2023)

#Juntando todas as tabelas filtradas: 
ocorrencias_filtradas <- bind_rows(ocorrencias19,ocorrencias20,ocorrencias21,ocorrencias22,ocorrencias23)


#Criando tabela de frequencia da subclasse de natureza principal 
Tab_freq1 <- ocorrencias_filtradas %>%
  tabyl( `Descri��o Subclasse Nat Principal`) %>%
  adorn_pct_formatting(digits = 2)

#116.089 casos com as respostas de interesse


-----------------#Tabelas com lat e long das variaveis de interesse#----------
#Usando 'função" para criar tabelas que não possuem lat/long, mas com logradouro.
enderecos_validos<- function(Ocorrencias) {
  com_endereco <- Ocorrencias %>%
    dplyr::filter(( !is.na(Latitude) | !is.na(Longitude) ))
  
  return (com_endereco)
}
ocorrencias_filtradas_comxy<-enderecos_validos(ocorrencias_filtradas)
write.xlsx(ocorrencias_filtradas_comxy, file = "C:/Users/User/Documents/VIOLENCIA_ESCOLAR/ocorrencias_filtradas_comxy.xlsx", dec = ",", rowNames = FALSE)

#106.384 casos com respostas de interesse e latitude e longitude 
------------------------# Encontrando endereços invalidos e suas porcentagens"---------------------------

#Usando 'função" para criar tabelas que não possuem lat/long, mas com logradouro.
enderecos_invalidos<- function(Ocorrencias) {
  sem_endereco <- Ocorrencias %>%
    dplyr::filter(( is.na(Latitude) | is.na(Longitude) ) & 
                    ('Logradouro Ocorr�ncia' != "INV�LIDO"|!is.na('Logradouro Ocorr�ncia N�o Cadastrado') ))
  
  return (sem_endereco)
}

#Criando tabelas que necessitam de consulta de endereços
consultar_enderecos<- enderecos_invalidos(ocorrencias_filtradas)
write.xlsx(consultar_endere�os, file = "C:/Users/User/Documents/UFMG 2024.1/Trabalho_Analise_Dados/consultar_endere�os", dec = ",", rowNames = FALSE)
write.csv(consultar_endere�os, "C:/Users/User/Documents/UFMG 2024.1/Trabalho_Analise_Dados/consultar_endere�os", row.names = FALSE)


Tab_freq2<- consultar_endere�os %>%
  tabyl( `Descri��o Subclasse Nat Principal`) %>%
  adorn_pct_formatting(digits = 2)

#9257-> tabela para consulta de endereços 

#Identificando os registros sem localização válida
invalidos <- function(Ocorrencias) {
  sem_endereco_valido <- Ocorrencias %>%
    dplyr::filter(( is.na(Latitude) | is.na(Longitude) ) & 
                    (`Logradouro Ocorr�ncia` == "INV�LIDO" & is.na(`Logradouro Ocorr�ncia N�o Cadastrado`) ))
  
  return (sem_endereco_valido)
}

ocorrencias_invalidas<-invalidos(ocorrencias_filtradas)

Tab_freq3 <- ocorrencias_invalidas %>%
  tabyl( `Descri��o Subclasse Nat Principal`) %>%
  adorn_pct_formatting(digits = 2)

#Apenas 24 ocorrencias foram completamente excluidas por falta de endereço. 