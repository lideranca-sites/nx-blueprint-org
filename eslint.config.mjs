import nx from '@nx/eslint-plugin';

export default [
  ...nx.configs['flat/base'],
  ...nx.configs['flat/typescript'],
  {
    ignores: [
      '**/dist',
      '**/node_modules',
      '**/coverage',
      '**/*.spec.ts',
      '**/*.test.ts',
      '**/*.e2e-spec.ts'
    ],
  },
  {
    files: ['**/*.ts', '**/*.tsx', '**/*.js', '**/*.jsx'],
    rules: {
      // Manter apenas a regra de boundaries do Nx
      '@nx/enforce-module-boundaries': [
        'error',
        {
          enforceBuildableLibDependency: true,
          allow: [String.raw`^.*/eslint(\.base)?\.config\.[cm]?js$`],
          depConstraints: [
            // Regras de Layer (Arquitetura Limpa)
            {
              sourceTag: 'layer:presentation',
              onlyDependOnLibsWithTags: ['layer:application', 'layer:domain', 'type:lib']
            },
            {
              sourceTag: 'layer:application',
              onlyDependOnLibsWithTags: ['layer:domain', 'layer:infrastructure', 'type:lib']
            },
            {
              sourceTag: 'layer:domain',
              onlyDependOnLibsWithTags: ['type:lib']
            },
            {
              sourceTag: 'layer:infrastructure',
              onlyDependOnLibsWithTags: ['layer:domain', 'type:lib']
            },
            
            // Regras de Runtime
            {
              sourceTag: 'runtime:node',
              onlyDependOnLibsWithTags: ['runtime:node', 'runtime:universal']
            },
            {
              sourceTag: 'runtime:go',
              onlyDependOnLibsWithTags: ['runtime:go', 'runtime:universal']
            },
            {
              sourceTag: 'runtime:browser',
              onlyDependOnLibsWithTags: ['runtime:browser', 'runtime:node', 'runtime:universal']
            },
            
            // Regras de Visibility
            {
              sourceTag: 'visibility:private',
              onlyDependOnLibsWithTags: ['visibility:public', 'visibility:private', 'visibility:internal']
            },
            {
              sourceTag: 'visibility:internal',
              onlyDependOnLibsWithTags: ['visibility:public', 'visibility:internal']
            },
            {
              sourceTag: 'visibility:public',
              onlyDependOnLibsWithTags: ['visibility:public']
            },
            
            // Regras de Type (mantidas para compatibilidade)
            {
              sourceTag: 'type:app',
              onlyDependOnLibsWithTags: ['type:lib', 'scope:internal']
            },
            {
              sourceTag: 'type:lib',
              onlyDependOnLibsWithTags: ['type:lib', 'scope:internal']
            },
            {
              sourceTag: 'scope:internal',
              onlyDependOnLibsWithTags: ['scope:internal']
            },
            {
              sourceTag: 'platform:express',
              onlyDependOnLibsWithTags: ['type:lib', 'scope:internal', 'scope:notifier']
            },
            
            // Regras específicas para projetos Go
            {
              sourceTag: 'runtime:go',
              onlyDependOnLibsWithTags: ['runtime:go', 'runtime:universal']
            }
          ],
        },
      ],
      // Desabilitar regras que serão cobertas pelo Biome
      '@typescript-eslint/no-unused-vars': 'off',
      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-unused-imports': 'off',
      '@typescript-eslint/no-unsafe-function-type': 'off',
      '@typescript-eslint/no-inferrable-types': 'off',
      '@typescript-eslint/no-empty-function': 'off',
      '@typescript-eslint/no-empty-object-type': 'off',
      '@typescript-eslint/no-empty-interface': 'off',
      '@typescript-eslint/no-non-null-assertion': 'off',
      'no-unused-vars': 'off',
      'no-console': 'off',
      'prefer-const': 'off',
      'no-var': 'off',
    },
  },
];
