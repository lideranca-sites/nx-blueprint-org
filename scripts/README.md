# Scripts de CI/CD

Este diretório contém scripts específicos que não duplicam funcionalidade nativa do Nx 20.
**IMPORTANTE:** Use funcionalidades nativas do Nx sempre que possível.

## 📁 Estrutura Simplificada

```
scripts/
├── README.md                              # Este arquivo
├── go/                                    # Scripts Go (uso futuro)
│   ├── README.md                         # Documentação de uso futuro
│   ├── fix-go-cache.sh                   # Correção de cache Go
│   └── sync-go-versions.sh               # Sincronização de versões Go
├── security/                             # Scripts de segurança
│   ├── generate-security-certification.sh # Geração de certificação de segurança
│   └── validate-secrets.sh               # Validação de secrets CI/CD
└── sonar/                                # Scripts do SonarCloud
    └── incremental-analysis.sh           # Análise incremental SonarCloud
```

## ⚠️ IMPORTANTE: Use Nx 20 nativo primeiro

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

### Scripts Go (preparados para uso futuro)
- `go/fix-go-cache.sh` - Correção de cache Go específica
- `go/sync-go-versions.sh` - Sincronização de versões Go específica

### Scripts de Segurança
- `security/validate-secrets.sh` - Validação de secrets obrigatórios
- `security/generate-security-certification.sh` - Geração de certificação de segurança

### Scripts de Integração Externa
- `sonar/incremental-analysis.sh` - Análise SonarCloud incremental

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
# Validação de secrets (CI/CD)
./scripts/security/validate-secrets.sh

# Análise SonarCloud
./scripts/sonar/incremental-analysis.sh

# Scripts Go (quando houver projetos Go)
./scripts/go/fix-go-cache.sh
./scripts/go/sync-go-versions.sh

# Geração de certificação de segurança
./scripts/security/generate-security-certification.sh LoggerService software critical
```

## 🎯 Quando Usar Scripts vs Nx Nativo

| Funcionalidade | Use | Motivo |
|---|---|---|
| Testes e cobertura | `nx test --coverage` | Nativo, configurável via nx.json |
| Cache | `nx reset`, `nx report` | Gerenciamento automático |
| Detecção de mudanças | `nx affected` | Nativo, mais eficiente |
| Paralelização | `nx run-many --parallel=N` | Nativo, otimizado |
| Análise de projetos | `nx graph`, `nx show projects` | Nativo, completo |
| Validação de secrets | `./scripts/security/validate-secrets.sh` | Específico CI/CD |
| Análise SonarCloud | `./scripts/sonar/incremental-analysis.sh` | Integração externa |
| Cache Go | `./scripts/go/fix-go-cache.sh` | Específico Go |
| Certificação segurança | `./scripts/security/generate-security-certification.sh` | Processo específico |

## 📊 Redução Implementada

**Antes:** 15 arquivos (incluindo duplicações do Nx)
**Depois:** 6 arquivos essenciais
**Redução:** 60% menos arquivos, foco no essencial

Scripts removidos foram substituídos por funcionalidades nativas do Nx 20.
