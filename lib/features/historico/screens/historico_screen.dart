import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';

/// 16 — Histórico da colônia em linha do tempo, agrupado por mês.
class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key, required this.coloniaId});

  final String coloniaId;

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  TipoAtividade? _filtro;
  bool _maisRecentesPrimeiro = true;

  String _rotulo(TipoAtividade? tipo) => switch (tipo) {
        null => 'Todos',
        TipoAtividade.revisao => 'Revisões',
        TipoAtividade.manejo => 'Manejos',
      };

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final colonia = store.colonia(widget.coloniaId);
    if (colonia == null) return const TelaNaoEncontrada(titulo: 'Colônia não encontrada');

    var atividades = store
        .atividadesDa(colonia.id)
        .where((a) => _filtro == null || a.tipo == _filtro)
        .toList();
    if (!_maisRecentesPrimeiro) atividades = atividades.reversed.toList();

    // Agrupa mantendo a ordem: "SETEMBRO DE 2026" → [atividades]
    final grupos = <String, List<Atividade>>{};
    for (final a in atividades) {
      grupos.putIfAbsent(Formatters.mesAno(a.data), () => []).add(a);
    }

    return Scaffold(
      appBar: AppHeader.voltar(
        titulo: 'Histórico',
        subtitulo: '${colonia.identificacao} • ${colonia.especie}',
        acao: HeaderIconButton(
          icone: Icons.swap_vert,
          tooltip: _maisRecentesPrimeiro ? 'Mais antigos primeiro' : 'Mais recentes primeiro',
          onPressed: () => setState(() => _maisRecentesPrimeiro = !_maisRecentesPrimeiro),
        ),
      ),
      body: PageBody(
        children: [
          FiltroChips<TipoAtividade?>(
            opcoes: const [null, TipoAtividade.revisao, TipoAtividade.manejo],
            selecionado: _filtro,
            rotuloDe: _rotulo,
            onChanged: (t) => setState(() => _filtro = t),
          ),
          const SizedBox(height: AppSpacing.md),
          if (atividades.isEmpty)
            const CardListaPontuada(itens: [], vazio: 'Nenhum registro neste filtro.'),
          for (final grupo in grupos.entries) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                grupo.key,
                style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            for (var i = 0; i < grupo.value.length; i++)
              TimelineItem(
                dia: '${grupo.value[i].data.day}',
                mes: Formatters.mesAbreviado(grupo.value[i].data),
                titulo: grupo.value[i].titulo,
                descricao: grupo.value[i].descricao,
                etiqueta: grupo.value[i].etiqueta,
                tom: grupo.value[i].tom,
                ultimo: i == grupo.value.length - 1,
              ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}
