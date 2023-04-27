public class ConsultaCreditoMock {
    public static String solicitarAnaliseDeRisco(String CNPJ) {
        return 'mock_request_id'; // Retorna uma string fixa como identificador de requisição
    }

    public static Boolean getAnaliseDeRisco(String requestId) {
        return true; // Retorna sempre "true" como resultado da análise de crédito
    }
}
