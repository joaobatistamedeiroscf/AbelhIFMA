import 'package:flutter/material.dart';

import '../../../core/constants/opcoes_formulario.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';

/// 15 — Nova revisão (Apiário / Meliponário).
class NovaRevisaoScreen extends StatefulWidget {
  const NovaRevisaoScreen({super.key, required this.coloniaId});

  final String coloniaId;

  @override
  State<NovaRevisaoScreen> createState() => _NovaRevisaoScreenState();
}

class _NovaRevisaoScreenState extends State<NovaRevisaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numero1 = TextEditingController();
  final _numero2 = TextEditingController();
  final _observacoes = TextEditingController();

  DateTime _data = DateTime.now();
  String? _responsavel = OpcoesFormulario.responsaveis.first;
  String? _forca = 'Forte';
  String? _rainha = 'Sim';
  String? _cria = OpcoesFormulario.situacaoCria.first;
  String? _alimento = OpcoesFormulario.disponibilidadeAlimento.first;
  String? _estado; // estado da colmeia ou condição do ninho
  String? _entrada = OpcoesFormulario.condicaoEntrada.first;

  @override
  void dispose() {
    for (final c in [_numero1, _numero2, _observacoes]) {
      c.dispose();
    }
    super.dispose();
  }

  void _salvar(TipoCriatorio tipo) {
    if (!_formKey.currentState!.validate()) return;
    final apiario = tipo == TipoCriatorio.apiario;
    AppScope.read(context).registrarRevisao(
      coloniaId: widget.coloniaId,
      data: _data,
      forca: _forca!,
      presencaRainha: _rainha!,
      observacoes: _observacoes.text,
      detalhes: {
        if (_numero1.text.isNotEmpty) (apiario ? 'Quadros de cria' : 'Discos de cria'): _numero1.text,
        if (_numero2.text.isNotEmpty)
          (apiario ? 'Quantidade de quadros' : 'Potes de alimento'): _numero2.text,
        if (!apiario && _estado != null) 'Condição do ninho': _estado!,
      },
    );
    AppFeedback.sucesso(context, 'Revisão salva com sucesso.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final colonia = store.colonia(widget.coloniaId);
    final criatorio = store.criatorio(colonia?.criatorioId);
    if (colonia == null || criatorio == null) {
      return const TelaNaoEncontrada(titulo: 'Colônia não encontrada');
    }
    final tipo = criatorio.tipo;
    final apiario = tipo == TipoCriatorio.apiario;
    final opcoesEstado =
        apiario ? OpcoesFormulario.estadoColmeia : OpcoesFormulario.condicaoNinho.sublist(1);
    _estado ??= opcoesEstado.first;

    return TelaFormulario(
      titulo: 'Nova revisão',
      subtitulo: '${colonia.identificacao} • ${criatorio.nome}',
      formKey: _formKey,
      children: [
        LinhaFormulario(children: [
          CampoData(
            rotulo: 'Data',
            valor: _data,
            ultimaData: DateTime.now(),
            onChanged: (d) => setState(() => _data = d),
          ),
          CampoSelecao<String>(
            rotulo: 'Responsável',
            opcoes: OpcoesFormulario.responsaveis,
            valor: _responsavel,
            onChanged: (v) => setState(() => _responsavel = v),
          ),
        ]),
        const SizedBox(height: AppSpacing.md),
        LinhaFormulario(children: [
          CampoSelecao<String>(
            rotulo: 'Força',
            opcoes: OpcoesFormulario.forcas,
            valor: _forca,
            onChanged: (v) => setState(() => _forca = v),
          ),
          CampoSelecao<String>(
            rotulo: 'Presença da rainha',
            opcoes: OpcoesFormulario.simNao,
            valor: _rainha,
            onChanged: (v) => setState(() => _rainha = v),
          ),
        ]),
        const SizedBox(height: AppSpacing.md),
        LinhaFormulario(children: [
          CampoSelecao<String>(
            rotulo: 'Situação da cria',
            opcoes: OpcoesFormulario.situacaoCria,
            valor: _cria,
            onChanged: (v) => setState(() => _cria = v),
          ),
          CampoSelecao<String>(
            rotulo: 'Disponibilidade de alimento',
            opcoes: OpcoesFormulario.disponibilidadeAlimento,
            valor: _alimento,
            onChanged: (v) => setState(() => _alimento = v),
          ),
        ]),
        const SizedBox(height: AppSpacing.md),
        InfoBanner(icone: tipo.icone, texto: tipo.tituloRevisao, tom: tipo.tom, negrito: true),
        const SizedBox(height: AppSpacing.md),
        LinhaFormulario(children: [
          CampoFormulario.numero(
            rotulo: apiario ? 'Quadros de cria' : 'Discos de cria',
            controller: _numero1,
          ),
          CampoFormulario.numero(
            rotulo: apiario ? 'Quantidade de quadros' : 'Potes de alimento',
            controller: _numero2,
          ),
        ]),
        const SizedBox(height: AppSpacing.md),
        if (apiario)
          CampoSelecao<String>(
            rotulo: 'Estado da colmeia',
            opcoes: opcoesEstado,
            valor: _estado,
            onChanged: (v) => setState(() => _estado = v),
          )
        else
          LinhaFormulario(children: [
            CampoSelecao<String>(
              rotulo: 'Condição do ninho',
              opcoes: opcoesEstado,
              valor: _estado,
              onChanged: (v) => setState(() => _estado = v),
            ),
            CampoSelecao<String>(
              rotulo: 'Condição da entrada',
              opcoes: OpcoesFormulario.condicaoEntrada,
              valor: _entrada,
              onChanged: (v) => setState(() => _entrada = v),
            ),
          ]),
        const SizedBox(height: AppSpacing.md),
        CampoFormulario(
          rotulo: 'Observações',
          controller: _observacoes,
          hint: 'Como a colônia está se desenvolvendo?',
          maxLines: 3,
          textInputAction: TextInputAction.newline,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(rotulo: 'Salvar revisão', onPressed: () => _salvar(tipo)),
      ],
    );
  }
}
