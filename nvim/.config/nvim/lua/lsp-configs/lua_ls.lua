return {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      codeLens = { enable = true },
      telemetry = { enable = false },
      hint = { enable = true },
      -- Prefer stylua
      format = {
        enable = false,
      },
    },
  },
}
