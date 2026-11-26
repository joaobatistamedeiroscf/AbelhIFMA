import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import 'responsive_center.dart';

/// Corpo padrão das telas: rolável, centralizado e com largura limitada.
///
/// Os filhos são empilhados na vertical e ocupam toda a largura disponível.
/// Use [espacamento] para inserir um intervalo uniforme entre eles.
class PageBody extends StatelessWidget {
  const PageBody({
    super.key,
    required this.children,
    this.espacamento = 0,
    this.maxWidth = AppSpacing.maxContentWidth,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.screen,
      AppSpacing.lg,
      AppSpacing.screen,
      AppSpacing.xxxl,
    ),
  });

  final List<Widget> children;
  final double espacamento;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: ResponsiveCenter(
          maxWidth: maxWidth,
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0 && espacamento > 0) SizedBox(height: espacamento),
                children[i],
              ],
            ],
          ),
        ),
      );
}
