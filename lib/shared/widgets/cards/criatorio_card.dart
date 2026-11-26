import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/models.dart';
import '../../extensions/visual_extensions.dart';
import '../chips/status_chip.dart';
import 'app_card.dart';

/// Card de criatório da lista "Meus criatórios".
class CriatorioCard extends StatelessWidget {
  const CriatorioCard({
    super.key,
    required this.criatorio,
    required this.totalColonias,
    this.onTap,
  });

  final Criatorio criatorio;
  final int totalColonias;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tom = criatorio.tipo.tom;
    return AppCard(
      onTap: onTap,
      corFaixa: criatorio.tipo == TipoCriatorio.apiario ? AppColors.amarelo : AppColors.verde,
      semanticLabel: '${criatorio.nome}, ${criatorio.cidadeUf}, $totalColonias colônias',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconeQuadrado(icone: criatorio.tipo.icone, corFundo: tom.fundo, corIcone: tom.destaque),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(criatorio.nome, style: AppTextStyles.cardTitle),
                    Text(criatorio.cidadeUf, style: AppTextStyles.label),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusChip(texto: criatorio.tipo.nome, tom: tom),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Text(
                  '$totalColonias ${totalColonias == 1 ? 'colônia' : 'colônias'}',
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textoSecundario),
            ],
          ),
        ],
      ),
    );
  }
}

/// Card colorido compacto usado no Dashboard ("Meus criatórios").
class CriatorioResumoCard extends StatelessWidget {
  const CriatorioResumoCard({
    super.key,
    required this.criatorio,
    required this.totalColonias,
    this.onTap,
  });

  final Criatorio criatorio;
  final int totalColonias;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tom = criatorio.tipo.tom;
    return Semantics(
      button: true,
      label: '${criatorio.nome}, $totalColonias colônias',
      excludeSemantics: true,
      child: Material(
        color: tom.fundo,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.card),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(criatorio.tipo.icone, color: tom.destaque, size: 22),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  criatorio.nome,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text('$totalColonias colônias', style: AppTextStyles.label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
