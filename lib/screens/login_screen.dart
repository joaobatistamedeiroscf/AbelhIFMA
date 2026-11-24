import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/theme/app_colors.dart';
import '../app/theme/app_radius.dart';
import '../app/theme/app_text_styles.dart';
import '../widgets/caixa_de_texto.dart';

/// Tela 02 do Figma. A autenticação é apenas uma demonstração em memória.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const emailDemo = 'joao.silva@ifma.edu.br';
  static const senhaDemo = 'Abelh@123';

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

  String? _validarEmail(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'Informe seu e-mail.';
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(valor.trim())) {
      return 'Informe um e-mail válido.';
    }
    return null;
  }

  void _limparErro(String _) {
    if (_credenciaisInvalidas) setState(() => _credenciaisInvalidas = false);
  }

  Future<void> _entrar() async {
    // A trava também impede envios repetidos pela tecla Enter.
    if (_carregando || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final email = _emailController.text.trim().toLowerCase();
    final senha = _senhaController.text;
    setState(() {
      _carregando = true;
      _credenciaisInvalidas = false;
    });

    // Simula a espera por uma API, sem enviar ou persistir credenciais.
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    final sucesso =
        email == LoginScreen.emailDemo && senha == LoginScreen.senhaDemo;
    setState(() {
      _carregando = false;
      _credenciaisInvalidas = !sucesso;
    });
    if (sucesso) {
      _senhaController.clear();
      await _mostrarInformacao(
        'Login de demonstração concluído',
        'Os dados foram validados localmente. Esta atividade não acessa uma conta real.',
      );
    }
  }

  Future<void> _mostrarInformacao(String titulo, String mensagem) =>
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Entendi'),
            ),
          ],
        ),
      );

  Widget _icone(String nome, [double tamanho = 18]) => SvgPicture.asset(
    'assets/login/$nome.svg',
    width: tamanho,
    height: tamanho,
    excludeFromSemantics: true,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.branco,
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _FavosLogin(),
              ),
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                  child: AutofillGroup(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/login/logo.png',
                              width: 96,
                              height: 72,
                              fit: BoxFit.contain,
                              semanticLabel: 'AbelhIFMA',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Bem-vindo ao AbelhIFMA',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.title.copyWith(height: 1.2),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Gerencie seus criatórios de forma simples e organizada.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.textoSecundario,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 18),
                          CaixaDeTexto(
                            key: const ValueKey('email'),
                            label: 'E-mail',
                            hint: 'seuemail@exemplo.com',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.username],
                            prefixIcon: _icone('mail'),
                            enabled: !_carregando,
                            validator: _validarEmail,
                            onChanged: _limparErro,
                          ),
                          const SizedBox(height: 12),
                          CaixaDeTexto(
                            key: const ValueKey('senha'),
                            label: 'Senha',
                            hint: 'Digite sua senha',
                            controller: _senhaController,
                            obscureText: _ocultarSenha,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            prefixIcon: _icone('lock'),
                            suffixIcon: IconButton(
                              tooltip: _ocultarSenha
                                  ? 'Mostrar senha'
                                  : 'Ocultar senha',
                              onPressed: _carregando
                                  ? null
                                  : () => setState(
                                      () => _ocultarSenha = !_ocultarSenha,
                                    ),
                              icon: Icon(
                                _ocultarSenha
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 20,
                                color: AppColors.textoSecundario,
                              ),
                            ),
                            enabled: !_carregando,
                            errorText: _credenciaisInvalidas
                                ? 'Verifique os dados informados.'
                                : null,
                            validator: (valor) => valor == null || valor.isEmpty
                                ? 'Informe sua senha.'
                                : null,
                            onChanged: _limparErro,
                            onFieldSubmitted: (_) => _entrar(),
                          ),
                          if (_credenciaisInvalidas) ...[
                            const SizedBox(height: 12),
                            Semantics(
                              liveRegion: true,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDECEA),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    _icone('alert', 16),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'E-mail ou senha incorretos.',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.erro,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _carregando
                                  ? null
                                  : () => _mostrarInformacao(
                                      'Recuperação de senha',
                                      'A recuperação por e-mail depende do serviço de autenticação, ainda não conectado. Para testar esta tela, use ${LoginScreen.emailDemo} e a senha ${LoginScreen.senhaDemo}.',
                                    ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                textStyle: AppTextStyles.caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text('Esqueci minha senha'),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _carregando ? null : _entrar,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                disabledBackgroundColor: AppColors.amarelo
                                    .withValues(alpha: 0.65),
                              ),
                              child: _carregando
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.carvao,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text('Entrando…'),
                                      ],
                                    )
                                  : const Text('Entrar'),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(color: Color(0xFFDDE3E0)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text('ou', style: AppTextStyles.caption),
                              ),
                              Expanded(
                                child: Divider(color: Color(0xFFDDE3E0)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: _carregando
                                  ? null
                                  : () => _mostrarInformacao(
                                      'Criar conta',
                                      'Esta atividade implementa a tela de login. O cadastro de contas será conectado em uma próxima etapa; nenhuma conta é criada nesta demonstração.',
                                    ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: AppColors.branco,
                                foregroundColor: AppColors.carvao,
                                side: const BorderSide(
                                  color: Color(0xFFDDE3E0),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.button,
                                  ),
                                ),
                                textStyle: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text('Criar conta'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Os três SVGs oficiais mantêm as dimensões e posições do Figma.
class _FavosLogin extends StatelessWidget {
  const _FavosLogin();

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: IgnorePointer(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 390,
          height: 210,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                left: 6.5,
                top: 0,
                child: SvgPicture.asset('assets/login/honey-top.svg'),
              ),
              Positioned(
                left: -42,
                top: 79.1,
                child: SvgPicture.asset('assets/login/honey-middle.svg'),
              ),
              Positioned(
                left: 6.6,
                top: 160,
                child: SvgPicture.asset('assets/login/honey-bottom.svg'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
