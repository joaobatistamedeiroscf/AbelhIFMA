import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/tom_visual.dart';

/// Faixa informativa com ícone ("Apiário • Apis", "Lembrete ativado",
/// "2 colônias precisam de atenção", "+18% neste mês").
class InfoBanner extends StatelessWidget {
  const InfoBanner({
    super.key,
    required this.icone,
    required this.texto,
    this.tom = TomVisual.amarelo,
    this.titulo,
    this.onTap,
    this.negrito = false,
  });

  final IconData icone;

  /// Texto principal (ou descrição, quando há [titulo]).
  final String texto;
  final TomVisual tom;
  final String? titulo;

  /// Exibe uma seta e torna o banner tocável.
  final VoidCallback? onTap;

  /// Destaca o [texto] (banners de contexto dos formulários).
  final bool negrito;

  @override
  Widget build(BuildContext context) {
    final corTexto = tom == TomVisual.escuro
        ? AppColors.branco
        : (tom == TomVisual.verde ? AppColors.verde : AppColors.carvao);
    return Material(
      color: tom.fundo,
      borderRadius: BorderRadius.circular(AppRadius.card - 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card - 2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            crossAxisAlignment:
                titulo == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Icon(icone, color: tom.destaque, size: 20),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (titulo != null)
                      Text(
                        titulo!,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: tom == TomVisual.verde ? AppColors.verde : corTexto,
                          height: 1.3,
                        ),
                      ),
                    Text(
                      texto,
                      style: (titulo != null
                              ? AppTextStyles.label.copyWith(fontSize: 12)
                              : AppTextStyles.body.copyWith(fontSize: 13, height: 1.4))
                          .copyWith(
                        color: titulo != null && tom == TomVisual.escuro
                            ? const Color(0xFFB0B8BC)
                            : titulo != null
                                ? AppColors.textoSecundario
                                : corTexto,
                        fontWeight: negrito ? FontWeight.w600 : null,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(Icons.chevron_right, color: tom.destaque, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
