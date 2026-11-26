import 'package:flutter/widgets.dart';

/// Pontos de quebra seguindo as classes de janela do Material 3.
abstract final class Breakpoints {
  /// Celulares muito estreitos (ex.: 320 px).
  static const compact = 360.0;

  /// A partir daqui listas podem virar grades de 2 colunas.
  static const medium = 600.0;

  /// A partir daqui a barra inferior vira um menu lateral.
  static const expanded = 840.0;
}

extension ResponsiveContext on BuildContext {
  double get larguraTela => MediaQuery.sizeOf(this).width;

  bool get telaCompacta => larguraTela < Breakpoints.compact;

  bool get telaMedia => larguraTela >= Breakpoints.medium;

  bool get telaExpandida => larguraTela >= Breakpoints.expanded;
}
