import 'package:abelhifma/app/app.dart';
import 'package:abelhifma/app/routes/app_routes.dart';
import 'package:abelhifma/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Finder campo(String nome) => find.descendant(
      of: find.byKey(ValueKey(nome)),
      matching: find.byType(TextFormField),
    );

Future<void> preencher(WidgetTester tester, {String? email, String? senha}) async {
  await tester.enterText(campo('email'), email ?? LoginScreen.emailDemo);
  await tester.enterText(campo('senha'), senha ?? LoginScreen.senhaDemo);
}

/// Avança o tempo do login simulado (1 s) e espera a navegação.
Future<void> concluirLogin(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

void usarTela(WidgetTester tester, Size tamanho) {
  tester.view.physicalSize = tamanho;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

const login = AbelhIFMA(initialRoute: AppRoutes.login);
const home = AbelhIFMA(initialRoute: AppRoutes.home);

void main() {
  group('Splash', () {
    testWidgets('Exibe a marca e segue para o login', (tester) async {
      await tester.pumpWidget(const AbelhIFMA());
      expect(find.text('Gestão de Apiários, Meliponários e Colônias'), findsOneWidget);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.text('Bem-vindo ao AbelhIFMA'), findsOneWidget);
    });
  });

  group('Login', () {
    testWidgets('Valida campos vazios e formato de e-mail', (tester) async {
      await tester.pumpWidget(login);
      await tester.tap(find.text('Entrar'));
      await tester.pumpAndSettle();
      expect(find.text('Informe seu e-mail.'), findsOneWidget);
      expect(find.text('Informe sua senha.'), findsOneWidget);
      await tester.enterText(campo('email'), 'email-invalido');
      await tester.pumpAndSettle();
      expect(find.text('Informe um e-mail válido.'), findsOneWidget);
    });

    testWidgets('Mostrar e ocultar senha preserva o texto digitado', (tester) async {
      await tester.pumpWidget(login);
      await tester.enterText(campo('senha'), 'minha-senha');
      final editable = find.descendant(
        of: find.byKey(const ValueKey('senha')),
        matching: find.byType(EditableText),
      );
      expect(tester.widget<EditableText>(editable).obscureText, isTrue);
      await tester.tap(find.byTooltip('Mostrar senha'));
      await tester.pump();
      expect(tester.widget<EditableText>(editable).obscureText, isFalse);
      expect(tester.widget<EditableText>(editable).controller.text, 'minha-senha');
    });

    testWidgets('Carregamento bloqueia envio; dados incorretos exibem erro', (tester) async {
      await tester.pumpWidget(login);
      await preencher(tester, senha: 'errada');
      await tester.tap(find.text('Entrar'));
      await tester.pump();
      expect(find.text('Entrando…'), findsOneWidget);
      final botao = find.ancestor(
        of: find.text('Entrando…'),
        matching: find.byType(ElevatedButton),
      );
      expect(tester.widget<ElevatedButton>(botao).onPressed, isNull);
      expect(tester.widget<TextFormField>(campo('email')).enabled, isFalse);
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('E-mail ou senha incorretos.'), findsOneWidget);

      await tester.enterText(campo('senha'), LoginScreen.senhaDemo);
      await tester.pumpAndSettle();
      expect(find.text('E-mail ou senha incorretos.'), findsNothing);
      await tester.tap(find.text('Entrar'));
      await concluirLogin(tester);
      expect(find.text('Olá, João! 👋'), findsOneWidget);
    });

    testWidgets('Enter envia e normaliza o e-mail', (tester) async {
      await tester.pumpWidget(login);
      await preencher(tester, email: '  JOAO.SILVA@IFMA.EDU.BR  ');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await concluirLogin(tester);
      expect(find.text('Olá, João! 👋'), findsOneWidget);
    });

    testWidgets('Sair durante o carregamento não gera erros', (tester) async {
      await tester.pumpWidget(login);
      await preencher(tester);
      await tester.tap(find.text('Entrar'));
      await tester.pump();
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      await tester.pump(const Duration(seconds: 2));
      expect(tester.takeException(), isNull);
    });

    testWidgets('Links abrem recuperação de senha e cadastro', (tester) async {
      await tester.pumpWidget(login);
      await tester.tap(find.text('Esqueci minha senha'));
      await tester.pumpAndSettle();
      expect(find.text('Enviar instruções'), findsOneWidget);
      await tester.tap(find.byTooltip('Voltar'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Criar conta'));
      await tester.tap(find.text('Criar conta'));
      await tester.pumpAndSettle();
      expect(find.text('Crie sua conta'), findsOneWidget);
    });
  });

  group('Navegação principal', () {
    testWidgets('Barra inferior troca de aba e mantém a pilha de cada aba', (tester) async {
      await tester.pumpWidget(home);
      await tester.pumpAndSettle();
      expect(find.text('Olá, João! 👋'), findsOneWidget);

      await tester.tap(find.text('Criatórios').last);
      await tester.pumpAndSettle();
      expect(find.text('Meus criatórios'), findsOneWidget);

      // Abre o detalhe dentro da aba: a barra inferior continua visível.
      await tester.tap(find.text('Meliponário IFMA'));
      await tester.pumpAndSettle();
      expect(find.text('Atividades recentes'), findsOneWidget);
      expect(find.text('Tarefas'), findsWidgets);

      // Vai para Tarefas e volta: o detalhe continua aberto na aba Criatórios.
      await tester.tap(find.text('Tarefas').last);
      await tester.pumpAndSettle();
      expect(find.text('Semana atual'), findsOneWidget);
      await tester.tap(find.text('Criatórios').last);
      await tester.pumpAndSettle();
      expect(find.text('Atividades recentes'), findsOneWidget);
    });

    testWidgets('Cadastra um novo apiário pelo fluxo completo', (tester) async {
      await tester.pumpWidget(home);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('+ Novo criatório'));
      await tester.tap(find.text('+ Novo criatório'));
      await tester.pumpAndSettle();
      expect(find.text('Selecione o tipo de criatório.'), findsOneWidget);

      await tester.ensureVisible(find.text('Continuar'));
      await tester.tap(find.text('Continuar'));
      await tester.pumpAndSettle();
      expect(find.text('Novo apiário'), findsOneWidget);

      final campos = find.byType(TextFormField);
      await tester.enterText(campos.at(0), 'Apiário Teste');
      await tester.enterText(campos.at(1), 'Sítio Esperança');
      await tester.enterText(campos.at(2), 'Bacabal');
      await tester.ensureVisible(find.text('Salvar apiário'));
      await tester.tap(find.text('Salvar apiário'));
      await tester.pumpAndSettle();

      expect(find.text('Apiário salvo com sucesso.'), findsOneWidget);
      expect(find.text('Apiário Teste'), findsOneWidget);
    });

    testWidgets('Concluir tarefa atualiza a caixa de seleção', (tester) async {
      await tester.pumpWidget(home);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Tarefas').last);
      await tester.pumpAndSettle();

      int concluidas() => find
          .byWidgetPredicate((w) => w is Checkbox && w.value == true)
          .evaluate()
          .length;
      final antes = concluidas();
      expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, isFalse);
      await tester.tap(find.byType(Checkbox).first);
      await tester.pumpAndSettle();
      expect(concluidas(), antes + 1);
    });
  });

  group('Responsividade', () {
    for (final tamanho in const [Size(320, 568), Size(390, 844), Size(1440, 900)]) {
      testWidgets('Login e Início sem overflow em ${tamanho.width} x ${tamanho.height}',
          (tester) async {
        usarTela(tester, tamanho);
        await tester.pumpWidget(login);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Desmonta o app para que a nova rota inicial seja aplicada.
        await tester.pumpWidget(const SizedBox());
        await tester.pumpWidget(home);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.text('Olá, João! 👋'), findsOneWidget);
      });
    }
  });
}
