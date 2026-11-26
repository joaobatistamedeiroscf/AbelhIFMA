import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../data/app_scope.dart';
import '../../../shared/widgets/widgets.dart';
import '../widgets/auth_icon.dart';

/// 04 — Recuperação de senha (estados Formulário e Sucesso).
class RecuperarSenhaScreen extends StatefulWidget {
  const RecuperarSenhaScreen({super.key});

  @override
  State<RecuperarSenhaScreen> createState() => _RecuperarSenhaScreenState();
}

class _RecuperarSenhaScreenState extends State<RecuperarSenhaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _carregando = false;
  String? _emailEnviado;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (_carregando || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _carregando = true);
    await AppScope.read(context).recuperarSenha(_email.text);
    if (!mounted) return;
    setState(() {
      _carregando = false;
      _emailEnviado = _email.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const AppHeader.voltar(titulo: 'Recuperar senha'),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _emailEnviado == null
              ? _formulario()
              : SuccessState(
                  key: const ValueKey('sucesso'),
                  icone: Icons.mark_email_read_outlined,
                  titulo: 'Verifique seu e-mail.',
                  mensagem: 'Enviamos as instruções para $_emailEnviado.',
                  rotuloAcao: 'Voltar ao login',
                  onAcao: () => Navigator.of(context).maybePop(),
                ),
        ),
      );

  Widget _formulario() => PageBody(
        key: const ValueKey('formulario'),
        maxWidth: AppSpacing.maxFormWidth,
        padding: const EdgeInsets.all(AppSpacing.xxl),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                color: AppColors.amareloClaro,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.key_outlined, color: AppColors.dourado, size: 30),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          const Text('Recuperar senha', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Informe seu e-mail para receber as instruções de recuperação.',
            style: AppTextStyles.body.copyWith(color: AppColors.textoSecundario),
          ),
          const SizedBox(height: AppSpacing.lg),
          Form(
            key: _formKey,
            child: CaixaDeTexto(
              label: 'E-mail',
              hint: 'seuemail@exemplo.com',
              controller: _email,
              enabled: !_carregando,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.send,
              prefixIcon: const AuthIcon(AppAssets.iconeEmail),
              validator: Validators.email,
              onFieldSubmitted: (_) => _enviar(),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            rotulo: 'Enviar instruções',
            rotuloCarregando: 'Enviando…',
            carregando: _carregando,
            onPressed: _enviar,
          ),
        ],
      );
}
