import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/tom_visual.dart';
import '../cards/app_card.dart';
import '../chips/status_chip.dart';

/// Item da linha do tempo do Histórico: data à esquerda, trilho e card.
class TimelineItem extends StatelessWidget {
  const TimelineItem({
    super.key,
    required this.dia,
    required this.mes,
    required this.titulo,
    required this.descricao,
    required this.etiqueta,
    required this.tom,
    this.ultimo = false,
  });

  final String dia;
  final String mes;
  final String titulo;
  final String descricao;
  final String etiqueta;
  final TomVisual tom;

  /// Oculta o trilho abaixo do último item.
  final bool ultimo;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 44,
              child: Column(
                children: [
                  Text(dia, style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w700)),
                  Text(
                    mes,
                    style: AppTextStyles.label.copyWith(
                      color: tom.destaque,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 28,
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(color: tom.destaque, shape: BoxShape.circle),
                  ),
                  if (!ultimo)
                    Expanded(child: Container(width: 1.5, color: AppColors.borda)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: ultimo ? 0 : AppSpacing.xl),
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(titulo, style: AppTextStyles.cardTitle)),
                          StatusChip(texto: etiqueta, tom: tom),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        descricao,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13,
                          color: AppColors.textoSecundario,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
