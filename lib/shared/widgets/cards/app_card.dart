import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';

/// Superfície base de todos os cards: fundo, borda, sombra suave,
/// toque opcional e faixa colorida à esquerda (cards de criatório/colônia).
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.corFaixa,
    this.cor = AppColors.branco,
    this.padding = const EdgeInsets.all(16),
    this.sombra = true,
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback? onTap;

  /// Cor da faixa vertical à esquerda. Nula = sem faixa.
  final Color? corFaixa;
  final Color cor;
  final EdgeInsetsGeometry padding;
  final bool sombra;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final conteudo = Padding(padding: padding, child: child);
    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: cor == AppColors.branco ? Border.all(color: AppColors.borda) : null,
          boxShadow: sombra && cor == AppColors.branco
              ? const [
                  BoxShadow(color: Color(0x0F101828), blurRadius: 12, offset: Offset(0, 4)),
                ]
              : null,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            child: corFaixa == null
                ? conteudo
                : IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(width: 4, color: corFaixa),
                        Expanded(child: conteudo),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// Ícone dentro de um quadrado arredondado colorido.
class IconeQuadrado extends StatelessWidget {
  const IconeQuadrado({
    super.key,
    required this.icone,
    required this.corFundo,
    required this.corIcone,
    this.tamanho = 40,
  });

  final IconData icone;
  final Color corFundo;
  final Color corIcone;
  final double tamanho;

  @override
  Widget build(BuildContext context) => Container(
        width: tamanho,
        height: tamanho,
        decoration: BoxDecoration(
          color: corFundo,
          borderRadius: BorderRadius.circular(AppRadius.small + 2),
        ),
        child: Icon(icone, color: corIcone, size: tamanho * 0.5),
      );
}
