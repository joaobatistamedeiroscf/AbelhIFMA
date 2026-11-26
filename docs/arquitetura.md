# Arquitetura do AbelhIFMA

Telas, navegação e componentes implementados a partir do
[protótipo no Figma](https://www.figma.com/design/ZNXmaVmDEoKhlbyt0HbF9p/Projeto---AbelhIFMA).

## Estrutura de pastas

```
lib/
├── main.dart
├── app/
│   ├── app.dart                 # MaterialApp, tema, AppScope e rotas
│   └── routes/
│       ├── app_routes.dart      # nomes de todas as rotas
│       ├── app_router.dart      # rota → tela (onGenerateRoute)
│       └── app_navigation.dart  # context.abrirNaAba / abrirTelaCheia / reiniciarEm
├── core/                        # sem dependência de telas
│   ├── constants/               # assets e listas de opções dos formulários
│   ├── theme/                   # cores, espaçamentos, raios, tipografia, tons, ThemeData
│   └── utils/                   # breakpoints, formatação pt-BR, validadores
├── data/
│   ├── models/                  # Criatorio, Colonia, Atividade, Tarefa, Producao...
│   ├── mock/mock_data.dart      # dados de demonstração do Figma
│   ├── app_store.dart           # estado em memória (ChangeNotifier)
│   └── app_scope.dart           # AppScope.of(context) / AppScope.read(context)
├── shared/
│   ├── extensions/              # modelo → cor/ícone do Design System
│   └── widgets/                 # biblioteca reutilizável (importe widgets.dart)
│       ├── buttons/  cards/  chips/  feedback/
│       ├── inputs/   layout/ lists/  navigation/
│       └── widgets.dart
└── features/                    # uma pasta por área do app
    ├── splash/  auth/  home/  dashboard/
    ├── criatorios/  colonias/  revisoes/  manejo/  historico/
    └── tarefas/  producao/  perfil/
```

## Navegação

```
Splash → Login ─┬─ Cadastro ──────────┐
                ├─ Recuperar senha    │
                └─────────────────────┴→ Home (HomeShell)
                                           ├─ Início
                                           ├─ Criatórios → Detalhes → Colônias → Colônia → Histórico
                                           ├─ Tarefas
                                           ├─ Produção
                                           └─ Perfil → Sair → Login
```

- **HomeShell** dá a cada aba o próprio `Navigator`. Telas de consulta (detalhes,
  colônias, histórico) abrem **dentro da aba** com `context.abrirNaAba(...)` e mantêm a
  barra inferior, como no Figma. Cada aba lembra onde parou.
- **Formulários** (novo criatório, nova colônia, revisão, manejo, tarefa, produção)
  abrem **em tela cheia** com `context.abrirTelaCheia(...)`, sem a barra inferior.
- Tocar na aba atual volta para a tela inicial dela. O botão voltar do Android volta
  dentro da aba e depois para o Início.

## Responsividade

| Largura          | Comportamento                                                    |
| ---------------- | ---------------------------------------------------------------- |
| < 330 px         | Indicadores do Início em grade 2×2; campos lado a lado empilham. |
| até 840 px       | Barra de navegação inferior.                                     |
| ≥ 600 px         | Listas de cards viram grades de 2 colunas (`GradeResponsiva`).   |
| ≥ 840 px         | Barra inferior vira menu lateral (`AppSideNav`).                 |
| qualquer         | Conteúdo centralizado com largura máxima (`ResponsiveCenter`).   |

## Telas × frames do Figma

| Frame | Tela |
| --- | --- |
| 01 Splash | `features/splash/splash_screen.dart` |
| 02 Login (4 estados) | `features/auth/screens/login_screen.dart` |
| 03 Cadastro | `features/auth/screens/cadastro_screen.dart` |
| 04 Recuperação (2 estados) | `features/auth/screens/recuperar_senha_screen.dart` |
| 05 Dashboard | `features/dashboard/screens/dashboard_screen.dart` |
| 06 Lista de criatórios (2 estados) | `features/criatorios/screens/criatorios_screen.dart` |
| 07 Escolher tipo | `features/criatorios/screens/escolher_tipo_screen.dart` |
| 08 / 09 Novo apiário / meliponário | `features/criatorios/screens/novo_criatorio_screen.dart` |
| 10 Detalhes do criatório | `features/criatorios/screens/criatorio_detalhes_screen.dart` |
| 11 Lista de colônias (2 estados) | `features/colonias/screens/colonias_screen.dart` |
| 12 Nova colônia (2 tipos) | `features/colonias/screens/nova_colonia_screen.dart` |
| 13 / 14 Detalhes da colônia | `features/colonias/screens/colonia_detalhes_screen.dart` |
| 15 Nova revisão (2 tipos) | `features/revisoes/screens/nova_revisao_screen.dart` |
| 16 Histórico | `features/historico/screens/historico_screen.dart` |
| 17 Registrar manejo (2 tipos) | `features/manejo/screens/registrar_manejo_screen.dart` |
| 18 Tarefas | `features/tarefas/screens/tarefas_screen.dart` |
| 19 Nova tarefa | `features/tarefas/screens/nova_tarefa_screen.dart` |
| 20 Produção | `features/producao/screens/producao_screen.dart` |
| 21 Nova produção | `features/producao/screens/nova_producao_screen.dart` |
| 22 Perfil | `features/perfil/screens/perfil_screen.dart` |

As variações Apiário/Meliponário usam **uma única tela**: textos, espécies, tipos de
caixa e tipos de manejo vêm do enum `TipoCriatorio`.

## Componentes reutilizáveis (frame "11 — Componentes")

| Grupo do Figma | Widget |
| --- | --- |
| Botões e ações | `AppButton` (principal, sucesso, secundário, perigo, carregando) |
| Inputs e selects | `CaixaDeTexto`, `CampoFormulario`, `CampoSelecao`, `CampoData`, `LinhaFormulario` |
| Chips e filtros | `StatusChip`, `FiltroChips`, `ChipsSelecao`, `StatCard`, `LinhaIndicadores` |
| Card de criatório | `CriatorioCard`, `CriatorioResumoCard` |
| Card de colônia | `ColoniaCard` |
| Card de tarefa | `TarefaCard`, `ProgressoCard` |
| Navegação | `AppHeader.logo`, `AppHeader.voltar`, `HeaderIconButton`, `AppBottomNav`, `AppSideNav` |
| Feedback | `InfoBanner`, `AppFeedback.sucesso`, `LoadingIndicator` |
| Modal e confirmação | `AppFeedback.confirmar`, `AppFeedback.informar` |
| Vazio / Erro / Confirmação | `EmptyState`, `ErrorState`, `SuccessState` |
| Outros | `AppCard`, `DetalhesCard`, `AcaoRapidaCard`, `TipoSelecaoCard`, `ProducaoCard`, `ItemPontuado`, `TimelineItem`, `MenuGrupo`/`MenuOpcao`, `PageBody`, `TelaFormulario`, `GradeResponsiva`, `FavosDecorativos` |

## Dados

Tudo roda em memória com `AppStore` (sem backend). Os formulários realmente criam
registros: um criatório novo aparece no Início e na lista, uma revisão entra no
histórico e atualiza a colônia, e assim por diante. Para conectar uma API, troque a
implementação dos métodos de `AppStore`; as telas não mudam.

Conta de demonstração: **joao.silva@ifma.edu.br** / **Abelh@123**.

## Como verificar

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d edge
```
