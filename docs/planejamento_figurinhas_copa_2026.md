# Planejamento de Organização — Álbum Copa do Mundo FIFA 2026™ (Panini)

> Documento de referência para modelagem de dados, telas e fluxo de organização de times e figurinhas especiais no app **completa_ai_app**.
> Compilado a partir de fontes oficiais (Panini, FIFA, Coca-Cola) e de rumores/leaks em comunidades como Reddit, Fandom (Football Sticker Album Wiki), CardzReview Forums e imprensa esportiva.
> **Alinhado com a arquitetura atual da branch `feat/firebase-config`**: feature-first + MVVM (`ChangeNotifier`), `get_it`, `dio`, `go_router`, Firebase.
> Última atualização: abril/2026.

---

## 1. Resumo Executivo do Álbum

| Item | Valor |
|---|---|
| Lançamento oficial | 1º de maio de 2026 (pré-venda em 1º de abril) |
| Total de figurinhas | **980** |
| Figurinhas "couché" (comuns) | **912** |
| Figurinhas metalizadas / especiais | **68** |
| Páginas | **112** (+ capa) |
| Seleções cobertas | **48** (novo formato da Copa) |
| Páginas por seleção | **1 página com 20 figurinhas** |
| Figurinhas por pacote | **7** (antes eram 5) |
| Preço por pacote (BR) | R$ 7,00 |
| Preço estimado para completar | ~US$ 2.500 / >R$ 4.000 |
| Versões do álbum | Brochura, Capa Dura, Capa Dura Prata, Capa Dura Ouro |

---

## 2. Estrutura Estimada de Numeração

> ⚠️ A Panini não divulgou o checklist numerado completo até o momento desta compilação. A estrutura abaixo é uma **projeção** baseada no padrão das edições anteriores (Qatar 2022, Rússia 2018) e nas informações já confirmadas para 2026. Os intervalos devem ser revisados após a publicação oficial do álbum.

### 2.1. Abertura / Intro (≈ figurinhas 1 a 20)

| Nº | Conteúdo | Material |
|----|----------|----------|
| 1 | Troféu FIFA | Metalizada |
| 2 | Logo oficial Copa 2026 | Metalizada |
| 3 | Pôster oficial | Metalizada |
| 4 | Mascote oficial (trio: Maple, Zayu, Clutch) | Metalizada |
| 5 | Bola oficial (Adidas Trionda) | Metalizada |
| 6–7 | Grupo de anfitriões (USA / Canadá / México) | Couché |
| 8–20 | Mapa de sedes, formato do torneio, páginas institucionais | Couché |

### 2.2. Sedes / Host Cities (≈ figurinhas 21 a 52)

16 cidades-sede (11 EUA, 3 México, 2 Canadá) com 2 figurinhas cada (estádio + skyline/ícone):

