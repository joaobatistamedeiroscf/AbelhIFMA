import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/tom_visual.dart';
import '../../../core/utils/validators.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';

/// 08 — Novo apiário / 09 — Novo meliponário.
///
/// Uma única tela atende os dois tipos; textos e cores vêm de [TipoCriatorio].
class NovoCriatorioScreen extends StatefulWidget {
  const NovoCriatorioScreen({super.key, required this.tipo});

  final TipoCriatorio tipo;

  static const estados = [
    'AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA',
    'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO',
  ];

  @override
  State<NovoCriatorioScreen> createState() => _NovoCriatorioScreenState();
}

class _NovoCriatorioScreenState extends State<NovoCriatorioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _localizacao = TextEditingController();
  final _municipio = TextEditingController();
  final _descricao = TextEditingController();
  final _observacoes = TextEditingController();
  String? _estado = 'MA';

  @override
  void dispose() {
    for (final c in [_nome, _localizacao, _municipio, _descricao, _observacoes]) {
      c.dispose();
    }
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    AppScope.read(context).adicionarCriatorio(
      tipo: widget.tipo,
      nome: _nome.text,
      localizacao: _localizacao.text,
      municipio: _municipio.text,
      estado: _estado!,
      descricao: _descricao.text,
      observacoes: _observacoes.text,
    );
    AppFeedback.sucesso(context, '${widget.tipo.nome} salvo com sucesso.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final tipo = widget.tipo;
    final nomeMinusculo = tipo.nome.toLowerCase();
    return TelaFormulario(
      titulo: 'Novo $nomeMinusculo',
      subtitulo: tipo.subtitulo,
      formKey: _formKey,
      children: [
        InfoBanner(icone: tipo.icone, texto: tipo.resumo, tom: tipo.tom, negrito: true),
        const SizedBox(height: AppSpacing.lg),
        CampoFormulario(
          rotulo: 'Nome do $nomeMinusculo',
          hint: tipo == TipoCriatorio.apiario ? 'Apiário São José' : 'Meliponário IFMA',
          controller: _nome,
          textCapitalization: TextCapitalization.words,
          validator: (v) => Validators.obrigatorio(v, 'Informe o nome.'),
        ),
        const SizedBox(height: AppSpacing.md),
        CampoFormulario(
          rotulo: 'Localização',
          hint: 'Comunidade, sítio ou referência',
          controller: _localizacao,
          validator: (v) => Validators.obrigatorio(v, 'Informe a localização.'),
        ),
        const SizedBox(height: AppSpacing.md),
        LinhaFormulario(
          larguraMinima: 260,
          flex: const [3, 2],
          children: [
            CampoFormulario(
              rotulo: 'Município',
              controller: _municipio,
              textCapitalization: TextCapitalization.words,
              validator: (v) => Validators.obrigatorio(v, 'Informe o município.'),
            ),
            CampoSelecao<String>(
              rotulo: 'Estado',
              hint: 'UF',
              opcoes: NovoCriatorioScreen.estados,
              valor: _estado,
              onChanged: (v) => setState(() => _estado = v),
              validator: (v) => v == null ? 'Selecione.' : null,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        CampoFormulario(rotulo: 'Descrição', controller: _descricao),
        const SizedBox(height: AppSpacing.md),
        CampoFormulario(
          rotulo: 'Observações',
          controller: _observacoes,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: AppSpacing.md),
        const InfoBanner(
          icone: Icons.location_on_outlined,
          tom: TomVisual.verde,
          texto: 'Informe uma referência clara para facilitar o manejo em campo.',
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(rotulo: 'Salvar $nomeMinusculo', onPressed: _salvar),
      ],
    );
  }
}
