import 'package:flutter/widgets.dart';

/// Atalhos de navegação usados pelas telas.
extension AppNavigation on BuildContext {
  /// Empilha a rota dentro da aba atual, mantendo a barra de navegação.
  Future<T?> abrirNaAba<T extends Object?>(String rota, {Object? argumentos}) =>
      Navigator.of(this).pushNamed<T>(rota, arguments: argumentos);

  /// Abre a rota em tela cheia, acima da barra de navegação (formulários).
  Future<T?> abrirTelaCheia<T extends Object?>(String rota, {Object? argumentos}) =>
      Navigator.of(this, rootNavigator: true).pushNamed<T>(rota, arguments: argumentos);

  /// Substitui toda a pilha raiz pela rota (ex.: login → home, sair → login).
  Future<T?> reiniciarEm<T extends Object?>(String rota) =>
      Navigator.of(this, rootNavigator: true)
          .pushNamedAndRemoveUntil<T>(rota, (_) => false);

  void voltar<T extends Object?>([T? resultado]) => Navigator.of(this).pop<T>(resultado);
}
