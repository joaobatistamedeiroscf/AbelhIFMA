import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../buttons/app_button.dart';

/// Mensagens e diálogos de feedback ("Modal e confirmação" e "Feedback").
abstract final class AppFeedback {
  /// Faixa escura de sucesso ("Revisão salva com sucesso.").
  static void sucesso(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: AppColors.amarelo, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(mensagem)),
            ],
          ),
        ),
      );
  }

  /// Diálogo informativo simples.
  static Future<void> informar(BuildContext context, String titulo, String mensagem) =>
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendi'),
            ),
          ],
        ),
      );

  /// Diálogo de confirmação ("Excluir colônia?"). Retorna true se confirmado.
  static Future<bool> confirmar(
    BuildContext context, {
    required String titulo,
    required String mensagem,
    String rotuloConfirmar = 'Confirmar',
    bool perigo = false,
  }) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.branco,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.large)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (perigo)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.erroClaro,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.delete_outline, color: AppColors.erro, size: 20),
                  ),
                if (perigo) const SizedBox(height: AppSpacing.md),
                Text(titulo, style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: AppSpacing.sm),
                Text(mensagem, style: AppTextStyles.caption.copyWith(fontSize: 13)),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        rotulo: 'Cancelar',
                        variante: VarianteBotao.secundario,
                        altura: 44,
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppButton(
                        rotulo: rotuloConfirmar,
                        variante: perigo ? VarianteBotao.perigo : VarianteBotao.principal,
                        altura: 44,
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return resultado ?? false;
  }
}
