# README - Teste de Web Scraping e Processamento de Dados

## Visão Geral
Este projeto tem como objetivo realizar o web scraping para download dos Anexos I e II em formato PDF do site da Agência Nacional de Saúde Suplementar (ANS), extrair informações relevantes desses arquivos, transformar os dados em um formato estruturado (CSV) e compactá-los para armazenamento.

## Tecnologias Utilizadas
- **Python**: Linguagem principal utilizada no projeto.
- **Requests**: Para fazer requisições HTTP e obter conteúdo do site.
- **BeautifulSoup**: Para realizar o parsing do HTML e extrair links.
- **pdfplumber**: Para extrair tabelas dos arquivos PDF.
- **pandas**: Para manipulação e transformação dos dados extraídos.
- **zipfile**: Para compactação dos arquivos resultantes.

## Estrutura do Projeto
```
/
|-- script.py            # Código principal
|-- README.md            # Este arquivo explicativo
|-- anexos.zip           # Arquivo ZIP contendo os PDFs baixados (gerado pelo script)
|-- rol_procedimentos.csv  # Arquivo CSV gerado a partir dos PDFs
|-- Teste_Milena.zip     # Arquivo ZIP contendo o CSV compactado
```

## Requisitos
Antes de executar o script, certifique-se de ter instalado os seguintes pacotes Python:
```sh
pip install requests beautifulsoup4 pdfplumber pandas
```

## Como Executar

### 1. Download dos PDFs
O script acessa o site da ANS e busca pelos links dos arquivos PDF (Anexos I e II). Em seguida, realiza o download e os salva na pasta local.

### 2. Compactação dos PDFs
Todos os arquivos PDF baixados são compactados no arquivo `anexos.zip`.

### 3. Extração e Processamento dos Dados
O script:
- Abre o PDF do Anexo I usando `pdfplumber`.
- Extrai tabelas de cada página.
- Organiza os dados em um DataFrame do `pandas`.
- Substitui abreviações por descrições completas (exemplo: "OD" -> "Odontologia").
- Salva o DataFrame em um arquivo CSV (`rol_procedimentos.csv`).

### 4. Compactação do Arquivo CSV
O arquivo CSV gerado é compactado no `Teste_Milena.zip`.

## Possíveis Melhorias
- Criar um script de logging para registrar as etapas do processo.
- Melhorar a filtragem dos PDFs antes do download.
- Adicionar tratamento de erros para downloads e extração de dados.
- Automatizar a execução periódica do script.

## Contribuição
Se desejar contribuir com melhorias, faça um fork do repositório, implemente as modificações e envie um pull request.

## Autor
- **Milena Calasans**

## Licença
Este projeto é distribuído sob a licença MIT.

