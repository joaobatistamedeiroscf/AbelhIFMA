import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_text_styles.dart';

/// Variantes de "Botões e ações" do inventário de componentes.
enum VarianteBotao { principal, sucesso, secundario, perigo }

/// Botão padrão do app, com estado de carregamento embutido.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.rotulo,
    required this.onPressed,
    this.variante = VarianteBotao.principal,
    this.icone,
    this.carregando = false,
    this.rotuloCarregando,
    this.expandir = true,
    this.altura = 50,
  });

  final String rotulo;
  final VoidCallback? onPressed;
  final VarianteBotao variante;
  final IconData? icone;

  /// Mostra um indicador e bloqueia toques enquanto verdadeiro.
  final bool carregando;

  /// Texto exibido durante o carregamento (ex.: "Entrando…").
  final String? rotuloCarregando;

  /// Ocupa toda a largura disponível.
  final bool expandir;
  final double altura;

  (Color fundo, Color texto) get _cores => switch (variante) {
        VarianteBotao.principal => (AppColors.amarelo, AppColors.carvao),
        VarianteBotao.sucesso => (AppColors.verde, AppColors.branco),
        VarianteBotao.secundario => (AppColors.branco, AppColors.carvao),
        VarianteBotao.perigo => (AppColors.erro, AppColors.branco),
      };

  @override
  Widget build(BuildContext context) {
    final (fundo, texto) = _cores;
    final conteudo = carregando
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: texto),
              ),
              const SizedBox(width: 10),
              Flexible(child: Text(rotuloCarregando ?? rotulo, overflow: TextOverflow.ellipsis)),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icone != null) ...[Icon(icone, size: 18), const SizedBox(width: 8)],
              Flexible(child: Text(rotulo, overflow: TextOverflow.ellipsis)),
            ],
          );

    final style = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: fundo,
      foregroundColor: texto,
      disabledBackgroundColor: fundo.withValues(alpha: 0.6),
      disabledForegroundColor: texto.withValues(alpha: 0.8),
      minimumSize: Size(expandir ? double.infinity : 120, altura),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      side: variante == VarianteBotao.secundario
          ? const BorderSide(color: AppColors.borda)
          : BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button)),
      textStyle: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
    );

    return SizedBox(
      width: expandir ? double.infinity : null,
      height: altura,
      child: ElevatedButton(
        onPressed: carregando ? null : onPressed,
        style: style,
        child: conteudo,
      ),
    );
  }
}
