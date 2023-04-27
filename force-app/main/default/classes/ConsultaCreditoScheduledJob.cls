public with sharing class ConsultaCreditoScheduledJob implements System.Schedulable {

    private Id leadId;
    
    public ConsultaCreditoScheduledJob(Id leadId) {
        this.leadId = leadId;
    }
    
    public void execute(SchedulableContext sc) {
        // Chama o método para atualizar a análise de crédito
        ConsultaCreditoController.atualizarConsultaDeCredito(leadId);
    }
    }