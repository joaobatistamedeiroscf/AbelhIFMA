import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';

/// Logotipo do AbelhIFMA.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.tamanho = 36});

  final double tamanho;

  @override
  Widget build(BuildContext context) => Image.asset(
        AppAssets.logo,
        width: tamanho,
        height: tamanho,
        fit: BoxFit.contain,
        semanticLabel: 'AbelhIFMA',
      );
}
