import 'package:flutter/material.dart';

import '../../../app/routes/app_navigation.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/tom_visual.dart';
import '../../../data/app_scope.dart';
import '../../../shared/widgets/widgets.dart';

/// 22 — Perfil.
class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  void _emBreve(BuildContext context, String recurso) => AppFeedback.informar(
        context,
        recurso,
        'Este recurso estará disponível em uma próxima versão do AbelhIFMA.',
      );

  Future<void> _sair(BuildContext context) async {
    final confirmado = await AppFeedback.confirmar(
      context,
      titulo: 'Sair da conta?',
      mensagem: 'Você precisará entrar novamente para acessar seus criatórios.',
      rotuloConfirmar: 'Sair',
      perigo: true,
    );
    if (!confirmado || !context.mounted) return;
    AppScope.read(context).sair();
    context.reiniciarEm(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final usuario = AppScope.of(context).usuario;
    return Scaffold(
      appBar: AppHeader.logo(
        titulo: 'Perfil',
        acao: HeaderIconButton(
          icone: Icons.settings_outlined,
          tooltip: 'Configurações',
          onPressed: () => _emBreve(context, 'Configurações'),
        ),
      ),
      body: PageBody(
        espacamento: AppSpacing.md,
        children: [
          AppCard(
            sombra: false,
            child: Row(
              children: [
                Container(
                  width: 76,
                  height: 76,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.amarelo, width: 3),
                  ),
                  child: const AppLogo(),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(usuario.nome, style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w700)),
                      Text(
                        usuario.email,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13,
                          color: AppColors.textoSecundario,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      StatusChip(texto: usuario.papel, tom: TomVisual.verde),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MenuGrupo(
            opcoes: [
              MenuOpcao(
                icone: Icons.manage_accounts_outlined,
                rotulo: 'Editar perfil',
                onTap: () => _emBreve(context, 'Editar perfil'),
              ),
              MenuOpcao(
                icone: Icons.key_outlined,
                rotulo: 'Alterar senha',
                onTap: () => context.abrirTelaCheia(AppRoutes.recuperarSenha),
              ),
              MenuOpcao(
                icone: Icons.tune,
                rotulo: 'Preferências',
                onTap: () => _emBreve(context, 'Preferências'),
              ),
            ],
          ),
          MenuGrupo(
            opcoes: [
              MenuOpcao(
                icone: Icons.info_outline,
                rotulo: 'Sobre o AbelhIFMA',
                onTap: () => showAboutDialog(
                  context: context,
                  applicationName: 'AbelhIFMA',
                  applicationVersion: 'v1.0',
                  applicationIcon: const AppLogo(tamanho: 48),
                  applicationLegalese: 'IFMA • Tecnologia no campo',
                ),
              ),
              MenuOpcao(
                icone: Icons.description_outlined,
                rotulo: 'Termos',
                onTap: () => _emBreve(context, 'Termos de uso'),
              ),
              MenuOpcao(
                icone: Icons.verified_user_outlined,
                rotulo: 'Política de privacidade',
                onTap: () => _emBreve(context, 'Política de privacidade'),
              ),
              MenuOpcao(
                icone: Icons.logout,
                rotulo: 'Sair',
                destrutiva: true,
                onTap: () => _sair(context),
              ),
            ],
          ),
          Text(
            'AbelhIFMA v1.0 • IFMA ${DateTime.now().year}',
            textAlign: TextAlign.center,
            style: AppTextStyles.label,
          ),
        ],
      ),
    );
  }
}
