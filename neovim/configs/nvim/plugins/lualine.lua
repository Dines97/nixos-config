require('lualine').setup({
  options = {
    -- One line accross all screen
    globalstatus = true,
    theme = 'onedark',
    section_separators = '',
    component_separators = ''
  },
  sections = {
    lualine_x = { 'encoding', { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' } }, 'filetype' }
  }
})
