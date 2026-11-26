/// Listas de opções compartilhadas pelos formulários de colônia,
/// revisão e manejo.
abstract final class OpcoesFormulario {
  static const simNao = ['Sim', 'Não'];
  static const forcas = ['Forte', 'Média', 'Fraca'];
  static const origens = ['Divisão', 'Enxame capturado', 'Compra', 'Resgate', 'Doação'];
  static const situacaoCria = ['Normal', 'Pouca cria', 'Sem cria', 'Cria irregular'];
  static const disponibilidadeAlimento = ['Boa', 'Regular', 'Baixa'];
  static const alimentoApiario = ['Suficiente', 'Regular', 'Escasso'];
  static const estadoColmeia = ['Boa conservação', 'Precisa de reparo', 'Danificada'];
  static const condicaoNinho = [
    'Organizado e saudável',
    'Saudável',
    'Precisa de alimento',
    'Com pragas',
  ];
  static const condicaoEntrada = ['Livre', 'Parcialmente obstruída', 'Obstruída'];
  static const responsaveis = ['João Silva', 'Maria Souza', 'Equipe IFMA'];
}
