return {
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
    'svelte',
    'astro',
    'html',
  },
  settings = {
    workingDirectories = { mode = 'auto' },
    rulesCustomizations = {
      { rule = 'prettier/prettier', severity = 'off' },
    },
  },
}
