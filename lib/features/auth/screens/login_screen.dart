import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../data/app_scope.dart';
import '../../../data/app_store.dart';
import '../../../data/mock/mock_data.dart';
import '../../../shared/widgets/widgets.dart';
import '../widgets/auth_icon.dart';
import '../widgets/auth_layout.dart';

/// 02 — Login (estados Vazio, Preenchido, Senha incorreta e Carregando).
///
/// A autenticação é uma demonstração em memória (ver [AppStore.entrar]).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const emailDemo = 'joao.silva@ifma.edu.br';
  static const senhaDemo = AppStore.senhaDemo;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _ocultarSenha = true;
  bool _carregando = false;
  bool _credenciaisInvalidas = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _limparErro(String _) {
    if (_credenciaisInvalidas) setState(() => _credenciaisInvalidas = false);
  }

  Future<void> _entrar() async {
    // A trava também impede envios repetidos pela tecla Enter.
    if (_carregando || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _carregando = true;
      _credenciaisInvalidas = false;
    });

    final sucesso = await AppScope.read(context)
        .entrar(_emailController.text, _senhaController.text);
    if (!mounted) return;

    if (sucesso) {
      _senhaController.clear();
      context.reiniciarEm(AppRoutes.home);
      return;
    }
    setState(() {
      _carregando = false;
      _credenciaisInvalidas = true;
    });
  }

  @override
  Widget build(BuildContext context) => AuthLayout(
        titulo: 'Bem-vindo ao AbelhIFMA',
        subtitulo: 'Gerencie seus criatórios de forma simples e organizada.',
        children: [
          AutofillGroup(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CaixaDeTexto(
                    key: const ValueKey('email'),
                    label: 'E-mail',
                    hint: 'seuemail@exemplo.com',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.username],
                    prefixIcon: const AuthIcon(AppAssets.iconeEmail),
                    enabled: !_carregando,
                    validator: Validators.email,
                    onChanged: _limparErro,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  CaixaDeTexto(
                    key: const ValueKey('senha'),
                    label: 'Senha',
                    hint: 'Digite sua senha',
                    controller: _senhaController,
                    obscureText: _ocultarSenha,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    prefixIcon: const AuthIcon(AppAssets.iconeCadeado),
                    suffixIcon: IconButton(
                      tooltip: _ocultarSenha ? 'Mostrar senha' : 'Ocultar senha',
                      onPressed: _carregando
                          ? null
                          : () => setState(() => _ocultarSenha = !_ocultarSenha),
                      icon: Icon(
                        _ocultarSenha
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                        color: AppColors.textoSecundario,
                      ),
                    ),
                    enabled: !_carregando,
                    errorText:
                        _credenciaisInvalidas ? 'Verifique os dados informados.' : null,
                    validator: (valor) =>
                        valor == null || valor.isEmpty ? 'Informe sua senha.' : null,
                    onChanged: _limparErro,
                    onFieldSubmitted: (_) => _entrar(),
                  ),
                  if (_credenciaisInvalidas) ...[
                    const SizedBox(height: AppSpacing.md),
                    const _AlertaCredenciais(),
                  ],
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _carregando
                  ? null
                  : () => context.abrirTelaCheia(AppRoutes.recuperarSenha),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                textStyle: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
              ),
              child: const Text('Esqueci minha senha'),
            ),
          ),
          AppButton(
            rotulo: 'Entrar',
            rotuloCarregando: 'Entrando…',
            carregando: _carregando,
            onPressed: _entrar,
          ),
          const SizedBox(height: 18),
          const _DivisorOu(),
          const SizedBox(height: 18),
          AppButton(
            rotulo: 'Criar conta',
            variante: VarianteBotao.secundario,
            onPressed: _carregando ? null : () => context.abrirTelaCheia(AppRoutes.cadastro),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Demonstração: ${MockData.usuarioDemo.email} • ${LoginScreen.senhaDemo}',
            textAlign: TextAlign.center,
            style: AppTextStyles.label,
          ),
        ],
      );
}

class _AlertaCredenciais extends StatelessWidget {
  const _AlertaCredenciais();

  @override
  Widget build(BuildContext context) => Semantics(
        liveRegion: true,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.erroClaro,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              const AuthIcon(AppAssets.iconeAlerta, tamanho: 16),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'E-mail ou senha incorretos.',
                  style: AppTextStyles.caption.copyWith(color: AppColors.erro),
                ),
              ),
            ],
          ),
        ),
      );
}

class _DivisorOu extends StatelessWidget {
  const _DivisorOu();

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          Expanded(child: Divider()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text('ou', style: AppTextStyles.caption),
          ),
          Expanded(child: Divider()),
        ],
      );
}
