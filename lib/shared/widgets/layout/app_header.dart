import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../app_logo.dart';
import 'responsive_center.dart';

/// Cabeçalho das telas, nos dois formatos do Figma:
///
/// - [AppHeader.logo]: telas principais das abas (logo + título + ação).
/// - [AppHeader.voltar]: telas internas e formulários (seta + título).
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader.logo({
    super.key,
    required this.titulo,
    this.subtitulo,
    this.acao,
  }) : _mostrarVoltar = false;

  const AppHeader.voltar({
    super.key,
    required this.titulo,
    this.subtitulo,
    this.acao,
  }) : _mostrarVoltar = true;

  final String titulo;
  final String? subtitulo;

  /// Ação à direita, normalmente um [HeaderIconButton].
  final Widget? acao;
  final bool _mostrarVoltar;

  static const altura = 64.0;

  @override
  Size get preferredSize => const Size.fromHeight(altura);

  @override
  Widget build(BuildContext context) => Material(
        color: AppColors.branco,
        child: SafeArea(
          bottom: false,
          child: Container(
            height: altura,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.borda)),
            ),
            child: ResponsiveCenter(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  if (_mostrarVoltar)
                    IconButton(
                      tooltip: 'Voltar',
                      icon: const Icon(Icons.arrow_back, color: AppColors.carvao),
                      onPressed: () => Navigator.of(context).maybePop(),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                      child: AppLogo(),
                    ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          header: true,
                          child: Text(
                            titulo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.subtitle.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                        ),
                        if (subtitulo != null)
                          Text(
                            subtitulo!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.label.copyWith(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                  if (acao != null) acao!,
                ],
              ),
            ),
          ),
        ),
      );
}

/// Botão circular usado nas ações do cabeçalho (busca, notificações...).
class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.icone,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icone;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.fundo,
          fixedSize: const Size(40, 40),
        ),
        icon: Icon(icone, size: 20, color: AppColors.carvao),
      );
}
