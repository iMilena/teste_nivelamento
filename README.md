# Teste de Web Scraping e Processamento de Dados

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
  
# API de Consulta de Operadoras de Saúde

Este projeto consiste em uma API desenvolvida em FastAPI para consulta de operadoras de saúde, utilizando um banco de dados MySQL. A API permite buscar operadoras por nome ou razão social e importar dados financeiros de operadoras a partir de arquivos CSV.

📌 Tecnologias Utilizadas

- Python (FastAPI, Pydantic, PyMySQL)
- MySQL
- Postman (para testes de API)

🚀 Instalação e Configuração

1️⃣ Clonar o repositório
```
$ git clone <URL_DO_REPOSITORIO>
$ cd <NOME_DO_DIRETORIO>
```
2️⃣ Criar e ativar ambiente virtual (opcional, mas recomendado)
```
$ python -m venv venv
$ source venv/bin/activate   # No Windows: venv\Scripts\activate
```
3️⃣ Instalar dependências
```
$ pip install -r requirements.txt
```
4️⃣ Configurar o banco de dados MySQL

Criar o banco de dados e tabelas conforme o script SQL disponibilizado no projeto.
```
CREATE DATABASE db_ans_data;
USE db_ans_data;
```
Executar os demais comandos SQL do script para criação de tabelas e importação de dados.

5️⃣ Configurar a conexão com o banco

No arquivo main.py, ajustar as credenciais do banco de dados conforme necessário:
```
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "SUA_SENHA",
    "database": "db_ans_data",
    "port": 3306
}
```
📡 Executando a API

Para iniciar o servidor FastAPI, utilize o comando:
```
$ uvicorn main:app --reload
```
O servidor estará disponível em http://127.0.0.1:8000.

📌 Endpoints da API

🔍 Buscar Operadora
```
Rota: GET /buscar_operadora?nome=<NOME>
```
Descrição: Retorna uma lista de operadoras com base no nome ou razão social.

Exemplo de Requisição:
```
GET http://127.0.0.1:8000/buscar_operadora?nome=Unimed
```
Exemplo de Resposta:
```
[
    {
        "registro_ans": 12345,
        "cnpj": "12.345.678/0001-99",
        "razao_social": "Unimed Brasil",
        "nome_fantasia": "Unimed",
        "modalidade": "Cooperativa",
        "logradouro": "Rua A",
        "numero": "123",
        "bairro": "Centro",
        "cidade": "São Paulo",
        "uf": "SP",
        "cep": "01000-000",
        "ddd": "11",
        "telefone": "4002-8922",
        "representante": "João Silva",
        "cargo_representante": "Diretor",
        "data_registro": "2024-01-01"
    }
]
```
🔍 Teste de Conexão

Rota: GET /

Descrição: Verifica se a API está conectada ao banco de dados.

Resposta esperada:
```
{
    "message": "API conectada ao banco!"
}
```
🛠 Testando com Postman

Abra o Postman

Crie uma nova requisição GET
```
Insira a URL http://127.0.0.1:8000/buscar_operadora?nome=Unimed
```
Clique em Send e verifique a resposta.

📂 Estrutura do Projeto
```
.
├── main.py         # Código principal da API
├── requirements.txt # Dependências do projeto
├── db_script.sql   # Script de criação do banco e tabelas
└── README.md       # Documentação do projeto
```
✨ Melhorias Futuras

- Criar novos endpoints para consulta de transações financeiras
- Implementar autenticação e autorização
- Criar testes automatizados

# Banco de Dados ANS Data

Visão Geral

Este projeto configura e popula um banco de dados MySQL para armazenar informações sobre operadoras de planos de saúde e suas transações financeiras. Ele inclui a criação do banco de dados, tabelas, importação de dados de arquivos CSV e consultas SQL para análise das despesas das operadoras.

## Requisitos

- MySQL Server 8.0 ou superior
- Acesso ao diretório C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ para importação de arquivos CSV
- Arquivos CSV com os dados necessários

## Configuração

1. Ajustando o tempo de timeout do servidor

