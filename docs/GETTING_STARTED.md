# 🚀 Guia de Início Rápido - Nx Blueprint Template

## 📋 Visão Geral

Este é um template de workspace Nx projetado para ser usado como base para novos projetos. Ele inclui configurações otimizadas, padrões arquiteturais, ferramentas de qualidade e processos de governança.

### ✨ **O que este template oferece:**

- **Arquitetura Limpa**: Implementação de Clean Architecture, DDD e padrões SOLID
- **Configuração Completa**: Nx, TypeScript, Jest, ESLint, Biome pré-configurados
- **Sistema de Governança**: Regras claras e processos definidos
- **Certificação de Segurança**: Processo estruturado baseado em padrões internacionais
- **Scripts Utilitários**: Ferramentas para detecção de flaky tasks, métricas de cobertura, etc.
- **Documentação Abrangente**: Guias, templates e exemplos práticos

---

## 🛠️ **Pré-requisitos**

Antes de começar, certifique-se de ter instalado:

- **Node.js**: >=20.11 <21
- **pnpm**: >=9.15.0
- **Git**: Para controle de versão
- **Go**: >=1.21 (opcional, para projetos Go)

### **Verificação rápida:**
```bash
node --version    # Deve ser >=20.11
pnpm --version    # Deve ser >=9.15.0
git --version     # Qualquer versão recente
go version        # Deve ser >=1.21 (se usando Go)
```

---

## 🏁 **Configuração Inicial**

### **1. Personalizar o Workspace**

#### **1.1 Atualizar Informações do Projeto**

Edite os seguintes arquivos com as informações do seu projeto:

**`package.json`:**
```json
{
  "name": "@sua-org/seu-projeto",
  "author": "Seu Nome <seu.email@empresa.com>",
  "repository": {
    "url": "https://github.com/sua-org/seu-projeto.git"
  }
}
```

**`nx.json`:**
```json
{
  "release": {
    "projects": [
      "@sua-org/*",
      "!@sua-org/seu-projeto",
      "seu-projeto/*"
    ]
  }
}
```

**`project.json`:**
```json
{
  "name": "@sua-org/seu-projeto"
}
```

#### **1.2 Configurar Variáveis de Ambiente**

Copie e personalize o arquivo de exemplo:
```bash
cp .env.example .env
```

Edite `.env` com suas configurações:
```bash
# Configurações do projeto
PROJECT_NAME="seu-projeto"
ORG_NAME="sua-org"

# Configurações de desenvolvimento
NODE_ENV=development
NX_CLOUD_DISTRIBUTED_EXECUTION=false

# Configurações de segurança (se aplicável)
NPM_TOKEN=seu_token_aqui
```

### **2. Instalar Dependências**

```bash
# Instalar dependências
pnpm install

# Verificar configuração
nx show projects
```

### **3. Configurar Git**

```bash
# Configurar remote (substitua pela URL do seu repositório)
git remote add origin https://github.com/sua-org/seu-projeto.git

# Configurar branch principal
git branch -M main
```

---

## 🏗️ **Criando Seu Primeiro Projeto**

### **1. Estrutura Recomendada**

```
apps/
├── api/                    # API Backend
├── web/                    # Frontend Web
└── mobile/                 # Aplicativo Mobile

libs/
├── shared/                 # Bibliotecas compartilhadas
│   ├── ui/                # Componentes de UI
│   ├── utils/             # Utilitários
│   └── types/             # Definições de tipos
├── domain/                 # Lógica de domínio
└── infrastructure/         # Implementações de infraestrutura
```

### **2. Gerando Projetos**

#### **2.1 Criar uma API NestJS**
```bash
nx generate @nx/nest:application api \
  --directory=apps/api \
  --tags=type:api,scope:backend
```

#### **2.2 Criar uma Aplicação Web**
```bash
nx generate @nx/react:application web \
  --directory=apps/web \
  --tags=type:app,scope:frontend
```

#### **2.3 Criar uma Biblioteca Compartilhada**
```bash
nx generate @nx/js:library shared-ui \
  --directory=libs/shared/ui \
  --tags=type:lib,scope:shared
```

### **3. Configurar Tags e Boundaries**

Adicione tags aos seus projetos para organizar e aplicar regras de dependência:

```json
// project.json
{
  "tags": ["type:app", "scope:frontend", "team:web"]
}
```

---

## 🧪 **Configurando Testes**

### **1. Estratégia de Cobertura**

Use o script utilitário para definir sua estratégia:
```bash
nx test --coverage --coverageReporters=text,lcov,html
```

### **2. Executando Testes**

```bash
# Todos os testes
nx run-many -t test

# Testes com cobertura
nx run-many -t test --coverage

# Testes de um projeto específico
nx test api
```

### **3. Detecção de Tarefas Flaky**

```bash
# Detectar tarefas instáveis
nx report

# Gerar métricas
nx report
```

---

## 🔒 **Configurando Segurança**

