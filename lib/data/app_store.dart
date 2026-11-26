import 'package:flutter/foundation.dart';

import 'mock/mock_data.dart';
import 'models/models.dart';

/// Estado da aplicação em memória.
///
/// Concentra os dados e as regras usadas pelas telas. Quando houver uma API,
/// basta trocar a origem dos dados aqui, sem alterar as telas.
class AppStore extends ChangeNotifier {
  AppStore({DateTime? agora}) : agora = agora ?? DateTime.now() {
    final mock = MockData(this.agora);
    _criatorios.addAll(mock.criatorios);
    _colonias.addAll(mock.colonias);
    _atividades.addAll(mock.atividades);
    _tarefas.addAll(mock.tarefas);
    _producoes.addAll(mock.producoes);
  }

  /// Senha da conta de demonstração.
  static const senhaDemo = 'Abelh@123';

  final DateTime agora;
  final _criatorios = <Criatorio>[];
  final _colonias = <Colonia>[];
  final _atividades = <Atividade>[];
  final _tarefas = <Tarefa>[];
  final _producoes = <Producao>[];
  Usuario? _usuario;
  int _sequencia = 100;
  bool _descartado = false;

  @override
  void dispose() {
    _descartado = true;
    super.dispose();
  }

  /// Ignora notificações que chegam depois do descarte
  /// (ex.: login concluído após o usuário fechar o app).
  @override
  void notifyListeners() {
    if (!_descartado) super.notifyListeners();
  }

  String _novoId(String prefixo) => '$prefixo${_sequencia++}';

  // ───────────────────────── Autenticação ─────────────────────────

  Usuario get usuario => _usuario ?? MockData.usuarioDemo;
  bool get autenticado => _usuario != null;

