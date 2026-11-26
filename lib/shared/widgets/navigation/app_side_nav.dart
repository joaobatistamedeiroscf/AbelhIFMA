import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../app_logo.dart';
import 'aba_home.dart';
import 'app_bottom_nav.dart';

/// Menu lateral usado em tablets e desktop no lugar da barra inferior.
class AppSideNav extends StatelessWidget {
  const AppSideNav({super.key, required this.atual, required this.onSelecionar});

  final AbaHome atual;
  final ValueChanged<AbaHome> onSelecionar;

  @override
  Widget build(BuildContext context) => Container(
        width: 96,
        decoration: const BoxDecoration(
          color: AppColors.branco,
          border: Border(right: BorderSide(color: AppColors.borda)),
        ),
        child: SafeArea(
          right: false,
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),
              const AppLogo(tamanho: 44),
              const SizedBox(height: AppSpacing.xxl),
              for (final aba in AbaHome.values)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: ItemNavegacao(
                    aba: aba,
                    selecionado: aba == atual,
                    onTap: () => onSelecionar(aba),
                  ),
                ),
            ],
          ),
        ),
      );
}
