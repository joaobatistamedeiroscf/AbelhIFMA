import 'package:flutter/material.dart';

import '../../data/models/tipo_criatorio.dart';
import '../../features/auth/screens/cadastro_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/recuperar_senha_screen.dart';
import '../../features/colonias/screens/colonia_detalhes_screen.dart';
import '../../features/colonias/screens/colonias_screen.dart';
import '../../features/colonias/screens/nova_colonia_screen.dart';
import '../../features/criatorios/screens/criatorio_detalhes_screen.dart';
import '../../features/criatorios/screens/escolher_tipo_screen.dart';
import '../../features/criatorios/screens/novo_criatorio_screen.dart';
import '../../features/historico/screens/historico_screen.dart';
import '../../features/home/home_shell.dart';
import '../../features/manejo/screens/registrar_manejo_screen.dart';
import '../../features/producao/screens/nova_producao_screen.dart';
import '../../features/revisoes/screens/nova_revisao_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/tarefas/screens/nova_tarefa_screen.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import 'app_routes.dart';

/// Argumentos opcionais da tela de registrar produção.
class NovaProducaoArgs {
  const NovaProducaoArgs({this.criatorioId, this.coloniaId});
  final String? criatorioId;
  final String? coloniaId;
}

/// Gera as páginas a partir do nome da rota e dos argumentos.
///
/// O mesmo gerador atende o navegador raiz e os navegadores de cada aba.
abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final Widget pagina = switch (settings.name) {
      AppRoutes.splash => const SplashScreen(),
      AppRoutes.login => const LoginScreen(),
      AppRoutes.cadastro => const CadastroScreen(),
      AppRoutes.recuperarSenha => const RecuperarSenhaScreen(),
      AppRoutes.home => const HomeShell(),
      AppRoutes.escolherTipo => const EscolherTipoScreen(),
      AppRoutes.novoCriatorio when args is TipoCriatorio =>
        NovoCriatorioScreen(tipo: args),
      AppRoutes.criatorioDetalhes when args is String =>
        CriatorioDetalhesScreen(criatorioId: args),
      AppRoutes.colonias when args is String => ColoniasScreen(criatorioId: args),
      AppRoutes.novaColonia when args is String =>
        NovaColoniaScreen(criatorioId: args),
      AppRoutes.coloniaDetalhes when args is String =>
        ColoniaDetalhesScreen(coloniaId: args),
      AppRoutes.historico when args is String => HistoricoScreen(coloniaId: args),
      AppRoutes.novaRevisao when args is String => NovaRevisaoScreen(coloniaId: args),
      AppRoutes.registrarManejo when args is String =>
        RegistrarManejoScreen(coloniaId: args),
      AppRoutes.novaTarefa => const NovaTarefaScreen(),
      AppRoutes.novaProducao => NovaProducaoScreen(
          args: args is NovaProducaoArgs ? args : const NovaProducaoArgs(),
        ),
      _ => const _RotaInvalida(),
    };
    return MaterialPageRoute<dynamic>(builder: (_) => pagina, settings: settings);
  }
}

class _RotaInvalida extends StatelessWidget {
  const _RotaInvalida();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: EmptyState(
          icone: Icons.explore_off_outlined,
          titulo: 'Página não encontrada',
          mensagem: 'O conteúdo solicitado não está disponível.',
          rotuloAcao: 'Voltar',
          onAcao: () => Navigator.of(context).maybePop(),
        ),
      );
}
