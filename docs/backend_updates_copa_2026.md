# Atualizações Necessárias no Backend — Completa AI (Copa 2026)

> Documento de referência para o time de backend. Mapeia **o que o app já consome hoje** (branch `feat/firebase-config`) e **o que precisa ser entregue** para suportar o fluxo completo de organização do álbum Panini Copa do Mundo 2026™ (ver `docs/planejamento_figurinhas_copa_2026.md`).
> Última atualização: abril/2026.

---

## 1. Convenções Gerais

- **Base URL:** `AppConfig.baseUrl` (configurável dev/prod em `lib/core/config/app_config.dart`).
- **Auth:** `Authorization: Bearer <firebase_id_token>` (injetado pelo `AuthInterceptor`). Backend **deve validar o ID Token do Firebase** (kid, iss, aud, exp).
- **Content-Type:** `application/json` (em requests e responses).
- **Timeouts client-side:** 30s connect / 30s receive / 30s send.
- **Erros:** o app já trata a hierarquia:
  - `400 BadRequestException` / `ValidationException`
  - `401 UnauthorizedException`
  - `403 ForbiddenException`
  - `404 NotFoundException`
  - `409 ConflictException`
  - `429 TooManyRequestsException`
  - `5xx ServerException`
  - `timeout TimeoutException`
  - `network NetworkException`
  - Backend **deve** retornar JSON `{ "error": { "code": "...", "message": "...", "details": {...} } }` para os códigos acima.
- **IDs:** `Sticker.id` e `Section.id` devem ser **estáveis** (slug/UUID). Usar `number` como campo secundário (varia conforme Panini publica checklist oficial).
- **Paginação:** adicionar `?page=<n>&pageSize=<n>` nas listas (ver §4).
- **Versionamento:** prefixo `/v1` (sugestão). Hoje o app **não** tem prefixo — introduzir antes do primeiro release externo.

---

## 2. Endpoints Atualmente Consumidos pelo App

Implementados em `lib/shared/services/*.dart`. Backend precisa responder nestes contratos.

### 2.1. Coleção do usuário (`CollectionApiService`)

| Método | Rota | Uso no app |
|---|---|---|
| `GET` | `/collection` | Home, detalhe de seção |
| `PUT` | `/collection` | Sync completo (body: `{ "stickers": { "<id>": <qty> } }`) |
| `POST` | `/collection/sync` | Sync com merge (body: `{ "stickers": {...}, "client_time": "<ISO8601>" }`) |
| `PATCH` | `/collection/stickers/:stickerId` | Atualiza uma única figurinha (`{ "quantity": <int> }`) |

**Formato aceito hoje no GET/SYNC (dual):**
```json
{
  "stickers": {
    "BRA-01": 3,
    "LEGEND-MESSI": { "stickerId": "LEGEND-MESSI", "isOwned": true, "repeatedCount": 0, "updatedAt": "2026-04-20T14:22:11Z" }
  }
}
```
> O parser no app aceita tanto `int` (qty) quanto objeto `UserSticker`. **Recomendação:** padronizar no objeto `UserSticker` e deprecar o formato `int`.

### 2.2. Seções (`SectionApiService`)

| Método | Rota | Uso |
|---|---|---|
| `GET` | `/sections` | Home (lista de seções) |
| `GET` | `/sections/:id` | Detalhe de seção |

**Schema atual (`Section`):**
```json
{
  "id": "team-BRA",
  "name": "Brasil",
  "imageUrl": "https://.../bra-flag.png",
  "totalStickers": 20,
  "order": 103
}
```

### 2.3. Figurinhas (`StickerApiService`)

| Método | Rota | Uso |
|---|---|---|
| `GET` | `/stickers?sectionId=:id` | Grid da seção |
| `GET` | `/stickers/:id` | Detalhe |
| `GET` | `/stickers/search?q=:query` | Busca |

**Schema atual (`Sticker`):**
```json
{
  "id": "BRA-01",
  "number": "103",
  "name": "Escudo — Brasil",
  "sectionId": "team-BRA",
  "isOwned": false,
  "repeatedCount": 0
}
```
> ⚠️ Observação: `isOwned` e `repeatedCount` **não deveriam** vir no catálogo público. Migrar para response "merged" só no `/collection` (ver §4.2).

