#!/usr/bin/env bash
set -e

# Script para gerar certificação de segurança para componentes
# Uso: ./scripts/security/generate-security-certification.sh <component-name> <component-type> <priority>
#
# Exemplo: ./scripts/security/generate-security-certification.sh LoggerService software critical

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly WORKSPACE_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ️  $*${NC}"; }
log_success() { echo -e "${GREEN}✅ $*${NC}"; }
log_error() { echo -e "${RED}❌ $*${NC}" >&2; }
log_warning() { echo -e "${YELLOW}⚠️  $*${NC}"; }

# Validação de parâmetros
if [[ $# -ne 3 ]]; then
  log_error "Uso: $0 <component-name> <component-type> <priority>"
  log_error "Exemplo: $0 LoggerService software critical"
  log_error ""
  log_error "Tipos válidos: software, api, infrastructure, data"
  log_error "Prioridades válidas: critical, high, medium, low"
  exit 1
fi

readonly COMPONENT_NAME="$1"
readonly COMPONENT_TYPE="$2"
readonly PRIORITY="$3"

# Validação de tipos
case "${COMPONENT_TYPE}" in
  software|api|infrastructure|data)
    ;;
  *)
    log_error "Tipo inválido: ${COMPONENT_TYPE}"
    log_error "Tipos válidos: software, api, infrastructure, data"
    exit 1
    ;;
esac

# Validação de prioridades
case "${PRIORITY}" in
  critical|high|medium|low)
    ;;
  *)
    log_error "Prioridade inválida: ${PRIORITY}"
    log_error "Prioridades válidas: critical, high, medium, low"
    exit 1
    ;;
esac

# Configuração de caminhos
readonly TEMPLATE_FILE="${WORKSPACE_ROOT}/docs/templates/SECURITY_CERTIFICATION_TASK_TEMPLATE.md"
readonly OUTPUT_DIR="${WORKSPACE_ROOT}/docs/certificates"
readonly OUTPUT_FILE="${OUTPUT_DIR}/${COMPONENT_NAME}_CERTIFICATION.md"

# Validar que template existe
if [[ ! -f "${TEMPLATE_FILE}" ]]; then
  log_error "Template não encontrado: ${TEMPLATE_FILE}"
  exit 1
fi

# Criar diretório de saída se não existir
mkdir -p "${OUTPUT_DIR}"

log_info "Gerando certificação para componente: ${COMPONENT_NAME}"
log_info "Tipo: ${COMPONENT_TYPE}"
log_info "Prioridade: ${PRIORITY}"

# Gerar data atual
readonly CURRENT_DATE=$(date +"%Y-%m-%d")
readonly CERTIFICATION_ID="CERT-$(date +"%Y%m%d")-$(echo "${COMPONENT_NAME}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"

# Gerar certificação baseada no template
cat > "${OUTPUT_FILE}" << EOF
# Certificação de Segurança - ${COMPONENT_NAME}

## Informações Gerais

**ID da Certificação:** ${CERTIFICATION_ID}  
**Componente:** ${COMPONENT_NAME}  
**Tipo:** ${COMPONENT_TYPE}  
**Prioridade:** ${PRIORITY}  
**Data de Criação:** ${CURRENT_DATE}  
**Status:** 🔄 **EM DESENVOLVIMENTO**

---

## 📋 **Checklist de Segurança**

### **Autenticação e Autorização**
- [ ] Implementação de autenticação robusta
- [ ] Controle de acesso baseado em roles (RBAC)
- [ ] Validação de tokens e sessões
- [ ] Logout seguro e invalidação de sessões

### **Validação de Entrada**
- [ ] Sanitização de dados de entrada
- [ ] Validação de tipos e formatos
- [ ] Proteção contra injection attacks
- [ ] Rate limiting implementado

### **Criptografia**
- [ ] Dados sensíveis criptografados em trânsito (TLS/SSL)
- [ ] Dados sensíveis criptografados em repouso
- [ ] Uso de algoritmos criptográficos seguros
- [ ] Gerenciamento seguro de chaves

### **Logging e Monitoramento**
- [ ] Logs estruturados implementados
- [ ] Logs sem exposição de dados sensíveis
- [ ] Monitoramento de eventos de segurança
- [ ] Alertas configurados para anomalias

