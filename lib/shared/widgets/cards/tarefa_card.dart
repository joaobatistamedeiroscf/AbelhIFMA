import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/models.dart';
import '../../extensions/visual_extensions.dart';
import '../chips/status_chip.dart';
import 'app_card.dart';

/// Card de tarefa com caixa de seleção para concluir.
class TarefaCard extends StatelessWidget {
  const TarefaCard({
    super.key,
    required this.tarefa,
    required this.onAlternar,
    this.subtitulo,
  });

  final Tarefa tarefa;
  final VoidCallback onAlternar;

  /// Normalmente o nome do criatório.
  final String? subtitulo;

  @override
  Widget build(BuildContext context) {
    final concluida = tarefa.concluida;
    final atrasada = !concluida &&
        tarefa.data.isBefore(DateTime.now().subtract(const Duration(days: 1)));
    final corData = concluida
        ? AppColors.verde
        : atrasada
            ? AppColors.erro
            : AppColors.dourado;
    final textoData = concluida ? 'Concluída' : Formatters.dataRelativa(tarefa.data);

    return AppCard(
      onTap: onAlternar,
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: concluida,
                onChanged: (_) => onAlternar(),
                semanticLabel: concluida ? 'Marcar como pendente' : 'Concluir tarefa',
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tarefa.titulo,
                        style: AppTextStyles.cardTitle.copyWith(
                          decoration: concluida ? TextDecoration.lineThrough : null,
                          color: concluida ? AppColors.textoSecundario : AppColors.carvao,
                        ),
                      ),
                      if (subtitulo != null) Text(subtitulo!, style: AppTextStyles.label),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: StatusChip(texto: tarefa.prioridade.rotulo, tom: tarefa.prioridade.tom),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 14, color: corData),
                const SizedBox(width: 6),
                Text(
                  textoData,
                  style: AppTextStyles.caption.copyWith(
                    color: corData,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
