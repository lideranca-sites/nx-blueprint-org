# ADR-002: Implementação de Clean Architecture

## Status
✅ **ACEITO** - 2025-01-27

## Contexto

Precisamos definir uma arquitetura que promova:
- Separação clara de responsabilidades
- Testabilidade
- Manutenibilidade
- Independência de frameworks
- Flexibilidade para mudanças

### Problemas Identificados
- Código acoplado dificulta manutenção
- Testes complexos devido a dependências
- Dificuldade para trocar tecnologias
- Falta de clareza sobre responsabilidades

## Decisão

Implementamos **Clean Architecture** como padrão arquitetural principal.

### Princípios Adotados

1. **Separação em Camadas**
   - **Domain**: Regras de negócio puras
   - **Application**: Casos de uso e orquestração
   - **Infrastructure**: Implementações técnicas
   - **Presentation**: Interfaces de usuário

2. **Dependency Inversion**
   - Dependências apontam para dentro
   - Abstrações no centro, implementações na borda
   - Injeção de dependências

3. **Independência de Frameworks**
   - Domain não depende de frameworks externos
   - Facilita migração e testes

## Implementação

### Estrutura de Diretórios
```
libs/
├── domain/                 # Regras de negócio
│   ├── entities/          # Entidades de domínio
│   ├── value-objects/     # Objetos de valor
│   ├── repositories/      # Interfaces de repositório
│   └── services/          # Serviços de domínio
├── application/            # Casos de uso
│   ├── use-cases/         # Implementação de casos de uso
│   ├── dto/               # Data Transfer Objects
│   └── interfaces/        # Interfaces de aplicação
├── infrastructure/        # Implementações técnicas
│   ├── database/          # Implementações de banco
│   ├── external/          # Integrações externas
│   └── config/            # Configurações
└── presentation/          # Interfaces
    ├── controllers/       # Controllers REST
    ├── resolvers/         # GraphQL resolvers
    └── dto/               # DTOs de apresentação
```

### Tags para Controle de Dependências
```json
{
  "tags": ["layer:domain", "visibility:public"]
}
```

### Regras de Dependência
- `layer:domain` → Nenhuma dependência externa
- `layer:application` → Pode depender de `layer:domain`
- `layer:infrastructure` → Pode depender de `layer:application` e `layer:domain`
- `layer:presentation` → Pode depender de todas as camadas

## Consequências

### Positivas
- Código mais testável e manutenível
- Separação clara de responsabilidades
- Facilita mudanças tecnológicas
- Melhor organização do código

### Negativas
- Maior complexidade inicial
- Mais arquivos e estrutura
- Curva de aprendizado para novos desenvolvedores

## Exemplo de Implementação

### Domain Entity
```typescript
// libs/domain/entities/user.entity.ts
export class User {
  constructor(
    public readonly id: string,
    public readonly email: string,
    public readonly name: string
  ) {}
  
  public isValidEmail(): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(this.email);
  }
}
```

### Application Use Case
```typescript
// libs/application/use-cases/create-user.use-case.ts
export class CreateUserUseCase {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly emailService: EmailService
  ) {}
  
  async execute(dto: CreateUserDto): Promise<User> {
    const user = new User(dto.id, dto.email, dto.name);
    
    if (!user.isValidEmail()) {
      throw new InvalidEmailError();
    }
    
    await this.userRepository.save(user);
    await this.emailService.sendWelcomeEmail(user.email);
    
    return user;
  }
}
```

## Referências

- [Clean Architecture - Robert Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Clean Architecture in TypeScript](https://github.com/remorses/clean-architecture-typescript)
- [Nx Architecture Best Practices](https://nx.dev/concepts/more-concepts/encapsulation)
