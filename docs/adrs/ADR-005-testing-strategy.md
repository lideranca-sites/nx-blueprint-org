# ADR-005: Estratégia de Testes e Qualidade

## Status
✅ **ACEITO** - 2025-01-27

## Contexto

Precisamos definir uma estratégia abrangente para:
- Garantir qualidade do código
- Detectar problemas precocemente
- Manter confiança nas mudanças
- Facilitar refatorações

### Problemas Identificados
- Falta de estratégia clara de testes
- Cobertura inconsistente entre projetos
- Tarefas flaky não detectadas
- Dificuldade para medir qualidade

## Decisão

Implementamos uma **Estratégia de Testes em Camadas** com foco em qualidade e confiabilidade.

### Estratégia Adotada

1. **Pirâmide de Testes**
   - **Unitários**: Base sólida, alta cobertura
   - **Integração**: Fluxos entre componentes
   - **E2E**: Cenários críticos do usuário

2. **Qualidade por Design**
   - Thresholds mínimos de cobertura
   - Detecção automática de tarefas flaky
   - Validação contínua de qualidade

3. **Automação Completa**
   - Execução em CI/CD
   - Relatórios automatizados
   - Alertas para degradação

## Implementação

### Configuração de Thresholds

```typescript
// jest.config.ts
export default {
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 70,
      lines: 70,
      statements: 70
    }
  },
  collectCoverageFrom: [
    'src/**/*.{ts,tsx,js,jsx}',
    '!src/**/*.d.ts',
    '!src/**/*.stories.{ts,tsx,js,jsx}',
    '!src/**/*.test.{ts,tsx,js,jsx}',
    '!src/**/*.spec.{ts,tsx,js,jsx}'
  ]
};
```

### Scripts de Qualidade

```bash
# Detectar tarefas flaky
nx report

# Definir estratégia de cobertura
nx test --coverage --coverageReporters=text,lcov,html

# Validar integridade do cache
nx reset
```

### Configuração por Tipo de Projeto

#### **Bibliotecas de Domínio**
- **Cobertura**: 90%+ (unitários)
- **Foco**: Lógica de negócio pura
- **Estratégia**: Testes unitários extensivos

#### **Aplicações**
- **Cobertura**: 70%+ (unitários + integração)
- **Foco**: Fluxos principais + casos edge
- **Estratégia**: Balanced

#### **APIs**
- **Cobertura**: 80%+ (unitários + integração)
- **Foco**: Endpoints + validações
- **Estratégia**: Comprehensive

## Estratégias por Contexto

### **Minimal** (Projetos Experimentais)
```bash
nx test --coverage --coverageReporters=text,lcov,html
```
- **Unitários**: 50%
- **Integração**: 30%
- **E2E**: 20%
- **Tempo**: 1-2 semanas

### **Balanced** (Projetos Padrão)
```bash
nx test --coverage --coverageReporters=text,lcov,html
```
- **Unitários**: 70%
- **Integração**: 50%
- **E2E**: 40%
- **Tempo**: 2-4 semanas

### **Comprehensive** (Projetos Críticos)
```bash
nx test --coverage --coverageReporters=text,lcov,html
```
- **Unitários**: 85%
- **Integração**: 70%
- **E2E**: 60%
- **Tempo**: 4-8 semanas

### **Exhaustive** (Projetos de Missão Crítica)
```bash
nx test --coverage --coverageReporters=text,lcov,html
```
- **Unitários**: 95%
- **Integração**: 85%
- **E2E**: 80%
- **Tempo**: 8+ semanas

## Detecção de Tarefas Flaky

### **Processo Automatizado**
```bash
# Executar detecção
nx report
  --threshold=10 \
  --runs=5 \
  --output=flaky-report.json

# Gerar métricas
nx report
  --input=flaky-report.json \
  --output=metrics.html
```

### **Critérios de Flaky**
- **Threshold**: 10% de falhas (configurável)
- **Execuções**: Mínimo 3 runs
- **Critério**: Falhas entre 1% e 90%

### **Ações Corretivas**
1. **Identificação**: Scripts automatizados
2. **Análise**: Revisão de logs e código
3. **Correção**: Implementação de fixes
4. **Validação**: Re-teste até estabilização

