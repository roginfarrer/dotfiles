return {
  {
    'kyazdani42/nvim-web-devicons',
    lazy = true,
    opts = {
      override = {
        lir_folder_icon = {
          icon = '',
          color = '#7ebae4',
          name = 'LirFolderNode',
        },
      },
      override_by_extension = {
        org = {
          icon = '',
          name = 'Org',
          color = '#77aa99',
        },
        astro = {
          icon = '󰑣',
          name = 'Astro',
          color = '#e63bac',
        },
      },
    },
  },
}
