import 'package:abelhifma/app/theme/app_colors.dart';
import 'package:abelhifma/app/theme/app_radius.dart';
import 'package:abelhifma/app/theme/app_text_styles.dart';
import 'package:abelhifma/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CaixaDeTexto extends StatelessWidget{
  const CaixaDeTexto({
    super.key,
    required this.label, //o nome do campo, como "E-mail" ou "Senha"
    this.hint, //o texto de exemplo dentro do campo
    this.controller, //permite ler e controlar o texto digitado
    this.obscureText = false, //oculta o conteúdo quando for uma senha
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.textoSecundario,

        labelStyle: AppTextStyles.body,
        hintStyle: AppTextStyles.caption,
        errorStyle: AppTextStyles.caption.copyWith(
          color: AppColors.erro,
        ),
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: const BorderSide(color: AppColors.verde, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: const BorderSide(color: AppColors.erro),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: const BorderSide(color: AppColors.erro, width: 2),
        ),
      ),
    );
  }
}