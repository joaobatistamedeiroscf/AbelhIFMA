import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../buttons/app_button.dart';
import 'empty_state.dart';

/// Estado "Erro": falha ao carregar com opção de tentar novamente.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    this.titulo = 'Não foi possível carregar',
    this.mensagem = 'Verifique sua conexão e tente novamente.',
    required this.onTentarNovamente,
  });

  final String titulo;
  final String mensagem;
  final VoidCallback onTentarNovamente;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_outlined, size: 36, color: AppColors.erro),
              const SizedBox(height: AppSpacing.md),
              Text(titulo, style: AppTextStyles.cardTitle, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.xs),
              Text(mensagem, style: AppTextStyles.caption, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                rotulo: 'Tentar novamente',
                variante: VarianteBotao.secundario,
                expandir: false,
                altura: 44,
                onPressed: onTentarNovamente,
              ),
            ],
          ),
        ),
      );
}

/// Estado "Confirmação" ("Tudo certo!", "Verifique seu e-mail.").
class SuccessState extends StatelessWidget {
  const SuccessState({
    super.key,
    required this.titulo,
    required this.mensagem,
    this.icone = Icons.check,
    this.rotuloAcao,
    this.onAcao,
  });

  final String titulo;
  final String mensagem;
  final IconData icone;
  final String? rotuloAcao;
  final VoidCallback? onAcao;

  @override
  Widget build(BuildContext context) => EmptyState(
        titulo: titulo,
        mensagem: mensagem,
        icone: icone,
        rotuloAcao: rotuloAcao,
        onAcao: onAcao,
        corIcone: AppColors.verde,
        corFundoIcone: AppColors.verdeClaro,
      );
}

/// Indicador "Carregando dados…".
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.mensagem = 'Carregando dados…'});

  final String mensagem;

  @override
  Widget build(BuildContext context) => Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.verde),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(mensagem, style: AppTextStyles.caption),
          ],
        ),
      );
}
