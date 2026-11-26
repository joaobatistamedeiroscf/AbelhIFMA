import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';

/// Grade que calcula o número de colunas pela largura disponível.
///
/// No celular normalmente fica com 1 coluna (lista) e em telas largas
/// distribui os itens em 2 ou mais colunas, sem alterar as telas.
class GradeResponsiva extends StatelessWidget {
  const GradeResponsiva({
    super.key,
    required this.children,
    this.larguraMinimaItem = 300,
    this.maxColunas = 3,
    this.espacamento = AppSpacing.md,
  });

  final List<Widget> children;
  final double larguraMinimaItem;
  final int maxColunas;
  final double espacamento;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final largura = constraints.maxWidth;
          final colunas = ((largura + espacamento) / (larguraMinimaItem + espacamento))
              .floor()
              .clamp(1, maxColunas)
              .toInt();
          final larguraItem =
              ((largura - espacamento * (colunas - 1)) / colunas).floorToDouble();
          return Wrap(
            spacing: espacamento,
            runSpacing: espacamento,
            children: [
              for (final filho in children) SizedBox(width: larguraItem, child: filho),
            ],
          );
        },
      );
}
