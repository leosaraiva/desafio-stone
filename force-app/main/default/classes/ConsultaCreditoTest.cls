@isTest
public class ConsultaCreditoTest {
    @isTest
    static void testAnaliseDeRisco() {
        // Substitui a chamada à classe ConsultaCredito por ConsultaCreditoMock
        String requestId = ConsultaCreditoMock.solicitarAnaliseDeRisco('12.345.678/0001-10');
        Boolean resultado = ConsultaCreditoMock.getAnaliseDeRisco(requestId);

        System.assertEquals(true, resultado);
    }
}