### 2.4. Usuário (`UserApiService`)

| Método | Rota | Uso |
|---|---|---|
| `GET` | `/profile` | ProfileScreen |
| `PATCH` | `/profile` | Editar perfil (`displayName`, `photoUrl`, `phoneNumber`) |
| `DELETE` | `/auth/account` | Excluir conta |

**Schema atual (`UserProfile`):**
```json
{
  "id": "uid-firebase",
  "email": "user@mail.com",
  "displayName": "User",
  "photoUrl": "https://...",
  "phoneNumber": "+55...",
  "totalOwned": 0,
  "totalRepeated": 0,
  "createdAt": "2026-04-01T00:00:00Z",
  "lastLoginAt": "2026-04-19T10:00:00Z"
}
```

---

## 3. Gaps Imediatos nos Endpoints Existentes

Ajustes **obrigatórios** para o app funcionar bem com os dados do álbum 2026:

### 3.1. `GET /sections` — adicionar metadados de categoria

O app hoje só recebe `id`, `name`, `imageUrl`, `totalStickers`, `order`. Precisamos diferenciar seção de time de seção especial.

**Adicionar:**
```json
{
  "id": "team-BRA",
  "kind": "team",                // NEW: team | intro | host_cities | legends | coca_cola | extras
  "group": "C",                  // NEW: só quando kind = team
  "teamCode": "BRA",             // NEW: só quando kind = team
  "isSpecial": false,            // NEW: derivado de kind != team
  "materialHint": "mixed"        // NEW: mixed | couche | metallic
}
```

> **Impacto no app:** adicionar campos opcionais em `lib/shared/models/section.dart` (`kind`, `group`, `teamCode`, `isSpecial`, `materialHint`) mantendo `fromJson` backward-compatible.

### 3.2. `Sticker` — adicionar categoria, material e metadados

Hoje: `id`, `number`, `name`, `sectionId`, `isOwned`, `repeatedCount`.

**Adicionar:**
```json
{
  "id": "BRA-01",
  "number": "103",
  "name": "Escudo — Brasil",
  "sectionId": "team-BRA",
  "category": "team_badge",          // NEW
  "material": "metallic",            // NEW: couche | metallic
  "imageUrl": "https://.../s/103.png",// NEW
  "thumbnailUrl": "https://.../s/103_thumb.png", // NEW
  "playerName": null,                // NEW: quando category = player | legend | coca_cola
  "playerPosition": null,            // NEW
  "playerShirtNumber": null,         // NEW
  "teamCode": "BRA",                 // NEW (redundante, facilita filtros)
  "isProvisional": true,             // NEW: flag para pré-checklist oficial
  "source": "panini"                 // NEW: panini | coca_cola | extra
}
```

**Remover do catálogo público:** `isOwned` e `repeatedCount` (isso é do usuário, não do catálogo).

### 3.3. `GET /collection` — padronizar resposta

Hoje aceita dois formatos (int ou objeto). Padronizar sempre como objeto:
```json
{
  "stickers": {
    "BRA-01": {
      "stickerId": "BRA-01",
      "isOwned": true,
      "repeatedCount": 2,
      "updatedAt": "2026-04-20T14:22:11Z"
    }
  },
  "syncedAt": "2026-04-20T14:22:11Z"
}
```

### 3.4. `POST /collection/sync` — retornar conflitos

Hoje só devolve o estado mesclado. Expandir para retornar o que mudou:
```json
{
  "stickers": { ... },
  "syncedAt": "2026-04-20T14:22:11Z",
  "conflicts": [
    {"stickerId": "BRA-01", "client": 3, "server": 1, "resolved": "server"}
  ]
}
```
Estratégia sugerida: **last-write-wins por `stickerId`** usando `updatedAt`.

### 3.5. `DELETE /auth/account` — contrato de confirmação