1. Atlanta (Mercedes-Benz Stadium)
2. Boston / Foxborough (Gillette Stadium)
3. Dallas / Arlington (AT&T Stadium)
4. Houston (NRG Stadium)
5. Kansas City (Arrowhead Stadium)
6. Los Angeles (SoFi Stadium)
7. Miami (Hard Rock Stadium)
8. Nova York / Nova Jersey (MetLife Stadium) — **final**
9. Filadélfia (Lincoln Financial Field)
10. São Francisco / Bay Area (Levi's Stadium)
11. Seattle (Lumen Field)
12. Toronto (BMO Field)
13. Vancouver (BC Place)
14. Cidade do México (Estádio Azteca) — **abertura**
15. Guadalajara (Estádio Akron)
16. Monterrey (Estádio BBVA)

### 2.3. Páginas das Seleções (≈ figurinhas 53 a 1012 no eixo de contagem, mas somando 960 slots de time)

Cada seleção ocupa **exatamente 1 página de 20 figurinhas**:

| Slot na página | Conteúdo |
|---|---|
| 1 | Escudo / badge (**metalizada**) |
| 2 | Foto oficial do time (team photo) |
| 3–20 | 18 jogadores convocados |

48 times × 20 = **960 figurinhas** de seleções.

### 2.4. Legends / "Eternos 22" (figurinhas metalizadas)

Categoria nova homenageando **heróis da Argentina campeã em Qatar 2022**. Confirmados pela Panini até agora (base Adrenalyn XL, esperado no álbum também):

1. Lionel Messi
2. Julián Álvarez
3. Lautaro Martínez
4. Alexis Mac Allister
5. Rodrigo De Paul
6. Enzo Fernández
7. Emiliano Martínez
8. Nahuel Molina
9. Cristian Romero

> **Rumor (Reddit / Fandom):** pode haver expansão para mais lendas de outras seleções campeãs (Pelé, Zidane, Ronaldo, Maradona) — não confirmado.

### 2.5. Figurinhas Exclusivas Coca-Cola × Panini (12 figurinhas)

Página dedicada dentro do álbum, mas as figurinhas **NÃO vêm em pacotes** — só em rótulos de garrafas Coca-Cola / Coca-Cola Zero 20oz, a partir de **20/abr/2026**:

| # | Jogador | Seleção |
|---|---------|---------|
| 1 | Alphonso Davies | Canadá |
| 2 | Antonee Robinson | EUA |
| 3 | Edson Álvarez | México |
| 4 | Gabriel Magalhães | Brasil |
| 5 | Harry Kane | Inglaterra |
| 6 | Jefferson Lerma | Colômbia |
| 7 | Joshua Kimmich | Alemanha |
| 8 | Lamine Yamal | Espanha |
| 9 | Lautaro Martínez | Argentina |
| 10 | Santiago Giménez | México |
| 11 | Virgil van Dijk | Holanda |
| 12 | Weston McKennie | EUA |

### 2.6. Extras / Finalização

- Seção de **histórico das Copas**
- Seção **Road to the Final** / **Records**
- Páginas finais para autógrafos/anotações
- **Extra Stickers** Panini (tiragem limitada, distribuídos em pacotes especiais — sem versões "parallel" desta vez, segundo rumor do Fandom Wiki)

### 2.7. Contabilidade das 68 especiais metalizadas

| Categoria | Qtd. estimada |
|---|---|
| 48 escudos de seleção | 48 |
| Troféu + Logo + Pôster + Mascote + Bola | 5 |
| Legends "Eternos 22" | 9 |
| Coca-Cola page header / selos institucionais | ~2–6 |
| **Total** | **≈ 62–68** |

---

## 3. Grupos do Sorteio Final (05/dez/2025)

| Grupo | Times |
|-------|-------|
| **A** | México (país-sede), África do Sul, Coreia do Sul, República Tcheca |
| **B** | Canadá (país-sede), Suíça, Catar, Bósnia e Herzegovina |
| **C** | Brasil, Marrocos, Haiti, Escócia |
| **D** | Estados Unidos (país-sede), Paraguai, Austrália, Turquia |
| **E** | Alemanha, Curaçao, Costa do Marfim, Equador |
| **F** | Holanda, Japão, Tunísia, Suécia |
| **G** | Bélgica, Egito, Irã, Nova Zelândia |
| **H** | Espanha, Cabo Verde, Arábia Saudita, Uruguai |
| **I** | França, Senegal, Noruega, Iraque |
| **J** | Argentina, Argélia, Áustria, Jordânia |
| **K** | Portugal, Uzbequistão, Colômbia, RD Congo |
| **L** | Inglaterra, Croácia, Gana, Panamá |

Formato: 2 melhores de cada grupo + 8 melhores terceiros avançam ao **Mata-mata de 32**.

---

## 4. Rumores / Observações de Comunidade

Fontes: Reddit (r/panini, r/soccer), **Football Sticker Album Wiki** (Fandom), **CardzReview Forums**, **Latination**, **SportBible**, **Beckett**.

- **Capa refeita:** design vazado originalmente era magenta; em 02/dez/2025 foi revelada a capa oficial branca com "26" estampados nas laterais — troca confirmada pela Panini.
- **Sem parallels no álbum (rumor do Fandom Wiki):** ao contrário do Qatar 2022, **não haverá parallel stickers** no álbum principal. Os parallels ficam restritos às caixas especiais (Amazon = laranja; iCollect = Gold Flood Crumple etc.).
- **Box Norte-Americana:** 6 cores possíveis de borda; **laranja exclusivo da Amazon**.
- **Caixas iCollect:** exclusivos com **Gold Flood Crumple**, média de 6 por caixa.
- **Extra Stickers confirmados:** semelhante ao Qatar 2022, Panini incluirá um set de "extra stickers" — a contagem final e sistema de troca ainda **não foram revelados**.
- **Leak de checklist completo:** até o momento **NÃO há leak consolidado do checklist numerado**; as discussões em Reddit e CardzReview ainda pedem por um post-scan do álbum físico.
- **Eternos 22:** rumor em fóruns de que uma versão "Eternos" por seleção campeã pode ser adicionada na linha Adrenalyn XL, mas não no álbum principal.
- **Campanha Pierluigi Collina + Roberto Baggio:** confirmada como garotos-propaganda oficiais.

---

## 5. Arquitetura Atual do App e Modelagem de Dados

### 5.1. Arquitetura em vigor (branch `feat/firebase-config`)

O app adota **feature-first com MVVM** (Controllers baseados em `ChangeNotifier`), **não** Clean Architecture pura. Resumo da stack:

| Camada | Implementação |
|---|---|
| State management | `ChangeNotifier` + `AnimatedBuilder`/`ListenableBuilder` nos widgets |
| Injeção de dependência | `get_it` (`setupDependencies()` em `lib/core/di/app_dependencies.dart`, todos como `LazySingleton`) |
| HTTP | `dio` via `ApiClient` (`lib/core/network/api_client.dart`) com `auth_interceptor`, `logging_interceptor`, `crashlytics_interceptor` e hierarquia de `*Exception` |
| Roteamento | `go_router` (`lib/routing/app_router.dart` + `AppRoutes` como `abstract final class` de constantes) |
| Persistência local | `shared_preferences` (hoje); backend próprio é a fonte de verdade |
| Backend | API REST própria (`/collection`, `/collection/sync`, `/sections`, `/stickers`, `/users/...`) |
| Firebase | Auth, Analytics, Crashlytics, Performance, Storage |
| Auth social | `google_sign_in`, `sign_in_with_apple` |
| Observabilidade | `AnalyticsService`, `CrashlyticsService`, `LoggingInterceptor`, `CrashlyticsInterceptor` |

> Nota: `riverpod_generator` e `riverpod_lint` estão em `dev_dependencies`, mas **Riverpod não está nas deps principais** — sinal de migração futura ou experimento. Toda a base atual é `ChangeNotifier`.

**Estrutura de pastas atual:**

```
lib/
├── core/
│   ├── config/          # app_config
│   ├── constants/       # app_assets, app_constants
│   ├── di/              # app_dependencies (get_it)
│   ├── extensions/      # context_extensions, string_extensions
│   ├── network/         # api_client + interceptors + exceptions
│   └── theme/           # app_colors, app_text_styles, app_theme
├── features/
│   ├── auth/            (controllers + presentation/{screens,widgets})
│   ├── collection/      (controllers + presentation/{screens,widgets})
│   ├── home/
│   ├── profile/         (inclui domain/enums/app_theme_mode)
│   └── scanner/
├── routing/             # app_router (go_router) + app_routes
├── shared/
│   ├── models/          # Section, Sticker, UserSticker, UserProfile
│   ├── repositories/    # UserRepository
│   └── services/        # *_api_service.dart + firebase_service, analytics, crashlytics
├── firebase_options.dart
└── main.dart
```

### 5.2. Modelos de domínio já existentes

Antes de adicionar qualquer coisa nova, reaproveitar o que já está em `lib/shared/models/`:

```dart
// lib/shared/models/section.dart
class Section {
  final String id;
  final String name;
  final String? imageUrl;
  final int totalStickers;
  final int order;
}

// lib/shared/models/sticker.dart
class Sticker {
  final String id;
  final String number;
  final String name;
  final String sectionId;
  final bool isOwned;
  final int repeatedCount;
}

// lib/shared/models/user_sticker.dart
class UserSticker {
  final String stickerId;
  final bool isOwned;
  final int repeatedCount;
  final DateTime? updatedAt;
}
```

### 5.3. Extensões propostas (sem quebrar modelos existentes)

As categorias e materiais do álbum 2026 **não existem** nos modelos atuais. Duas abordagens:

**Opção A — Derivar de `Section` (preferida, zero mudança de schema):**
Usar o `Section.id` ou um novo campo `Section.kind` no backend para diferenciar. Exemplo de `id`s convencionados:

| Section.id | Significado | totalStickers |
|---|---|---|
| `intro` | Abertura (troféu, logo, pôster, mascote, bola) | ~20 |
| `host-cities` | 16 cidades-sede | ~32 |
| `legends` | Eternos 22 | 9 |
| `coca-cola` | 12 exclusivas Coca-Cola | 12 |
| `team-BRA`, `team-ARG`, ... | Página de cada seleção | 20 |
| `extras` | Extra Stickers | a definir |

**Opção B — Adicionar enums no app (se o backend não distinguir):**

```dart
// lib/features/collection/domain/sticker_kind.dart
enum StickerMaterial { couche, metalizada }

enum StickerCategory {
  intro, hostCity, teamBadge, teamPhoto, player,
  legend, cocaCola, extra,
}

extension StickerKindX on Sticker {
  StickerCategory categoryFromNumber() { /* regras por prefixo de number */ }
  StickerMaterial materialFromNumber() { /* 68 metalizadas conhecidas */ }
}
```

Recomendação: **começar pela Opção A**, manter a distinção no backend, e só adicionar enums no app se o design precisar (ícone de "metalizada", filtro por categoria etc.).

### 5.4. Nova entidade sugerida: `Team` (opcional)

Hoje não há modelo de seleção. Se a tela de "Grupos A–L" for implementada:

```dart
// lib/shared/models/team.dart
class Team {
  final String code;           // "BRA"
  final String name;           // "Brasil"
  final String group;          // "C"
  final String sectionId;      // referência para Section do time
  final String? flagAssetPath;
}
```

Pode viver como seed local (`assets/data/teams_2026.json`) até o backend expor `/teams`.

---

## 6. Fluxo de Organização no App (aderente às telas/rotas atuais)

Rotas já existentes em `lib/routing/app_routes.dart`: `home`, `collection`, `section` (`/collection/:sectionId`), `search`, `scanner`, `share`, `profile` e variações.

### 6.1. Home (`AppRoutes.home` — `HomeScreen` + `HomeController`/`SectionsController`)
- Barra de progresso global (`X / 980`) via `CollectionController.totalOwned`.
- `ProgressCard` por seção destacada: **Especiais metalizadas (0/68)**, **Coca-Cola (0/12)**, **Legends — Eternos 22 (0/9)**, **Sedes (0/32)**.
- `SectionsList` agrupando seções de times por **Grupo A→L** (cabeçalho de grupo + % de conclusão por time).

### 6.2. Tela de Grupo (novo sub-fluxo dentro de Home)
- Mostra os 4 times do grupo + progresso individual.
- Atalho para comparar figurinhas repetidas entre times do mesmo grupo (troca local).
- Implementar como filtro em `SectionsController` ou tela dedicada `GroupDetailScreen`.

### 6.3. Detalhe de Seção / Time (`AppRoutes.section` — `SectionDetailScreen` + `SectionDetailController`/`StickersController`)
- Para time: layout **escudo + foto + 18 jogadores** (reusa `StickerGridItem`).
- Toque em figurinha abre `StickerOptionsSheet`: **tenho / faltando / repetida (+N)**.
- Destaque visual para escudo e demais metalizadas (ícone/borda).

### 6.4. "Especiais" como conjunto de Sections
Reaproveitar `SectionDetailScreen` para cada section com `id` específico:
1. `intro` — abertura
2. `host-cities`
3. `legends`
4. `coca-cola` (incluir texto explicando que só sai em garrafas Coca-Cola)
5. `extras`

### 6.5. Trocas (`AppRoutes.share` — **ainda sem controller específico**)
- Lista automática das **repetidas** (`repeatedCount >= 1`) vs **faltando** (`!isOwned`) derivada de `CollectionController.stickers`.
- Compartilhar lista como imagem/texto (WhatsApp, Telegram).
- Filtro por grupo, por seleção, por tipo (só metalizadas, só comuns).
- Sugestão: criar `ShareController extends ChangeNotifier` em `features/share/controllers/` e registrar no `get_it`.

### 6.6. Scanner (`AppRoutes.scanner` — `ScannerScreen` já existente)
- Item de backlog alinhado: OCR da numeração da figurinha → atualizar `UserSticker` via `CollectionController.updateSticker`.

### 6.7. Estatísticas (novo — sugestão)
- Custo estimado para completar (configurável).
- Projeção: "faltam ~N pacotes com base na taxa atual de repetidas".
- Pode morar dentro de `ProfileScreen` (já há `ProfileStatsCard`) ou em `features/collection/presentation/screens/stats_screen.dart`.

---

## 7. Plano de Implementação (fases)

> O app já tem a base de arquitetura, DI, roteamento, Firebase e modelos `Section`/`Sticker`/`UserSticker`. As fases abaixo focam no conteúdo de Copa 2026, **não** em reconstruir a infraestrutura.

### Fase 1 — Seed de conteúdo 2026
- Definir `Section`s no backend para: `intro`, `host-cities`, `legends`, `coca-cola`, `team-XXX` (48) e `extras`.
- Alimentar `/sections` e `/stickers` com números provisórios marcados por convenção (ex.: sufixo `-prov` no `number`).
- Popular assets locais: `assets/data/teams_2026.json` (48 times, grupo, `sectionId`) e flags em `assets/images/flags/`.

### Fase 2 — Grupos A–L na Home
- Estender `SectionsController` (ou criar `GroupsController`) para agrupar sections de time por `Team.group`.
- Novo widget `GroupHeader` + reuso de `SectionListItem`.
- (Opcional) `GroupDetailScreen` como rota nova em `AppRoutes`.

### Fase 3 — Destaques das "Especiais"
- Cards fixos na Home para `intro`, `host-cities`, `legends`, `coca-cola` (usando `ProgressCard`).
- Tela de Coca-Cola com aviso explicativo ("só em garrafas").
- Ícone/borda para figurinhas metalizadas em `StickerGridItem`.

### Fase 4 — Trocas (`/share`)
- Criar `features/share/controllers/share_controller.dart` (`ChangeNotifier`).
- Registrar no `setupDependencies()` como `LazySingleton`.
- Listar repetidas × faltando a partir de `CollectionController.stickers`.
- Export como texto/imagem compartilhável.

### Fase 5 — Atualização pós-checklist oficial
- Quando a Panini publicar o checklist numerado: migração no backend substituindo `number` provisório pelo oficial; `Sticker.id` permanece estável.
- Adicionar seção `extras` (Extra Stickers) conforme Panini divulgar.

### Fase 6 — Social / Gamificação (backlog)
- OCR de número via `ScannerScreen`.
- Grupos de troca por região.
- Conquistas (seleção completa, grupo completo, 68 metalizadas etc.) via `AnalyticsService` + UI.

---

## 8. Pontos em Aberto / A Revisar

- [ ] Numeração exata do intervalo 1–20 (intro).
- [ ] Numeração exata das host cities (2 figurinhas por sede? ou só 1?).
- [ ] Lista completa de legends além dos 9 argentinos — confirmar se haverá campeões históricos.
- [ ] Existência real (ou não) de parallels dentro do álbum principal.
- [ ] Tamanho e sistema de troca dos **extra stickers**.
- [ ] Prefixos de numeração (ex.: `FWC1`, `CC1`, `L1`) — padrão ainda não confirmado oficialmente.
- [ ] Confirmar se as 12 figurinhas da Coca-Cola têm **numeração integrada** ao álbum ou numeração separada (`CC1`–`CC12`).

---

## 9. Fontes Consultadas

- Panini (loja BR e internacional)
- FIFA.com — Final Draw 2026
- Football Sticker Album Wiki (Fandom)
- Beckett — 2026 Panini FIFA World Cup Sticker Collection
- Checklist Insider
- SportBible — álbum maior da história
- CNN Brasil, ESPN Brasil, Lance, Placar, Goal Brasil
- The Sports Cast — release date & pre-order
- Coca-Cola Company — parceria Panini × Coca-Cola
- Latination — "hidden stickers" nas garrafas
- Sports Collectors Digest
- Fóruns: CardzReview, Reddit (r/panini, r/soccer) — rumores e discussão de comunidade
