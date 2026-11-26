import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';

/// Coloca campos lado a lado e os empilha automaticamente
/// quando a largura disponível fica pequena demais.
class LinhaFormulario extends StatelessWidget {
  const LinhaFormulario({
    super.key,
    required this.children,
    this.flex,
    this.larguraMinima = 300,
  });

  final List<Widget> children;

  /// Proporção de cada coluna (ex.: [3, 2]). Padrão: colunas iguais.
  final List<int>? flex;

  /// Abaixo desta largura os campos ficam um embaixo do outro.
  final double larguraMinima;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < larguraMinima) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  if (i > 0) const SizedBox(height: AppSpacing.md),
                  children[i],
                ],
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(width: AppSpacing.md),
                Expanded(flex: flex?[i] ?? 1, child: children[i]),
              ],
            ],
          );
        },
      );
}
