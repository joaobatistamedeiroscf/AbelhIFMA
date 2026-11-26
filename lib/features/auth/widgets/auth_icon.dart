import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Ícone SVG exportado do Figma para os campos de autenticação.
class AuthIcon extends StatelessWidget {
  const AuthIcon(this.asset, {super.key, this.tamanho = 18});

  final String asset;
  final double tamanho;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        asset,
        width: tamanho,
        height: tamanho,
        excludeFromSemantics: true,
      );
}
