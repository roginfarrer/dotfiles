return {
  settings = {
    intelephense = {
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