### **1. Certificação de Segurança**

Para componentes críticos, use o sistema de certificação:

```bash
# Gerar certificação para um componente
./scripts/security/generate-security-certification.sh \
  MyService software critical
```

### **2. Validação de Segredos**

```bash
# Validar se há segredos expostos
./scripts/security/validate-secrets.sh
```

---

## 🚀 **Desenvolvimento**

### **1. Comandos Essenciais**

```bash
# Desenvolvimento
nx serve api          # Executar API em modo dev
nx serve web          # Executar frontend em modo dev

# Build
nx build api          # Build da API
nx build web          # Build do frontend

# Linting e Formatação
nx run-many -t lint   # Executar linting
nx run-many -t format # Formatar código

# Validação completa
pnpm validate         # Lint + Build + Test
```

### **2. Trabalhando com Dependências**

```bash
# Ver dependências
nx graph

# Ver dependências afetadas
nx affected:graph

# Executar apenas projetos afetados
nx affected -t build
```

### **3. Cache e Performance**

```bash
# Validar integridade do cache
nx reset

# Limpar cache se necessário
nx reset
```

---

## 📦 **Release e Deploy**

### **1. Configuração de Release**

O template inclui configuração automática de release:

```bash
# Dry run do release
nx release --dry-run

# Executar release
nx release
```

### **2. Configuração de CI/CD**

Exemplo de workflow GitHub Actions:

```yaml
name: CI/CD Pipeline
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'
      
      - run: pnpm install
      - run: nx affected -t test
      - run: nx affected -t lint
      - run: nx affected -t build
```

---

## 🔧 **Personalização Avançada**

### **1. Configurações Específicas do Projeto**

#### **1.1 Adicionar Novas Tecnologias**

```bash
# Adicionar suporte a Go
nx add @nx-go/nx-go

# Adicionar suporte a Python
nx add @nx/python/nx-python
```

#### **1.2 Configurar Novos Targets**

```json
// project.json
{
  "targets": {
    "docker-build": {
      "executor": "nx:run-commands",
      "options": {
        "command": "docker build -t ${PROJECT_NAME} ."
      }
    }
  }
}
```

### **2. Extensões e Plugins**

#### **2.1 Plugins Recomendados**

```bash
# Plugin de Storybook
nx add @nx/storybook

# Plugin de Cypress
nx add @nx/cypress

# Plugin de Docker
nx add @nx/docker
```

---

## 📚 **Recursos Adicionais**

### **1. Documentação do Workspace**

- **[Arquitetura](./docs/ARCHITECTURE.md)**: Visão geral da arquitetura
- **[Padrões de Código](./docs/standards/)**: Padrões e convenções
- **[Certificação de Segurança](./docs/certificates/)**: Processo de certificação
- **[Templates](./docs/templates/)**: Templates para tarefas e documentação

### **2. Scripts Utilitários**

- **`detect-flaky-tasks.sh`**: Detectar tarefas instáveis
- **`flaky-tasks-metrics.sh`**: Gerar métricas de tarefas flaky
- **`coverage-strategy.sh`**: Definir estratégia de cobertura
- **`validate-cache-integrity.sh`**: Validar integridade do cache
- **`generate-security-certification.sh`**: Gerar certificações de segurança

### **3. Comandos Úteis**

```bash
# Ver todos os projetos
nx show projects

# Ver configuração de um projeto
nx show project api

# Ver dependências
nx graph

# Executar comandos em paralelo
nx run-many -t build --parallel=5

# Verificar boundaries
nx run-many -t check-boundaries
```

---

## 🆘 **Solução de Problemas**

### **1. Problemas Comuns**

#### **Cache Corrompido**
```bash
nx reset
rm -rf .nx/cache
pnpm install
```

#### **Dependências Desatualizadas**
```bash
pnpm update
nx migrate latest
```

#### **Problemas de Permissão**
```bash
# Linux/macOS
chmod -R 755 .nx/cache

# Windows (Git Bash)
git update-index --chmod=+x scripts/*.sh
```

### **2. Validação do Workspace**

```bash
# Validar configuração completa
nx reset --verbose

# Verificar integridade geral
pnpm validate
```

### **3. Suporte**

- **Documentação**: Consulte a pasta `docs/` para guias detalhados
- **Issues**: Abra uma issue no repositório do template
- **Comunidade**: Participe da comunidade Nx

---

## 🎯 **Próximos Passos**

1. **✅ Personalizar** informações do projeto
2. **✅ Configurar** variáveis de ambiente
3. **✅ Criar** seus primeiros projetos
4. **✅ Configurar** testes e cobertura
5. **✅ Implementar** certificação de segurança
6. **✅ Configurar** CI/CD
7. **✅ Personalizar** conforme necessário

---

**🎉 Parabéns!** Seu workspace Nx está configurado e pronto para desenvolvimento.

**Última atualização:** $(date +"%Y-%m-%d")  
**Versão do template:** 1.0.0
