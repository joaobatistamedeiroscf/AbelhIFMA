import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../data/models/models.dart';
import '../../../shared/widgets/widgets.dart';

/// Busca de criatórios por nome ou município.
class BuscaCriatorioDelegate extends SearchDelegate<Criatorio?> {
  BuscaCriatorioDelegate(this.criatorios, {required this.totalColonias})
      : super(searchFieldLabel: 'Buscar por nome ou município');

  final List<Criatorio> criatorios;

  /// Quantidade de colônias de cada criatório (pelo id).
  final int Function(String criatorioId) totalColonias;

  List<Criatorio> get _resultados {
    final termo = query.trim().toLowerCase();
    if (termo.isEmpty) return criatorios;
    return criatorios
        .where((c) =>
            c.nome.toLowerCase().contains(termo) ||
            c.municipio.toLowerCase().contains(termo))
        .toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
        if (query.isNotEmpty)
          IconButton(
            tooltip: 'Limpar',
            icon: const Icon(Icons.close),
            onPressed: () => query = '',
          ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        tooltip: 'Voltar',
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _lista(context);

  @override
  Widget buildSuggestions(BuildContext context) => _lista(context);

  Widget _lista(BuildContext context) {
    final resultados = _resultados;
    if (resultados.isEmpty) {
      return const EmptyState(
        icone: Icons.search_off,
        titulo: 'Nada encontrado',
        mensagem: 'Tente buscar por outro nome ou município.',
      );
    }
    return PageBody(
      espacamento: AppSpacing.md,
      children: [
        for (final c in resultados)
          CriatorioCard(
            criatorio: c,
            totalColonias: totalColonias(c.id),
            onTap: () => close(context, c),
          ),
      ],
    );
  }
}
