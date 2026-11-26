import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'input_styles.dart';

/// Campo de texto compacto dos formulários de cadastro.
class CampoFormulario extends StatelessWidget {
  const CampoFormulario({
    super.key,
    required this.rotulo,
    this.controller,
    this.hint,
    this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.sentences,
  });

  final String rotulo;
  final TextEditingController? controller;
  final String? hint;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;

  /// Campo numérico (aceita vírgula ou ponto decimal).
  factory CampoFormulario.numero({
    Key? key,
    required String rotulo,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    bool decimal = false,
  }) =>
      CampoFormulario(
        key: key,
        rotulo: rotulo,
        controller: controller,
        validator: validator,
        keyboardType: TextInputType.numberWithOptions(decimal: decimal),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(decimal ? r'[0-9.,]' : r'[0-9]')),
        ],
      );

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RotuloCampo(rotulo),
          Semantics(
            label: rotulo,
            child: TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              textCapitalization: textCapitalization,
              maxLines: maxLines,
              readOnly: readOnly,
              onTap: onTap,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: InputStyles.textoCampo,
              decoration: InputStyles.compacto(hint: hint, suffixIcon: suffixIcon),
            ),
          ),
        ],
      );
}
