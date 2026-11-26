/// Nomes de todas as rotas do aplicativo.
///
/// - **Raiz**: telas de tela cheia, sem barra de navegação (autenticação e
///   formulários). Abra com `context.abrirTelaCheia(...)`.
/// - **Aba**: telas de consulta que mantêm a barra de navegação visível,
///   empilhadas dentro da aba atual. Abra com `context.abrirNaAba(...)`.
abstract final class AppRoutes {
  // Raiz — fluxo de entrada
  static const splash = '/';
  static const login = '/login';
  static const cadastro = '/cadastro';
  static const recuperarSenha = '/recuperar-senha';
  static const home = '/home';

  // Raiz — formulários
  static const escolherTipo = '/criatorios/novo';
  static const novoCriatorio = '/criatorios/novo/formulario';
  static const novaColonia = '/colonias/nova';
  static const novaRevisao = '/revisoes/nova';
  static const registrarManejo = '/manejos/novo';
  static const novaTarefa = '/tarefas/nova';
  static const novaProducao = '/producao/nova';

  // Aba — telas internas que mantêm a barra inferior
  static const criatorioDetalhes = '/criatorios/detalhes';
  static const colonias = '/colonias';
  static const coloniaDetalhes = '/colonias/detalhes';
  static const historico = '/historico';
}
