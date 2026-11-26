import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/models.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';

/// 07 — Escolher tipo (Apiário ou Meliponário selecionado).
class EscolherTipoScreen extends StatefulWidget {
  const EscolherTipoScreen({super.key});

  @override
  State<EscolherTipoScreen> createState() => _EscolherTipoScreenState();
}

class _EscolherTipoScreenState extends State<EscolherTipoScreen> {
  TipoCriatorio _tipo = TipoCriatorio.apiario;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const AppHeader.voltar(titulo: 'Novo criatório'),
        body: PageBody(
          maxWidth: AppSpacing.maxFormWidth + 80,
          children: [
            Text(
              'Selecione o tipo de criatório.',
              style: AppTextStyles.body.copyWith(color: AppColors.textoSecundario),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final tipo in TipoCriatorio.values) ...[
              TipoSelecaoCard(
                titulo: tipo.nomeMaiusculo,
                descricao: tipo.descricao,
                icone: tipo.icone,
                tom: tipo.tom,
                selecionado: _tipo == tipo,
                onTap: () => setState(() => _tipo = tipo),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
            AppButton(
              rotulo: 'Continuar',
              // Substitui esta tela para que "voltar" no formulário retorne à origem.
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.novoCriatorio, arguments: _tipo),
            ),
          ],
        ),
      );
}
