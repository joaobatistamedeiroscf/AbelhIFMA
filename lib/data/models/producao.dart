/// Registro de colheita (mel, própolis, pólen...).
class Producao {
  const Producao({
    required this.id,
    required this.criatorioId,
    required this.produto,
    required this.quantidade,
    required this.unidade,
    required this.data,
    this.coloniaId,
    this.observacoes = '',
  });

  static const produtos = ['Mel', 'Própolis', 'Pólen', 'Cera', 'Geleia real'];
  static const unidades = ['kg', 'g', 'L', 'ml'];

  final String id;
  final String criatorioId;
  final String? coloniaId;
  final String produto;
  final double quantidade;
  final String unidade;
  final DateTime data;
  final String observacoes;

  /// Quantidade convertida para kg (ou L), usada nos totais.
  double get quantidadeBase => switch (unidade) {
        'g' || 'ml' => quantidade / 1000,
        _ => quantidade,
      };
}
