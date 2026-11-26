import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_router.dart';
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

/// 13 — Detalhes da colônia (Apiário) / 14 — Detalhes da colônia (Meliponário).
class ColoniaDetalhesScreen extends StatelessWidget {
  const ColoniaDetalhesScreen({super.key, required this.coloniaId});

  final String coloniaId;

  Future<void> _excluir(BuildContext context, Colonia colonia) async {
    final confirmado = await AppFeedback.confirmar(
      context,
      titulo: 'Excluir colônia?',
      mensagem: 'Esta ação não poderá ser desfeita. O histórico será removido.',
      rotuloConfirmar: 'Excluir',
      perigo: true,
    );
    if (!confirmado || !context.mounted) return;
    final store = AppScope.read(context);
    AppFeedback.sucesso(context, 'Colônia ${colonia.identificacao} excluída.');
    Navigator.of(context).pop();
    // Remove após a animação de saída, evitando exibir "não encontrada".
    Future<void>.delayed(
      const Duration(milliseconds: 400),
      () => store.excluirColonia(colonia.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final colonia = store.colonia(coloniaId);
    final criatorio = store.criatorio(colonia?.criatorioId);
    if (colonia == null || criatorio == null) {
      return const TelaNaoEncontrada(titulo: 'Colônia não encontrada');
    }
    final tipo = criatorio.tipo;
    final atividades = store.atividadesDa(colonia.id).take(3).toList();

    void historico() => context.abrirNaAba(AppRoutes.historico, argumentos: colonia.id);

    return Scaffold(
      appBar: AppHeader.voltar(
        titulo: colonia.identificacao,
        subtitulo: '${colonia.especie} • ${criatorio.nome}',
        acao: PopupMenuButton<String>(
          tooltip: 'Mais opções',
          icon: const Icon(Icons.more_vert),
          onSelected: (opcao) {
            if (opcao == 'historico') historico();
            if (opcao == 'excluir') _excluir(context, colonia);
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'historico', child: Text('Ver histórico')),
            PopupMenuItem(
              value: 'excluir',
              child: Text('Excluir colônia', style: TextStyle(color: AppColors.erro)),
            ),
          ],
        ),
      ),
      body: PageBody(
        children: [
          Row(
            children: [
              IconeQuadrado(icone: tipo.icone, corFundo: tipo.tom.fundo, corIcone: tipo.tom.destaque),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  tipo.abelhas,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textoSecundario),
                ),
              ),
              StatusChip(texto: colonia.status.rotulo, tom: colonia.status.tom),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          LinhaAcoesRapidas(
            acoes: [
              AcaoRapidaCard(
                icone: Icons.fact_check_outlined,
                rotulo: 'Nova revisão',
                tom: TomVisual.amarelo,
                onTap: () => context.abrirTelaCheia(AppRoutes.novaRevisao, argumentos: colonia.id),
              ),
              AcaoRapidaCard(
                icone: Icons.build_outlined,
                rotulo: 'Novo manejo',
                tom: TomVisual.verde,
                onTap: () =>
                    context.abrirTelaCheia(AppRoutes.registrarManejo, argumentos: colonia.id),
              ),
              AcaoRapidaCard(
                icone: Icons.balance_outlined,
                rotulo: 'Registrar produção',
                tom: TomVisual.amarelo,
                onTap: () => context.abrirTelaCheia(
                  AppRoutes.novaProducao,
                  argumentos: NovaProducaoArgs(criatorioId: criatorio.id, coloniaId: colonia.id),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          DetalhesCard(
            itens: [
              (tipo.nome, criatorio.nomeCurto),
              ('Tipo de caixa', colonia.tipoCaixa),
              ('Data de instalação', Formatters.data(colonia.dataInstalacao)),
              ('Origem', colonia.origem),
              ('Força', colonia.forca),
              ('Presença da rainha', colonia.presencaRainha),
              for (final item in colonia.detalhes.entries) (item.key, item.value),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TituloSecao('Últimas atividades', rotuloAcao: 'Histórico', onAcao: historico),
          CardListaPontuada(
            vazio: 'Nenhuma atividade registrada.',
            itens: [
              for (final a in atividades)
                ItemPontuado(
                  corPonto: a.tom.destaque,
                  titulo: '${a.titulo} • ${Formatters.diaMesAbreviado(a.data)}',
                  subtitulo: a.descricao,
                  onTap: historico,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
