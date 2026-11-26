import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import 'app_card.dart';

/// Lista de pares rótulo/valor ("Tipo de caixa ........ Langstroth").
class DetalhesCard extends StatelessWidget {
  const DetalhesCard({super.key, required this.itens});

  final List<(String rotulo, String valor)> itens;

  @override
  Widget build(BuildContext context) => AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          children: [
            for (final (rotulo, valor) in itens)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        rotulo,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13,
                          color: AppColors.textoSecundario,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Flexible(
                      child: Text(
                        valor,
                        textAlign: TextAlign.end,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
}
