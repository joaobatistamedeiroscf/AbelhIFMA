import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// Grupo de opções de escolha única em forma de chips, quebrando linha
/// conforme a largura ("Tipo de manejo", "Prioridade").
class ChipsSelecao<T> extends StatelessWidget {
  const ChipsSelecao({
    super.key,
    required this.opcoes,
    required this.selecionado,
    required this.onChanged,
    this.rotuloDe,
    this.corSelecionado = AppColors.amarelo,
    this.corDe,
  });

  final List<T> opcoes;
  final T? selecionado;
  final ValueChanged<T> onChanged;
  final String Function(T)? rotuloDe;

  /// Cor de fundo do chip selecionado.
  final Color corSelecionado;

  /// Permite uma cor própria por opção (ex.: prioridade).
  final Color Function(T)? corDe;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          for (final opcao in opcoes) _chip(opcao),
        ],
      );

  Widget _chip(T opcao) {
    final ativo = opcao == selecionado;
    final cor = corDe?.call(opcao) ?? corSelecionado;
    final corTexto = ativo
        ? (cor == AppColors.amarelo ? AppColors.carvao : AppColors.branco)
        : AppColors.carvao;
    return Semantics(
      button: true,
      selected: ativo,
      child: Material(
        color: ativo ? cor : AppColors.branco,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          side: BorderSide(color: ativo ? cor : AppColors.borda),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () => onChanged(opcao),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              rotuloDe?.call(opcao) ?? opcao.toString(),
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: corTexto,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