Retornar `202 Accepted` se a exclusão for assíncrona (mais seguro que `204`). Body:
```json
{"status": "scheduled", "expectedDeletionAt": "2026-04-27T00:00:00Z"}
```
(O app pode chamar `FirebaseAuth.signOut()` logo depois.)

---

## 4. Endpoints **Novos** Necessários

Para cobrir o planejamento do álbum 2026.

### 4.1. Times e Grupos

| Método | Rota | Descrição |
|---|---|---|
| `GET` | `/teams` | Lista as 48 seleções com `code`, `name`, `group`, `sectionId`, `flagUrl` |
| `GET` | `/teams/:code` | Detalhe de uma seleção (inclui squad, treinador opcional) |
| `GET` | `/groups` | Lista dos 12 grupos A–L com seus times |
| `GET` | `/groups/:letter` | Detalhe de grupo (times + % de completude do usuário autenticado) |

**Schema `Team`:**
```json
{
  "code": "BRA",
  "name": "Brasil",
  "group": "C",
  "sectionId": "team-BRA",
  "flagUrl": "https://.../bra.png",
  "kitPrimaryColor": "#FFD90F"
}
```

### 4.2. Catálogo expandido

| Método | Rota | Descrição |
|---|---|---|
| `GET` | `/stickers?sectionId=X&category=Y&material=Z&group=W` | Filtros compostos |
| `GET` | `/stickers/missing` | Retorna só as que o usuário **não tem** |
| `GET` | `/stickers/repeated` | Retorna só as repetidas (`repeatedCount >= 1`) |

### 4.3. Estatísticas do usuário

| Método | Rota | Descrição |
|---|---|---|
| `GET` | `/me/stats` | Progresso por seção, por categoria, por grupo, por material (metalizadas) |
| `GET` | `/me/stats/projection` | Projeção de custo e pacotes restantes |

**Response `/me/stats`:**
```json
{
  "totals": {"owned": 420, "repeated": 95, "total": 980, "percent": 42.86},
  "byCategory": {
    "player": {"owned": 380, "total": 864},
    "team_badge": {"owned": 20, "total": 48},
    "legend": {"owned": 2, "total": 9},
    "coca_cola": {"owned": 0, "total": 12},
    "host_city": {"owned": 10, "total": 32},
    "intro": {"owned": 8, "total": 20}
  },
  "byGroup": { "A": {"percent": 30}, "B": {"percent": 55}, ... },
  "byMaterial": {"metallic": {"owned": 15, "total": 68}, "couche": {"owned": 405, "total": 912}}
}
```

### 4.4. Trocas / Compartilhamento (`/share`)

Rota já existe no app (`AppRoutes.share`) — backend **ainda não tem endpoints**.

| Método | Rota | Descrição |
|---|---|---|
| `POST` | `/trades/matches` | Recebe (opcional) filtros e devolve **outros usuários** com sobreposição entre minhas repetidas e o que falta para eles |
| `GET` | `/trades/me` | Minha lista consolidada (tenho/falta/repetida) |
| `POST` | `/trades/proposals` | Cria proposta de troca (A oferece X → recebe Y) |
| `GET` | `/trades/proposals` | Lista propostas recebidas/enviadas |
| `PATCH` | `/trades/proposals/:id` | Aceitar/recusar/cancelar |
| `POST` | `/trades/proposals/:id/complete` | Confirma que a troca aconteceu offline |

**Nota de privacidade:** `POST /trades/matches` deve expor apenas `displayName`, `photoUrl`, distância aproximada ou cidade, nunca e-mail/telefone. Usuário **precisa aceitar** aparecer em matching (flag em `UserProfile`).

### 4.5. Notificações (screen existe)

| Método | Rota | Descrição |
|---|---|---|
| `GET` | `/me/notifications/settings` | Preferências |
| `PUT` | `/me/notifications/settings` | Atualiza |
| `POST` | `/me/devices` | Registra FCM token (`{ "token": "...", "platform": "android\|ios" }`) |
| `DELETE` | `/me/devices/:token` | Remove token no logout |

Eventos a disparar (FCM):
- Nova proposta de troca.
- Alguém aceitou sua troca.
- Lembrete de sync (opcional).

