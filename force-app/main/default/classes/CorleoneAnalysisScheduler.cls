global class CorleoneAnalysisScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        // Verificar se o campo do identificador foi modificado em um objeto específico
        List<Lead> objetosAtualizados = [SELECT Id, Cnpj__c FROM Lead WHERE Cnpj__c != null AND LastModifiedDate >= :System.now().addMinutes(-5)];
        
        for (Lead objeto : objetosAtualizados) {
            // Aguardar 5 minutos
            Datetime scheduledTime = System.now().addMinutes(5);
            
            // Agendar a chamada do método getAnaliseDeRisco da classe CorleoneAPI
            CorleoneAnalysisSchedulerWrapper wrapper = new CorleoneAnalysisSchedulerWrapper();
            wrapper.requestId = objeto.CNPJ__c;
            String jobId = System.schedule('Get Corleone Analysis Result - ' + objeto.Id, 
                                            '0 ' + scheduledTime.minute() + ' ' + scheduledTime.hour() + ' ' + scheduledTime.day() + ' ' + scheduledTime.month() + ' ?', 
                                            wrapper);
            System.debug('Job ID: ' + jobId);
        }
    }
    
    global class CorleoneAnalysisSchedulerWrapper implements System.Schedulable {
        
        public String requestId;
        
        global void execute(SchedulableContext sc) {
            // Chamar o método getAnaliseDeRisco da classe CorleoneAPI com o requestId obtido do objeto atualizado
            Boolean analysisResult = CorleoneAPI.getAnaliseDeRisco(requestId);
        }
    }
}