Antes de executar os scripts, aumente o tempo limite do MySQL para evitar desconexões durante operações demoradas:
```
SET GLOBAL net_read_timeout = 600;
SET GLOBAL net_write_timeout = 600;
SET GLOBAL wait_timeout = 600;
```
2. Criando o banco de dados e tabelas

Execute os seguintes comandos para criar o banco de dados e suas tabelas:
```
CREATE DATABASE db_ans_data;
USE db_ans_data;

Tabela tb_operadoras
```
Esta tabela armazena informações sobre operadoras de planos de saúde, incluindo CNPJ, razão social, endereço e outros dados relevantes.
```
CREATE TABLE tb_operadoras (
    registro_ans INT PRIMARY KEY,
    cnpj VARCHAR(20),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(255),
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(255),
    bairro VARCHAR(255),
    cidade VARCHAR(255),
    uf CHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(3),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(255),
    regiao_comercializacao INT NULL,
    data_registro DATE
);

Tabela tb_transacoes_financeiras
```
Registra transações financeiras das operadoras, como saldos iniciais e finais por trimestre e ano.
```
CREATE TABLE tb_transacoes_financeiras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    registro_ans INT NOT NULL,
    cd_conta_contabil VARCHAR(20) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    vl_saldo_inicial DECIMAL(15,2) NOT NULL,
    vl_saldo_final DECIMAL(15,2) NOT NULL,
    trimestre TINYINT NOT NULL,
    ano SMALLINT NOT NULL,
    FOREIGN KEY (registro_ans) REFERENCES tb_operadoras(registro_ans)
);
```
Importação de Dados

Para importar dados dos arquivos CSV, habilite o carregamento local:
```
SET GLOBAL local_infile = 1;
```
Importando tb_operadoras
```
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Relatorio_cadop.csv'
INTO TABLE tb_operadoras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, numero, complemento, bairro, cidade, uf, cep, ddd, telefone, fax, endereco_eletronico, representante, cargo_representante, @regiao_comercializacao, data_registro)
SET regiao_comercializacao = NULLIF(@regiao_comercializacao, '');
```
Importando tb_transacoes_financeiras

Antes de importar, desative temporariamente as verificações de chave estrangeira:
```
SET FOREIGN_KEY_CHECKS = 0;
```
Exemplo de importação para um trimestre:
```
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/demonstracoes_contabeis2024/1T2024.csv'
INTO TABLE tb_transacoes_financeiras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.'),
    trimestre = 1,
    ano = 2024;
```
Após importar todos os arquivos, reative as verificações:
```
SET FOREIGN_KEY_CHECKS = 1;
```
Consultas SQL

1. Operadoras com maiores despesas no 4º trimestre de 2024
```
SELECT
    tf.registro_ans,
    op.razao_social,
    SUM(tf.vl_saldo_final) AS total_despesas
FROM tb_transacoes_financeiras tf
JOIN tb_operadoras op ON tf.registro_ans = op.registro_ans
WHERE
    tf.descricao = "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR "
    AND tf.trimestre = 4
    AND tf.ano = 2024
GROUP BY tf.registro_ans, op.razao_social
ORDER BY total_despesas DESC
LIMIT 10;
```
2. Operadoras com maiores despesas no ano de 2024
```
SELECT
    tf.registro_ans,
    op.razao_social,
    SUM(tf.vl_saldo_final) AS total_despesas
FROM tb_transacoes_financeiras tf
JOIN tb_operadoras op ON tf.registro_ans = op.registro_ans
WHERE
    tf.descricao = "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR "
    AND tf.ano = 2024
GROUP BY tf.registro_ans, op.razao_social
ORDER BY total_despesas DESC
LIMIT 10;
```
## Notas Adicionais

- Certifique-se de que os arquivos CSV estão no caminho correto e seguem o formato esperado.
- Se houver erros de importação, verifique os separadores de campo e formato de data.
- O wait_timeout foi aumentado para evitar desconexões durante cargas de dados grandes.
  
## Contribuição
Se desejar contribuir com melhorias, faça um fork do repositório, implemente as modificações e envie um pull request.

## Autor
- **Milena Calasans**

## Licença
Este projeto é distribuído sob a licença MIT.

