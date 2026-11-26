import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/routes/app_router.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/widgets.dart';
import '../criatorios/screens/criatorios_screen.dart';
import '../dashboard/screens/dashboard_screen.dart';
import '../perfil/screens/perfil_screen.dart';
import '../producao/screens/producao_screen.dart';
import '../tarefas/screens/tarefas_screen.dart';

/// Estrutura principal após o login.
///
/// Cada aba tem o próprio [Navigator], então telas internas (detalhes,
/// colônias, histórico) mantêm a barra visível e cada aba lembra onde parou.
/// Em telas largas a barra inferior vira um menu lateral.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key, this.abaInicial = AbaHome.inicio});

  final AbaHome abaInicial;

  /// Permite que telas internas troquem de aba ("Ver todos", "Ver agenda").
  static void irPara(BuildContext context, AbaHome aba) =>
      context.findAncestorStateOfType<_HomeShellState>()?._selecionar(aba);

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late AbaHome _atual = widget.abaInicial;
  final _navegadores = {
    for (final aba in AbaHome.values) aba: GlobalKey<NavigatorState>(),
  };

  Widget _raizDa(AbaHome aba) => switch (aba) {
        AbaHome.inicio => const DashboardScreen(),
        AbaHome.criatorios => const CriatoriosScreen(),
        AbaHome.tarefas => const TarefasScreen(),
        AbaHome.producao => const ProducaoScreen(),
        AbaHome.perfil => const PerfilScreen(),
      };

  void _selecionar(AbaHome aba) {
    if (aba == _atual) {
      // Tocar na aba atual volta para a tela inicial dela.
      _navegadores[aba]!.currentState?.popUntil((rota) => rota.isFirst);
      return;
    }
    setState(() => _atual = aba);
  }

  /// Botão voltar do sistema: volta dentro da aba, depois para o Início.
  void _aoVoltar(bool jaVoltou, Object? _) {
    if (jaVoltou) return;
    final navegador = _navegadores[_atual]!.currentState;
    if (navegador != null && navegador.canPop()) {
      navegador.pop();
    } else if (_atual != AbaHome.inicio) {
      setState(() => _atual = AbaHome.inicio);
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final abas = IndexedStack(
      index: _atual.index,
      children: [
        for (final aba in AbaHome.values)
          HeroControllerScope.none(
            child: Navigator(
              key: _navegadores[aba],
              onGenerateRoute: AppRouter.onGenerateRoute,
              onGenerateInitialRoutes: (_, _) => [
                MaterialPageRoute<void>(builder: (_) => _raizDa(aba)),
              ],
            ),
          ),
      ],
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _aoVoltar,
      child: context.telaExpandida
          ? Scaffold(
              body: Row(
                children: [
                  AppSideNav(atual: _atual, onSelecionar: _selecionar),
                  Expanded(child: abas),
                ],
              ),
            )
          : Scaffold(
              body: abas,
              bottomNavigationBar: AppBottomNav(atual: _atual, onSelecionar: _selecionar),
            ),
    );
  }
}
