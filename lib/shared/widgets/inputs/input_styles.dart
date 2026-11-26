import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_text_styles.dart';

/// Decoração compartilhada pelos campos compactos dos formulários
/// (estados Normal, Selecionado e Erro do inventário de componentes).
abstract final class InputStyles {
  static OutlineInputBorder _borda(Color cor, [double largura = 1]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        borderSide: BorderSide(color: cor, width: largura),
      );

  static InputDecoration compacto({String? hint, Widget? suffixIcon, String? errorText}) =>
      InputDecoration(
        hintText: hint,
        errorText: errorText,
        isDense: true,
        filled: true,
        fillColor: AppColors.branco,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textoSecundario, height: 1.2),
        errorStyle: AppTextStyles.caption.copyWith(color: AppColors.erro, fontSize: 11),
        errorMaxLines: 2,
        suffixIcon: suffixIcon,
        border: _borda(AppColors.borda),
        enabledBorder: _borda(AppColors.borda),
        disabledBorder: _borda(AppColors.borda),
        focusedBorder: _borda(AppColors.verde, 2),
        errorBorder: _borda(AppColors.erro),
        focusedErrorBorder: _borda(AppColors.erro, 2),
      );

  static const textoCampo = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.2,
    color: AppColors.carvao,
  );
}

/// Rótulo pequeno exibido acima dos campos compactos.
class RotuloCampo extends StatelessWidget {
  const RotuloCampo(this.texto, {super.key});

  final String texto;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: ExcludeSemantics(child: Text(texto, style: AppTextStyles.label)),
      );
}
