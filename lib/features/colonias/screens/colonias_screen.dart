import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';

/// 11 — Lista de colônias (estados Preenchida e Vazia).
class ColoniasScreen extends StatefulWidget {
  const ColoniasScreen({super.key, required this.criatorioId});

  final String criatorioId;

  @override
  State<ColoniasScreen> createState() => _ColoniasScreenState();
}

class _ColoniasScreenState extends State<ColoniasScreen> {
  StatusColonia? _filtro;
  bool _buscando = false;
  String _termo = '';

  static const _filtros = [
    null,
    StatusColonia.ativa,
    StatusColonia.atencao,
    StatusColonia.inativa,
  ];

  String _rotulo(StatusColonia? status) => switch (status) {
        null => 'Todas',
        StatusColonia.ativa => 'Ativas',
        StatusColonia.atencao => 'Atenção',
        StatusColonia.problema => 'Problema',
        StatusColonia.inativa => 'Inativas',
      };

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final criatorio = store.criatorio(widget.criatorioId);
    if (criatorio == null) return const TelaNaoEncontrada(titulo: 'Criatório não encontrado');

    final todas = store.coloniasDo(criatorio.id);
    final termo = _termo.trim().toLowerCase();
    final lista = todas
        .where((c) => _filtro == null || c.status == _filtro)
        .where((c) =>
            termo.isEmpty ||
            c.identificacao.toLowerCase().contains(termo) ||
            c.especie.toLowerCase().contains(termo))
        .toList();
    final ativas = todas.where((c) => c.status == StatusColonia.ativa).length;
    final atencao = todas.where((c) => c.status == StatusColonia.atencao).length;

    void novaColonia() => context.abrirTelaCheia(AppRoutes.novaColonia, argumentos: criatorio.id);

    return Scaffold(
      appBar: AppHeader.voltar(
        titulo: 'Colônias',
        subtitulo: criatorio.nome,
        acao: todas.isEmpty
            ? null
            : HeaderIconButton(
                icone: _buscando ? Icons.close : Icons.search,
                tooltip: _buscando ? 'Fechar busca' : 'Buscar colônia',
                onPressed: () => setState(() {
                  _buscando = !_buscando;
                  _termo = '';
                }),
              ),
      ),
      body: todas.isEmpty
          ? EmptyState(
              titulo: 'Nenhuma colônia cadastrada.',
              mensagem: 'Cadastre a primeira colônia deste criatório para iniciar o acompanhamento.',
              rotuloAcao: '+ Nova colônia',
              onAcao: novaColonia,
            )
          : PageBody(
              children: [
                if (_buscando) ...[
                  TextField(
                    autofocus: true,
                    onChanged: (v) => setState(() => _termo = v),
                    decoration: const InputDecoration(
                      hintText: 'Buscar por identificação ou espécie',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                FiltroChips<StatusColonia?>(
                  opcoes: _filtros,
                  selecionado: _filtro,
                  rotuloDe: _rotulo,
                  onChanged: (s) => setState(() => _filtro = s),
                ),
                const SizedBox(height: AppSpacing.md),
                InfoBanner(
                  icone: criatorio.tipo.icone,
                  tom: criatorio.tipo.tom,
                  negrito: true,
                  texto: '${todas.length} colônias • $ativas ativas • $atencao em atenção',
                ),
                const SizedBox(height: AppSpacing.md),
                if (lista.isEmpty)
                  const CardListaPontuada(itens: [], vazio: 'Nenhuma colônia encontrada.')
                else
                  GradeResponsiva(
                    children: [
                      for (final c in lista)
                        ColoniaCard(
                          colonia: c,
                          tipo: criatorio.tipo,
                          onTap: () => context.abrirNaAba(AppRoutes.coloniaDetalhes, argumentos: c.id),
                        ),
                    ],
                  ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(rotulo: '+ Nova colônia', onPressed: novaColonia),
              ],
            ),
    );
  }
}
