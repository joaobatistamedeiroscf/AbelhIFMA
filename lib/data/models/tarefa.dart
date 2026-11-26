enum Prioridade {
  baixa('Baixa'),
  media('Média'),
  alta('Alta');

  const Prioridade(this.rotulo);
  final String rotulo;
}

class Tarefa {
  const Tarefa({
    required this.id,
    required this.titulo,
    required this.data,
    required this.prioridade,
    this.descricao = '',
    this.criatorioId,
    this.coloniaId,
    this.concluida = false,
    this.lembrete = true,
  });

  final String id;
  final String titulo;
  final String descricao;
  final String? criatorioId;
  final String? coloniaId;
  final DateTime data;
  final Prioridade prioridade;
  final bool concluida;
  final bool lembrete;

  Tarefa copyWith({bool? concluida}) => Tarefa(
        id: id,
        titulo: titulo,
        descricao: descricao,
        criatorioId: criatorioId,
        coloniaId: coloniaId,
        data: data,
        prioridade: prioridade,
        concluida: concluida ?? this.concluida,
        lembrete: lembrete,
      );
}
