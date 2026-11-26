/// Tipo de criatório. Concentra os textos e opções que mudam entre
/// apiário (abelhas Apis) e meliponário (abelhas sem ferrão), evitando
/// telas duplicadas para cada tipo.
enum TipoCriatorio {
  apiario(
    nome: 'Apiário',
    descricao: 'Criação de abelhas do gênero Apis',
    subtitulo: 'Abelhas do gênero Apis',
    resumo: 'Apiário • Apis',
    sufixo: 'Apis',
    abelhas: 'Abelhas Apis',
    tituloColonia: 'Colônia de Apis',
    tituloDados: 'Dados do apiário',
    tituloRevisao: 'Avaliação de colmeia Apis',
    tituloManejo: 'Manejo para abelhas Apis',
    prefixoColonia: 'A',
    especies: ['Apis mellifera', 'Apis mellifera ligustica', 'Apis mellifera carnica'],
    tiposCaixa: ['Langstroth', 'Schenk', 'Top bar'],
    tiposManejo: [
      'Alimentação', 'Inspeção', 'Adição de melgueira', 'Retirada de melgueira',
      'Colheita', 'Troca de rainha', 'Divisão', 'União', 'Controle sanitário', 'Outro',
    ],
  ),
  meliponario(
    nome: 'Meliponário',
    descricao: 'Criação de abelhas sem ferrão',
    subtitulo: 'Abelhas sem ferrão',
    resumo: 'Meliponário • sem ferrão',
    sufixo: 'sem ferrão',
    abelhas: 'Abelhas sem ferrão',
    tituloColonia: 'Colônia de abelhas sem ferrão',
    tituloDados: 'Dados do meliponário',
    tituloRevisao: 'Avaliação de ninho sem ferrão',
    tituloManejo: 'Manejo para abelhas sem ferrão',
    prefixoColonia: 'M',
    especies: ['Jataí', 'Uruçu', 'Mandaçaia', 'Tiúba', 'Manduri'],
    tiposCaixa: ['INPA', 'Nordestina', 'Fernando Oliveira'],
    tiposManejo: [
      'Alimentação', 'Divisão', 'Multiplicação', 'Transferência', 'Troca de caixa',
      'Resgate', 'Formação de colônia', 'Manejo do ninho', 'Colheita',
      'Controle sanitário', 'Outro',
    ],
  );

  const TipoCriatorio({
    required this.nome,
    required this.descricao,
    required this.subtitulo,
    required this.resumo,
    required this.sufixo,
    required this.abelhas,
    required this.tituloColonia,
    required this.tituloDados,
    required this.tituloRevisao,
    required this.tituloManejo,
    required this.prefixoColonia,
    required this.especies,
    required this.tiposCaixa,
    required this.tiposManejo,
  });

  final String nome;
  final String descricao;
  final String subtitulo;
  final String resumo;
  final String sufixo;
  final String abelhas;
  final String tituloColonia;
  final String tituloDados;
  final String tituloRevisao;
  final String tituloManejo;
  final String prefixoColonia;
  final List<String> especies;
  final List<String> tiposCaixa;
  final List<String> tiposManejo;

  String get nomeMaiusculo => nome.toUpperCase();
}
