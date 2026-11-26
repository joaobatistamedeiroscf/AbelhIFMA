import 'package:flutter/material.dart';

import '../../../app/routes/app_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/tom_visual.dart';
import '../../../core/utils/validators.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/widgets/widgets.dart';

/// 21 — Registrar produção.
class NovaProducaoScreen extends StatefulWidget {
  const NovaProducaoScreen({super.key, this.args = const NovaProducaoArgs()});

  final NovaProducaoArgs args;

  @override
  State<NovaProducaoScreen> createState() => _NovaProducaoScreenState();
}

class _NovaProducaoScreenState extends State<NovaProducaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantidade = TextEditingController();
  final _observacoes = TextEditingController();
  late String? _criatorioId = widget.args.criatorioId;
  late String? _coloniaId = widget.args.coloniaId;
  String? _produto = Producao.produtos.first;
  String? _unidade = Producao.unidades.first;
  DateTime _data = DateTime.now();

  @override
  void dispose() {
    _quantidade.dispose();
    _observacoes.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    AppScope.read(context).adicionarProducao(
      criatorioId: _criatorioId!,
      coloniaId: _coloniaId,
      produto: _produto!,
      quantidade: double.parse(_quantidade.text.replaceAll(',', '.')),
      unidade: _unidade!,
      data: _data,
      observacoes: _observacoes.text,
    );
    AppFeedback.sucesso(context, 'Produção registrada com sucesso.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final colonias = _criatorioId == null ? <Colonia>[] : store.coloniasDo(_criatorioId!);

    return TelaFormulario(
      titulo: 'Registrar produção',
      formKey: _formKey,
      children: [
        const InfoBanner(
          icone: Icons.balance_outlined,
          tom: TomVisual.verde,
          texto: 'Registre a colheita para acompanhar sua produtividade.',
        ),
        const SizedBox(height: AppSpacing.lg),
        CampoSelecao<String>(
          rotulo: 'Criatório',
          opcoes: [for (final c in store.criatorios) c.id],
          rotuloDe: (id) => store.criatorio(id)?.nome ?? '',
          valor: _criatorioId,
          validator: (v) => v == null ? 'Selecione o criatório.' : null,
          onChanged: (id) => setState(() {
            _criatorioId = id;
            _coloniaId = null;
          }),
        ),
        const SizedBox(height: AppSpacing.md),
        CampoSelecao<String>(
          rotulo: 'Colônia',
          hint: 'Opcional',
          opcoes: [for (final c in colonias) c.id],
          rotuloDe: (id) {
            final c = store.colonia(id);
            return c == null ? '' : '${c.identificacao} • ${c.especie}';
          },
          valor: _coloniaId,
          onChanged: (id) => setState(() => _coloniaId = id),
        ),
        const SizedBox(height: AppSpacing.md),
        CampoSelecao<String>(
          rotulo: 'Produto',
          opcoes: Producao.produtos,
          valor: _produto,
          onChanged: (v) => setState(() => _produto = v),
        ),
        const SizedBox(height: AppSpacing.md),
        LinhaFormulario(
          larguraMinima: 240,
          children: [
            CampoFormulario.numero(
              rotulo: 'Quantidade',
              controller: _quantidade,
              decimal: true,
              validator: (v) {
                final erro = Validators.numero(v, obrigatorio: true);
                if (erro != null) return erro;
                return double.parse(v!.replaceAll(',', '.')) <= 0
                    ? 'Informe um valor maior que zero.'
                    : null;
              },
            ),
            CampoSelecao<String>(
              rotulo: 'Unidade',
              opcoes: Producao.unidades,
              valor: _unidade,
              onChanged: (v) => setState(() => _unidade = v),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        CampoData(
          rotulo: 'Data',
          valor: _data,
          ultimaData: DateTime.now(),
          onChanged: (d) => setState(() => _data = d),
        ),
        const SizedBox(height: AppSpacing.md),
        CampoFormulario(
          rotulo: 'Observações',
          controller: _observacoes,
          hint: 'Ex.: Mel claro, lote ${_data.month.toString().padLeft(2, '0')}/${_data.year}',
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(rotulo: 'Registrar produção', onPressed: _salvar),
      ],
    );
  }
}
