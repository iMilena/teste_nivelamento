-- Aumentando o tempo de timeout no servidor MySQL
SET GLOBAL net_read_timeout = 600; -- 10 min
SET GLOBAL net_write_timeout = 600; -- 10 min
SET GLOBAL wait_timeout = 600; -- 10 min

-- Criando banco
CREATE DATABASE db_ans_data;
SHOW DATABASES;
USE db_ans_data;

-- Criando a tabela de operadoras
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
-- Criando a tabela de transações financeiras
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
-- Mostrando tabelas
SHOW TABLES;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
-- ---------------------- Importanto dados do CSV para a tabela tb_operadoras ----------------------

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Relatorio_cadop.csv'
INTO TABLE tb_operadoras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, numero, complemento, bairro, cidade, uf, cep, ddd, telefone, fax, endereco_eletronico, representante, cargo_representante,
 @regiao_comercializacao, data_registro)
SET regiao_comercializacao = NULLIF(@regiao_comercializacao, '');

-- Verificar tabela
SELECT * FROM db_ans_data.tb_operadoras;

-- ---------------------- Importanto dados do CSV para a tabela tb_transacoes_financeiras ----------------------

-- Remove verificação da chave secundaria
SET FOREIGN_KEY_CHECKS = 0;

-- Importanto dados do CSV 1T2024
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
-- Importanto dados do CSV 2T2024
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/demonstracoes_contabeis2024/2T2024.csv'
INTO TABLE tb_transacoes_financeiras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.'),
    trimestre = 2,
    ano = 2024;
-- Importanto dados do CSV 3T2024
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/demonstracoes_contabeis2024/3T2024.csv'
INTO TABLE tb_transacoes_financeiras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.'),
    trimestre = 3,
    ano = 2024;
-- Importanto dados do CSV 4T2024
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/demonstracoes_contabeis2024/4T2024.csv'
INTO TABLE tb_transacoes_financeiras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.'),
    trimestre = 4,
    ano = 2024;
-- Importanto dados do CSV 1T2023
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/demonstracoes_contabeis2023/1T2023.csv'
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
    ano = 2023;
-- Importanto dados do CSV 2T2023
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/demonstracoes_contabeis2023/2T2023.csv'
INTO TABLE tb_transacoes_financeiras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.'),
    trimestre = 2,
    ano = 2023;
-- Importanto dados do CSV 3T2023
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/demonstracoes_contabeis2023/3T2023.csv'
INTO TABLE tb_transacoes_financeiras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.'),
    trimestre = 3,
    ano = 2023;
-- Importanto dados do CSV 4T2023
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/demonstracoes_contabeis2023/4T2023.csv'
INTO TABLE tb_transacoes_financeiras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%d/%m/%Y'),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.'),
    trimestre = 4,
    ano = 2023;

-- ativa verificação da chave secundaria
SET FOREIGN_KEY_CHECKS = 1;

-- Verificar tabela
SELECT * FROM db_ans_data.tb_transacoes_financeiras;

-- ---------------------- Query para as 10 operadoras com maiores despesas no ÚLTIMO TRIMESTRE (4º trimestre de 2024) ----------------------

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

-- ---------------------- Query para as 10 operadoras com maiores despesas no ÚLTIMO ANO (2024) ----------------------

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


