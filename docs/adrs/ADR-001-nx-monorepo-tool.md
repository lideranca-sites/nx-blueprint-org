# ADR-001: Adoção do Nx como Ferramenta de Monorepo

## Status
✅ **ACEITO** - 2025-01-27

## Contexto

Precisamos escolher uma ferramenta para gerenciar nosso monorepo que suporte:
- Múltiplas linguagens (TypeScript, Go)
- Build incremental e cache inteligente
- Controle de dependências entre projetos
- Integração com ferramentas de qualidade
- Escalabilidade para equipes grandes

### Opções Consideradas

1. **Lerna + Yarn Workspaces**
   - ✅ Suporte a múltiplas linguagens
   - ❌ Cache limitado
   - ❌ Build incremental básico
   - ❌ Controle de dependências limitado

2. **Rush**
   - ✅ Excelente para grandes monorepos
   - ✅ Controle rigoroso de dependências
   - ❌ Complexidade de configuração
   - ❌ Curva de aprendizado íngreme

3. **Nx**
   - ✅ Cache distribuído avançado
   - ✅ Build incremental otimizado
   - ✅ Controle de dependências robusto
   - ✅ Ecossistema maduro
   - ✅ Suporte nativo a TypeScript e Go

## Decisão

Escolhemos **Nx** como ferramenta principal do monorepo.

### Justificativas

1. **Performance**: Cache distribuído e build incremental superior
2. **Developer Experience**: Ferramentas integradas (graph, affected, etc.)
3. **Escalabilidade**: Suporta desde pequenos até grandes monorepos
4. **Ecossistema**: Plugins maduros para TypeScript, Go, NestJS
5. **Comunidade**: Ativa e bem documentada

## Consequências

### Positivas
- Build times significativamente reduzidos
- Melhor controle de dependências
- Ferramentas integradas de desenvolvimento
- Suporte robusto a múltiplas linguagens

### Negativas
- Curva de aprendizado inicial
- Dependência de uma ferramenta específica
- Configuração inicial mais complexa

## Implementação

### Configuração Base
- Nx 20.8.2 com pnpm como package manager
- Configuração de cache distribuído
- Plugins para TypeScript, Go e NestJS

### Padrões Estabelecidos
- Uso de tags para controle de dependências
- Configuração de targets padronizados
- Integração com ferramentas de qualidade

## Referências

- [Nx Documentation](https://nx.dev)
- [Nx vs Lerna Comparison](https://nx.dev/more-concepts/why-nx)
- [Nx Performance](https://nx.dev/concepts/computation-caching)