## Integração com CI/CD

### **Pipeline de Qualidade**
```yaml
# .github/workflows/quality.yml
name: Quality Assurance

on: [push, pull_request]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'
      
      - run: pnpm install
      
      # Testes com cobertura
      - run: nx run-many -t test --coverage
      
      # Detecção de flaky tasks
      - run: nx report --threshold=10
      
      # Upload de cobertura
      - uses: codecov/codecov-action@v3
        with:
          file: ./coverage/lcov.info
```

### **Gates de Qualidade**
- **Cobertura mínima**: 70%
- **Zero tarefas flaky críticas**
- **Todos os testes passando**
- **Lint sem erros**

## Ferramentas e Métricas

### **Dashboard de Qualidade**
- Cobertura por projeto
- Tendência de qualidade
- Alertas de degradação
- Métricas de flaky tasks

### **Relatórios Automatizados**
```bash
# Relatório completo de qualidade
nx report
  --coverage \
  --flaky \
  --performance \
  --output=quality-dashboard.html
```

## Consequências

### Positivas
- Maior confiança nas mudanças
- Detecção precoce de problemas
- Facilita refatorações
- Melhora qualidade geral

### Negativas
- Overhead inicial de implementação
- Necessidade de manutenção contínua
- Possível lentidão em CI/CD

## Exemplo de Implementação

### **Projeto com Estratégia Balanced**
```typescript
// src/services/user.service.ts
export class UserService {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly emailService: EmailService
  ) {}

  async createUser(dto: CreateUserDto): Promise<User> {
    // Validação de entrada
    if (!dto.email || !dto.name) {
      throw new ValidationError('Email and name are required');
    }

    // Verificar se usuário já existe
    const existingUser = await this.userRepository.findByEmail(dto.email);
    if (existingUser) {
      throw new ConflictError('User already exists');
    }

    // Criar usuário
    const user = new User(dto.id, dto.email, dto.name);
    await this.userRepository.save(user);

    // Enviar email de boas-vindas
    await this.emailService.sendWelcomeEmail(user.email);

    return user;
  }
}
```

### **Testes Unitários**
```typescript
// src/services/user.service.spec.ts
describe('UserService', () => {
  let service: UserService;
  let userRepository: jest.Mocked<UserRepository>;
  let emailService: jest.Mocked<EmailService>;

  beforeEach(() => {
    userRepository = createMockRepository();
    emailService = createMockEmailService();
    service = new UserService(userRepository, emailService);
  });

  describe('createUser', () => {
    it('should create user successfully', async () => {
      // Arrange
      const dto = { id: '1', email: 'test@example.com', name: 'Test User' };
      userRepository.findByEmail.mockResolvedValue(null);
      userRepository.save.mockResolvedValue(undefined);
      emailService.sendWelcomeEmail.mockResolvedValue(undefined);

      // Act
      const result = await service.createUser(dto);

      // Assert
      expect(result).toEqual(new User('1', 'test@example.com', 'Test User'));
      expect(userRepository.save).toHaveBeenCalledWith(expect.any(User));
      expect(emailService.sendWelcomeEmail).toHaveBeenCalledWith('test@example.com');
    });

    it('should throw ValidationError when email is missing', async () => {
      // Arrange
      const dto = { id: '1', email: '', name: 'Test User' };

      // Act & Assert
      await expect(service.createUser(dto)).rejects.toThrow(ValidationError);
    });

    it('should throw ConflictError when user already exists', async () => {
      // Arrange
      const dto = { id: '1', email: 'test@example.com', name: 'Test User' };
      const existingUser = new User('2', 'test@example.com', 'Existing User');
      userRepository.findByEmail.mockResolvedValue(existingUser);

      // Act & Assert
      await expect(service.createUser(dto)).rejects.toThrow(ConflictError);
    });
  });
});
```

## Referências

- [Testing Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)
- [Jest Documentation](https://jestjs.io/docs/getting-started)
- [Nx Testing](https://nx.dev/concepts/testing)
- [Flaky Tests Best Practices](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepscontinue-on-error)
