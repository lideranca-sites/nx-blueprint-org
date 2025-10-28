# ADRs - Architecture Decision Records

Este diretório contém os Architecture Decision Records (ADRs) do workspace, documentando decisões arquiteturais importantes e suas justificativas.

## 📋 **ADRs Ativos**

| ADR | Título | Status | Data | Descrição |
|-----|--------|--------|------|-----------|
| [ADR-001](ADR-001-nx-monorepo-tool.md) | Adoção do Nx como Ferramenta de Monorepo | ✅ Aceito | 2025-01-27 | Decisão de usar Nx para gerenciamento do monorepo |
| [ADR-002](ADR-002-clean-architecture.md) | Implementação de Clean Architecture | ✅ Aceito | 2025-01-27 | Padrão arquitetural baseado em Clean Architecture |
| [ADR-003](ADR-003-tag-system.md) | Sistema de Tags Multidimensionais | ✅ Aceito | 2025-01-27 | Sistema de controle de dependências via tags |
| [ADR-004](ADR-004-security-certification.md) | Sistema de Certificação de Segurança | ✅ Aceito | 2025-01-27 | Processo estruturado de certificação de segurança |
| [ADR-005](ADR-005-testing-strategy.md) | Estratégia de Testes e Qualidade | ✅ Aceito | 2025-01-27 | Estratégia abrangente de testes e qualidade |
| [ADR-006](ADR-006-release-strategy.md) | Configuração de Release e Versionamento | ✅ Aceito | 2025-01-27 | Processo automatizado de release e versionamento |

## 🎯 **Status dos ADRs**

- **✅ Aceito**: Decisão implementada e ativa
- **🔄 Em Revisão**: Decisão sendo avaliada
- **❌ Rejeitado**: Decisão não implementada
- **📝 Proposto**: Decisão em discussão

## 📚 **Categorias**

### **Arquitetura e Organização**
- [ADR-001](ADR-001-nx-monorepo-tool.md): Ferramenta de monorepo
- [ADR-002](ADR-002-clean-architecture.md): Padrão arquitetural
- [ADR-003](ADR-003-tag-system.md): Sistema de organização

### **Qualidade e Segurança**
- [ADR-004](ADR-004-security-certification.md): Certificação de segurança
- [ADR-005](ADR-005-testing-strategy.md): Estratégia de testes

### **Processo e Automação**
- [ADR-006](ADR-006-release-strategy.md): Release e versionamento

## 🔄 **Processo de ADRs**

### **Criando um Novo ADR**

1. **Identificar Necessidade**
   - Decisão arquitetural importante
   - Mudança de padrão ou processo
   - Resolução de problema técnico

2. **Criar Documento**
   ```bash
   # Copiar template
   cp docs/templates/ADR_TEMPLATE.md docs/adrs/ADR-XXX-titulo.md
   
   # Editar com informações específicas
   ```

3. **Estrutura Padrão**
   ```markdown
   # ADR-XXX: Título da Decisão
   
   ## Status
   🔄 **EM REVISÃO** - YYYY-MM-DD
   
   ## Contexto
   [Situação que levou à decisão]
   
   ## Decisão
   [Decisão tomada]
   
   ## Consequências
   [Impactos positivos e negativos]
   
   ## Implementação
   [Como implementar]
   ```

4. **Revisão e Aprovação**
   - Discussão com equipe técnica
   - Review de arquitetos
   - Aprovação final

5. **Implementação**
   - Atualizar status para "Aceito"
   - Implementar mudanças
   - Documentar progresso

### **Template de ADR**

```markdown
# ADR-XXX: [Título da Decisão]

## Status
🔄 **EM REVISÃO** - YYYY-MM-DD

## Contexto

[Descrever a situação que levou à necessidade desta decisão]

### Problemas Identificados
- [Lista de problemas específicos]

### Opções Consideradas
1. **Opção A**: [Descrição]
   - ✅ [Vantagens]
   - ❌ [Desvantagens]

2. **Opção B**: [Descrição]
   - ✅ [Vantagens]
   - ❌ [Desvantagens]

## Decisão

Escolhemos **[Opção Escolhida]** porque:

1. [Justificativa principal]
2. [Justificativa secundária]
3. [Justificativa adicional]

### Critérios de Decisão
- [Critério 1]
- [Critério 2]
- [Critério 3]

## Implementação

### Configuração
```json
// Exemplo de configuração
{
  "key": "value"
}
```

### Processo
1. [Passo 1]
2. [Passo 2]
3. [Passo 3]

## Consequências

### Positivas
- [Consequência positiva 1]
- [Consequência positiva 2]

### Negativas
- [Consequência negativa 1]
- [Consequência negativa 2]

### Riscos
- [Risco identificado]
- [Mitigação do risco]

## Referências

- [Link para documentação relevante]
- [Link para ferramentas utilizadas]
- [Link para padrões seguidos]
```

## 📊 **Métricas dos ADRs**

### **Distribuição por Status**
- **Aceitos**: 6 (100%)
- **Em Revisão**: 0 (0%)
- **Rejeitados**: 0 (0%)

### **Distribuição por Categoria**
- **Arquitetura**: 3 ADRs
- **Qualidade**: 2 ADRs
- **Processo**: 1 ADR

### **Última Atualização**
- **Data**: 2025-01-27
- **Responsável**: Tech Lead
- **Próxima Revisão**: 2025-04-27 (trimestral)

## 🔍 **Como Usar os ADRs**

### **Para Desenvolvedores**
- Consulte ADRs antes de implementar mudanças arquiteturais
- Siga os padrões estabelecidos nos ADRs aceitos
- Proponha novos ADRs para mudanças significativas

### **Para Arquitetos**
- Revise ADRs periodicamente
- Atualize ADRs quando necessário
- Documente mudanças de contexto

### **Para Product Owners**
- Entenda as decisões técnicas através dos ADRs
- Considere impactos de mudanças de requisitos
- Participe de discussões sobre ADRs críticos

## 📞 **Contato**

Para dúvidas sobre ADRs ou propostas de novos ADRs:
- **Tech Lead**: [tech-lead@company.com]
- **Arquitetos**: [architects@company.com]
- **Slack**: [#architecture-decisions]

---

**Última atualização**: 2025-01-27  
**Próxima revisão**: 2025-04-27
