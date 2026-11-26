import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/models.dart';
import '../../extensions/visual_extensions.dart';
import '../chips/status_chip.dart';
import 'app_card.dart';

/// Card de colônia ("A-001 • Apis mellifera • Última revisão").
class ColoniaCard extends StatelessWidget {
  const ColoniaCard({super.key, required this.colonia, required this.tipo, this.onTap});

  final Colonia colonia;
  final TipoCriatorio tipo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final revisao = colonia.ultimaRevisao;
    return AppCard(
      onTap: onTap,
      corFaixa: tipo == TipoCriatorio.apiario ? AppColors.amarelo : AppColors.verde,
      semanticLabel: '${colonia.identificacao}, ${colonia.especie}, ${colonia.status.rotulo}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      colonia.identificacao,
                      style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      colonia.especie,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 13,
                        color: AppColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
              StatusChip(texto: colonia.status.rotulo, tom: colonia.status.tom),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  revisao == null
                      ? 'Ainda não revisada'
                      : 'Última revisão • ${Formatters.data(revisao)}',
                  style: AppTextStyles.label,
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textoSecundario, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
