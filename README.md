# Completa Aí - Álbum Copa 2026

Aplicativo mobile para colecionadores gerenciarem suas figurinhas do álbum da Copa do Mundo 2026.

## Sobre

**Completa Aí** permite catalogar sua coleção rapidamente via scanner automático, visualizar progresso por seção e gerar listas formatadas para compartilhar no WhatsApp.

## Features

- **Checklist de Figurinhas** - Marque como "tenho" ou "repetida" com contador
- **Scanner Automático** - OCR contínuo detecta códigos automaticamente
- **Progresso Visual** - Acompanhe por seção e geral
- **Compartilhamento** - Gere listas de faltantes/repetidas para WhatsApp
- **Busca Rápida** - Encontre por código (ex: "BRA 12")
- **Offline-first** - Funciona sem internet com sync automático

## Stack Técnica

| Camada | Tecnologia |
|--------|------------|
| Frontend | Flutter (iOS + Android) |
| Backend | Supabase (PostgreSQL + Auth + Realtime) |
| Cache Local | Hive |
| OCR | Google ML Kit |

## Packages Principais

- `supabase_flutter` - Auth, database e realtime
- `camera` - Acesso à câmera
- `google_mlkit_text_recognition` - OCR
- `permission_handler` - Permissões
- `hive` - Cache local para offline
- `share_plus` - Compartilhamento

## Estrutura do Álbum

- **48 seleções** (20 figurinhas cada)
- **Estádios** (16 figurinhas)
- **Posters das Cidades** (16 figurinhas)
- **Seções Especiais** (~40 figurinhas)
- **Total estimado:** ~980 figurinhas

## Getting Started

```bash
# Clone o repositório
git clone <repo-url>

# Instale as dependências
flutter pub get

# Configure as variáveis de ambiente do Supabase
cp .env.example .env

# Execute o app
flutter run
```

## Requisitos

- Flutter 3.38+
- Dart 3.8+
- iOS 12+ / Android API 21+

## Licença

Projeto privado - Todos os direitos reservados.
