import 'package:abelhifma/app/app.dart';
import 'package:abelhifma/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Finder campo(String nome) => find.descendant(
  of: find.byKey(ValueKey(nome)),
  matching: find.byType(TextFormField),
);

Future<void> preencher(
  WidgetTester tester, {
  String? email,
  String? senha,
}) async {
  await tester.enterText(campo('email'), email ?? LoginScreen.emailDemo);
  await tester.enterText(campo('senha'), senha ?? LoginScreen.senhaDemo);
}

void main() {
  testWidgets('Valida campos vazios e formato de e-mail', (tester) async {
    await tester.pumpWidget(const AbelhIFMA());
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();
    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    await tester.enterText(campo('email'), 'email-invalido');
    await tester.pumpAndSettle();
    expect(find.text('Informe um e-mail válido.'), findsOneWidget);
  });

  testWidgets('Mostrar e ocultar senha preserva o texto digitado', (
    tester,
  ) async {
    await tester.pumpWidget(const AbelhIFMA());
    await tester.enterText(campo('senha'), 'minha-senha');
    final editable = find.descendant(
      of: find.byKey(const ValueKey('senha')),
      matching: find.byType(EditableText),
    );
    expect(tester.widget<EditableText>(editable).obscureText, isTrue);
    await tester.tap(find.byTooltip('Mostrar senha'));
    await tester.pump();
    expect(tester.widget<EditableText>(editable).obscureText, isFalse);
    expect(
      tester.widget<EditableText>(editable).controller.text,
      'minha-senha',
    );
    await tester.tap(find.byTooltip('Ocultar senha'));
    await tester.pump();
    expect(tester.widget<EditableText>(editable).obscureText, isTrue);
  });

  testWidgets('Carregamento bloqueia envio e dados incorretos exibem erro', (
    tester,
  ) async {
    await tester.pumpWidget(const AbelhIFMA());
    await preencher(tester, senha: 'errada');
    await tester.tap(find.text('Entrar'));
    await tester.pump();
    expect(find.text('Entrando…'), findsOneWidget);
    expect(
      tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
      isNull,
    );
    expect(tester.widget<TextFormField>(campo('email')).enabled, isFalse);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('E-mail ou senha incorretos.'), findsOneWidget);
    await tester.enterText(campo('senha'), LoginScreen.senhaDemo);
    await tester.pumpAndSettle();
    expect(find.text('E-mail ou senha incorretos.'), findsNothing);
    await tester.tap(find.text('Entrar'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Login de demonstração concluído'), findsOneWidget);
  });

  testWidgets('Enter envia e normaliza e-mail sem alterar senha', (
    tester,
  ) async {
    await tester.pumpWidget(const AbelhIFMA());
    await preencher(tester, email: '  JOAO.SILVA@IFMA.EDU.BR  ');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Login de demonstração concluído'), findsOneWidget);
    await tester.tap(find.text('Entendi'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('Sair durante o carregamento não atualiza estado descartado', (
    tester,
  ) async {
    await tester.pumpWidget(const AbelhIFMA());
    await preencher(tester);
    await tester.tap(find.text('Entrar'));
    await tester.pump();
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    await tester.pump(const Duration(seconds: 2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Links explicam limites da demonstração sem simular envio real', (
    tester,
  ) async {
    await tester.pumpWidget(const AbelhIFMA());
    await tester.tap(find.text('Esqueci minha senha'));
    await tester.pumpAndSettle();
    expect(find.text('Recuperação de senha'), findsOneWidget);
    await tester.tap(find.text('Entendi'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Criar conta'));
    await tester.tap(find.text('Criar conta'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.textContaining('nenhuma conta é criada'), findsOneWidget);
  });

  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(1440, 900),
  ]) {
    testWidgets('Layout sem overflow em ${size.width} x ${size.height}', (
      tester,
    ) async {
      tester.view.reset();
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const AbelhIFMA());
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Criar conta'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
