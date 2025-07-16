return {
  settings = {
    intelephense = {
      runtime = '~/.local/share/fnm/node-versions/v23.11.0/installation/bin/node',
      maxMemory = 8192,
      format = { enable = true },
      files = {
        exclude = {
          '**/.git/**',
          '**/.svn/**',
          '**/.hg/**',
          '**/CVS/**',
          '**/.DS_Store/**',
          '**/node_modules/**',
          '**/bower_components/**',
          '**/htdocs_customshops/**',
          '**/htdocs_gearman/**',
          '**/htdocs/assets/dist/**',
          '**/tmp/**',
          '**vendor/*/{!(phpunit)/**}',
          'translations/**',
          '**/.phan/**',
          '**/cron.d/**',
          '**/generated/**',
          '**/Generated/**',
          '**/modules/css/**',
          '**/__modules__*__src__/**',
          'vendor/etsy/module-*/**',
        },
      },
    },
  },
}