### **Tratamento de Erros**
- [ ] Mensagens de erro não expõem informações sensíveis
- [ ] Logs de erro estruturados
- [ ] Tratamento adequado de exceções
- [ ] Fallbacks seguros implementados

### **Dependências**
- [ ] Dependências atualizadas e sem vulnerabilidades conhecidas
- [ ] Auditoria de dependências realizada
- [ ] Dependências de desenvolvimento excluídas da produção
- [ ] Verificação de integridade de pacotes

---

## 🧪 **Testes de Segurança**

### **Testes Automatizados**
- [ ] Testes unitários de segurança implementados
- [ ] Testes de integração com foco em segurança
- [ ] Testes de penetração automatizados
- [ ] Validação de configurações de segurança

### **Testes Manuais**
- [ ] Revisão de código focada em segurança
- [ ] Testes de penetração manuais
- [ ] Validação de configurações de produção
- [ ] Testes de cenários de ataque

---

## 📊 **Métricas de Segurança**

### **Cobertura de Testes**
- **Unitários:** [ ]% (Meta: ≥80%)
- **Integração:** [ ]% (Meta: ≥70%)
- **E2E:** [ ]% (Meta: ≥60%)

### **Vulnerabilidades**
- **Críticas:** 0 (Meta: 0)
- **Altas:** 0 (Meta: 0)
- **Médias:** 0 (Meta: ≤2)
- **Baixas:** 0 (Meta: ≤5)

### **Dependências**
- **Total:** [ ] (Meta: ≤50)
- **Com vulnerabilidades:** 0 (Meta: 0)
- **Desatualizadas:** [ ] (Meta: ≤10%)

---

## 🔍 **Auditoria e Revisão**

### **Revisão Técnica**
- [ ] Revisão de código por pares
- [ ] Revisão de arquitetura de segurança
- [ ] Validação de padrões de segurança
- [ ] Aprovação de security specialist

### **Documentação**
- [ ] Documentação de segurança atualizada
- [ ] Procedimentos de resposta a incidentes
- [ ] Guias de troubleshooting
- [ ] Runbooks operacionais

---

## 📅 **Cronograma**

### **Fase 1: Implementação** (Semana 1-2)
- [ ] Implementação de controles de segurança básicos
- [ ] Configuração de autenticação e autorização
- [ ] Implementação de logging estruturado

### **Fase 2: Testes** (Semana 3)
- [ ] Execução de testes de segurança
- [ ] Correção de vulnerabilidades identificadas
- [ ] Validação de configurações

### **Fase 3: Certificação** (Semana 4)
- [ ] Auditoria final de segurança
- [ ] Aprovação de certificação
- [ ] Documentação final

---

## ✅ **Aprovação**

### **Responsáveis**
- **Desenvolvedor:** [Nome do desenvolvedor]
- **Tech Lead:** [Nome do tech lead]
- **Security Specialist:** [Nome do security specialist]

### **Assinaturas**
- [ ] Desenvolvedor: _________________ Data: _______
- [ ] Tech Lead: _________________ Data: _______
- [ ] Security Specialist: _________________ Data: _______

---

## 📝 **Notas Adicionais**

### **Observações**
- [Adicionar observações específicas do componente]

### **Próximos Passos**
- [Definir próximos passos após certificação]

### **Revisões Futuras**
- **Próxima Revisão:** [Data + 3 meses]
- **Responsável:** [Nome do responsável]

---

**Status:** 🔄 **EM DESENVOLVIMENTO**  
**Última Atualização:** ${CURRENT_DATE}  
**Próxima Revisão:** [Data + 3 meses]
EOF

log_success "Certificação gerada com sucesso: ${OUTPUT_FILE}"
log_info "Próximos passos:"
log_info "1. Revisar e personalizar o conteúdo da certificação"
log_info "2. Implementar os controles de segurança listados"
log_info "3. Executar os testes de segurança"
log_info "4. Obter aprovação dos responsáveis"
log_info "5. Atualizar o status para 'CERTIFICADO'"

log_warning "IMPORTANTE: Esta é uma certificação em desenvolvimento."
log_warning "Complete todos os itens do checklist antes de considerar o componente certificado."
