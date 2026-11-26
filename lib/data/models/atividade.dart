enum TipoAtividade { revisao, manejo }

/// Registro do histórico de uma colônia (revisão ou manejo).
class Atividade {
  const Atividade({
    required this.id,
    required this.coloniaId,
    required this.tipo,
    required this.titulo,
    required this.descricao,
    required this.data,
  });

  final String id;
  final String coloniaId;
  final TipoAtividade tipo;

  /// "Revisão", "Alimentação", "Divisão"...
  final String titulo;

  /// "Força forte • Rainha presente", "2 litros de xarope"...
  final String descricao;
  final DateTime data;

  String get etiqueta => tipo == TipoAtividade.revisao ? 'Normal' : 'Manejo';
}
