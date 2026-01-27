# 🐝 BeeSafe – Proteção de Abelhas no Agronegócio

O **BeeSafe** é um aplicativo mobile que conecta **agricultores** e **apicultores**, promovendo a **comunicação antecipada sobre pulverizações agrícolas** e ajudando a **reduzir a mortalidade de abelhas** causada pelo uso de defensivos próximos às colmeias.

---

## 🎯 Objetivo do Projeto

Permitir que:

- **Apicultores** cadastrem a localização de suas colmeias
- **Agricultores** registrem pulverizações agrícolas
- O sistema **identifique automaticamente possíveis impactos**
- **Notificações sejam enviadas aos apicultores afetados**

Tudo isso de forma **simples, segura e escalável**, respeitando a privacidade dos usuários.

---

## 📱 Funcionalidades Principais

### 👤 Autenticação
- Cadastro e login
- Dois perfis:
  - Agricultor
  - Apicultor

---

### 🗺️ Mapa Interativo
- Visualização via Google Maps
- Seleção de ponto no mapa
- Definição de raio de atuação (via slider)

---

### 🐝 Cadastro de Colmeias
- Apicultores registram:
  - localização (latitude/longitude)
  - raio padrão de atuação (3 km)

---

### 🚜 Registro de Pulverizações
- Agricultores informam:
  - local da aplicação
  - raio da pulverização
  - tipo de agrotóxico
  - grupo de risco

---

### ⚠️ Detecção de Impacto
- O backend verifica:
  - interseção entre o raio da pulverização e colmeias cadastradas
- Caso exista impacto:
  - o agricultor recebe um alerta
  - ao confirmar, apicultores são notificados

---

### 🔔 Notificações
- Push notifications via **Firebase Cloud Messaging**
- Histórico salvo no banco

---

## 🏗️ Arquitetura

### 📦 Mobile
- **Flutter**
- Arquitetura inspirada em **Clean Architecture**
- Gerenciamento de estado com **Provider / Cubit**
- Injeção de dependência com **GetIt**
- Navegação com **go_router**

---

### ☁️ Backend
- **Supabase**
  - PostgreSQL
  - Edge Functions (Deno)
  - Row Level Security (RLS)
- **Firebase Cloud Messaging**
  - envio de notificações push

---

## 🗂️ Estrutura do Projeto (Flutter)

```text
lib/
├── core/
│   ├── services/
│   ├── helpers/
│   └── service_locator.dart
│
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── providers/
│
├── presentation/
│   ├── pages/
│   └── widgets/
│
└── main.dart
```

---

## 🧪 Tecnologias Utilizadas

| Camada | Tecnologia |
|------|-----------|
| Mobile | Flutter |
| Mapas | Google Maps |
| Backend | Supabase |
| Banco de Dados | PostgreSQL |
| Notificações | Firebase Cloud Messaging |
| Edge Functions | Deno |
| Autenticação | Supabase Auth |

---

## 🔐 Segurança e Privacidade

- Autenticação via **Supabase Auth**
- Políticas de **Row Level Security (RLS)**
- Comunicação segura via HTTPS
- Dados sensíveis protegidos no backend
- Localização das colmeias não é exposta diretamente a agricultores
- Notificações vinculadas apenas a usuários autenticados

---

## 🚀 Status do Projeto

🟡 **Em desenvolvimento (MVP)**

Próximos passos:
- Melhorias de UX
- Histórico e filtros avançados

