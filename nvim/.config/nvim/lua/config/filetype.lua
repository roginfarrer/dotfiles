vim.filetype.add {
  pattern = {
    ['.*/create%-wayfair%-app/.*%.kit'] = 'javascript',
    ['.*/create%-wayfair%-lib/.*%.kit'] = 'javascript',
  },
  filename = {
    ['Brewfile'] = 'bash',
  },
  extension = {
    mdx = 'mdx',
  },
}
