from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import pymysql
from pymysql.cursors import DictCursor  # Importando o DictCursor

# Configuração da conexão com o banco
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "milena092a",
    "database": "db_ans_data",
    "port": 3306
}

# Função para conectar ao banco
def get_db_connection():
    conn = pymysql.connect(**DB_CONFIG)
    return conn

# rodando backend
app = FastAPI()

# Configurações de CORS
origins = ["http://localhost:8080"] # URL do seu frontend

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # Permite requisições do frontend
    allow_credentials=True, # Permite o acesso sem credenciais
    allow_methods=["*"],  # Permite todos os métodos HTTP
    allow_headers=["*"],  # Permite todos os cabeçalhos
)

# Modelo de dados para resposta
class Operadora(BaseModel):
    registro_ans: int
    cnpj: str
    razao_social: str
    nome_fantasia: Optional[str]
    modalidade: str
    logradouro: str
    numero: str
    complemento: Optional[str]
    bairro: str
    cidade: str
    uf: str
    cep: str
    ddd: str
    telefone: Optional[str]
    fax: Optional[str]
    endereco_eletronico: Optional[str]
    representante: str
    cargo_representante: str
    regiao_comercializacao: Optional[int]
    data_registro: str

    @classmethod
    def from_db(cls, db_row):
        db_row['data_registro'] = db_row['data_registro'].strftime('%Y-%m-%d')  # Convertendo a data
        return cls(**db_row)

# Endpoint para buscar operadoras por nome_fantasia ou razao_social
@app.get("/buscar_operadora", response_model=List[Operadora])
async def buscar_operadora(nome: str):
    conn = get_db_connection()
    cursor = conn.cursor(cursor=DictCursor)  # Usando o DictCursor explicitamente

    query = """
    SELECT registro_ans, cnpj, razao_social, 
           COALESCE(nome_fantasia, razao_social) AS nome_fantasia,
           modalidade, logradouro, numero, complemento, bairro, cidade, uf, cep, 
           ddd, telefone, fax, endereco_eletronico, representante, cargo_representante, 
           regiao_comercializacao, data_registro
    FROM tb_operadoras
    WHERE nome_fantasia LIKE %s OR razao_social LIKE %s
    ORDER BY CHAR_LENGTH(nome_fantasia), nome_fantasia
    """
    
    # Passando o parâmetro nome para ambos os placeholders
    cursor.execute(query, (f"%{nome}%", f"%{nome}%"))
    resultados = cursor.fetchall()

    cursor.close()
    conn.close()

    return [Operadora.from_db(row) for row in resultados]

@app.get("/")
async def root():
    conn = get_db_connection()
    conn.close()
    return {"message": "API conectada ao banco!"}