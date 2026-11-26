import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/widgets.dart';

/// Estrutura comum de Login e Cadastro: logo, título, subtítulo,
/// formulário rolável e favos decorativos no rodapé.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.children,
  });

  final String titulo;
  final String subtitulo;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.branco,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSpacing.maxFormWidth),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const Positioned(left: 0, right: 0, bottom: 0, child: FavosDecorativos()),
                  SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(child: AppLogo(tamanho: 72)),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          titulo,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title.copyWith(height: 1.2),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          subtitulo,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textoSecundario,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 18),
                        ...children,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
