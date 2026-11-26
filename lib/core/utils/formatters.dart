/// Formatação de datas e números em pt-BR sem dependências externas.
abstract final class Formatters {
  static const _mesesAbreviados = [
    'JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN',
    'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ',
  ];

  static const _mesesExtenso = [
    'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
    'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro',
  ];

  static String _doisDigitos(int valor) => valor.toString().padLeft(2, '0');

  /// 30/09/2026
  static String data(DateTime data) =>
      '${_doisDigitos(data.day)}/${_doisDigitos(data.month)}/${data.year}';

  /// 30/09
  static String diaMes(DateTime data) =>
      '${_doisDigitos(data.day)}/${_doisDigitos(data.month)}';

  /// 28 SET
  static String diaMesAbreviado(DateTime data) =>
      '${data.day} ${_mesesAbreviados[data.month - 1]}';

  /// SET
  static String mesAbreviado(DateTime data) => _mesesAbreviados[data.month - 1];

  /// setembro
  static String mesExtenso(DateTime data) => _mesesExtenso[data.month - 1];

  /// SETEMBRO DE 2026
  static String mesAno(DateTime data) =>
      '${mesExtenso(data).toUpperCase()} DE ${data.year}';

  /// "Hoje", "Amanhã", "Ontem" ou 05/10.
  static String dataRelativa(DateTime data, {DateTime? agora}) {
    final hoje = _somenteData(agora ?? DateTime.now());
    final diferenca = _somenteData(data).difference(hoje).inDays;
    return switch (diferenca) {
      0 => 'Hoje',
      1 => 'Amanhã',
      -1 => 'Ontem',
      _ => diaMes(data),
    };
  }

  /// 12 → "12", 12.5 → "12,5"
  static String quantidade(double valor) {
    if (valor == valor.roundToDouble()) return valor.toInt().toString();
    return valor.toStringAsFixed(1).replaceAll('.', ',');
  }

  /// Converte "30/09/2026" em [DateTime]. Retorna null se inválido.
  static DateTime? parseData(String texto) {
    final partes = texto.trim().split('/');
    if (partes.length != 3) return null;
    final dia = int.tryParse(partes[0]);
    final mes = int.tryParse(partes[1]);
    final ano = int.tryParse(partes[2]);
    if (dia == null || mes == null || ano == null) return null;
    final data = DateTime(ano, mes, dia);
    if (data.day != dia || data.month != mes) return null;
    return data;
  }

  static DateTime _somenteData(DateTime data) =>
      DateTime(data.year, data.month, data.day);
}
