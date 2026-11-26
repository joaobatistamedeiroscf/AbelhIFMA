import '../models/models.dart';

/// Dados de demonstração baseados no protótipo do Figma.
///
/// As datas são relativas a [agora] para que "Hoje", "Este mês" e o
/// histórico continuem coerentes em qualquer dia em que o app for aberto.
class MockData {
  MockData(DateTime agora) : _hoje = DateTime(agora.year, agora.month, agora.day);

  final DateTime _hoje;

  DateTime _dias(int quantidade) => _hoje.add(Duration(days: quantidade));

  static const usuarioDemo = Usuario(
    nome: 'João Silva',
    email: 'joao.silva@ifma.edu.br',
  );

  List<Criatorio> get criatorios => const [
        Criatorio(
          id: 'c1',
          nome: 'Apiário São José',
          tipo: TipoCriatorio.apiario,
          localizacao: 'Comunidade São Pedro',
          municipio: 'São Luís',
          estado: 'MA',
          descricao: 'Área produtiva com 12 colmeias',
          observacoes: 'Acesso pela estrada principal',
        ),
        Criatorio(
          id: 'c2',
          nome: 'Meliponário IFMA',
          tipo: TipoCriatorio.meliponario,
          localizacao: 'Campus IFMA',
          municipio: 'Caxias',
          estado: 'MA',
          descricao: 'Unidade didática de meliponicultura',
          observacoes: 'Acesso pela estrada principal',
        ),
        Criatorio(
          id: 'c3',
          nome: 'Apiário Boa Vista',
          tipo: TipoCriatorio.apiario,
          localizacao: 'Povoado Boa Vista',
          municipio: 'Codó',
          estado: 'MA',
        ),
      ];

  List<Colonia> get colonias => [
        Colonia(
          id: 'col1',
          criatorioId: 'c1',
          identificacao: 'A-001',
          especie: 'Apis mellifera',
          tipoCaixa: 'Langstroth',
          origem: 'Enxame capturado',
          dataInstalacao: DateTime(_hoje.year, 3, 10),
          status: StatusColonia.ativa,
          forca: 'Forte',
          presencaRainha: 'Confirmada',
          detalhes: const {'Quantidade de quadros': '10', 'Quadros de cria': '6'},
          ultimaRevisao: _dias(-2),
        ),
        Colonia(
          id: 'col2',
          criatorioId: 'c1',
          identificacao: 'A-005',
          especie: 'Apis mellifera',
          tipoCaixa: 'Langstroth',
          origem: 'Divisão',
          dataInstalacao: DateTime(_hoje.year, 4, 22),
          status: StatusColonia.atencao,
          forca: 'Média',
          presencaRainha: 'Confirmada',
          detalhes: const {'Quantidade de quadros': '10', 'Quadros de cria': '3'},
          ultimaRevisao: _dias(-15),
        ),
        Colonia(
          id: 'col3',
          criatorioId: 'c2',
          identificacao: 'M-001',
          especie: 'Jataí',
          tipoCaixa: 'INPA',
          origem: 'Divisão',
          dataInstalacao: DateTime(_hoje.year, 3, 10),
          status: StatusColonia.ativa,
          forca: 'Forte',
          presencaRainha: 'Confirmada',
          detalhes: const {
            'Discos de cria': '5',
            'Potes de alimento': '12',
            'Condição do ninho': 'Saudável',
          },
          ultimaRevisao: _dias(-3),
        ),
        Colonia(
          id: 'col4',
          criatorioId: 'c2',
          identificacao: 'M-003',
          especie: 'Uruçu',
          tipoCaixa: 'INPA',
          origem: 'Resgate',
          dataInstalacao: DateTime(_hoje.year, 5, 2),
          status: StatusColonia.atencao,
          forca: 'Fraca',
          presencaRainha: 'Não observada',
          detalhes: const {
            'Discos de cria': '2',
            'Potes de alimento': '4',
            'Condição do ninho': 'Precisa de alimento',
          },
          ultimaRevisao: _dias(-10),
        ),
      ];

  List<Atividade> get atividades => [
        Atividade(
          id: 'at1',
          coloniaId: 'col1',
          tipo: TipoAtividade.revisao,
          titulo: 'Revisão',
          descricao: 'Força forte • Rainha presente',
          data: _dias(-2),
        ),
        Atividade(
          id: 'at2',
          coloniaId: 'col1',
          tipo: TipoAtividade.manejo,
          titulo: 'Alimentação',
          descricao: '2 litros de xarope',
          data: _dias(-10),
        ),
        Atividade(
          id: 'at3',
          coloniaId: 'col1',
          tipo: TipoAtividade.revisao,
          titulo: 'Revisão',
          descricao: 'Força média',
          data: _dias(-15),
        ),
        Atividade(
          id: 'at4',
          coloniaId: 'col2',
          tipo: TipoAtividade.manejo,
          titulo: 'Alimentação',
          descricao: '2 litros de xarope',
          data: _dias(-10),
        ),
        Atividade(
          id: 'at5',
          coloniaId: 'col3',
          tipo: TipoAtividade.revisao,
          titulo: 'Revisão',
          descricao: 'Força forte • Rainha presente',
          data: _dias(-3),
        ),
        Atividade(
          id: 'at6',
          coloniaId: 'col3',
          tipo: TipoAtividade.manejo,
          titulo: 'Alimentação',
          descricao: 'Alimentação energética de apoio',
          data: _dias(-11),
        ),
      ];

  List<Tarefa> get tarefas => [
        Tarefa(
          id: 't1',
          titulo: 'Revisar A-001',
          descricao: 'Avaliar força, cria e alimento',
          criatorioId: 'c1',
          coloniaId: 'col1',
          data: _hoje,
          prioridade: Prioridade.alta,
        ),
        Tarefa(
          id: 't2',
          titulo: 'Alimentar M-003',
          criatorioId: 'c2',
          coloniaId: 'col4',
          data: _dias(1),
          prioridade: Prioridade.media,
        ),
        Tarefa(
          id: 't3',
          titulo: 'Registrar produção',
          criatorioId: 'c1',
          data: _dias(5),
          prioridade: Prioridade.media,
        ),
        Tarefa(
          id: 't4',
          titulo: 'Revisar A-005',
          criatorioId: 'c1',
          coloniaId: 'col2',
          data: _dias(-1),
          prioridade: Prioridade.baixa,
          concluida: true,
        ),
      ];

  List<Producao> get producoes => [
        Producao(
          id: 'p1',
          criatorioId: 'c1',
          coloniaId: 'col1',
          produto: 'Mel',
          quantidade: 12,
          unidade: 'kg',
          data: _dias(-5),
        ),
        Producao(
          id: 'p2',
          criatorioId: 'c2',
          coloniaId: 'col3',
          produto: 'Mel',
          quantidade: 5,
          unidade: 'kg',
          data: _dias(-10),
        ),
        Producao(
          id: 'p3',
          criatorioId: 'c1',
          produto: 'Mel',
          quantidade: 28,
          unidade: 'kg',
          data: _dias(-40),
        ),
        Producao(
          id: 'p4',
          criatorioId: 'c1',
          produto: 'Mel',
          quantidade: 80,
          unidade: 'kg',
          data: _dias(-90),
        ),
      ];
}
