import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/tom_visual.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/app_scope.dart';
import '../../../data/models/models.dart';
import '../../../shared/extensions/visual_extensions.dart';
import '../../../shared/widgets/widgets.dart';
import '../../home/home_shell.dart';

/// 05 — Dashboard / Início.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final criatorios = store.criatorios;
    final proximas = store.tarefasPendentes.take(3).toList();
    final coloniasEmAtencao = criatorios
        .expand((c) => store.coloniasDo(c.id))
        .where((c) => c.status == StatusColonia.atencao || c.status == StatusColonia.problema)
        .length;

    return Scaffold(
      appBar: AppHeader.logo(
        titulo: 'AbelhIFMA',
        subtitulo: 'Gestão rural inteligente',
        acao: HeaderIconButton(
          icone: Icons.notifications_none,
          tooltip: 'Notificações',
          onPressed: () => AppFeedback.informar(
            context,
            'Notificações',
            coloniasEmAtencao == 0
                ? 'Nenhum alerta no momento.'
                : '$coloniasEmAtencao colônias precisam de atenção.',
          ),
        ),
      ),
      body: PageBody(
        children: [
          Text('Olá, ${store.usuario.primeiroNome}! 👋', style: AppTextStyles.display),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Vamos cuidar das suas abelhas.',
            style: AppTextStyles.body.copyWith(
              fontSize: 15,
              color: AppColors.textoSecundario,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          LinhaIndicadores(
            indicadores: [
              StatCard(
                valor: '${store.criatoriosDoTipo(TipoCriatorio.apiario).length}',
                rotulo: 'Apiários',
                tom: TomVisual.amarelo,
              ),
              StatCard(
                valor: '${store.criatoriosDoTipo(TipoCriatorio.meliponario).length}',
                rotulo: 'Meliponários',
                tom: TomVisual.verde,
              ),
              StatCard(
                valor: '${store.totalColonias}',
                rotulo: 'Colônias',
                tom: TomVisual.cinza,
              ),
              StatCard(
                valor: '${store.tarefasPendentes.length}',
                rotulo: 'Pendentes',
                tom: TomVisual.amarelo,
              ),
            ],
          ),
          if (coloniasEmAtencao > 0) ...[
            const SizedBox(height: AppSpacing.md),
            InfoBanner(
              icone: Icons.warning_amber_rounded,
              texto: '$coloniasEmAtencao colônias precisam de atenção.',
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          TituloSecao(
            'Meus criatórios',
            rotuloAcao: 'Ver todos',
            onAcao: () => HomeShell.irPara(context, AbaHome.criatorios),
          ),
          if (criatorios.isEmpty)
            const CardListaPontuada(itens: [], vazio: 'Nenhum criatório cadastrado.')
          else
            GradeResponsiva(
              larguraMinimaItem: 150,
              maxColunas: 4,
              children: [
                for (final c in criatorios)
                  CriatorioResumoCard(
                    criatorio: c,
                    totalColonias: store.coloniasDo(c.id).length,
                    onTap: () => context.abrirNaAba(AppRoutes.criatorioDetalhes, argumentos: c.id),
                  ),
              ],
            ),
          const SizedBox(height: AppSpacing.md),
          TituloSecao(
            'Próximas tarefas',
            rotuloAcao: 'Ver agenda',
            onAcao: () => HomeShell.irPara(context, AbaHome.tarefas),
          ),
          CardListaPontuada(
            vazio: 'Nenhuma tarefa pendente. 🎉',
            itens: [
              for (final t in proximas)
                ItemPontuado(
                  corPonto: t.prioridade.tom.destaque,
                  titulo: t.titulo,
                  subtitulo: store.criatorio(t.criatorioId)?.nome,
                  trailing: StatusChip(
                    texto: Formatters.dataRelativa(t.data, agora: store.agora),
                    tom: Formatters.dataRelativa(t.data, agora: store.agora) == 'Hoje'
                        ? TomVisual.vermelho
                        : TomVisual.amarelo,
                  ),
                  onTap: () => HomeShell.irPara(context, AbaHome.tarefas),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            rotulo: '+ Novo criatório',
            onPressed: () => context.abrirTelaCheia(AppRoutes.escolherTipo),
          ),
        ],
      ),
    );
  }
}
