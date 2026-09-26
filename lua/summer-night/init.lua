-- summer-night: a small local colorscheme (replaces roobert/palette.nvim).
-- Variants live in palettes.lua; load one with `:colorscheme summer-night` or `:colorscheme summer-dusk`.
local M = {}

---Mix `fg` over `bg` by `alpha` (0..1), for tinted backgrounds.
local function blend(fg, bg, alpha)
  local function rgb(hex)
    return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
  end
  local fr, fg_, fb = rgb(fg)
  local br, bg_, bb = rgb(bg)
  local function mix(a, b)
    return math.floor(a * alpha + b * (1 - alpha) + 0.5)
  end
  return string.format('#%02x%02x%02x', mix(fr, br), mix(fg_, bg_), mix(fb, bb))
end

---@param p table palette from palettes.lua
local function groups(p)
  local tint = function(color)
    return blend(color, p.bg0, 0.18)
  end
  -- Heading colours, calm to warm: the common levels (H1-H3) stay cool/gold,
  -- the warm reds only appear on rarely used deep levels
  local levels = { p.blue, p.teal, p.gold, p.orange, p.pink, p.coral }

  local g = {
    -- Editor
    Normal = { fg = p.text, bg = p.bg0 },
    NormalNC = { link = 'Normal' },
    NormalFloat = { fg = p.fg, bg = p.bg0 },
    FloatBorder = { fg = p.bg3, bg = p.bg0 },
    FloatTitle = { fg = p.cyan, bg = p.bg0, bold = true },
    WinSeparator = { fg = p.bg2 },
    NonText = { fg = p.muted },
    Whitespace = { fg = p.pink }, -- trailing-space dots stay loud on purpose
    EndOfBuffer = { fg = p.bg0 },
    Conceal = { fg = p.comment },
    SpecialKey = { fg = p.muted },

    Cursor = { fg = p.bg0, bg = p.pink },
    CursorLine = { bg = p.bg1 },
    CursorColumn = { bg = p.bg1 },
    ColorColumn = { bg = p.bg1 },
    LineNr = { fg = p.line_nr },
    LineNrAbove = { fg = p.muted },
    LineNrBelow = { fg = p.muted },
    CursorLineNr = { fg = p.cyan, bold = true },
    SignColumn = { bg = p.bg0 },
    FoldColumn = { fg = p.muted, bg = p.bg0 },
    CursorLineFold = { fg = p.pink },
    CursorLineSign = { fg = p.pink },
    Folded = { fg = p.coral, bg = p.bg1 },

    Visual = { bg = p.bg2 },
    VisualNOS = { bg = p.bg2 },
    Search = { fg = p.bg0, bg = p.gold },
    IncSearch = { fg = p.bg0, bg = p.pink },
    CurSearch = { link = 'IncSearch' },
    Substitute = { fg = p.bg0, bg = p.red },
    MatchParen = { fg = p.fg_bright, bg = p.bg3, bold = true },

    Pmenu = { fg = p.fg, bg = p.bg1 },
    PmenuSel = { fg = p.gold, bg = p.bg2, bold = true },
    PmenuSbar = { bg = p.bg1 },
    PmenuThumb = { bg = p.cyan },
    PmenuMatch = { fg = p.cyan, bold = true },
    PmenuMatchSel = { fg = p.cyan, bold = true },
    PmenuKind = { fg = p.coral, bg = p.bg1 },
    PmenuExtra = { fg = p.comment, bg = p.bg1 },

    StatusLine = { fg = p.fg, bg = p.bg_dim },
    StatusLineNC = { fg = p.comment, bg = p.bg_dim },
    TabLine = { fg = p.comment, bg = p.bg_dim },
    TabLineSel = { fg = p.orange, bg = p.bg0 },
    TabLineFill = { bg = p.bg_dim },
    WinBar = { fg = p.fg, bg = p.bg0 },
    WinBarNC = { fg = p.comment, bg = p.bg0 },
    Title = { fg = p.blue, bold = true },
    Directory = { fg = p.gold },
    Question = { fg = p.cyan },
    MoreMsg = { fg = p.cyan },
    ModeMsg = { fg = p.fg, bold = true },
    ErrorMsg = { fg = p.error },
    WarningMsg = { fg = p.warn },
    NvimInternalError = { fg = p.error, bg = p.bg0 },
    QuickFixLine = { bg = p.bg2, bold = true },
    ToolbarLine = { fg = p.red },
    ToolbarButton = { fg = p.red },

    SpellBad = { undercurl = true, sp = p.red },
    SpellCap = { undercurl = true, sp = p.coral },
    SpellRare = { undercurl = true, sp = p.orange },
    SpellLocal = { undercurl = true, sp = p.gold },

    -- Syntax (legacy groups; treesitter captures link to these by default)
    Comment = { fg = p.comment, italic = true },
    Constant = { fg = p.cyan },
    String = { fg = p.gold },
    Character = { fg = p.pink },
    Number = { fg = p.orange },
    Float = { fg = p.orange },
    Boolean = { fg = p.red },
    Identifier = { fg = p.fg },
    Function = { fg = p.cyan },
    Statement = { fg = p.pink },
    Conditional = { fg = p.pink },
    Repeat = { fg = p.pink },
    Label = { fg = p.pink },
    Operator = { fg = p.fg },
    Keyword = { fg = p.pink },
    Exception = { fg = p.pink },
    PreProc = { fg = p.pink },
    Include = { fg = p.red },
    Define = { fg = p.pink },
    Macro = { fg = p.cyan },
    Type = { fg = p.coral },
    StorageClass = { fg = p.red },
    Structure = { fg = p.coral },
    Typedef = { fg = p.coral },
    Special = { fg = p.coral },
    SpecialChar = { fg = p.red },
    Tag = { fg = p.cyan },
    Delimiter = { fg = p.fg },
    SpecialComment = { fg = p.comment, italic = true },
    Debug = { fg = p.coral, italic = true },
    Underlined = { underline = true },
    Error = { fg = p.error },
    Todo = { fg = p.cyan, italic = true },
    Added = { fg = p.ok },
    Changed = { fg = p.warn },
    Removed = { fg = p.error },

    -- Treesitter refinements (from the Summer Night VS Code theme)
    ['@variable'] = { fg = p.fg },
    ['@variable.parameter'] = { fg = p.orange },
    ['@variable.member'] = { fg = p.orange },
    ['@property'] = { fg = p.orange },
    ['@variable.builtin'] = { fg = p.orange, italic = true },
    ['@constant.builtin'] = { fg = p.red },
    ['@module'] = { fg = p.fg },
    ['@function.builtin'] = { fg = p.blue },
    ['@function.method'] = { fg = p.cyan },
    ['@constructor'] = { fg = p.coral },
    ['@keyword.import'] = { fg = p.pink },
    ['@keyword.modifier'] = { fg = p.red },
    ['@string.escape'] = { fg = p.blue },
    ['@string.regexp'] = { fg = p.blue },
    ['@string.special.url'] = { fg = p.cyan, underline = true },
    ['@tag'] = { fg = p.cyan },
    ['@tag.attribute'] = { fg = p.orange },
    ['@tag.delimiter'] = { fg = p.fg },
    ['@punctuation.special'] = { fg = p.pink },
    ['@comment.todo'] = { fg = p.cyan, bold = true },
    ['@comment.note'] = { fg = p.teal, bold = true },
    ['@comment.warning'] = { fg = p.orange, bold = true },
    ['@comment.error'] = { fg = p.red, bold = true },
    ['@lsp.type.namespace'] = { fg = p.fg },
    ['@lsp.type.property'] = { fg = p.orange },
    ['@lsp.type.property.rust'] = { fg = p.pink },
    ['@lsp.typemod.property.declaration.rust'] = { fg = p.fg },

    -- Diagnostics
    DiagnosticError = { fg = p.error, italic = true },
    DiagnosticWarn = { fg = p.warn, italic = true },
    DiagnosticInfo = { fg = p.info, italic = true },
    DiagnosticHint = { fg = p.hint, italic = true },
    DiagnosticOk = { fg = p.ok, italic = true },
    DiagnosticUnderlineError = { undercurl = true, sp = p.error },
    DiagnosticUnderlineWarn = { undercurl = true, sp = p.warn },
    DiagnosticUnderlineInfo = { underdotted = true, sp = p.info },
    DiagnosticUnderlineHint = { underdotted = true, sp = p.hint },
    DiagnosticVirtualTextError = { fg = p.error, bg = blend(p.error, p.bg0, 0.1), italic = true },
    DiagnosticVirtualTextWarn = { fg = p.warn, bg = blend(p.warn, p.bg0, 0.1), italic = true },
    DiagnosticVirtualTextInfo = { fg = p.info, bg = blend(p.info, p.bg0, 0.1), italic = true },
    DiagnosticVirtualTextHint = { fg = p.hint, bg = blend(p.hint, p.bg0, 0.1), italic = true },
    DiagnosticUnnecessary = { fg = p.comment },
    LspReferenceText = { bg = p.bg2 },
    LspReferenceRead = { bg = p.bg2 },
    LspReferenceWrite = { bg = p.bg2, underline = true },
    LspInlayHint = { fg = p.muted, italic = true },
    LspSignatureActiveParameter = { fg = p.gold, bold = true },

    -- Diff / git
    DiffAdd = { bg = blend(p.ok, p.bg0, 0.15) },
    DiffChange = { bg = blend(p.warn, p.bg0, 0.1) },
    DiffDelete = { fg = p.error, bg = blend(p.error, p.bg0, 0.15) },
    DiffText = { bg = blend(p.warn, p.bg0, 0.25) },
    GitSignsAdd = { fg = p.ok },
    GitSignsChange = { fg = p.warn },
    GitSignsDelete = { fg = p.error },

    -- Markdown (treesitter + render-markdown.nvim)
    ['@markup.heading'] = { fg = p.blue, bold = true },
    ['@markup.strong'] = { fg = p.fg_bright, bold = true },
    ['@markup.italic'] = { italic = true },
    ['@markup.strikethrough'] = { fg = p.comment, strikethrough = true },
    ['@markup.underline'] = { underline = true },
    ['@markup.quote'] = { fg = p.fg, italic = true },
    ['@markup.list'] = { fg = p.cyan },
    ['@markup.list.checked'] = { fg = p.comment },
    ['@markup.list.unchecked'] = { fg = p.pink },
    ['@markup.raw'] = { fg = p.gold },
    ['@markup.raw.markdown_inline'] = { fg = p.gold },
    -- Links: text stays plain, a dim icon marks it; the URL only shows on the cursor line
    ['@markup.link'] = { fg = p.comment },
    ['@markup.link.label'] = { fg = p.text },
    ['@markup.link.url'] = { fg = p.comment },
    ['@markup.math'] = { fg = p.teal },

    RenderMarkdownCode = { bg = p.bg1 },
    RenderMarkdownCodeBorder = { bg = p.bg1 },
    RenderMarkdownCodeInfo = { fg = p.comment, bg = p.bg1 },
    RenderMarkdownCodeInline = { fg = p.gold }, -- no chip background: it read as a link
    RenderMarkdownInlineHighlight = { fg = p.gold, bg = p.bg2 },
    RenderMarkdownDash = { fg = p.muted },
    RenderMarkdownQuote = { fg = p.muted },
    RenderMarkdownTableHead = { fg = p.muted },
    RenderMarkdownTableRow = { fg = p.muted },
    RenderMarkdownBullet = { fg = p.cyan },
    RenderMarkdownSign = { fg = p.muted },
    RenderMarkdownLink = { fg = p.comment },
    RenderMarkdownWikiLink = { fg = p.comment },
    RenderMarkdownUnchecked = { fg = p.pink },
    RenderMarkdownChecked = { fg = p.comment },
    RenderMarkdownTodo = { fg = p.cyan },
    RenderMarkdownSuccess = { fg = p.ok },
    RenderMarkdownInfo = { fg = p.info },
    RenderMarkdownHint = { fg = p.hint },
    RenderMarkdownWarn = { fg = p.warn },
    RenderMarkdownError = { fg = p.error },
    RenderMarkdownMath = { fg = p.teal },
    RenderMarkdownHtmlComment = { fg = p.comment, italic = true },

    -- Telescope / snacks / noice / which-key / cmp
    TelescopeBorder = { link = 'FloatBorder' },
    TelescopeTitle = { link = 'FloatTitle' },
    TelescopeSelection = { bg = p.bg2 },
    TelescopeMatching = { fg = p.cyan, bold = true },
    TelescopePromptPrefix = { fg = p.pink },
    NoiceCmdlinePopupBorder = { link = 'FloatBorder' },
    NoiceCmdlineIcon = { fg = p.cyan },
    WhichKey = { fg = p.cyan },
    WhichKeyGroup = { fg = p.pink },
    WhichKeyDesc = { fg = p.fg },
    WhichKeySeparator = { fg = p.muted },
    SnacksIndent = { fg = p.bg2 },
    SnacksIndentScope = { fg = p.bg3 },
    SnacksDashboardHeader = { fg = p.cyan },
    SnacksDashboardKey = { fg = p.pink },
    SnacksDashboardIcon = { fg = p.gold },
    CmpItemAbbrMatch = { fg = p.cyan, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = p.cyan },
    CmpItemKind = { fg = p.coral },
    CmpItemMenu = { fg = p.comment },
    NotifyBackground = { bg = p.bg0 },
    OilDir = { fg = p.gold },
  }

  for i, color in ipairs(levels) do
    g['RenderMarkdownH' .. i] = { fg = color, bold = true }
    g['RenderMarkdownH' .. i .. 'Bg'] = { fg = color, bg = tint(color), bold = true }
    g['@markup.heading.' .. i] = { fg = color, bold = true }
  end

  -- todo-comments keywords share the heading look: tinted label + coloured bold text.
  -- (todo-comments uses `hi def`, so these take precedence.)
  local todo = { TODO = p.cyan, NOTE = p.teal, FIX = p.red, WARN = p.orange, HACK = p.coral, PERF = p.pink, TEST = p.gold }
  for kw, color in pairs(todo) do
    g['TodoBg' .. kw] = { fg = color, bg = tint(color), bold = true }
    g['TodoFg' .. kw] = { fg = color }
    g['TodoSign' .. kw] = { fg = color, bg = p.bg0 }
  end

  return g
end

---@param variant 'night'|'dusk'
function M.load(variant)
  local p = require('summer-night.palettes')[variant]
  if vim.g.colors_name then
    vim.cmd 'highlight clear'
  end
  vim.o.termguicolors = true
  vim.o.background = 'dark'
  vim.g.colors_name = variant == 'night' and 'summer-night' or 'summer-' .. variant

  for name, spec in pairs(groups(p)) do
    vim.api.nvim_set_hl(0, name, spec)
  end

  local term = { p.bg0, p.red, p.teal, p.orange, p.blue, p.pink, p.cyan, p.fg }
  for i = 0, 15 do
    vim.g['terminal_color_' .. i] = term[(i % 8) + 1]
  end
  vim.g.terminal_color_8 = p.muted
end

return M
