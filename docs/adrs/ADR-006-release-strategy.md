# ADR-006: Configuração de Release e Versionamento

## Status
✅ **ACEITO** - 2025-01-27

## Contexto

Precisamos estabelecer um processo para:
- Versionamento semântico consistente
- Release automatizado
- Changelog automático
- Publicação de pacotes

### Problemas Identificados
- Versionamento manual inconsistente
- Changelog desatualizado
- Processo de release manual e propenso a erros
- Falta de rastreabilidade de mudanças

## Decisão

Implementamos **Nx Release** com Conventional Commits para automatizar o processo de release.

### Estratégia Adotada

1. **Conventional Commits**
   - Padronização de mensagens de commit
   - Geração automática de changelog
   - Versionamento semântico automático

2. **Release Independente**
   - Cada projeto versionado independentemente
   - Releases baseados em mudanças reais
   - Flexibilidade para diferentes ciclos

3. **Automação Completa**
   - CI/CD integrado
   - Validação pré-release
   - Publicação automática

## Implementação

### Configuração do Nx Release

```json
// nx.json
{
  "release": {
    "projects": [
      "@your-org/*",
      "!@your-org/your-project",
      "your-project/*"
    ],
    "projectsRelationship": "independent",
    "releaseTagPattern": "{projectName}@{version}",
    "git": {
      "commit": true,
      "commitMessage": "🔖 chore(release): publish {version}",
      "tag": true,
      "tagMessage": "🔖 chore(release): tag {tagName}",
      "push": true
    },
    "version": {
      "preVersionCommand": "pnpm nx affected -t build --parallel=5",
      "generator": "@nx/js:release-version",
      "generatorOptions": {
        "packageRoot": "{projectRoot}",
        "currentVersionResolver": "git-tag",
        "fallbackCurrentVersionResolver": "disk",
        "specifierSource": "conventional-commits"
      }
    },
    "changelog": {
      "projectChangelogs": {
        "createRelease": "github",
        "entryWhenNoChanges": "This was a version bump only, there were no code changes.",
        "file": "{projectRoot}/CHANGELOG.md",
        "renderOptions": {
          "includeAuthors": true,
          "includeCommits": true,
          "includeScopes": true
        }
      }
    }
  }
}
```

### Conventional Commits

#### **Formato Padrão**
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### **Tipos Suportados**
- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Documentação
- `style`: Formatação
- `refactor`: Refatoração
- `perf`: Melhoria de performance
- `test`: Testes
- `chore`: Tarefas de manutenção

#### **Exemplos**
```bash
# Nova funcionalidade (patch)
feat(auth): add JWT token validation

# Correção de bug (patch)
fix(api): resolve memory leak in user service

# Mudança que quebra compatibilidade (major)
feat!: migrate to new authentication system

BREAKING CHANGE: Old auth tokens are no longer supported
```

### Scripts de Release

```json
// package.json
{
  "scripts": {
    "release": "nx release",
    "release:dry-run": "nx release --dry-run",
    "release:version": "nx release version",
    "release:publish": "nx release publish",
    "release:verify": "pnpm format:check && pnpm lint:affected && pnpm test:affected"
  }
}
```

## Processo de Release

### **1. Desenvolvimento**
```bash
# Fazer mudanças
git add .
git commit -m "feat(user): add user profile management"

# Push para branch
git push origin feature/user-profile
```

### **2. Pull Request**
- Validação automática via CI/CD
- Review de código
- Merge para main

### **3. Release Automático**
```bash
# Executado automaticamente no CI/CD
pnpm release:verify    # Validação pré-release
pnpm release:version   # Geração de versão e changelog
pnpm release:publish   # Publicação de pacotes
```

### **4. Validação Manual (Opcional)**
```bash
# Dry run para verificar mudanças
pnpm release:dry-run

# Executar release manualmente
pnpm release
```

## Configuração de CI/CD

### **GitHub Actions Workflow**
```yaml
# .github/workflows/release.yml
name: Release

on:
  push:
    branches: [main]
    paths-ignore:
      - 'docs/**'
      - '*.md'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          fetch-depth: 0

      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'

      - run: pnpm install
      - run: pnpm release:verify
      - run: pnpm release:version
      - run: pnpm release:publish
        env:
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}

      - name: Push changes
        run: git push --follow-tags
```