### 4.6. Coca-Cola — figurinhas por QR / rótulo

As 12 figurinhas Coca-Cola **não vêm em pacotes** — só em rótulos. Precisa de claim authenticated:

| Método | Rota | Descrição |
|---|---|---|
| `POST` | `/claims/coca-cola` | Body: `{ "code": "<raspadinha>" }`. Valida, marca figurinha correspondente como owned, retorna `Sticker`. |
| `GET` | `/claims/coca-cola/history` | Códigos já usados pelo usuário |

Proteções obrigatórias:
- Rate limit 10/min por usuário.
- Código consumido **uma única vez** (status `claimed`, `consumedByUserId`).
- Retornar `409 Conflict` se já consumido por outro; `400 Validation` se inválido.

### 4.7. Scanner — OCR do número

Tela `ScannerScreen` já existe. Fluxo sugerido:

| Método | Rota | Descrição |
|---|---|---|
| `POST` | `/stickers/resolve` | Body: `{ "number": "103" }` ou `{ "imageBase64": "..." }` → retorna `Sticker` ou `404` |

Pode começar só com `number` (OCR no cliente). `imageBase64` é backlog (OCR server-side).

### 4.8. Search aprimorado (facets)

Hoje: `/stickers/search?q=`. Adicionar facets para UI de filtros:

| Método | Rota | Descrição |
|---|---|---|
| `GET` | `/stickers/search?q=&category=&material=&group=&section=&ownedState=missing\|repeated\|any` | |
| `GET` | `/stickers/facets` | Conta figurinhas por categoria/grupo/material (para chips de filtro) |

### 4.9. Admin / seed (interno)

Para a equipe popular o catálogo antes do checklist oficial:

| Método | Rota | Descrição |
|---|---|---|
| `POST` | `/admin/catalog/import` | Upload CSV/JSON de `sections` + `stickers` (auth: role=admin) |
| `POST` | `/admin/catalog/promote-official` | Substitui `number` provisório pelo oficial mantendo `id` |

---

## 5. Modelo de Dados Sugerido (backend)

Entidades-núcleo. Pode ser Postgres, Firestore ou híbrido — decisão do time de infra.

```
Team
  code (PK)            varchar(3)
  name                 varchar
  group                char(1)   -- 'A'..'L'
  section_id (FK)      fk → sections.id
  flag_url             text
  kit_primary_color    varchar

Section
  id (PK)              varchar
  name                 varchar
  image_url            text
  total_stickers       int
  order                int
  kind                 enum('team','intro','host_cities','legends','coca_cola','extras')
  is_special           bool
  material_hint        enum('couche','metallic','mixed')
  group                char(1) nullable
  team_code            varchar(3) nullable (FK teams.code)

Sticker
  id (PK)              varchar (slug, estável)
  number               varchar     -- pode ser provisório
  name                 varchar
  section_id (FK)
  category             enum('team_badge','team_photo','player','intro','host_city','legend','coca_cola','extra')
  material             enum('couche','metallic')
  image_url            text
  thumbnail_url        text
  player_name          varchar nullable
  player_position      varchar nullable
  player_shirt_number  int nullable
  team_code            varchar(3) nullable
  is_provisional       bool default true
  source               enum('panini','coca_cola','extra')
  created_at, updated_at

UserSticker
  user_id (FK)
  sticker_id (FK)
  is_owned             bool
  repeated_count       int
  updated_at           timestamp
  PK (user_id, sticker_id)

UserProfile
  id (PK = firebase uid)
  email, display_name, photo_url, phone_number
  allow_trade_matching bool default false      -- NEW
  city, region         nullable                -- NEW (trocas)
  total_owned          int (materializado)
  total_repeated       int (materializado)
  created_at, last_login_at

CocaColaCode
  code (PK)            varchar
  sticker_id (FK)
  status               enum('unused','claimed','void')
  consumed_by_user_id  fk nullable
  consumed_at          timestamp nullable

TradeProposal
  id (PK)
  from_user_id, to_user_id
  offered_sticker_ids  array<varchar>
  requested_sticker_ids array<varchar>
  status               enum('pending','accepted','rejected','cancelled','completed')
  created_at, updated_at

DeviceToken
  user_id, token, platform, created_at
  PK (user_id, token)
```

