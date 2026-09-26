-- Palettes for the summer-night colorscheme. Every highlight group is built from these
-- role names, so a new variant only needs a new table here.
--
--   bg_dim  sidebars / statusline      bg0  editor background
--   bg1     raised surfaces (code, menus)  bg2  cursorline / selection   bg3 borders
--   text    body text      fg  identifiers / punctuation   fg_bright  emphasis
--   comment, muted (structure that should recede)
local M = {}

-- Summer Night as it was in the old palette.nvim config (based on jackw01/summer-night-vscode-theme)
M.night = {
  bg_dim = '#1b2029',
  bg0 = '#21262f',
  bg1 = '#2b303a',
  bg2 = '#393e48',
  bg3 = '#525762',

  text = '#00a3d2',
  fg = '#a6abb8',
  fg_bright = '#e2eaf5',
  comment = '#6d727e',
  muted = '#525762',
  line_nr = '#00ab9a',

  blue = '#00a3d2',
  cyan = '#00a9b9',
  teal = '#00ab9a',
  pink = '#fa5f8b',
  red = '#f06c6f',
  orange = '#d08447',
  coral = '#e17954',
  gold = '#d3ab58',

  error = '#d97c8f',
  warn = '#d9ae7e',
  info = '#8bb9c8',
  hint = '#a5d9a7',
  ok = '#a5d9a7',
}

-- Summer Dusk: the same hues, softened and lifted onto an everforest-like, not-super-dark base.
-- Accents sit at ~5-7:1 contrast (everforest's range) instead of 4-9:1.
M.dusk = {
  bg_dim = '#262c35',
  bg0 = '#2c323c',
  bg1 = '#333a45',
  bg2 = '#3c4450',
  bg3 = '#4d5563',

  text = '#6cb6d9',
  fg = '#a3a9b6',
  fg_bright = '#dde2ea',
  comment = '#838a98',
  muted = '#5c6370',
  line_nr = '#5eb8a5',

  blue = '#5fb0d8',
  cyan = '#58b5bf',
  teal = '#5eb8a5',
  pink = '#eb85a3',
  red = '#e8878a',
  orange = '#dd9a66',
  coral = '#e48e70',
  gold = '#dbb672',

  error = '#e8878a',
  warn = '#dbb672',
  info = '#5fb0d8',
  hint = '#8fc0a9',
  ok = '#8fc0a9',
}

return M
