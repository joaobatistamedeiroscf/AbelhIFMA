import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/app_scope.dart';
import '../../../shared/widgets/widgets.dart';

enum _FiltroTarefa { todas, pendentes, concluidas }

/// 18 — Tarefas.
class TarefasScreen extends StatefulWidget {
  const TarefasScreen({super.key});

  @override
  State<TarefasScreen> createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  _FiltroTarefa _filtro = _FiltroTarefa.todas;

  String _rotulo(_FiltroTarefa f) => switch (f) {
        _FiltroTarefa.todas => 'Todas',
        _FiltroTarefa.pendentes => 'Pendentes',
        _FiltroTarefa.concluidas => 'Concluídas',
      };

  Future<void> _escolherData() async {
    final hoje = DateTime.now();
    await showDatePicker(
      context: context,
      initialDate: hoje,
      firstDate: DateTime(hoje.year - 1),
      lastDate: DateTime(hoje.year + 2),
      helpText: 'Agenda',
      cancelText: 'Fechar',
      confirmText: 'OK',
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final tarefas = store.tarefas.where((t) => switch (_filtro) {
          _FiltroTarefa.todas => true,
          _FiltroTarefa.pendentes => !t.concluida,
          _FiltroTarefa.concluidas => t.concluida,
        }).toList();
    final semana = store.tarefasDaSemana;
    final pendentesSemana = semana.where((t) => !t.concluida).length;

    return Scaffold(
      appBar: AppHeader.logo(
        titulo: 'Tarefas',
        subtitulo: '$pendentesSemana ${pendentesSemana == 1 ? 'pendente' : 'pendentes'} nesta semana',
        acao: HeaderIconButton(
          icone: Icons.calendar_month_outlined,
          tooltip: 'Agenda',
          onPressed: _escolherData,
        ),
      ),
      body: PageBody(
        children: [
          FiltroChips<_FiltroTarefa>(
            opcoes: _FiltroTarefa.values,
            selecionado: _filtro,
            rotuloDe: _rotulo,
            onChanged: (f) => setState(() => _filtro = f),
          ),
          const SizedBox(height: AppSpacing.md),
          ProgressoCard(
            titulo: 'Semana atual',
            concluidas: semana.where((t) => t.concluida).length,
            total: semana.length,
          ),
          const SizedBox(height: AppSpacing.md),
          if (tarefas.isEmpty)
            const CardListaPontuada(itens: [], vazio: 'Nenhuma tarefa neste filtro.')
          else
            GradeResponsiva(
              children: [
                for (final t in tarefas)
                  TarefaCard(
                    key: ValueKey(t.id),
                    tarefa: t,
                    subtitulo: store.criatorio(t.criatorioId)?.nome,
                    onAlternar: () => store.alternarTarefa(t.id),
                  ),
              ],
            ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            rotulo: '+ Nova tarefa',
            onPressed: () => context.abrirTelaCheia(AppRoutes.novaTarefa),
          ),
        ],
      ),
    );
  }
}