  /// Simula a espera de uma API e valida a conta de demonstração.
  Future<bool> entrar(String email, String senha) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final valido = email.trim().toLowerCase() == MockData.usuarioDemo.email &&
        senha == senhaDemo;
    if (valido) {
      _usuario = MockData.usuarioDemo;
      notifyListeners();
    }
    return valido;
  }

  Future<void> cadastrar({required String nome, required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _usuario = Usuario(nome: nome.trim(), email: email.trim().toLowerCase());
    notifyListeners();
  }

  Future<void> recuperarSenha(String email) =>
      Future<void>.delayed(const Duration(milliseconds: 800));

  void sair() {
    _usuario = null;
    notifyListeners();
  }

  // ───────────────────────── Criatórios ─────────────────────────

  List<Criatorio> get criatorios => List.unmodifiable(_criatorios);

  List<Criatorio> criatoriosDoTipo(TipoCriatorio? tipo) => tipo == null
      ? criatorios
      : _criatorios.where((c) => c.tipo == tipo).toList();

  Criatorio? criatorio(String? id) =>
      _criatorios.where((c) => c.id == id).firstOrNull;

  Criatorio adicionarCriatorio({
    required TipoCriatorio tipo,
    required String nome,
    required String localizacao,
    required String municipio,
    required String estado,
    String descricao = '',
    String observacoes = '',
  }) {
    final novo = Criatorio(
      id: _novoId('c'),
      nome: nome.trim(),
      tipo: tipo,
      localizacao: localizacao.trim(),
      municipio: municipio.trim(),
      estado: estado,
      descricao: descricao.trim(),
      observacoes: observacoes.trim(),
    );
    _criatorios.add(novo);
    notifyListeners();
    return novo;
  }

  // ───────────────────────── Colônias ─────────────────────────

  int get totalColonias => _colonias.length;

  List<Colonia> coloniasDo(String criatorioId) =>
      _colonias.where((c) => c.criatorioId == criatorioId).toList();

  Colonia? colonia(String? id) => _colonias.where((c) => c.id == id).firstOrNull;

  /// Sugere a próxima identificação: A-013, M-009...
  String proximaIdentificacao(Criatorio alvo) {
    final total =
        _colonias.where((c) => criatorio(c.criatorioId)?.tipo == alvo.tipo).length + 1;
    return '${alvo.tipo.prefixoColonia}-${total.toString().padLeft(3, '0')}';
  }

  Colonia adicionarColonia({
    required String criatorioId,
    required String identificacao,
    required String especie,
    required String tipoCaixa,
    required String origem,
    required DateTime dataInstalacao,
    required StatusColonia status,
    required String forca,
    required String presencaRainha,
    Map<String, String> detalhes = const {},
  }) {
    final nova = Colonia(
      id: _novoId('col'),
      criatorioId: criatorioId,
      identificacao: identificacao.trim().toUpperCase(),
      especie: especie,
      tipoCaixa: tipoCaixa,
      origem: origem,
      dataInstalacao: dataInstalacao,
      status: status,
      forca: forca,
      presencaRainha: presencaRainha == 'Sim' ? 'Confirmada' : presencaRainha,
      detalhes: detalhes,
    );
    _colonias.add(nova);
    notifyListeners();
    return nova;
  }

  void excluirColonia(String id) {
    _colonias.removeWhere((c) => c.id == id);
    _atividades.removeWhere((a) => a.coloniaId == id);
    notifyListeners();
  }

  // ───────────────────────── Histórico ─────────────────────────

  List<Atividade> atividadesDa(String coloniaId) =>
      _atividades.where((a) => a.coloniaId == coloniaId).toList()
        ..sort((a, b) => b.data.compareTo(a.data));

  List<Atividade> atividadesDoCriatorio(String criatorioId) {
    final ids = coloniasDo(criatorioId).map((c) => c.id).toSet();
    return _atividades.where((a) => ids.contains(a.coloniaId)).toList()
      ..sort((a, b) => b.data.compareTo(a.data));
  }

  int revisoesDoCriatorio(String criatorioId) => atividadesDoCriatorio(criatorioId)
      .where((a) => a.tipo == TipoAtividade.revisao)
      .length;

  void registrarRevisao({
    required String coloniaId,
    required DateTime data,
    required String forca,
    required String presencaRainha,
    required Map<String, String> detalhes,
    String observacoes = '',
  }) {
    final colonia = this.colonia(coloniaId);
    if (colonia == null) return;
    final rainha = presencaRainha == 'Sim' ? 'Rainha presente' : 'Rainha ausente';
    _atividades.add(Atividade(
      id: _novoId('at'),
      coloniaId: coloniaId,
      tipo: TipoAtividade.revisao,
      titulo: 'Revisão',
      descricao: 'Força ${forca.toLowerCase()} • $rainha',
      data: data,
    ));
    final indice = _colonias.indexOf(colonia);
    _colonias[indice] = colonia.copyWith(
      forca: forca,
      presencaRainha: presencaRainha == 'Sim' ? 'Confirmada' : 'Não observada',
      detalhes: {...colonia.detalhes, ...detalhes},
      ultimaRevisao: data,
    );
    notifyListeners();
  }

  void registrarManejo({
    required String coloniaId,
    required String tipoManejo,
    required DateTime data,
    required String descricao,
  }) {
    _atividades.add(Atividade(
      id: _novoId('at'),
      coloniaId: coloniaId,
      tipo: TipoAtividade.manejo,
      titulo: tipoManejo,
      descricao: descricao.trim().isEmpty ? tipoManejo : descricao.trim(),
      data: data,
    ));
    notifyListeners();
  }

  // ───────────────────────── Tarefas ─────────────────────────

  List<Tarefa> get tarefas => List.of(_tarefas)
    ..sort((a, b) {
      if (a.concluida != b.concluida) return a.concluida ? 1 : -1;
      return a.data.compareTo(b.data);
    });

  List<Tarefa> get tarefasPendentes => tarefas.where((t) => !t.concluida).toList();

  /// Tarefas da semana atual (segunda a domingo).
  List<Tarefa> get tarefasDaSemana {
    final inicio = DateTime(agora.year, agora.month, agora.day)
        .subtract(Duration(days: agora.weekday - 1));
    final fim = inicio.add(const Duration(days: 7));
    return _tarefas
        .where((t) => !t.data.isBefore(inicio) && t.data.isBefore(fim))
        .toList();
  }

  void adicionarTarefa({
    required String titulo,
    required DateTime data,
    required Prioridade prioridade,
    String descricao = '',
    String? criatorioId,
    String? coloniaId,
  }) {
    _tarefas.add(Tarefa(
      id: _novoId('t'),
      titulo: titulo.trim(),
      descricao: descricao.trim(),
      criatorioId: criatorioId,
      coloniaId: coloniaId,
      data: data,
      prioridade: prioridade,
    ));
    notifyListeners();
  }

  void alternarTarefa(String id) {
    final indice = _tarefas.indexWhere((t) => t.id == id);
    if (indice < 0) return;
    _tarefas[indice] = _tarefas[indice].copyWith(concluida: !_tarefas[indice].concluida);
    notifyListeners();
  }

  // ───────────────────────── Produção ─────────────────────────

  List<Producao> producoesDoTipo(TipoCriatorio? tipo) => _producoes
      .where((p) => tipo == null || criatorio(p.criatorioId)?.tipo == tipo)
      .toList()
    ..sort((a, b) => b.data.compareTo(a.data));

  double producaoTotal({TipoCriatorio? tipo, String? criatorioId}) => _producoes
      .where((p) => criatorioId == null || p.criatorioId == criatorioId)
      .where((p) => tipo == null || criatorio(p.criatorioId)?.tipo == tipo)
      .fold(0, (soma, p) => soma + p.quantidadeBase);

  double producaoNoMes(DateTime mes, {TipoCriatorio? tipo, String? criatorioId}) =>
      _producoes
          .where((p) => p.data.year == mes.year && p.data.month == mes.month)
          .where((p) => criatorioId == null || p.criatorioId == criatorioId)
          .where((p) => tipo == null || criatorio(p.criatorioId)?.tipo == tipo)
          .fold(0, (soma, p) => soma + p.quantidadeBase);

  /// Variação percentual em relação ao mês anterior (null sem base de comparação).
  double? variacaoMensal({TipoCriatorio? tipo, String? criatorioId}) {
    final atual = producaoNoMes(agora, tipo: tipo, criatorioId: criatorioId);
    final anterior = producaoNoMes(
      DateTime(agora.year, agora.month - 1),
      tipo: tipo,
      criatorioId: criatorioId,
    );
    if (anterior == 0) return null;
    return (atual - anterior) / anterior * 100;
  }

  void adicionarProducao({
    required String criatorioId,
    required String produto,
    required double quantidade,
    required String unidade,
    required DateTime data,
    String? coloniaId,
    String observacoes = '',
  }) {
    _producoes.add(Producao(
      id: _novoId('p'),
      criatorioId: criatorioId,
      coloniaId: coloniaId,
      produto: produto,
      quantidade: quantidade,
      unidade: unidade,
      data: data,
      observacoes: observacoes.trim(),
    ));
    notifyListeners();
  }
}
