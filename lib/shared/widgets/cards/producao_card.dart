import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/models.dart';
import '../../extensions/visual_extensions.dart';
import 'app_card.dart';

/// Registro de produção ("Mel • 25/09/2026 — 12 kg").
class ProducaoCard extends StatelessWidget {
  const ProducaoCard({super.key, required this.producao, required this.criatorio});

  final Producao producao;
  final Criatorio? criatorio;

  @override
  Widget build(BuildContext context) {
    final tipo = criatorio?.tipo ?? TipoCriatorio.apiario;
    final tom = tipo.tom;
    final apiario = tipo == TipoCriatorio.apiario;
    return AppCard(
      corFaixa: apiario ? AppColors.amarelo : AppColors.verde,
      child: Row(
        children: [
          IconeQuadrado(
            icone: Icons.water_drop_outlined,
            corFundo: tom.fundo,
            corIcone: tom.destaque,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${producao.produto} • ${Formatters.data(producao.data)}',
                  style: AppTextStyles.cardTitle,
                ),
                if (criatorio != null) Text(criatorio!.nome, style: AppTextStyles.label),
              ],
            ),
          ),
          Text(
            '${Formatters.quantidade(producao.quantidade)} ${producao.unidade}',
            style: AppTextStyles.subtitle.copyWith(
              fontWeight: FontWeight.w700,
              color: apiario ? AppColors.carvao : AppColors.verde,
            ),
          ),
        ],
      ),
    );
  }
}