---

## 6. Contratos Não-Funcionais

- **Rate limit:** 60 req/min por usuário no geral; 10 req/min em endpoints de claim e trade.
- **Cache:** `Cache-Control: public, max-age=3600` no catálogo (`/sections`, `/stickers`, `/teams`, `/groups`). Catálogo muda raramente.
- **Idempotência:** `POST /collection/sync`, `POST /claims/coca-cola`, `POST /trades/proposals` aceitarão `Idempotency-Key` header.
- **Compressão:** gzip/brotli.
- **Observability:** logar `stickerId`, `userId` (hash), `traceId` em erros. Backend precisa expor `X-Request-Id` nas responses (app já loga via interceptor).
- **Segurança:**
  - Validar Firebase ID Token via Admin SDK (nunca trust blindly).
  - Bloquear escrita de `UserSticker` de outro `user_id`.
  - CORS: restringir a domínios confiáveis (se houver web).
  - Não retornar e-mail/telefone de outros usuários em `/trades/*`.
- **LGPD:** endpoint de exportação (`GET /me/export` → JSON) e purge completo em `DELETE /auth/account`.

---

## 7. Roadmap Sugerido (alinhado ao plano do app)

| Sprint | Backend entregas |
|---|---|
| **S1 — Base** | Ajustes §3 (campos `kind`, `category`, `material`, padronização de `/collection`). Seed inicial via `/admin/catalog/import`. |
| **S2 — Times & Grupos** | `/teams`, `/groups`, facets no search. |
| **S3 — Especiais** | `/claims/coca-cola`, `/stickers/resolve`, flags `is_provisional`, `source`. |
| **S4 — Trocas** | `/trades/*`, privacy flags em `UserProfile`, notificações FCM. |
| **S5 — Checklist oficial** | Endpoint de promoção (`/admin/catalog/promote-official`), migração de `number` provisório → oficial preservando `id`. |
| **S6 — Social / Stats** | `/me/stats`, `/me/stats/projection`, conquistas. |

---

## 8. Checklist para a Primeira Entrega (mínimo viável)

- [ ] Retornar `Section.kind` e `Section.group` em `/sections`.
- [ ] Retornar `Sticker.category`, `Sticker.material`, `Sticker.imageUrl` em `/stickers`.
- [ ] Padronizar response de `/collection` sempre como objeto `UserSticker`.
- [ ] Publicar `/teams` e `/groups`.
- [ ] Documentar contrato de erro padrão `{ error: { code, message, details } }`.
- [ ] Validar Firebase ID Token em todos os endpoints `/profile`, `/collection`, `/trades`, `/claims`.

---

## 9. Dependências do App que Impactam o Backend

Do `pubspec.yaml`:
- `dio ^5.9.0` — cliente HTTP.
- `firebase_auth ^6.1.3` — Token (Bearer ID Token).
- `firebase_analytics`, `firebase_crashlytics`, `firebase_performance` — tracing client-side.
- `shared_preferences` — cache local simples.
- `google_sign_in`, `sign_in_with_apple` — cada novo provider precisa ser registrado no Firebase Auth do projeto.

> O backend **não precisa** falar com Firestore — o app migrou para API própria (`refactor: update user repository to use api service`, `refactor: remove firestore methods from models`). Manter esse padrão.

---

## 10. Perguntas em Aberto para o Time de Backend

1. Vamos usar Postgres, Firestore ou um híbrido (Postgres para catálogo + Firestore para `UserSticker`)?
2. O matching de trocas usa geolocalização real (lat/long) ou só cidade?
3. Códigos Coca-Cola virão de um CSV fornecido pela Panini/Coca-Cola ou serão gerados localmente?
4. Qual é o SLO de latência esperado para `/collection` (impacta caching agressivo)?
5. Precisamos de webhook da Panini para atualizar checklist automaticamente?
6. Admin CMS próprio ou uso de ferramenta externa (Retool, Strapi, Forest Admin) para popular o catálogo?
