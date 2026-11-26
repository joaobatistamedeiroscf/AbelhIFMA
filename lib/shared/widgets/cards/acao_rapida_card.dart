import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/tom_visual.dart';

/// Atalho em bloco colorido ("Nova revisão", "Novo manejo"...).
class AcaoRapidaCard extends StatelessWidget {
  const AcaoRapidaCard({
    super.key,
    required this.icone,
    required this.rotulo,
    required this.tom,
    required this.onTap,
  });

  final IconData icone;
  final String rotulo;
  final TomVisual tom;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: rotulo,
        excludeSemantics: true,
        child: Material(
          color: tom.fundo,
          borderRadius: BorderRadius.circular(AppRadius.card - 2),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.card - 2),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                children: [
                  Icon(icone, color: tom.destaque, size: 22),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    rotulo,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: tom.texto,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

/// Linha de ações rápidas com larguras iguais.
class LinhaAcoesRapidas extends StatelessWidget {
  const LinhaAcoesRapidas({super.key, required this.acoes});

  final List<AcaoRapidaCard> acoes;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < acoes.length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpacing.sm),
              Expanded(child: acoes[i]),
            ],
          ],
        ),
      );
}
