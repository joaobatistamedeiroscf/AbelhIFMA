import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../buttons/app_button.dart';

/// Estado "Vazio": ícone em círculo, título, mensagem e ação opcional.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.titulo,
    required this.mensagem,
    this.icone = Icons.inventory_2_outlined,
    this.rotuloAcao,
    this.onAcao,
    this.corIcone = AppColors.dourado,
    this.corFundoIcone = AppColors.amareloClaro,
  });

  final String titulo;
  final String mensagem;
  final IconData icone;
  final String? rotuloAcao;
  final VoidCallback? onAcao;
  final Color corIcone;
  final Color corFundoIcone;

  @override
  Widget build(BuildContext context) => Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(color: corFundoIcone, shape: BoxShape.circle),
                  child: Icon(icone, size: 38, color: corIcone),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  titulo,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(fontSize: 21, height: 1.25),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(color: AppColors.textoSecundario),
                ),
                if (rotuloAcao != null) ...[
                  const SizedBox(height: AppSpacing.xl),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: AppButton(rotulo: rotuloAcao!, onPressed: onAcao),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
