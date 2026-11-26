import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../data/app_scope.dart';
import '../../../shared/widgets/widgets.dart';
import '../widgets/auth_icon.dart';
import '../widgets/auth_layout.dart';

/// 03 — Cadastro.
class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmacao = TextEditingController();
  bool _aceitouTermos = false;
  bool _mostrarErroTermos = false;
  bool _carregando = false;

  @override
  void dispose() {
    for (final c in [_nome, _email, _senha, _confirmacao]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _criarConta() async {
    final valido = _formKey.currentState!.validate();
    setState(() => _mostrarErroTermos = !_aceitouTermos);
    if (_carregando || !valido || !_aceitouTermos) return;
    FocusScope.of(context).unfocus();
    setState(() => _carregando = true);
    await AppScope.read(context).cadastrar(nome: _nome.text, email: _email.text);
    if (!mounted) return;
    context.reiniciarEm(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) => AuthLayout(
        titulo: 'Crie sua conta',
        subtitulo: 'Comece a organizar seus criatórios.',
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CaixaDeTexto(
                  label: 'Nome',
                  hint: 'Seu nome completo',
                  controller: _nome,
                  enabled: !_carregando,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  prefixIcon: const Icon(Icons.person_outline,
                      size: 18, color: AppColors.textoSecundario),
                  validator: (v) => Validators.obrigatorio(v, 'Informe seu nome.'),
                ),
                const SizedBox(height: AppSpacing.md),
                CaixaDeTexto(
                  label: 'E-mail',
                  hint: 'seuemail@exemplo.com',
                  controller: _email,
                  enabled: !_carregando,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  prefixIcon: const AuthIcon(AppAssets.iconeEmail),
                  validator: Validators.email,
                ),
                const SizedBox(height: AppSpacing.md),
                CaixaDeTexto(
                  label: 'Senha',
                  hint: 'Mínimo de 8 caracteres',
                  controller: _senha,
                  enabled: !_carregando,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.newPassword],
                  prefixIcon: const AuthIcon(AppAssets.iconeCadeado),
                  validator: Validators.senha,
                ),
                const SizedBox(height: AppSpacing.md),
                CaixaDeTexto(
                  label: 'Confirmar senha',
                  hint: 'Repita sua senha',
                  controller: _confirmacao,
                  enabled: !_carregando,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const AuthIcon(AppAssets.iconeCadeado),
                  validator: (v) => v != _senha.text ? 'As senhas não conferem.' : null,
                  onFieldSubmitted: (_) => _criarConta(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          CheckboxListTile(
            value: _aceitouTermos,
            onChanged: _carregando
                ? null
                : (v) => setState(() {
                      _aceitouTermos = v ?? false;
                      if (_aceitouTermos) _mostrarErroTermos = false;
                    }),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text('Li e concordo com os termos.', style: AppTextStyles.caption.copyWith(
              color: AppColors.carvao,
            )),
            subtitle: _mostrarErroTermos
                ? Text(
                    'Aceite os termos para continuar.',
                    style: AppTextStyles.caption.copyWith(color: AppColors.erro, fontSize: 11),
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            rotulo: 'Criar conta',
            rotuloCarregando: 'Criando conta…',
            carregando: _carregando,
            onPressed: _criarConta,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: _carregando ? null : () => Navigator.of(context).maybePop(),
            child: const Text('Já tenho uma conta'),
          ),
          const SizedBox(height: 140),
        ],
      );
}
