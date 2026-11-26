import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_router.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/tom_visual.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/app_scope.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';

/// 10 — Detalhes do criatório.
class CriatorioDetalhesScreen extends StatelessWidget {
  const CriatorioDetalhesScreen({super.key, required this.criatorioId});

  final String criatorioId;

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final criatorio = store.criatorio(criatorioId);
    if (criatorio == null) return const TelaNaoEncontrada(titulo: 'Criatório não encontrado');

    final colonias = store.coloniasDo(criatorio.id);
    final atividades = store.atividadesDoCriatorio(criatorio.id).take(4).toList();
    final variacao = store.variacaoMensal(criatorioId: criatorio.id);
    final producaoMes = store.producaoNoMes(store.agora, criatorioId: criatorio.id);

    void novaColonia() => context.abrirTelaCheia(AppRoutes.novaColonia, argumentos: criatorio.id);

    return Scaffold(
      appBar: AppHeader.voltar(
        titulo: criatorio.nome,
        subtitulo: '${criatorio.tipo.nome} • ${criatorio.cidadeUf}',
        acao: PopupMenuButton<String>(
          tooltip: 'Mais opções',
          icon: const Icon(Icons.more_vert),
          onSelected: (opcao) => switch (opcao) {
            'colonias' => context.abrirNaAba(AppRoutes.colonias, argumentos: criatorio.id),
            'producao' => context.abrirTelaCheia(
                AppRoutes.novaProducao,
                argumentos: NovaProducaoArgs(criatorioId: criatorio.id),
              ),
            _ => null,
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'colonias', child: Text('Ver colônias')),
            PopupMenuItem(value: 'producao', child: Text('Registrar produção')),
          ],
        ),
      ),
      body: PageBody(
        children: [
          LinhaIndicadores(
            indicadores: [
              StatCard(valor: '${colonias.length}', rotulo: 'Colônias', tom: TomVisual.amarelo),
              StatCard(
                valor: '${store.revisoesDoCriatorio(criatorio.id)}',
                rotulo: 'Revisões',
                tom: TomVisual.verde,
              ),
              StatCard(
                valor: '${Formatters.quantidade(store.producaoTotal(criatorioId: criatorio.id))} kg',
                rotulo: 'Produção',
                tom: TomVisual.cinza,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          LinhaFormulario(
            larguraMinima: 280,
            children: [
              AppButton(rotulo: '+ Nova colônia', onPressed: novaColonia),
              AppButton(
                rotulo: 'Registrar atividade',
                variante: VarianteBotao.secundario,
                onPressed: colonias.isEmpty
                    ? novaColonia
                    : () => context.abrirNaAba(AppRoutes.colonias, argumentos: criatorio.id),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TituloSecao(
            'Colônias',
            rotuloAcao: 'Ver todas',
            onAcao: () => context.abrirNaAba(AppRoutes.colonias, argumentos: criatorio.id),
          ),
          CardListaPontuada(
            vazio: 'Nenhuma colônia cadastrada.',
            itens: [
              for (final c in colonias.take(3))
                ItemPontuado(
                  corPonto: c.status.tom.destaque,
                  titulo: '${c.identificacao} • ${c.especie}',
                  subtitulo: c.ultimaRevisao == null
                      ? 'Ainda não revisada'
                      : 'Revisada em ${Formatters.data(c.ultimaRevisao!)}',
                  trailing: StatusChip(texto: c.status.rotulo, tom: c.status.tom),
                  onTap: () => context.abrirNaAba(AppRoutes.coloniaDetalhes, argumentos: c.id),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const TituloSecao('Atividades recentes'),
          CardListaPontuada(
            vazio: 'Nenhuma atividade registrada.',
            itens: [
              for (final a in atividades)
                ItemPontuado(
                  corPonto: a.tom.destaque,
                  titulo: a.titulo == 'Revisão' ? 'Revisão concluída' : a.titulo,
                  subtitulo: '${store.colonia(a.coloniaId)?.identificacao ?? ''} • ${a.descricao}',
                  trailing: StatusChip(
                    texto: Formatters.diaMesAbreviado(a.data),
                    tom: TomVisual.amarelo,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          InfoBanner(
            icone: Icons.balance_outlined,
            tom: TomVisual.verde,
            titulo: 'Produção em ${Formatters.mesExtenso(store.agora)}',
            texto: '${Formatters.quantidade(producaoMes)} kg de mel'
                '${variacao == null ? '' : ' • ${variacao >= 0 ? '+' : ''}${variacao.round()}% no mês'}',
            onTap: () => context.abrirTelaCheia(
              AppRoutes.novaProducao,
              argumentos: NovaProducaoArgs(criatorioId: criatorio.id),
            ),
          ),
        ],
      ),
    );
  }
}
