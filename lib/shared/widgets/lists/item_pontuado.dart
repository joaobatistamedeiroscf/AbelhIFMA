import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../cards/app_card.dart';

/// Linha com ponto colorido, título, subtítulo e um elemento à direita.
/// Usada em "Próximas tarefas", "Atividades recentes" e "Últimas atividades".
class ItemPontuado extends StatelessWidget {
  const ItemPontuado({
    super.key,
    required this.corPonto,
    required this.titulo,
    this.subtitulo,
    this.trailing,
    this.onTap,
  });

  final Color corPonto;
  final String titulo;
  final String? subtitulo;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: corPonto, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (subtitulo != null) Text(subtitulo!, style: AppTextStyles.label),
                  ],
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: AppSpacing.sm), trailing!],
            ],
          ),
        ),
      );
}

/// Card que agrupa uma lista de [ItemPontuado].
class CardListaPontuada extends StatelessWidget {
  const CardListaPontuada({super.key, required this.itens, this.vazio});

  final List<Widget> itens;

  /// Texto exibido quando não há itens.
  final String? vazio;

  @override
  Widget build(BuildContext context) => AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: itens.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Text(vazio ?? 'Nada por aqui ainda.', style: AppTextStyles.caption),
              )
            : Column(children: itens),
      );
}
