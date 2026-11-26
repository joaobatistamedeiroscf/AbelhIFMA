/// Validadores reutilizáveis para os formulários.
abstract final class Validators {
  static final _email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  static String? obrigatorio(String? valor, [String mensagem = 'Campo obrigatório.']) =>
      valor == null || valor.trim().isEmpty ? mensagem : null;

  static String? email(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'Informe seu e-mail.';
    if (!_email.hasMatch(valor.trim())) return 'Informe um e-mail válido.';
    return null;
  }

  static String? senha(String? valor) {
    if (valor == null || valor.isEmpty) return 'Informe sua senha.';
    if (valor.length < 8) return 'A senha deve ter no mínimo 8 caracteres.';
    return null;
  }

  static String? numero(String? valor, {bool obrigatorio = false}) {
    if (valor == null || valor.trim().isEmpty) {
      return obrigatorio ? 'Campo obrigatório.' : null;
    }
    return double.tryParse(valor.replaceAll(',', '.')) == null
        ? 'Informe um número válido.'
        : null;
  }
}
