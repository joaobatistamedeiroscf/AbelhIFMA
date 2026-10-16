import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';
import '../app/theme/app_radius.dart';
import '../app/theme/app_text_styles.dart';

/// Campo reutilizável com rótulo, validação e suporte a senha.
class CaixaDeTexto extends StatelessWidget {
  const CaixaDeTexto({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.enabled = true,
    this.textInputAction,
    this.autofillHints,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final bool enabled;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.button),
      borderSide: const BorderSide(color: Color(0xFFDDE3E0)),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.carvao,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Semantics(
          label: label,
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autofillHints: autofillHints,
            autocorrect: false,
            enableSuggestions: !obscureText,
            validator: validator,
            forceErrorText: errorText,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: AppTextStyles.body.copyWith(height: 1.2),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: AppColors.branco,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 15,
              ),
              hintStyle: AppTextStyles.body.copyWith(
                color: AppColors.textoSecundario,
                height: 1.2,
              ),
              errorStyle: AppTextStyles.caption.copyWith(
                color: AppColors.erro,
                fontSize: 10,
              ),
              errorMaxLines: 2,
              prefixIcon: prefixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: prefixIcon,
                    ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 38,
                minHeight: 18,
              ),
              suffixIcon: suffixIcon,
              border: border,
              enabledBorder: border,
              disabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: const BorderSide(color: AppColors.verde, width: 2),
              ),
              errorBorder: border.copyWith(
                borderSide: const BorderSide(color: AppColors.erro),
              ),
              focusedErrorBorder: border.copyWith(
                borderSide: const BorderSide(color: AppColors.erro, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
