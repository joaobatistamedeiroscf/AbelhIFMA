import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/routes/app_navigation.dart';
import '../../app/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/widgets.dart';

/// 01 — Splash. Exibe a marca e segue para o login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.duracao = const Duration(milliseconds: 1800)});

  final Duration duracao;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.duracao, () {
      if (mounted) context.reiniciarEm(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              children: [
                const Spacer(flex: 3),
                Container(
                  width: 148,
                  height: 128,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.branco,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.borda),
                  ),
                  child: const AppLogo(tamanho: 96),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'AbelhIFMA',
                  style: AppTextStyles.title.copyWith(fontSize: 30, color: AppColors.verde),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Gestão de Apiários, Meliponários e Colônias',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 15,
                    color: AppColors.textoSecundario,
                  ),
                ),
                const Spacer(flex: 4),
                const _Pontos(),
                const SizedBox(height: AppSpacing.md),
                Text('IFMA • Tecnologia no campo', style: AppTextStyles.label),
              ],
            ),
          ),
        ),
      );
}

class _Pontos extends StatelessWidget {
  const _Pontos();

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final cor in const [AppColors.verde, AppColors.amarelo, AppColors.borda])
            Container(
              width: 7,
              height: 7,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: cor,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
        ],
      );
}
