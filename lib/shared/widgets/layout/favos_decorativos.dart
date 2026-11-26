import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';

/// Favos de mel decorativos do rodapé das telas de autenticação.
/// Os três SVGs oficiais mantêm as dimensões e posições do Figma.
class FavosDecorativos extends StatelessWidget {
  const FavosDecorativos({super.key});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: IgnorePointer(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 390,
              height: 210,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned(
                    left: 6.5,
                    top: 0,
                    child: SvgPicture.asset(AppAssets.favoTopo),
                  ),
                  Positioned(
                    left: -42,
                    top: 79.1,
                    child: SvgPicture.asset(AppAssets.favoMeio),
                  ),
                  Positioned(
                    left: 6.6,
                    top: 160,
                    child: SvgPicture.asset(AppAssets.favoBase),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
