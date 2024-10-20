return {
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
    },
    typescript = {
      suggest = {
        completeFunctionCalls = true,
      },
      tsserver = {
        maxTsServerMemory = 8192,
      },
    },
  },
}
