
##Georreferenciamento das ocorr√™ncias selecionadas para o projeto efeitos de vizinhan√ßa e resultados escolares
##Per√≠odo: 01/2019-10/2023
##Crimes selecionados: "HOMICIDIO","ESTUPRO",
##"ESTUPRO DE VULNERAVEL",
#"DISPARO DE ARMA DE FOGO/ACIONAM DE MUNICAO",
#"POSSE ILEGAL ARMA DE FOGO/ACESS√ìRIO/MUNI√á√ÉO DE USO",
#"PORTE ILEGAL ARMA DE FOGO/ACESS√ìRIO/MUNI√á√ÉO DE USO",
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
pacman::p_load(haven, dplyr, RCurl, ggplot2, devtools, pkgconfig, tidyverse, data.table,ggmap, readxl,openxlsx)

options(scipen = 999)       #for√ßa o R a n√£o usar nota√ß√£o cient√≠fica
Sys.setlocale("LC_CTYPE", "pt_BR.UTF-8") # Identificando caracteres especiais no texto
rm(list = ls())             #limpa todas as vari√°veis criadas
getwd()                     #indica o diret√≥rio que est√° sendo utilizado pelo R
setwd("C:/Users/User/Documents/consultar_endereÁos")

library(readxl)
consultar_enderecos <- read_excel("VIOLENCIA_ESCOLAR/consultar_endereÁos.xlsx")
View(consultar_enderecos)

-----# ABERTURA E VERIFICA«√O DA BASE#------------------

consultaxy <- consultar_enderecos


----#Consulta ao google para localiza√ß√£o das coordenadas#----

# install dev version of ggmap
#devtools::install_github("dkahle/ggmap")
#library(ggmap)

#> Loading required package: ggplot2
#> Google Maps API Terms of Service: http://developers.google.com/maps/terms.
#> Please cite ggmap if you use it: see citation("ggmap") for details.

register_google(key = "AIzaSyB_LqiPZxHFCdiUucuOqIeEZQu-ru2NjSM")


has_google_key()

------------#Variavel de enderecos#---------
#cria a vari√°vel de endere√ßo

consultaxy_valido <- filter(consultaxy, `Logradouro OcorrÍncia` != "INV¡LIDO")


consultaxy_valido<-  mutate (consultaxy_valido, endereco= paste(`Logradouro OcorrÍncia - Tipo`, `Logradouro OcorrÍncia`, ",", `N˙mero Logradouro`, ",", Bairro, ",", MunicÌpio , ", Minas Gerais, Brazil" ))

#cria a vari√°vel de endere√ßo com endere√ßo n√£o cadastrado

consultaxy_invalido <- filter(consultaxy, `Logradouro OcorrÍncia` == "INV¡LIDO")

consultaxy_invalido<-  mutate (consultaxy_invalido, endereco= paste(`Logradouro OcorrÍncia - Tipo`, `Logradouro OcorrÍncia N„o Cadastrado`, ",", `Bairro N„o Cadastrado`, ",", MunicÌpio , ", Minas Gerais, Brazil" ))



-------# mapa de base #---------

geocode(c("Belo Horizonte"))

ggmap(
  ggmap = get_map(
    "Belo Horizonte",
    zoom = 6
    , scale = "auto",
    maptype = "satellite",
    source = "google"),
  extent = "device",
  legend = "topright"
)

localmg<- c(lon= -43.9, lat = -19.9)
mapa_mg <- get_map(localmg)
plot(mapa_mg)
mapa_mg2 <- get_map(localmg, source="google", maptype="roadmap", zoom=12)
plot(mapa_mg2)


---------------# Achando lat e long #-------------
consultaxy_valido_xy <- geocode(consultaxy_valido$endereco)
consultaxy_invalido_xy<- geocode(consultaxy_invalido$endereco)

write.xlsx(consultaxy_valido, file = "C:/Users/User/Documents/VIOLENCIA_ESCOLAR/consultaxy_valido.xlsx", dec = ",", rowNames = FALSE)
write.xlsx(consultaxy_valido_xy, file = "C:/Users/User/Documents/VIOLENCIA_ESCOLAR/consultaxy_valido_xy.xlsx", dec = ",", rowNames = FALSE)
write.xlsx(consultaxy_invalido, file = "C:/Users/User/Documents/VIOLENCIA_ESCOLAR/consultaxy_invalido.xlsx", dec = ",", rowNames = FALSE)
write.xlsx(consultaxy_invalido_xy, file = "C:/Users/User/Documents/VIOLENCIA_ESCOLAR/consultaxy_invalido_xy.xlsx", dec = ",", rowNames = FALSE)


ggmap(mapa_mg2,
      base_layer = ggplot(aes(Longitude, Latitude), data= ocorrencias_filtradas_comxy))+
  geom_point()
#para os consultaxy utilizar lon e lat

consultaxy_invalido_comxy<- cbind(consultaxy_invalido, consultaxy_invalido_xy)

consultaxy_valido<- cbind(consultaxy_valido, consultaxy_valido_xy)

consultar_enderecos_atualizado <- consultar_enderecos %>%
  left_join(consultaxy_valido %>%
              select(`Logradouro OcorrÍncia`, lat, lon), by = "Logradouro OcorrÍncia") %>%
  left_join(consultaxy_invalido %>%
              select(`Logradouro OcorrÍncia`, lat, lon), by = "Logradouro OcorrÍncia", suffix = c("", ".invalido"))
warnings()