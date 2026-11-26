import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/validators.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';

/// 19 — Nova tarefa.
class NovaTarefaScreen extends StatefulWidget {
  const NovaTarefaScreen({super.key});

  @override
  State<NovaTarefaScreen> createState() => _NovaTarefaScreenState();
}

class _NovaTarefaScreenState extends State<NovaTarefaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titulo = TextEditingController();
  final _descricao = TextEditingController();
  String? _criatorioId;
  String? _coloniaId;
  DateTime _data = DateTime.now().add(const Duration(days: 1));
  Prioridade _prioridade = Prioridade.alta;
  bool _lembrete = true;

  @override
  void dispose() {
    _titulo.dispose();
    _descricao.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    AppScope.read(context).adicionarTarefa(
      titulo: _titulo.text,
      descricao: _descricao.text,
      criatorioId: _criatorioId,
      coloniaId: _coloniaId,
      data: _data,
      prioridade: _prioridade,
    );
    AppFeedback.sucesso(context, 'Tarefa criada com sucesso.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final colonias = _criatorioId == null ? <Colonia>[] : store.coloniasDo(_criatorioId!);

    return TelaFormulario(
      titulo: 'Nova tarefa',
      formKey: _formKey,
      children: [
        CampoFormulario(
          rotulo: 'Título',
          controller: _titulo,
          hint: 'Ex.: Revisar colônia A-001',
          validator: (v) => Validators.obrigatorio(v, 'Informe o título.'),
        ),
        const SizedBox(height: AppSpacing.md),
        CampoFormulario(
          rotulo: 'Descrição',
          controller: _descricao,
          hint: 'Ex.: Avaliar força, cria e alimento',
        ),
        const SizedBox(height: AppSpacing.md),
        CampoSelecao<String>(
          rotulo: 'Criatório',
          opcoes: [for (final c in store.criatorios) c.id],
          rotuloDe: (id) => store.criatorio(id)?.nome ?? '',
          valor: _criatorioId,
          onChanged: (id) => setState(() {
            _criatorioId = id;
            _coloniaId = null;
          }),
        ),
        const SizedBox(height: AppSpacing.md),
        CampoSelecao<String>(
          rotulo: 'Colônia',
          hint: _criatorioId == null ? 'Escolha um criatório primeiro' : 'Opcional',
          opcoes: [for (final c in colonias) c.id],
          rotuloDe: (id) {
            final c = store.colonia(id);
            return c == null ? '' : '${c.identificacao} • ${c.especie}';
          },
          valor: _coloniaId,
          onChanged: (id) => setState(() => _coloniaId = id),
        ),
        const SizedBox(height: AppSpacing.md),
        CampoData(
          rotulo: 'Data',
          valor: _data,
          primeiraData: DateTime.now().subtract(const Duration(days: 1)),
          onChanged: (d) => setState(() => _data = d),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('PRIORIDADE', style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: AppSpacing.sm),
        ChipsSelecao<Prioridade>(
          opcoes: Prioridade.values,
          selecionado: _prioridade,
          rotuloDe: (p) => p.rotulo,
          corDe: (p) => p.tom.destaque,
          onChanged: (p) => setState(() => _prioridade = p),
        ),
        const SizedBox(height: AppSpacing.lg),
        InfoBanner(
          icone: _lembrete ? Icons.notifications_active_outlined : Icons.notifications_off_outlined,
          titulo: _lembrete ? 'Lembrete ativado' : 'Lembrete desativado',
          texto: _lembrete
              ? 'No dia da tarefa (${Formatters.diaMes(_data)}), às 8:00.'
              : 'Toque para ativar o lembrete.',
          onTap: () => setState(() => _lembrete = !_lembrete),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(rotulo: 'Criar tarefa', onPressed: _salvar),
      ],
    );
  }
}
