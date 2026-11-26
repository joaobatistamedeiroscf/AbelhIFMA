import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// Barra de filtros horizontal ("● Todos  ● Apiários  ● Meliponários").
///
/// Use `null` como primeira opção para representar "Todos".
class FiltroChips<T> extends StatelessWidget {
  const FiltroChips({
    super.key,
    required this.opcoes,
    required this.selecionado,
    required this.rotuloDe,
    required this.onChanged,
  });

  final List<T> opcoes;
  final T selecionado;
  final String Function(T) rotuloDe;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final opcao in opcoes)
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: _Filtro(
                  rotulo: rotuloDe(opcao),
                  selecionado: opcao == selecionado,
                  onTap: () => onChanged(opcao),
                ),
              ),
          ],
        ),
      );
}

class _Filtro extends StatelessWidget {
  const _Filtro({required this.rotulo, required this.selecionado, required this.onTap});

  final String rotulo;
  final bool selecionado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final corTexto = selecionado ? AppColors.branco : AppColors.carvao;
    return Semantics(
      button: true,
      selected: selecionado,
      child: Material(
        color: selecionado ? AppColors.verde : AppColors.cinzaClaro,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(color: corTexto, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(
                  rotulo,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: corTexto,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
