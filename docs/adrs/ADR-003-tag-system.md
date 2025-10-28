# ADR-003: Sistema de Tags Multidimensionais

## Status
✅ **ACEITO** - 2025-01-27

## Contexto

Precisamos de um sistema para:
- Controlar dependências entre projetos
- Organizar projetos por diferentes dimensões
- Aplicar regras arquiteturais automaticamente
- Facilitar navegação e compreensão do workspace

### Problemas sem Sistema de Tags
- Dependências circulares não detectadas
- Violação de princípios arquiteturais
- Dificuldade para entender relacionamentos
- Falta de organização clara

## Decisão

Implementamos um **Sistema de Tags Multidimensionais** usando as capacidades nativas do Nx.

### Dimensões Definidas

1. **`type`**: Categoria principal do projeto
   - `app`: Aplicação executável
   - `lib`: Biblioteca/componente reutilizável

2. **`scope`**: Contexto de negócio
   - `internal`: Funcionalidades internas
   - `notifier`: Sistema de notificações
   - `shared`: Compartilhado entre contextos

3. **`runtime`**: Ambiente de execução
   - `node`: Node.js/TypeScript
   - `go`: Go
   - `universal`: Múltiplos ambientes

4. **`layer`**: Camada arquitetural (Clean Architecture)
   - `domain`: Regras de negócio
   - `application`: Casos de uso
   - `infrastructure`: Implementações técnicas
   - `presentation`: Interfaces

5. **`visibility`**: Controle de acesso
   - `public`: Pode ser usado por qualquer projeto
   - `private`: Apenas dentro do mesmo scope
   - `internal`: Apenas dentro do mesmo layer

6. **`platform`**: Tecnologia específica
   - `nest`: NestJS
   - `express`: Express.js
   - `react`: React
   - `vue`: Vue.js

## Implementação

### Configuração de Boundaries

```json
// nx.json
{
  "plugins": [
    {
      "plugin": "@nx/eslint/plugin",
      "options": {
        "targetName": "lint"
      }
    }
  ],
  "namedInputs": {
    "sharedGlobals": [
      "{workspaceRoot}/.eslintrc.json",
      "{workspaceRoot}/.eslintignore"
    ]
  }
}
```

### Regras de Dependência

```typescript
// eslint.config.mjs
module.exports = [
  {
    files: ['**/*.ts', '**/*.tsx'],
    rules: {
      '@nx/enforce-module-boundaries': [
        'error',
        {
          allow: [],
          depConstraints: [
            {
              sourceTag: 'layer:presentation',
              onlyDependOnLibsWithTags: ['layer:application', 'layer:domain', 'layer:infrastructure']
            },
            {
              sourceTag: 'layer:application',
              onlyDependOnLibsWithTags: ['layer:domain']
            },
            {
              sourceTag: 'layer:infrastructure',
              onlyDependOnLibsWithTags: ['layer:application', 'layer:domain']
            },
            {
              sourceTag: 'layer:domain',
              onlyDependOnLibsWithTags: []
            },
            {
              sourceTag: 'runtime:node',
              onlyDependOnLibsWithTags: ['runtime:node', 'runtime:universal']
            },
            {
              sourceTag: 'runtime:go',
              onlyDependOnLibsWithTags: ['runtime:go', 'runtime:universal']
            }
          ]
        }
      ]
    }
  }
];
```

### Exemplo de Projeto

```json
// libs/domain/user/project.json
{
  "name": "domain-user",
  "tags": [
    "type:lib",
    "scope:internal",
    "runtime:universal",
    "layer:domain",
    "visibility:public"
  ]
}
```

## Consequências

### Positivas
- Controle automático de dependências
- Organização clara do workspace
- Prevenção de violações arquiteturais
- Facilita onboarding de novos desenvolvedores

### Negativas
- Curva de aprendizado inicial
- Configuração mais complexa
- Necessidade de disciplina na aplicação das tags

## Ferramentas de Validação

### Comando de Verificação
```bash
# Verificar boundaries
nx run-many -t check-boundaries

# Verificar dependências
nx graph --file=dependencies.json
```

### Scripts Utilitários
```bash
# Validar conformidade de tags
nx show projects --json | jq '.[] | select(.tags) | {name: .name, tags: .tags}'

# Gerar relatório de dependências
nx graph --file=dependencies.json
```

## Exemplos de Uso

### Criando um Novo Projeto
```bash
# Biblioteca de domínio
nx generate @nx/js:library domain-user \
  --directory=libs/domain/user \
  --tags=type:lib,scope:internal,runtime:universal,layer:domain,visibility:public

# Aplicação NestJS
nx generate @nx/nest:application api \
  --directory=apps/api \
  --tags=type:app,scope:internal,runtime:node,layer:presentation,platform:nest
```

### Validação Automática
O sistema automaticamente:
- Impede dependências circulares
- Valida hierarquia de camadas
- Controla acesso por visibilidade
- Isola runtimes diferentes

## Referências

- [Nx Module Boundaries](https://nx.dev/concepts/more-concepts/encapsulation)
- [Nx Tags](https://nx.dev/concepts/tags)
- [Clean Architecture Boundaries](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
