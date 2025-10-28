# Scripts Go (Uso Futuro)

Scripts preparados para quando projetos Go forem adicionados ao workspace.

## Scripts Disponíveis

- `fix-go-cache.sh` - Correção de cache Go no CI/CD
- `sync-go-versions.sh` - Sincronização de versões entre libs e apps Go

## Pré-requisitos

Workspace deve conter projetos Go em apps/ ou libs/ e go.work configurado.

## Configuração go.work

Atualizar go.work com projetos específicos:
```go
go 1.23

use (
    ./apps/seu-app-go
    ./libs/sua-lib-go
)
```

## Quando Usar

Execute após adicionar projetos Go ao workspace ou ao enfrentar problemas de cache Go no CI/CD.

## Uso dos Scripts

### fix-go-cache.sh
```bash
# Executar correção de cache Go
./scripts/go/fix-go-cache.sh
```

### sync-go-versions.sh
```bash
# Sincronizar versões Go
./scripts/go/sync-go-versions.sh
```

## Notas Importantes

- Estes scripts são específicos para projetos Go e não têm equivalente nativo no Nx
- Execute apenas quando houver projetos Go no workspace
- Configure corretamente o go.work antes de usar os scripts
