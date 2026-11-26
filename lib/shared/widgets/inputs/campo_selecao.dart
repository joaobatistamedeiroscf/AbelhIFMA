import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'input_styles.dart';

/// Lista suspensa ("Select") com o mesmo visual dos campos compactos.
class CampoSelecao<T> extends StatelessWidget {
  const CampoSelecao({
    super.key,
    required this.rotulo,
    required this.opcoes,
    required this.valor,
    required this.onChanged,
    this.rotuloDe,
    this.hint = 'Selecione uma opção',
    this.validator,
  });

  final String rotulo;
  final List<T> opcoes;
  final T? valor;
  final ValueChanged<T?> onChanged;

  /// Texto de cada opção. Padrão: `toString()`.
  final String Function(T)? rotuloDe;
  final String hint;
  final FormFieldValidator<T>? validator;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RotuloCampo(rotulo),
          Semantics(
            label: rotulo,
            child: DropdownButtonFormField<T>(
              // A chave recria o campo quando o valor muda por fora
              // (ex.: trocar o criatório limpa a colônia selecionada).
              key: ValueKey<Object?>(valor),
              initialValue: opcoes.contains(valor) ? valor : null,
              isExpanded: true,
              validator: validator,
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textoSecundario),
              style: InputStyles.textoCampo,
              dropdownColor: AppColors.branco,
              borderRadius: BorderRadius.circular(12),
              decoration: InputStyles.compacto(hint: hint),
              items: [
                for (final opcao in opcoes)
                  DropdownMenuItem<T>(
                    value: opcao,
                    child: Text(
                      rotuloDe?.call(opcao) ?? opcao.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
}
