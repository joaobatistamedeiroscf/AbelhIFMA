class Usuario {
  const Usuario({required this.nome, required this.email, this.papel = 'Gestor rural'});

  final String nome;
  final String email;
  final String papel;

  String get primeiroNome => nome.trim().split(' ').first;
}
