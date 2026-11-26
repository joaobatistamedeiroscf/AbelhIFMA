import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// Card escuro com barra de progresso ("Semana atual — 3 de 7").
class ProgressoCard extends StatelessWidget {
  const ProgressoCard({
    super.key,
    required this.titulo,
    required this.concluidas,
    required this.total,
  });

  final String titulo;
  final int concluidas;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progresso = total == 0 ? 0.0 : concluidas / total;
    return Semantics(
      label: '$titulo: $concluidas de $total concluídas',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.carvao,
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    titulo,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.branco,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '$concluidas de $total',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.amarelo,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: progresso,
                minHeight: 8,
                color: AppColors.amarelo,
                backgroundColor: const Color(0xFF2B3337),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
