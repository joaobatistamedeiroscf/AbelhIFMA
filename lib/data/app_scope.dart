import 'package:flutter/widgets.dart';

import 'app_store.dart';

/// Disponibiliza o [AppStore] para toda a árvore de widgets.
///
/// - `AppScope.of(context)`: lê e reconstrói o widget quando os dados mudam.
/// - `AppScope.read(context)`: apenas lê (use em callbacks como onPressed).
class AppScope extends InheritedNotifier<AppStore> {
  const AppScope({super.key, required AppStore store, required super.child})
      : super(notifier: store);

  static AppStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope não encontrado na árvore de widgets.');
    return scope!.notifier!;
  }

  static AppStore read(BuildContext context) {
    final element = context.getElementForInheritedWidgetOfExactType<AppScope>();
    assert(element != null, 'AppScope não encontrado na árvore de widgets.');
    return (element!.widget as AppScope).notifier!;
  }
}
