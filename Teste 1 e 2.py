# TESTE DE WEB SCRAPING

## Download dos Anexos I e II em formato PDF

import requests
from bs4 import BeautifulSoup

url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
response = requests.get(url)
soup = BeautifulSoup(response.content, 'html.parser')

pdf_links = []
for link in soup.find_all('a', href=True):
    if 'pdf' in link['href']:
        pdf_links.append(link['href'])

for pdf_link in pdf_links:
    pdf_response = requests.get(pdf_link)
    with open(pdf_link.split('/')[-1], 'wb') as f:
        f.write(pdf_response.content)

## Compactando arquivos

        import zipfile
import os

with zipfile.ZipFile('anexos.zip', 'w') as zipf:
    for pdf in pdf_links:
        zipf.write(pdf.split('/')[-1])

# TESTE DE TRANSFORMAÇÃO DE DADOS

import pdfplumber
import pandas as pd
import zipfile
import os

# Caminho para o PDF do Anexo I
anexo_i_path = r'c:\Estágio\teste_nivelamento\Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf'  

# Lista para armazenar os dados extraídos
dados = []

# Abrindo o PDF
with pdfplumber.open(anexo_i_path) as pdf:
    for page in pdf.pages:
        # Extraindo a tabela da página
        table = page.extract_table()
        if table:
            # Adicionando os dados da tabela à lista
            for row in table[1:]:  # Ignorando o cabeçalho
                dados.append(row)

# Verificando o número de colunas
if dados:
    num_colunas = len(dados[0])
    print(f"Número de colunas encontradas: {num_colunas}")
    # Ajustando os nomes das colunas de acordo com o número de colunas
    colunas = [f'Coluna{i+1}' for i in range(num_colunas)]
else:
    colunas = []

# Convertendo os dados para um DataFrame
df = pd.DataFrame(dados, columns=colunas)

# Substituindo abreviações pelas descrições completas
# Supondo que "OD" é "Odontologia" e "AMB" é "Ambulatório"
df.replace({'Coluna1': {'OD': 'Odontologia', 'AMB': 'Ambulatório'}}, inplace=True)

print("Dados extraídos com substituições:")
print(df.head())  # Exibindo as primeiras linhas do DataFrame

# Salvando os dados em um arquivo CSV
csv_file_path = r'c:\Estágio\teste_nivelamento\rol_procedimentos.csv'
df.to_csv(csv_file_path, index=False, encoding='utf-8')

# Compactando o arquivo CSV em um arquivo ZIP
zip_file_path = r'c:\Estágio\teste_nivelamento\Teste_Milena.zip'
with zipfile.ZipFile(zip_file_path, 'w') as zipf:
    zipf.write(csv_file_path, os.path.basename(csv_file_path))

print(f"Arquivo CSV salvo em: {csv_file_path}")
print(f"Arquivo ZIP criado em: {zip_file_path}")