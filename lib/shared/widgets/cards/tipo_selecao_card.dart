import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/tom_visual.dart';

/// Opção grande de escolha única ("APIÁRIO" / "MELIPONÁRIO").
class TipoSelecaoCard extends StatelessWidget {
  const TipoSelecaoCard({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.icone,
    required this.tom,
    required this.selecionado,
    required this.onTap,
  });

  final String titulo;
  final String descricao;
  final IconData icone;
  final TomVisual tom;
  final bool selecionado;
  final VoidCallback onTap;

  Color get _corForte => tom == TomVisual.amarelo ? AppColors.amarelo : AppColors.verde;

  @override
  Widget build(BuildContext context) => Semantics(
        selected: selecionado,
        button: true,
        label: '$titulo. $descricao',
        excludeSemantics: true,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: selecionado ? tom.fundo : AppColors.branco,
            borderRadius: BorderRadius.circular(AppRadius.large),
            border: Border.all(
              color: selecionado ? _corForte : AppColors.borda,
              width: selecionado ? 2 : 1,
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.large),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg + 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: _corForte,
                            borderRadius: BorderRadius.circular(AppRadius.card),
                          ),
                          child: Icon(
                            icone,
                            size: 28,
                            color: tom == TomVisual.amarelo ? AppColors.carvao : AppColors.branco,
                          ),
                        ),
                        const Spacer(),
                        _IndicadorSelecao(selecionado: selecionado, cor: _corForte),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    Text(titulo, style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      descricao,
                      style: AppTextStyles.body.copyWith(color: AppColors.textoSecundario),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _IndicadorSelecao extends StatelessWidget {
  const _IndicadorSelecao({required this.selecionado, required this.cor});

  final bool selecionado;
  final Color cor;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selecionado ? cor : AppColors.branco,
          border: Border.all(color: selecionado ? cor : AppColors.bordaInput, width: 1.5),
        ),
        child: selecionado
            ? Icon(
                Icons.check,
                size: 16,
                color: cor == AppColors.amarelo ? AppColors.carvao : AppColors.branco,
              )
            : null,
      );
}
