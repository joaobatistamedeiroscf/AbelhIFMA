import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../data/app_scope.dart';
import '../data/app_store.dart';
import 'routes/app_router.dart';
import 'routes/app_routes.dart';

class AbelhIFMA extends StatefulWidget {
  const AbelhIFMA({super.key, this.initialRoute = AppRoutes.splash, this.store});

  /// Rota inicial (os testes começam direto no login ou na home).
  final String initialRoute;

  /// Permite injetar um estado pronto, útil em testes.
  final AppStore? store;

  @override
  State<AbelhIFMA> createState() => _AbelhIFMAState();
}

class _AbelhIFMAState extends State<AbelhIFMA> {
  late final AppStore _store = widget.store ?? AppStore();

  @override
  void dispose() {
    if (widget.store == null) _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AppScope(
        store: _store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AbelhIFMA',
          theme: AppTheme.light,
          initialRoute: widget.initialRoute,
          onGenerateRoute: AppRouter.onGenerateRoute,
          // Evita que '/home' gere também a rota '/' (splash) por baixo.
          onGenerateInitialRoutes: (rota) => [
            AppRouter.onGenerateRoute(RouteSettings(name: rota)),
          ],
        ),
      );
}
