import 'package:flutter/material.dart';

/// Destinos da navegação principal: Início • Criatórios • Tarefas • Produção • Perfil.
enum AbaHome {
  inicio('Início', Icons.home_outlined, Icons.home),
  criatorios('Criatórios', Icons.warehouse_outlined, Icons.warehouse),
  tarefas('Tarefas', Icons.assignment_turned_in_outlined, Icons.assignment_turned_in),
  producao('Produção', Icons.bar_chart_outlined, Icons.bar_chart),
  perfil('Perfil', Icons.person_outline, Icons.person);

  const AbaHome(this.rotulo, this.icone, this.iconeSelecionado);

  final String rotulo;
  final IconData icone;
  final IconData iconeSelecionado;
}
