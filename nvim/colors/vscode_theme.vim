highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "vscode_theme"

" ==========================================
" --- 1. Basic UI ---
" ==========================================
hi Normal guifg=#FFFFFF guibg=#121212 gui=NONE ctermfg=231 ctermbg=233 cterm=NONE
hi Comment guifg=#8B95A3 gui=italic ctermfg=246 cterm=italic
hi ColorColumn guibg=#2D2E30 gui=NONE ctermbg=236 cterm=NONE
hi Cursor guifg=#1C1D1F guibg=#FCFCFC gui=NONE ctermfg=234 ctermbg=253 cterm=NONE
hi CursorLine guibg=#2D2E30 gui=NONE ctermbg=236 cterm=NONE
hi CursorColumn guibg=#2D2E30 gui=NONE ctermbg=236 cterm=NONE
hi Directory guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE
hi DiffAdd guibg=#347d39 gui=NONE ctermbg=65 cterm=NONE
hi DiffChange guibg=#276782 gui=NONE ctermbg=31 cterm=NONE
hi DiffDelete guifg=#FFFFFF guibg=#F97583 gui=NONE ctermfg=231 ctermbg=210 cterm=NONE
hi DiffText guibg=#57ab5a gui=NONE ctermbg=71 cterm=NONE
hi ErrorMsg guifg=#FF0000 guibg=NONE ctermfg=197 ctermbg=NONE 
hi VertSplit guifg=#569CD6 guibg=#121212 gui=NONE ctermfg=39 ctermbg=233 cterm=NONE
hi Folded guifg=#8B95A3 guibg=#28292B gui=NONE ctermfg=246 ctermbg=235 cterm=NONE
hi IncSearch guibg=#317796 gui=NONE ctermbg=31 cterm=NONE
hi LineNr guifg=#72777B guibg=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#FFFFFF guibg=NONE gui=bold ctermfg=231 ctermbg=NONE cterm=bold
hi MatchParen guibg=#45A9D6 gui=NONE ctermbg=74 cterm=NONE
hi Pmenu guifg=#FFFFFF guibg=#28292B gui=NONE ctermfg=231 ctermbg=235 cterm=NONE
hi PmenuSel guifg=#ffffff guibg=#317796 gui=NONE ctermfg=231 ctermbg=31 cterm=NONE
hi Search guibg=#317796 gui=NONE ctermbg=31 cterm=NONE
hi SignColumn guibg=#121212 gui=NONE ctermbg=233 cterm=NONE
hi StatusLine guifg=#FFFFFF guibg=#317796 gui=bold ctermfg=231 ctermbg=31 cterm=bold
hi StatusLineNC guifg=#6B727A guibg=#232426 gui=NONE ctermfg=242 ctermbg=235 cterm=NONE
hi Visual guibg=#317796 gui=NONE ctermbg=31 cterm=NONE
hi WarningMsg guifg=#CE9178 guibg=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE

" ==========================================
" --- 2. Vim Native Highlight Engine ---
" ==========================================
" Strings
hi String guifg=#4CAF50 gui=NONE ctermfg=70 cterm=NONE
hi Character guifg=#4CAF50 gui=NONE ctermfg=70 cterm=NONE
" Keywords
hi Statement guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi Conditional guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi Repeat guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi Keyword guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
" Types and Structures
hi Type guifg=#DCDCAA gui=NONE ctermfg=220 cterm=NONE
hi StorageClass guifg=#DCDCAA gui=NONE ctermfg=220 cterm=NONE
hi Structure guifg=#DCDCAA gui=NONE ctermfg=220 cterm=NONE
hi Typedef guifg=#DCDCAA gui=NONE ctermfg=220 cterm=NONE
hi @type guifg=#5CE1E6 gui=NONE ctermfg=117 cterm=NONE
hi @type.builtin guifg=#5CE1E6 gui=NONE ctermfg=117 cterm=NONE
hi @type.qualifier guifg=#5CE1E6 gui=NONE ctermfg=117 cterm=NONE
" Functions
hi Function guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE
hi PreCondit guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE
" Macros
hi PreProc guifg=#CE9178 gui=NONE ctermfg=208 cterm=NONE
hi Include guifg=#CE9178 gui=NONE ctermfg=208 cterm=NONE
hi Define guifg=#CE9178 gui=NONE ctermfg=208 cterm=NONE
hi Macro guifg=#CE9178 gui=NONE ctermfg=208 cterm=NONE
" Errors
hi Exception guifg=#FF0000 guibg=NONE ctermfg=197 ctermbg=NONE
hi Error guifg=#FF0000 guibg=NONE ctermfg=197 ctermbg=NONE
hi @keyword.exception guifg=#FF0000 guibg=NONE ctermfg=197 ctermbg=NONE
hi @exception guifg=#FF0000 guibg=NONE ctermfg=197 ctermbg=NONE
" Identifiers and Numbers
hi Identifier guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE
hi Constant guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE
hi Number guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
hi Float guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
hi Boolean guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi Operator guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE
hi Label guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE
hi Delimiter guifg=#90969C gui=NONE ctermfg=246 cterm=NONE
hi Special guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE
hi Tag guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE

" ==========================================
" --- 3. Treesitter Semantic Highlights ---
" ==========================================
" Variables and properties
hi @variable guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE
hi @variable.builtin guifg=#FFFFFF gui=italic ctermfg=231 cterm=italic
hi @variable.parameter guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE 
hi @parameter guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE 
hi @variable.member guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE
hi @property guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE 

" Modules and Imports
hi @keyword.import guifg=#CE9178 gui=NONE ctermfg=208 cterm=NONE
hi @module guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE
hi @module.builtin guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE
hi @keyword.directive guifg=#CE9178 gui=NONE ctermfg=208 cterm=NONE

