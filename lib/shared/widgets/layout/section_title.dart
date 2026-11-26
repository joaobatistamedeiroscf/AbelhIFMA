import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// Título de seção com link opcional à direita ("Ver todos", "Histórico").
class TituloSecao extends StatelessWidget {
  const TituloSecao(this.titulo, {super.key, this.rotuloAcao, this.onAcao});

  final String titulo;
  final String? rotuloAcao;
  final VoidCallback? onAcao;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  titulo,
                  style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            if (rotuloAcao != null)
              TextButton(
                onPressed: onAcao,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  minimumSize: const Size(48, 36),
                  textStyle: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Text(rotuloAcao!),
              ),
          ],
        ),
      );
}
