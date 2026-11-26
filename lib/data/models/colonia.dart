enum StatusColonia {
  ativa('Ativa'),
  atencao('Atenção'),
  problema('Problema'),
  inativa('Inativa');

  const StatusColonia(this.rotulo);
  final String rotulo;
}

/// Colônia (colmeia ou ninho) pertencente a um criatório.
class Colonia {
  const Colonia({
    required this.id,
    required this.criatorioId,
    required this.identificacao,
    required this.especie,
    required this.tipoCaixa,
    required this.origem,
    required this.dataInstalacao,
    required this.status,
    required this.forca,
    required this.presencaRainha,
    this.detalhes = const {},
    this.ultimaRevisao,
  });

  final String id;
  final String criatorioId;
  final String identificacao;
  final String especie;
  final String tipoCaixa;
  final String origem;
  final DateTime dataInstalacao;
  final StatusColonia status;
  final String forca;
  final String presencaRainha;

  /// Campos específicos do tipo (quadros de cria, discos de cria, potes...).
  final Map<String, String> detalhes;
  final DateTime? ultimaRevisao;

  Colonia copyWith({
    StatusColonia? status,
    String? forca,
    String? presencaRainha,
    Map<String, String>? detalhes,
    DateTime? ultimaRevisao,
  }) =>
      Colonia(
        id: id,
        criatorioId: criatorioId,
        identificacao: identificacao,
        especie: especie,
        tipoCaixa: tipoCaixa,
        origem: origem,
        dataInstalacao: dataInstalacao,
        status: status ?? this.status,
        forca: forca ?? this.forca,
        presencaRainha: presencaRainha ?? this.presencaRainha,
        detalhes: detalhes ?? this.detalhes,
        ultimaRevisao: ultimaRevisao ?? this.ultimaRevisao,
      );
}
