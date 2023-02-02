
String statusAgendamento(String status) {
  switch(status) {
    case 'P':
      return 'Pendente';
    case 'CN':
      return 'Confirmada';
    case 'F':
      return 'Finalizada';
    case 'C':
      return 'Cancelada';
    default: 
     return '';
  }
}