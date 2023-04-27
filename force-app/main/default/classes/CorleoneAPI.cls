public class CorleoneAPI {
    // Endpoint da API do serviço externo Corleone
    private static final String CORLEONE_API_ENDPOINT = 'https://api.corleone.com';

    // Método para solicitar a análise de risco do cliente no serviço externo Corleone
    public static String solicitarAnaliseDeRisco(String CNPJ) {
        // Montar o JSON do corpo da solicitação POST
        Map<String, String> requestBody = new Map<String, String>();
        requestBody.put('CNPJ', CNPJ);
        String requestBodyJSON = JSON.serialize(requestBody);
        
        // Realizar a chamada POST para a API do Corleone
        HttpRequest req = new HttpRequest();
        req.setEndpoint('API_URL');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(requestBodyJSON);
        HttpResponse res = new Http().send(req);
        
        // Verificar a resposta da API
        if (res.getStatusCode() == 200) {
            // Sucesso na chamada POST, obter a chave identificadora da requisição
            String requestId = res.getBody();
            return requestId;
        } else {
            // Tratar erros na chamada POST, por exemplo, lançando uma exceção ou retornando um valor de erro
            throw new CalloutException('Erro na chamada POST para a API do Corleone: ' + res.getStatusCode() + ' - ' + res.getStatus());
        }
    }

    // Método para consultar o resultado da análise de risco do cliente no serviço externo Corleone de forma assíncrona
    public static Boolean getAnaliseDeRisco(String requestId) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(CORLEONE_API_ENDPOINT + '/analise/' + requestId ); // Endpoint para consultar o resultado da análise de risco
        request.setMethod('GET');

        // Enviar a requisição
        HttpResponse response = new Http().send(request);

        // Verificar a resposta da API do serviço Corleone
        if (response.getStatusCode() == 200) { // Verificar o status code da resposta
            // Extrair o resultado da análise de risco da resposta
            String resultado = response.getBody(); // Exemplo: obter o resultado do corpo da resposta

            // Verificar se a análise de crédito foi aprovada ou não
            if (resultado == 'APROVADO') {
                return true;
            } else {
                return false;
            }    
        } else {
            // Tratar erros na consulta do resultado da análise de risco
            System.debug('Erro na consulta do resultado da análise de risco: ' + response.getBody());
            return null; // Ou lançar uma exceção, de acordo com a estratégia de tratamento de erros da sua aplicação
        }
    }
}
