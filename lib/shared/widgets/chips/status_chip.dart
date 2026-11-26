import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/tom_visual.dart';

/// Etiqueta de estado com ponto colorido ("● Ativa", "● Alta", "● Hoje").
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.texto, required this.tom, this.comPonto = true});

  final String texto;
  final TomVisual tom;
  final bool comPonto;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: tom.fundo,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (comPonto) ...[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: tom.destaque, shape: BoxShape.circle),
              ),
              const SizedBox(width: 5),
            ],
            Text(
              texto,
              style: AppTextStyles.caption.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: tom.destaque,
              ),
            ),
          ],
        ),
      );
}
