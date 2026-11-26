import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/tom_visual.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/widgets/widgets.dart';

/// 20 — Produção.
class ProducaoScreen extends StatefulWidget {
  const ProducaoScreen({super.key});

  @override
  State<ProducaoScreen> createState() => _ProducaoScreenState();
}

class _ProducaoScreenState extends State<ProducaoScreen> {
  TipoCriatorio? _filtro;

  String _rotulo(TipoCriatorio? tipo) => switch (tipo) {
        null => 'Todos',
        TipoCriatorio.apiario => 'Apiários',
        TipoCriatorio.meliponario => 'Meliponários',
      };

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final registros = store.producoesDoTipo(_filtro);
    final total = store.producaoTotal(tipo: _filtro);
    final mes = store.producaoNoMes(store.agora, tipo: _filtro);
    final variacao = store.variacaoMensal(tipo: _filtro);
    final mesAnterior = DateTime(store.agora.year, store.agora.month - 1);

    return Scaffold(
      appBar: AppHeader.logo(
        titulo: 'Produção',
        subtitulo: 'Acompanhamento da safra',
        acao: HeaderIconButton(
          icone: Icons.add,
          tooltip: 'Registrar produção',
          onPressed: () => context.abrirTelaCheia(AppRoutes.novaProducao),
        ),
      ),
      body: PageBody(
        children: [
          LinhaIndicadores(
            indicadores: [
              StatCard(
                valor: '${Formatters.quantidade(total)} kg',
                rotulo: 'Produção total',
                tom: TomVisual.verde,
              ),
              StatCard(
                valor: '${Formatters.quantidade(mes)} kg',
                rotulo: 'Este mês',
                tom: TomVisual.amarelo,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          FiltroChips<TipoCriatorio?>(
            opcoes: const [null, ...TipoCriatorio.values],
            selecionado: _filtro,
            rotuloDe: _rotulo,
            onChanged: (t) => setState(() => _filtro = t),
          ),
          const SizedBox(height: AppSpacing.md),
          InfoBanner(
            tom: TomVisual.escuro,
            icone: (variacao ?? 0) >= 0 ? Icons.trending_up : Icons.trending_down,
            titulo: variacao == null
                ? 'Sem base de comparação'
                : '${variacao >= 0 ? '+' : ''}${variacao.round()}% neste mês',
            texto: 'Comparado a ${Formatters.mesExtenso(mesAnterior)} de ${mesAnterior.year}',
          ),
          const TituloSecao('Registros recentes'),
          if (registros.isEmpty)
            const CardListaPontuada(itens: [], vazio: 'Nenhuma produção registrada.')
          else
            GradeResponsiva(
              children: [
                for (final p in registros)
                  ProducaoCard(producao: p, criatorio: store.criatorio(p.criatorioId)),
              ],
            ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            rotulo: '+ Registrar produção',
            onPressed: () => context.abrirTelaCheia(AppRoutes.novaProducao),
          ),
        ],
      ),
    );
  }
}
