# ADR-001: Uso de package.json em Projetos Go para Controle de Versão

## Status
**Aceito** - 2025-01-27

## Contexto

O workspace Nx contém projetos em múltiplas linguagens:
- **Node.js/TypeScript**: `@lideranca-sites/bff-nestjs`, `@lideranca-sites/utils-nestjs`
- **Go**: `service-go`, `utils-go`

O comando `nx release` funciona nativamente apenas com projetos que possuem arquivo `package.json`, resultando em:
- ✅ Projetos Node.js: versionados e tagueados automaticamente
- ❌ Projetos Go: ignorados pelo processo de release

## Decisão

**Adicionar arquivos `package.json` minimalistas aos projetos Go exclusivamente para controle de versão.**

### Estrutura Implementada

**`apps/service-go/package.json`**:
```json
{
  "name": "lideranca-sites/service-go",
  "version": "0.1.0",
  "private": true,
  "description": "Go service application"
}
```

**`libs/utils-go/package.json`**:
```json
{
  "name": "lideranca-sites/utils-go",
  "version": "0.0.1",
  "private": true,
  "description": "Go utility library"
}
```

### Configuração Atualizada

**`nx.json`** - Configuração híbrida para projetos Node.js e Go:
```json
"release": {
  "projects": [
    "lideranca-sites/*",      // Projetos Go (sem @)
    "@lideranca-sites/*",     // Projetos Node.js (com @)
    "!@lideranca-sites/source"
  ]
}
```

## Consequências

### Positivas
- ✅ Integração nativa com `nx release`
- ✅ Consistência no processo de versionamento entre todos os projetos
- ✅ Suporte a changelogs automáticos via conventional commits
- ✅ Tagueamento Git automático com padrão unificado `{projectName}@v{version}`
- ✅ Baixo custo de manutenção (arquivos estáticos)
- ✅ Não interfere no build ou runtime dos projetos Go
- ✅ **Campo `"private": true` evita publish acidental no NPM registry**
- ✅ **Nomenclatura sem `@` mantém compatibilidade com convenções Go**

### Negativas
- ❌ Introduz arquivo não-nativo ao ecossistema Go
- ❌ Requer manutenção adicional de metadados de versão
- ❌ **Nomenclatura híbrida** (`@` para Node.js, sem `@` para Go) pode confundir

## Alternativas Consideradas

### Opção 2: Scripts Customizados
- **Rejeitada**: Fragmentaria o processo de release e duplicaria lógica de versionamento

### Opção 3: Aguardar Suporte Nativo
- **Rejeitada**: Sem timeline definido, não resolve problema imediato

## Descobertas e Ajustes Críticos

### Problema 1: Nomenclatura com `@`
**Descoberta**: O símbolo `@` em nomes de módulos Go causa problemas:
- ❌ Incompatibilidade com `go mod` e proxy Go
- ❌ Problemas com ferramentas Go (IDEs, linters)
- ❌ Viola convenções do Google Go Style Guide

**Solução**: Usar nomenclatura sem `@` para projetos Go:
- ✅ `lideranca-sites/service-go` (sem `@`)
- ✅ `@lideranca-sites/bff-nestjs` (com `@` para Node.js)

### Problema 2: Publish Acidental no NPM
**Descoberta**: `nx release` tentará publicar todos os projetos com `package.json` no NPM registry.

**Solução**: Campo `"private": true` em todos os projetos Go:
```json
{
  "name": "lideranca-sites/service-go",
  "private": true,  // ← Evita publish no NPM
  "version": "0.1.0"
}
```

### Problema 3: Configuração Híbrida
**Descoberta**: Necessário configurar padrões diferentes para Node.js e Go.

**Solução**: Configuração híbrida no `nx.json`:
```json
"projects": [
  "lideranca-sites/*",      // Projetos Go (sem @)
  "@lideranca-sites/*",     // Projetos Node.js (com @)
  "!@lideranca-sites/source"
]
```

## Implementação

1. ✅ Criados arquivos `package.json` nos projetos Go
2. ✅ **Corrigida nomenclatura** (removido `@` dos projetos Go)
3. ✅ **Adicionado `"private": true`** para evitar publish acidental
4. ✅ Atualizada configuração `release.projects` no `nx.json`
5. 🔄 Validação com `nx release --dry-run` (pendente)
6. 🔄 Execução de `nx release --first-release` (pendente)

## Monitoramento

- **Métricas**: Verificar criação de tags Git para todos os 4 projetos
- **Validação**: Confirmar que projetos Go não são publicados no NPM
- **Revisão**: Avaliar impacto após 3 meses de uso
- **Critério de Sucesso**: 
  - ✅ Todos os projetos (Node.js + Go) versionados consistentemente
  - ✅ Projetos Go não tentam publish no NPM registry
  - ✅ Nomenclatura compatível com ferramentas Go

---

**Decisão tomada por**: Mateus Macedo Dos Anjos  
**Data**: 2025-01-27  
**Atualização**: 2025-01-27 (descobertas sobre compatibilidade Go)  
**Revisão**: 2025-04-27
