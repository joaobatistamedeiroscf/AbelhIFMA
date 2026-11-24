# Tela de login com estado — AbelhIFMA

Tela escolhida: **02 — Login** do [protótipo no Figma](https://www.figma.com/design/ZNXmaVmDEoKhlbyt0HbF9p/Projeto---AbelhIFMA?node-id=4-36022).

## Como executar

Na pasta do projeto:

```powershell
flutter pub get
flutter run -d edge
```

Pare e execute novamente o aplicativo após adicionar os assets e a dependência flutter_svg.

## Como demonstrar a atividade

1. Toque em **Entrar** sem preencher os campos: as mensagens de validação aparecem.
2. Digite um e-mail inválido: o campo indica o formato incorreto.
3. Digite uma senha e toque no ícone de olho: a senha alterna entre visível e oculta.
4. Use **joao.silva@ifma.edu.br** com uma senha diferente de **Abelh@123**: o botão mostra carregamento e, depois, aparece o erro de credenciais.
5. Corrija a senha para **Abelh@123** e entre novamente: aparece a confirmação de login de demonstração.
6. Durante o carregamento, os campos e botões ficam desabilitados, impedindo envios duplicados.
7. Os links de recuperação e cadastro abrem explicações sobre o escopo da demonstração.

## Onde está o StatefulWidget

Em `lib/screens/login_screen.dart`, `LoginScreen` estende `StatefulWidget` e cria `_LoginScreenState`.

| Estado | Efeito visível |
| --- | --- |
| `_ocultarSenha` | Altera `obscureText` e o ícone de visibilidade. |
| `_carregando` | Exibe o indicador de progresso e bloqueia interações durante o envio. |
| `_credenciaisInvalidas` | Exibe o alerta e o erro no campo de senha. |

As mudanças usam `setState`, fazendo o Flutter reconstruir os widgets com os valores atuais. O formulário usa `GlobalKey<FormState>`, `TextFormField` e validadores. Os `TextEditingController` são descartados em `dispose`; após a espera assíncrona, `mounted` impede atualizar uma tela que já foi fechada.

## Arquivos

- `lib/screens/login_screen.dart`: layout e comportamentos da tela.
- `lib/widgets/caixa_de_texto.dart`: componente existente ampliado para suportar formulários, validação, ícones e eventos.
- `lib/app/app.dart`: define a tela de login como página inicial.
- `assets/login/`: logo, ícones e favos oficiais exportados do Figma.
- `pubspec.yaml` e `pubspec.lock`: registro dos assets e da biblioteca flutter_svg.
- `test/widget_test.dart`: testes de interação, ciclo de vida e layout.

A tela usa o tema existente. No desktop, o formulário tem largura máxima de 440 pixels. Em telas pequenas ou com teclado aberto, o conteúdo pode ser rolado. A barra de status é fornecida pelo sistema operacional, por meio de `SafeArea`.

## Escopo

A autenticação é simulada localmente por uma espera de um segundo e comparação com uma conta de demonstração. Não há conexão com backend, criação de conta, envio de e-mail, sessão autenticada real ou armazenamento de senhas. Os links de cadastro e recuperação informam isso ao usuário.

## Verificação

```powershell
flutter analyze
flutter test test/widget_test.dart
```
