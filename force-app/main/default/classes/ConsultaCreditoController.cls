public with sharing class ConsultaCreditoController {
    //Chamada do método para iniciar a consulta de crédito
    @AuraEnabled
    public static void iniciarConsultaDeCredito(Id leadId) {
        Lead lead = [SELECT Id, Name, CNPJ__c, ConsultaCredito__c FROM Lead WHERE Id =: leadId];

        //Verifica se já foi iniciada a consulta de crédito
        if (lead.ConsultaCredito__c != null) {
            System.debug('A consulta de crédito já foi iniciada para este lead.');
            return;
        }
        
        //Seta o campo ConsultaCredito__c com o valor "Iniciada"
        lead.ConsultaCredito__c = 'Iniciada';
        update lead;
        
        //Executa o post na CorleoneAPI para início da análise
        //ConsultaCredito.solicitarAnaliseDeRisco(lead.CNPJ__c);

        //Agendamento do job que realiza a chamada para o método de retorno da consulta de crédito
        String jobId = System.schedule('Consulta de Crédito para Lead: ' + lead.Name, 
                                    '* /5 * * * * ?', 
                                        new ConsultaCreditoScheduledJob(leadId));
        System.debug('Job ID: ' + jobId);
    }

    //Método que recebe o resultado da consulta de crédito de uma forma assíncrona
    @future
    public static void atualizarConsultaDeCredito(Id leadId) {
        Lead lead = [SELECT Id, Name, CNPJ__c, ConsultaCredito__c FROM Lead WHERE Id =: leadId];
        
        //Verifica se a consulta de crédito já foi iniciada
        if (lead.ConsultaCredito__c == null || lead.ConsultaCredito__c != 'Iniciada') {
            System.debug('Não é possível atualizar o campo de Consulta de Crédito. A consulta de crédito não foi iniciada.');
            return;
        }
        
        //Chamada à CorleoneAPI para obter o resultado da consulta de crédito
        Boolean creditoAprovado = ConsultaCredito.getAnaliseDeRisco(lead.CNPJ__c);
        
        //Atualiza o campo ConsultaCredito__c com o resultado da consulta de crédito
        if (creditoAprovado) {
            lead.ConsultaCredito__c = 'Aprovado';
        } else {
            lead.ConsultaCredito__c = 'Reprovado';
        }
        update lead;


    }
}