import 'tipo_criatorio.dart';

/// Unidade produtiva: um apiário ou um meliponário.
class Criatorio {
  const Criatorio({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.localizacao,
    required this.municipio,
    required this.estado,
    this.descricao = '',
    this.observacoes = '',
  });

  final String id;
  final String nome;
  final TipoCriatorio tipo;
  final String localizacao;
  final String municipio;
  final String estado;
  final String descricao;
  final String observacoes;

  /// "São Luís - MA"
  String get cidadeUf => '$municipio - $estado';

  /// Nome sem o prefixo do tipo: "Apiário São José" → "São José".
  String get nomeCurto {
    final prefixo = '${tipo.nome} ';
    return nome.startsWith(prefixo) ? nome.substring(prefixo.length) : nome;
  }
}
