# Kong Gateway VPS

Kong Gateway Architecture Application that acts as an API proxy for microservices.

## 📋 O que é?

Um **Kong Gateway** é um API proxy robusto que funciona como middlewere central para gerenciar:
- ✅ Roteamento de requisições
- ✅ Autenticação e autorização (JWT, OAuth, API Key)
- ✅ Rate limiting e throttling
- ✅ CORS e headers HTTP
- ✅ Logging e monitoramento
- ✅ Transformação de requisições/respostas

---

## 🏗️ Arquitetura

```
GitHub (develop/main/release)
        ↓
   CI/CD Pipeline (.github/workflows/deploy.yml)
        ↓
   Build Docker Image
        ↓
   Push to Docker Hub
        ↓
   Update Kubernetes Manifests
        ↓
   Deploy to K8s Namespace
        ├── develop/
        ├── main/ (prod)
        └── release/ (staging)
```

---

## 🚀 Quick Start

### Build Local
```bash
docker build -t kong-api:dev .
docker run -p 8000:8000 -p 8001:8001 kong-api:dev
```

### Deploy no Kubernetes
```bash
# Develop
kubectl apply -f kubernetes/develop/

# Production
kubectl apply -f kubernetes/main/
```

---

## 📁 Estrutura do Projeto

```
Kong_Gateway_vps/
├── Dockerfile              # Imagem Docker Kong
├── kong.yml               # Configuração Kong
├── .dockerignore          # Arquivos ignorados na build
├── README.md              # Este arquivo
│
├── kubernetes/            # Manifests Kubernetes
│   ├── develop/           # Ambiente de desenvolvimento
│   │   ├── namespace.yml
│   │   ├── deployment.yml
│   │   ├── service.yml
│   │   └── ingress.yml
│   │
│   └── main/              # Ambiente de produção
│       ├── namespace.yml
│       ├── deployment.yml
│       ├── service.yml
│       └── ingress.yml
│
└── .github/workflows/     # CI/CD
    └── deploy.yml         # GitHub Actions Pipeline
```

---

## ⚙️ Configuração

### 1. Secrets GitHub
Configure os secrets em: `Settings → Secrets and variables → Actions`

| Secret | Descrição |
|--------|-----------|
| `DOCKER_USERNAME` | Seu username Docker Hub |
| `DOCKER_TOKEN` | Token de acesso Docker Hub |

**Como gerar Docker Token:**
```
🔗 https://app.docker.com/settings/personal-access-tokens
- Click "Create token"
- Name: github-actions
- Permissions: Read, Write, Delete
- Copy o token
```

### 2. Configurar Kong
Edite `kong.yml` com suas rotas e plugins.

### 3. Deploy no Kubernetes (Manual)
```bash
kubectl apply -f kubernetes/develop/namespace.yml
kubectl apply -f kubernetes/develop/deployment.yml
kubectl apply -f kubernetes/develop/service.yml
kubectl apply -f kubernetes/develop/ingress.yml
```

---

## 🔄 CI/CD Pipeline

Automaticamente executado em: `push` para branches `develop`, `main` ou `release`

**O que acontece:**
1. ✅ Valida Docker credentials (secrets)
2. 📦 Build imagem Docker
3. 📤 Push para Docker Hub
4. 🔄 Atualiza manifests Kubernetes
5. 📝 Commita mudanças

**Status:** Verifique em: `GitHub → Actions`

---

## 🔗 Endpoints

### Kong Proxy (8000)
```
GET  http://localhost:8000/health
GET  http://localhost:8000/api/*
```

### Kong Admin API (8001)
```
GET  http://localhost:8001/status
GET  http://localhost:8001/services
GET  http://localhost:8001/routes
```

---

## 📝 Logs

### Local
```bash
docker logs <container-id>
```

### Kubernetes
```bash
kubectl logs -n kong deployment/kong
kubectl logs -n kong deployment/kong --follow
```

---

## 🐛 Troubleshooting

### Erro: Dockerfile não encontrado
```bash
# Verifique se o Dockerfile existe na raiz
ls -la Dockerfile
```

### Erro: Secrets não configurados
```bash
# Verifique GitHub Settings → Secrets
# Adicione: DOCKER_USERNAME, DOCKER_TOKEN
```

### Erro: Imagem não há no Docker Hub
```bash
# Verifique o workflow log no GitHub Actions
# Procure por: "Push para Docker Hub"
```

---
