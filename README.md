# Projeto: Efeito de Vizinhança — Geocodificação e Filtragem de Ocorrências (2019–2023)

Este diretório reúne dois scripts centrais utilizados na etapa preliminar do projeto **Efeitos de Vizinhança e Resultados Escolares**, que investiga a relação entre ambiente territorial, exposição à violência e desempenho educacional.  

Os códigos desta pasta têm como foco o processamento das ocorrências policiais registradas no **REDS (Registro de Eventos de Defesa Social)** entre **2019 e 2023**, incluindo filtragem de crimes relevantes, validação de endereços e geocodificação.

---

#  1. **Script: Georreferenciamento das Ocorrências**

###  Objetivo
Geocodificar ocorrências selecionadas do REDS que não possuíam coordenadas XY, utilizando combinações de logradouro + número + bairro. A etapa é essencial para análises espaciais e posterior vinculação das ocorrências às escolas e áreas de vizinhança.

### Escopo
- Período: **01/2019 a 10/2023**
- Crimes analisados:  
  Homicídio, Lesão Corporal, Estupro, Estupro de Vulnerável, Agressão, Crimes com arma de fogo, Drogas (uso, tráfico, associação), entre outros.

### Etapas principais
1. **Importação da base “consultar_endereços”** (ocorrências sem XY).
2. Criação de variável de endereço completo no padrão da Google API.
3. Separação entre:
   - endereços válidos,
   - endereços não cadastrados,
   - endereços inválidos.
4. **Uso da API do Google Maps via `ggmap::geocode()`** para localizar:
   - Latitude,
   - Longitude.
5. Visualização dos pontos em mapas base (satélite e roadmap).
6. Exportação de:
   - ocorrências com coordenadas geocodificadas,
   - ocorrências inválidas para tratamento manual.

### Saídas geradas
- `consultaxy_valido.xlsx`
- `consultaxy_valido_xy.xlsx`
- `consultaxy_invalido.xlsx`
- `consultaxy_invalido_xy.xlsx`
- `consultar_enderecos_atualizado.xlsx`

---

# 2. **Script: Filtragem, Unificação e Classificação das Ocorrências (2019–2023)**

###  Objetivo
Selecionar, padronizar e consolidar todas as ocorrências do REDS referentes aos crimes definidos pelo projeto, para criar a base-mãe do estudo.  

Inclui também a identificação de registros:
- com coordenadas válidas,
- sem coordenadas (e com potencial de geocodificação),
- completamente inválidos.

###  Etapas principais

#### **1. Leitura dos arquivos brutos (2019–2023)**
Os dados são divididos em múltiplos arquivos por ano e semestre.  
O script:
- padroniza tipos de variáveis,
- automatiza a abertura com a função `abre_tabela()`.

#### **2. Consolidação anual**
Todos os arquivos são unidos com `bind_rows()` para formar:
- `Ocorrencias_2019`, ... , `Ocorrencias_2023`.

#### **3. Filtragem dos crimes de interesse**
A função `sub_nat_principal()` mantém apenas as naturezas principais relevantes.

Resultado total:  
**116.089 ocorrências** com as categorias de interesse.

#### **4. Classificação quanto à localização**
- **Com XY:** `ocorrencias_filtradas_comxy`  
  (106.384 registros)

- **Sem XY mas com endereço válido:** `consultar_enderecos`  
  (9.257 registros — enviados para geocodificação)

- **Completamente inválidos:**  
  Endereço inexistente + sem complemento  
  (24 registros — excluídos da análise)

#### **5. Geração de tabelas de frequência**
Tabulações das naturezas principais para:
- casos válidos,
- casos sem XY,
- casos totalmente inválidos.

### Saídas geradas
- `ocorrencias_filtradas_comxy.xlsx`
- `consultar_endereços.xlsx`
- `ocorrencias_invalidas.xlsx`
- tabelas de frequências (% por tipo de crime)

---

# **Resumo Geral da Pasta**

Esta pasta contém a pipeline inicial do projeto **Efeito de Vizinhança**, composta por:

✔ Filtragem dos crimes relevantes (2019–2023)  
✔ Padronização e unificação das bases originais do REDS  
✔ Identificação de registros com e sem coordenadas  
✔ Preparação dos endereços para geocodificação  
✔ Consulta à API do Google Maps  
✔ Exportação das bases geocodificadas e inválidas  
✔ Preparação das bases para análise espacial no QGIS e R  

---

# 👩‍💻 Autoria
**Júlia Rodrigues Gontijo**  
Núcleo de Pesquisa em Desigualdades Escolares (NUPEDE)
03/08/2024

---
