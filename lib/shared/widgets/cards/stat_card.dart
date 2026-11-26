import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/tom_visual.dart';

/// Indicador numérico ("27 Colônias", "125 kg Produção").
class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.valor, required this.rotulo, required this.tom});

  final String valor;
  final String rotulo;
  final TomVisual tom;

  @override
  Widget build(BuildContext context) => Semantics(
        label: '$valor $rotulo',
        excludeSemantics: true,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: tom.fundo,
            borderRadius: BorderRadius.circular(AppRadius.card - 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  valor,
                  style: AppTextStyles.statValue.copyWith(
                    color: tom == TomVisual.verde ? AppColors.verde : AppColors.carvao,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                rotulo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.label,
              ),
            ],
          ),
        ),
      );
}

/// Linha de indicadores que vira grade 2×2 em telas estreitas.
class LinhaIndicadores extends StatelessWidget {
  const LinhaIndicadores({super.key, required this.indicadores});

  final List<StatCard> indicadores;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          const espaco = AppSpacing.sm;
          // Cada card precisa de ~76 px para não cortar o rótulo.
          final porLinha = indicadores.length > 3 && constraints.maxWidth < 330
              ? 2
              : indicadores.length;
          final largura =
              ((constraints.maxWidth - espaco * (porLinha - 1)) / porLinha).floorToDouble();
          return Wrap(
            spacing: espaco,
            runSpacing: espaco,
            children: [
              for (final card in indicadores) SizedBox(width: largura, child: card),
            ],
          );
        },
      );
}
