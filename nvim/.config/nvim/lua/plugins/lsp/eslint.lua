return {
  filetypes = {
    'html.mustache',
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
    'svelte',
    'astro',
    'mustache',
    'html',
  },
  settings = {
    workingDirectories = { mode = 'auto' },
    rulesCustomizations = {
      { rule = 'prettier/prettier', severity = 'off' },
    },
  },
}
