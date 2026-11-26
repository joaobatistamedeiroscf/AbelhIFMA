import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/tom_visual.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/widgets/widgets.dart';
import '../widgets/busca_criatorio_delegate.dart';

/// 06 — Lista de criatórios (estados Preenchida e Vazia).
class CriatoriosScreen extends StatefulWidget {
  const CriatoriosScreen({super.key});

  @override
  State<CriatoriosScreen> createState() => _CriatoriosScreenState();
}

class _CriatoriosScreenState extends State<CriatoriosScreen> {
  TipoCriatorio? _filtro;

  String _rotuloFiltro(TipoCriatorio? tipo) => switch (tipo) {
        null => 'Todos',
        TipoCriatorio.apiario => 'Apiários',
        TipoCriatorio.meliponario => 'Meliponários',
      };

  void _abrir(Criatorio criatorio) =>
      context.abrirNaAba(AppRoutes.criatorioDetalhes, argumentos: criatorio.id);

  Future<void> _buscar() async {
    final store = AppScope.read(context);
    final escolhido = await showSearch<Criatorio?>(
      context: context,
      delegate: BuscaCriatorioDelegate(
        store.criatorios,
        totalColonias: (id) => store.coloniasDo(id).length,
      ),
    );
    if (escolhido != null && mounted) _abrir(escolhido);
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final todos = store.criatorios;
    final lista = store.criatoriosDoTipo(_filtro);
    final total = todos.length;

    return Scaffold(
      appBar: AppHeader.logo(
        titulo: 'Meus criatórios',
        subtitulo: '$total ${total == 1 ? 'criatório cadastrado' : 'criatórios cadastrados'}',
        acao: HeaderIconButton(
          icone: Icons.search,
          tooltip: 'Buscar criatório',
          onPressed: todos.isEmpty ? null : _buscar,
        ),
      ),
      floatingActionButton: todos.isEmpty
          ? null
          : FloatingActionButton(
              tooltip: 'Novo criatório',
              backgroundColor: AppColors.amarelo,
              foregroundColor: AppColors.carvao,
              shape: const CircleBorder(),
              onPressed: () => context.abrirTelaCheia(AppRoutes.escolherTipo),
              child: const Icon(Icons.add),
            ),
      body: todos.isEmpty
          ? EmptyState(
              titulo: 'Você ainda não possui criatórios.',
              mensagem: 'Comece cadastrando seu primeiro apiário ou meliponário.',
              rotuloAcao: '+ Novo criatório',
              onAcao: () => context.abrirTelaCheia(AppRoutes.escolherTipo),
            )
          : PageBody(
              children: [
                FiltroChips<TipoCriatorio?>(
                  opcoes: const [null, ...TipoCriatorio.values],
                  selecionado: _filtro,
                  rotuloDe: _rotuloFiltro,
                  onChanged: (tipo) => setState(() => _filtro = tipo),
                ),
                const SizedBox(height: AppSpacing.md),
                if (lista.isEmpty)
                  const CardListaPontuada(itens: [], vazio: 'Nenhum criatório deste tipo.')
                else
                  GradeResponsiva(
                    children: [
                      for (final c in lista)
                        CriatorioCard(
                          criatorio: c,
                          totalColonias: store.coloniasDo(c.id).length,
                          onTap: () => _abrir(c),
                        ),
                    ],
                  ),
                const SizedBox(height: AppSpacing.md),
                InfoBanner(
                  icone: Icons.eco_outlined,
                  tom: TomVisual.verde,
                  texto: '${store.totalColonias} colônias acompanhadas em '
                      '$total ${total == 1 ? 'unidade produtiva' : 'unidades produtivas'}.',
                ),
                // Espaço para o botão flutuante não cobrir o conteúdo.
                const SizedBox(height: 72),
              ],
            ),
    );
  }
}