" Strings and Numbers
hi @string guifg=#4CAF50 gui=NONE ctermfg=70 cterm=NONE
hi @string.regexp guifg=#4CAF50 gui=NONE ctermfg=70 cterm=NONE
hi @string.escape guifg=#CE9178 gui=bold ctermfg=208 cterm=bold
hi @string.documentation guifg=#8B95A3 gui=NONE ctermfg=248 cterm=NONE
" Paths
hi @string.special.path guifg=#FFFFFF gui=NONE ctermfg=231 cterm=NONE
hi @character guifg=#4CAF50 gui=NONE ctermfg=70 cterm=NONE
hi @number guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
hi @boolean guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi @float guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
hi @comment guifg=#8B95A3 gui=italic ctermfg=246 cterm=italic
hi @comment.documentation guifg=#8B95A3 gui=NONE ctermfg=246 cterm=NONE
hi @comment.error guifg=#FF0000  guibg=NONE ctermfg=197 ctermbg=NONE
hi @comment.warning guifg=#CE9178 gui=NONE ctermfg=208 cterm=NONE

" Functions and Methods
hi @function guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE
hi @function.builtin guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE
hi @function.macro guifg=#CE9178 gui=NONE ctermfg=208 cterm=NONE
hi @method guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE
hi @function.call guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE
hi @method.call guifg=#569CD6 gui=NONE ctermfg=39 cterm=NONE

" Keywords
hi @keyword guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi @keyword.function guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi @keyword.conditional guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi @keyword.repeat guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi @keyword.return guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE

" ==========================================
" --- 4. Markdown Semantic Rendering (@markup) ---
" ==========================================
" Headings
hi @markup.heading guifg=#569CD6 gui=bold ctermfg=39 cterm=bold
hi @markup.heading.1 guifg=#569CD6 gui=bold ctermfg=39 cterm=bold
hi @markup.heading.2 guifg=#569CD6 gui=bold ctermfg=39 cterm=bold
hi @markup.heading.3 guifg=#569CD6 gui=bold ctermfg=39 cterm=bold
hi @markup.heading.4 guifg=#569CD6 gui=bold ctermfg=39 cterm=bold

" Lists and Bullets
hi @markup.list guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
hi @markup.list.checked guifg=#4CAF50 gui=NONE ctermfg=70 cterm=NONE
hi @markup.list.unchecked guifg=#8B95A3 gui=NONE ctermfg=246 cterm=NONE

" Strong (Bold)
hi! @markup.strong guifg=#D2A8FF gui=bold ctermfg=183 cterm=bold
hi! markdownBold guifg=#D2A8FF gui=bold ctermfg=183 cterm=bold
" Italic (removed underline)
hi! @markup.italic guifg=#45A9D6 gui=italic ctermfg=74 cterm=italic
hi! @markup.italic.markdown_inline guifg=#45A9D6 gui=italic ctermfg=74 cterm=italic
hi! markdownItalic guifg=#45A9D6 gui=italic ctermfg=74 cterm=italic

" Links and Quotes
hi @markup.link guifg=#45A9D6 gui=underline ctermfg=74 cterm=underline
hi @markup.link.url guifg=#8B95A3 gui=underline ctermfg=246 cterm=underline
hi @markup.quote guifg=#8B95A3 gui=italic ctermfg=246 cterm=italic

" Markdown Code Block Labels
hi @label.markdown guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
hi @property.markdown guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE

" Inline Code and Code Blocks
hi @markup.raw guifg=#CE9178 guibg=#2A2D30 gui=NONE ctermfg=208 ctermbg=236 cterm=NONE
hi @markup.raw.block guifg=#B5CEA8 guibg=#2A2D30 gui=NONE ctermfg=114 ctermbg=236 cterm=NONE
hi @markup.raw.markdown_inline guifg=#CE9178 guibg=#2A2D30 gui=NONE ctermfg=208 ctermbg=236 cterm=NONE
hi @markup.strikethrough guifg=#8B95A3 gui=strikethrough ctermfg=246 cterm=strikethrough

" RenderMarkdown Code Block Fill
hi RenderMarkdownCode guibg=#2A2D30 ctermbg=236

" RenderMarkdown Table & Quote Overrides
hi RenderMarkdownTableHead guifg=#A0AAB5 guibg=#2A2D30 gui=bold ctermfg=247 ctermbg=236 cterm=bold
hi RenderMarkdownTableRow guifg=#FFFFFF guibg=#2A2D30 gui=NONE ctermfg=231 ctermbg=236 cterm=NONE
hi RenderMarkdownTableFill guifg=#8B95A3 guibg=#2A2D30 gui=NONE ctermfg=246 ctermbg=236 cterm=NONE
hi RenderMarkdownQuote guifg=#8B95A3 gui=NONE ctermfg=246 cterm=NONE

" ==========================================
" --- 5. Math LaTeX Rendering (@math) ---
" ==========================================
" Native Conceal color (so concealed greek letters are visible and pale green)
hi Conceal guifg=#B5CEA8 guibg=NONE ctermfg=114 ctermbg=NONE

" Markdown Math Boundaries ($ and $$) and Math Text
hi @markup.math guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
hi @markup.math.latex guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
hi texMathZoneX guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
hi texMathZoneW guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE

" Injected LaTeX Highlights
" LaTeX Macros
hi @function.macro.latex guifg=#C586C0 gui=NONE ctermfg=204 cterm=NONE
" LaTeX Punctuation
hi @punctuation.special.latex guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
" LaTeX Operators
hi @operator.latex guifg=#B5CEA8 gui=NONE ctermfg=114 cterm=NONE
" LaTeX Variables
hi @variable.parameter.latex guifg=#569CD6 gui=italic ctermfg=39 cterm=italic
