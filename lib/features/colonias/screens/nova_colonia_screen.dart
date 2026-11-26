import 'package:flutter/material.dart';

import '../../../core/constants/opcoes_formulario.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';

/// 12 — Nova colônia (Apiário / Meliponário).
class NovaColoniaScreen extends StatefulWidget {
  const NovaColoniaScreen({super.key, required this.criatorioId});

  final String criatorioId;

  @override
  State<NovaColoniaScreen> createState() => _NovaColoniaScreenState();
}

class _NovaColoniaScreenState extends State<NovaColoniaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identificacao = TextEditingController();
  // Apiário: quadros / quadros de cria. Meliponário: discos de cria / potes.
  final _numero1 = TextEditingController();
  final _numero2 = TextEditingController();

  String? _especie;
  String? _tipoCaixa;
  String? _origem = OpcoesFormulario.origens.first;
  DateTime _dataInstalacao = DateTime.now();
  StatusColonia? _status = StatusColonia.ativa;
  String? _rainha = 'Sim';
  String? _forca = 'Forte';
  String? _condicao;
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_iniciado) return;
    _iniciado = true;
    final store = AppScope.read(context);
    final criatorio = store.criatorio(widget.criatorioId);
    if (criatorio == null) return;
    final tipo = criatorio.tipo;
    _identificacao.text = store.proximaIdentificacao(criatorio);
    _especie = tipo.especies.first;
    _tipoCaixa = tipo.tiposCaixa.first;
    _condicao = tipo == TipoCriatorio.apiario
        ? OpcoesFormulario.alimentoApiario.first
        : OpcoesFormulario.condicaoNinho.first;
  }

  @override
  void dispose() {
    for (final c in [_identificacao, _numero1, _numero2]) {
      c.dispose();
    }
    super.dispose();
  }

  void _salvar(Criatorio criatorio) {
    if (!_formKey.currentState!.validate()) return;
    final apiario = criatorio.tipo == TipoCriatorio.apiario;
    AppScope.read(context).adicionarColonia(
      criatorioId: criatorio.id,
      identificacao: _identificacao.text,
      especie: _especie!,
      tipoCaixa: _tipoCaixa!,
      origem: _origem!,
      dataInstalacao: _dataInstalacao,
      status: _status!,
      forca: _forca!,
      presencaRainha: _rainha!,
      detalhes: {
        if (_numero1.text.isNotEmpty)
          (apiario ? 'Quantidade de quadros' : 'Discos de cria'): _numero1.text,
        if (_numero2.text.isNotEmpty)
          (apiario ? 'Quadros de cria' : 'Potes de alimento'): _numero2.text,
        (apiario ? 'Alimento' : 'Condição do ninho'): _condicao!,
      },
    );
    AppFeedback.sucesso(context, 'Colônia salva com sucesso.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final criatorio = AppScope.of(context).criatorio(widget.criatorioId);
    if (criatorio == null) return const TelaNaoEncontrada(titulo: 'Criatório não encontrado');
    final tipo = criatorio.tipo;
    final apiario = tipo == TipoCriatorio.apiario;
    String? obrigatorio(Object? v) => v == null ? 'Selecione.' : null;

    return TelaFormulario(
      titulo: 'Nova colônia',
      subtitulo: '${criatorio.nome} • ${tipo.sufixo}',
      formKey: _formKey,
      children: [
        InfoBanner(icone: tipo.icone, texto: tipo.tituloColonia, tom: tipo.tom, negrito: true),
        const SizedBox(height: AppSpacing.lg),
        LinhaFormulario(children: [
          CampoFormulario(
            rotulo: 'Identificação',
            controller: _identificacao,
            textCapitalization: TextCapitalization.characters,
            validator: (v) => Validators.obrigatorio(v, 'Informe a identificação.'),
          ),
          CampoSelecao<String>(
            rotulo: 'Espécie',
            opcoes: tipo.especies,
            valor: _especie,
            onChanged: (v) => setState(() => _especie = v),
            validator: obrigatorio,
          ),
        ]),
        const SizedBox(height: AppSpacing.md),
        LinhaFormulario(children: [
          CampoSelecao<String>(
            rotulo: 'Tipo de caixa',
            opcoes: tipo.tiposCaixa,
            valor: _tipoCaixa,
            onChanged: (v) => setState(() => _tipoCaixa = v),
            validator: obrigatorio,
          ),
          CampoSelecao<String>(
            rotulo: 'Origem',
            opcoes: OpcoesFormulario.origens,
            valor: _origem,
            onChanged: (v) => setState(() => _origem = v),
            validator: obrigatorio,
          ),
        ]),
        const SizedBox(height: AppSpacing.md),
        LinhaFormulario(children: [
          CampoData(
            rotulo: 'Data de instalação',
            valor: _dataInstalacao,
            ultimaData: DateTime.now(),
            onChanged: (d) => setState(() => _dataInstalacao = d),
          ),
          CampoSelecao<StatusColonia>(
            rotulo: 'Status',
            opcoes: StatusColonia.values,
            valor: _status,
            rotuloDe: (s) => s.rotulo,
            onChanged: (v) => setState(() => _status = v),
            validator: obrigatorio,
          ),
        ]),
        const SizedBox(height: AppSpacing.md),
        TituloSecao(tipo.tituloDados),
        LinhaFormulario(children: [
          CampoSelecao<String>(
            rotulo: 'Presença da rainha',
            opcoes: OpcoesFormulario.simNao,
            valor: _rainha,
            onChanged: (v) => setState(() => _rainha = v),
            validator: obrigatorio,
          ),
          CampoSelecao<String>(
            rotulo: 'Força da colônia',
            opcoes: OpcoesFormulario.forcas,
            valor: _forca,
            onChanged: (v) => setState(() => _forca = v),
            validator: obrigatorio,
          ),
        ]),
        const SizedBox(height: AppSpacing.md),
        LinhaFormulario(children: [
          CampoFormulario.numero(
            rotulo: apiario ? 'Quantidade de quadros' : 'Discos de cria',
            controller: _numero1,
          ),
          CampoFormulario.numero(
            rotulo: apiario ? 'Quadros de cria' : 'Potes de alimento',
            controller: _numero2,
          ),
        ]),
        const SizedBox(height: AppSpacing.md),
        CampoSelecao<String>(
          rotulo: apiario ? 'Alimento' : 'Condição do ninho',
          opcoes: apiario ? OpcoesFormulario.alimentoApiario : OpcoesFormulario.condicaoNinho,
          valor: _condicao,
          onChanged: (v) => setState(() => _condicao = v),
          validator: obrigatorio,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(rotulo: 'Salvar colônia', onPressed: () => _salvar(criatorio)),
      ],
    );
  }
}
