import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../cards/app_card.dart';

/// Grupo de opções do Perfil dentro de um card.
class MenuGrupo extends StatelessWidget {
  const MenuGrupo({super.key, required this.opcoes});

  final List<MenuOpcao> opcoes;

  @override
  Widget build(BuildContext context) => AppCard(
        sombra: false,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Column(children: opcoes),
      );
}

/// Opção de menu com ícone, texto e seta ("Editar perfil  >").
class MenuOpcao extends StatelessWidget {
  const MenuOpcao({
    super.key,
    required this.icone,
    required this.rotulo,
    required this.onTap,
    this.destrutiva = false,
  });

  final IconData icone;
  final String rotulo;
  final VoidCallback onTap;

  /// Exibe em vermelho (ex.: "Sair").
  final bool destrutiva;

  @override
  Widget build(BuildContext context) {
    final cor = destrutiva ? AppColors.erro : AppColors.carvao;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
        child: Row(
          children: [
            IconeQuadrado(
              icone: icone,
              corFundo: destrutiva ? AppColors.erroClaro : AppColors.fundo,
              corIcone: cor,
              tamanho: 36,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(rotulo, style: AppTextStyles.body.copyWith(color: cor))),
            const Icon(Icons.chevron_right, color: AppColors.textoSecundario, size: 20),
          ],
        ),
      ),
    );
  }
}
