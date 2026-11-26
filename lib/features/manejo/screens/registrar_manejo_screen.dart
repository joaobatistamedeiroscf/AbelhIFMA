import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/tom_visual.dart';
import '../../../core/utils/validators.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';

/// 17 — Registrar manejo (Apiário / Meliponário).
class RegistrarManejoScreen extends StatefulWidget {
  const RegistrarManejoScreen({super.key, required this.coloniaId});

  final String coloniaId;

  @override
  State<RegistrarManejoScreen> createState() => _RegistrarManejoScreenState();
}

class _RegistrarManejoScreenState extends State<RegistrarManejoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descricao = TextEditingController();
  final _observacoes = TextEditingController();
  String _tipoManejo = 'Alimentação';
  DateTime _data = DateTime.now();

  @override
  void dispose() {
    _descricao.dispose();
    _observacoes.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    final observacoes = _observacoes.text.trim();
    AppScope.read(context).registrarManejo(
      coloniaId: widget.coloniaId,
      tipoManejo: _tipoManejo,
      data: _data,
      descricao: observacoes.isEmpty ? _descricao.text : '${_descricao.text.trim()} • $observacoes',
    );
    AppFeedback.sucesso(context, 'Manejo registrado com sucesso.');
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

    return TelaFormulario(
      titulo: 'Registrar manejo',
      subtitulo: '${colonia.identificacao} • ${criatorio.nome}',
      formKey: _formKey,
      children: [
        InfoBanner(icone: tipo.icone, texto: tipo.tituloManejo, tom: tipo.tom, negrito: true),
        const TituloSecao('Tipo de manejo'),
        ChipsSelecao<String>(
          opcoes: tipo.tiposManejo,
          selecionado: _tipoManejo,
          corSelecionado: tipo == TipoCriatorio.apiario ? AppColors.amarelo : AppColors.verde,
          onChanged: (v) => setState(() => _tipoManejo = v),
        ),
        const SizedBox(height: AppSpacing.lg),
        CampoData(
          rotulo: 'Data',
          valor: _data,
          ultimaData: DateTime.now(),
          onChanged: (d) => setState(() => _data = d),
        ),
        const SizedBox(height: AppSpacing.md),
        CampoFormulario(
          rotulo: 'Descrição',
          controller: _descricao,
          hint: 'Ex.: Alimentação com xarope 1:1',
          validator: (v) => Validators.obrigatorio(v, 'Descreva o manejo.'),
        ),
        const SizedBox(height: AppSpacing.md),
        CampoFormulario(
          rotulo: 'Observações',
          controller: _observacoes,
          hint: 'Ex.: Aplicados 2 litros ao entardecer.',
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: AppSpacing.md),
        const InfoBanner(
          icone: Icons.verified_user_outlined,
          tom: TomVisual.verde,
          texto: 'Registre detalhes suficientes para apoiar o próximo manejo.',
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(rotulo: 'Salvar manejo', onPressed: _salvar),
      ],
    );
  }
}
