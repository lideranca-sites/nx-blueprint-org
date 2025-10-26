# Scripts de CI/CD

Este diretório contém scripts específicos que não duplicam funcionalidade nativa do Nx 20.
**IMPORTANTE:** Use funcionalidades nativas do Nx sempre que possível.

## 📁 Estrutura Atual

```
scripts/
├── README.md                           # Este arquivo
├── security/                           # Scripts de segurança
│   └── validate-secrets.sh             # Validação de secrets (específico)
├── sonar/                              # Scripts do SonarCloud
│   └── incremental-analysis.sh         # Análise incremental (específico)
└── utils/                              # Scripts utilitários
    ├── README.md                       # Documentação dos utilitários
    └── common-functions.sh             # Funções comuns essenciais
```

## ⚠️ IMPORTANTE: Use Nx 20 nativo

**NÃO use scripts customizados para funcionalidades que o Nx 20 já fornece:**

- **Detecção de mudanças:** `nx affected --target=test --base=origin/main`
- **Cobertura:** `nx test --coverage` ou `nx affected --target=test --coverage`
- **Cache:** Nx gerencia automaticamente via `nx.json`
- **Retry:** Nx tem retry nativo via configuração
- **Paralelização:** `nx run-many --target=test --parallel=3`
- **Análise:** `nx graph`, `nx report`, `nx show projects`
- **Execução:** `nx exec` para scripts customizados
- **Configuração:** `nx.json` com `targetDefaults`, `namedInputs`

## 🚀 Scripts Específicos Mantidos

### Scripts de Segurança
- `security/validate-secrets.sh` - Validação de secrets obrigatórios

### Scripts de Qualidade
- `sonar/incremental-analysis.sh` - Análise SonarCloud incremental

### Scripts Utilitários
- `utils/common-functions.sh` - Funções comuns essenciais (sem duplicar Nx)

## 📝 Como Usar

### Para funcionalidades padrão, use Nx 20:
```bash
# Detecção de mudanças
nx affected --target=test --base=origin/main

# Cobertura
nx test --coverage

# Paralelização
nx run-many --target=test --parallel=3

# Análise
nx graph
nx report
```

### Para funcionalidades específicas, use scripts:
```bash
# Validação de secrets
./scripts/security/validate-secrets.sh

# Análise SonarCloud
./scripts/sonar/incremental-analysis.sh

# Carregar funções comuns
source scripts/utils/common-functions.sh
```

## 🔧 Configuração Necessária

### Secrets do GitHub Actions
Configure os seguintes secrets no repositório:
- `GH_TOKEN` - Token do GitHub
- `NPM_TOKEN` - Token do NPM
- `SONAR_TOKEN` - Token do SonarCloud

### Variáveis de Ambiente SonarCloud
Configure as seguintes variáveis:
- `SONAR_PROJECT_KEY` - Chave do projeto SonarCloud
- `SONAR_ORGANIZATION` - Organização SonarCloud
