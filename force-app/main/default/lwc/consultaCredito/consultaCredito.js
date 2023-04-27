import { LightningElement, api, wire } from 'lwc';
import iniciarConsultaDeCredito from '@salesforce/apex/ConsultaCreditoController.iniciarConsultaDeCredito';

export default class ConsultaCredito extends LightningElement {
    @api recordId; // Id do registro do Lead

    iniciarConsultaDeCredito() {
        iniciarConsultaDeCredito({ leadId: this.recordId })
        .then(result => {
            console.log('Consulta de crédito iniciada com sucesso:', result);
            // Exibir mensagem de sucesso ou redirecionar para outra página
            alert('Consulta de crédito iniciada com sucesso:');
        })
        .catch(error => {
            console.error('Erro ao iniciar consulta de crédito:', error);
            // Exibir mensagem de erro ou redirecionar para outra página de erro
            alert('Erro ao iniciar consulta de crédito:');
        });
    }
}
