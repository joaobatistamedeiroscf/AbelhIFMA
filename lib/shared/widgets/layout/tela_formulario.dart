import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../feedback/empty_state.dart';
import 'app_header.dart';
import 'page_body.dart';

/// Estrutura padrão dos formulários: cabeçalho com voltar, [Form]
/// e conteúdo rolável com largura limitada.
class TelaFormulario extends StatelessWidget {
  const TelaFormulario({
    super.key,
    required this.titulo,
    required this.formKey,
    required this.children,
    this.subtitulo,
  });

  final String titulo;
  final String? subtitulo;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppHeader.voltar(titulo: titulo, subtitulo: subtitulo),
        body: Form(
          key: formKey,
          child: PageBody(
            maxWidth: AppSpacing.maxFormWidth + 80,
            children: children,
          ),
        ),
      );
}

/// Tela exibida quando o registro aberto não existe mais (ex.: foi excluído).
class TelaNaoEncontrada extends StatelessWidget {
  const TelaNaoEncontrada({super.key, this.titulo = 'Registro não encontrado'});

  final String titulo;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const AppHeader.voltar(titulo: 'Voltar'),
        body: EmptyState(
          icone: Icons.search_off,
          titulo: titulo,
          mensagem: 'Ele pode ter sido removido. Volte e tente novamente.',
          rotuloAcao: 'Voltar',
          onAcao: () => Navigator.of(context).maybePop(),
        ),
      );
}
