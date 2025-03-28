<template>
  <div>
    <h1>Operadoras</h1>
    <input v-model="nome" placeholder="Buscar operadora">
    <button @click="buscarOperadoras">Buscar</button>
    
    <ul>
      <li v-for="operadora in operadoras" :key="operadora.registro_ans">
        <p><strong>Razão Social:</strong> {{ operadora.razao_social }}</p>
        <p><strong>CNPJ:</strong> {{ operadora.cnpj }}</p>
        <p><strong>Data de Registro:</strong> {{ operadora.data_registro }}</p>
        <hr>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'OperadorasLista',
  data() {
    return {
      nome: '', // Armazena o nome digitado
      operadoras: [] // Armazena as operadoras retornadas
    };
  },
  methods: {
    // Função para fazer a requisição
    async buscarOperadoras() {
      try {
        const response = await axios.get('http://localhost:8000/buscar_operadora', {
          params: {
            nome: this.nome
          }
        });
        this.operadoras = response.data; // Armazena os dados recebidos
      } catch (error) {
        console.error("Erro ao buscar operadoras:", error);
      }
    }
  }
};
</script>

<style scoped>
/* Adicione seu estilo aqui */
</style>
