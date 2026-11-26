import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_text_styles.dart';
import 'aba_home.dart';

/// Barra de navegação inferior (celulares).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.atual, required this.onSelecionar});

  final AbaHome atual;
  final ValueChanged<AbaHome> onSelecionar;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.branco,
          border: Border(top: BorderSide(color: AppColors.borda)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Row(
              children: [
                for (final aba in AbaHome.values)
                  Expanded(
                    child: ItemNavegacao(
                      aba: aba,
                      selecionado: aba == atual,
                      onTap: () => onSelecionar(aba),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}

/// Item de navegação com destaque amarelo quando selecionado.
/// Compartilhado pela barra inferior e pelo menu lateral.
class ItemNavegacao extends StatelessWidget {
  const ItemNavegacao({
    super.key,
    required this.aba,
    required this.selecionado,
    required this.onTap,
  });

  final AbaHome aba;
  final bool selecionado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        selected: selecionado,
        label: aba.rotulo,
        excludeSemantics: true,
        child: Material(
          color: selecionado ? AppColors.amareloClaro : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.button),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.button),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    selecionado ? aba.iconeSelecionado : aba.icone,
                    size: 22,
                    color: selecionado ? AppColors.carvao : AppColors.textoSecundario,
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      aba.rotulo,
                      maxLines: 1,
                      style: AppTextStyles.label.copyWith(
                        color: selecionado ? AppColors.carvao : AppColors.textoSecundario,
                        fontWeight: selecionado ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