### **Validação de PR**
```yaml
# .github/workflows/release-validation.yml
name: Release Validation

on:
  pull_request:
    branches: [main]

jobs:
  validate-release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'

      - run: pnpm install
      - run: pnpm release:dry-run
```

## Estratégias de Versionamento

### **Semantic Versioning**
- **MAJOR**: Mudanças que quebram compatibilidade
- **MINOR**: Novas funcionalidades compatíveis
- **PATCH**: Correções de bugs compatíveis

### **Conventional Commits → Version**
- `feat:` → MINOR
- `fix:` → PATCH
- `feat!:` → MAJOR
- `BREAKING CHANGE:` → MAJOR

### **Exemplos de Versionamento**
```bash
# 1.0.0 → 1.0.1 (patch)
fix(api): resolve authentication bug

# 1.0.1 → 1.1.0 (minor)
feat(user): add profile management

# 1.1.0 → 2.0.0 (major)
feat!: migrate to new authentication system
BREAKING CHANGE: Old tokens no longer supported
```

## Changelog Automático

### **Formato Gerado**
```markdown
# Changelog

## [1.1.0](https://github.com/your-org/your-project/compare/v1.0.1...v1.1.0) (2025-01-27)

### Features
* **user**: add profile management ([abc123](https://github.com/your-org/your-project/commit/abc123)) (@developer)

### Bug Fixes
* **api**: resolve authentication bug ([def456](https://github.com/your-org/your-project/commit/def456)) (@developer)

## [1.0.1](https://github.com/your-org/your-project/compare/v1.0.0...v1.0.1) (2025-01-26)

### Bug Fixes
* **api**: fix memory leak in user service ([ghi789](https://github.com/your-org/your-project/commit/ghi789)) (@developer)
```

## Configuração por Projeto

### **Projetos com Release**
```json
// libs/shared/ui/package.json
{
  "name": "@your-org/shared-ui",
  "version": "1.0.0",
  "publishConfig": {
    "access": "public"
  }
}
```

### **Projetos sem Release**
```json
// apps/web/package.json
{
  "name": "@your-org/web",
  "version": "0.0.0",
  "private": true
}
```

## Consequências

### Positivas
- Processo de release automatizado
- Versionamento consistente
- Changelog sempre atualizado
- Rastreabilidade completa

### Negativas
- Curva de aprendizado para Conventional Commits
- Necessidade de disciplina nas mensagens
- Configuração inicial complexa

## Ferramentas de Suporte

### **Commitizen** (Opcional)
```bash
# Instalar
pnpm add -D commitizen cz-conventional-changelog

# Configurar
echo '{"path": "cz-conventional-changelog"}' > .czrc

# Usar
git cz  # Interface interativa para commits
```

### **Husky** (Opcional)
```bash
# Instalar
pnpm add -D husky lint-staged

# Configurar
npx husky install
npx husky add .husky/commit-msg 'npx commitlint --edit $1'
```

## Exemplo de Fluxo Completo

### **1. Desenvolvimento**
```bash
# Criar feature branch
git checkout -b feature/user-profile

# Fazer mudanças
echo "// New user profile feature" >> src/user-profile.ts
git add src/user-profile.ts

# Commit com conventional format
git commit -m "feat(user): add user profile management

- Add profile creation endpoint
- Add profile update functionality
- Add profile validation"

# Push
git push origin feature/user-profile
```

### **2. Pull Request**
- Criar PR com título descritivo
- CI/CD executa validações
- Review e merge

### **3. Release Automático**
```bash
# Executado automaticamente no CI/CD
pnpm release:verify
# ✅ Format check passed
# ✅ Lint passed
# ✅ Tests passed

pnpm release:version
# ✅ Version updated: 1.0.0 → 1.1.0
# ✅ Changelog updated
# ✅ Git tag created: shared-ui@1.1.0

pnpm release:publish
# ✅ Package published to npm
# ✅ GitHub release created
```

## Referências

- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Nx Release](https://nx.dev/features/manage-releases)
- [Release Please](https://github.com/googleapis/release-please)
