" ==============================================================================
" Stage 0: Core Settings
" ==============================================================================
let $PATH = '/opt/homebrew/bin:' . $PATH
let g:python3_host_prog = '/opt/homebrew/bin/python3.9'
" Bypass system proxy for local AI/LSP servers
let $NO_PROXY = 'localhost,127.0.0.1,::1'
let $no_proxy = 'localhost,127.0.0.1,::1'
let g:mapleader = '\'

" Basic formatting and search settings
set updatetime=250
set tabstop=2
set shiftwidth=2
set expandtab
set splitbelow
set splitright
set hlsearch
set ignorecase
set clipboard=unnamedplus
set fillchars+=eob:\ 

" UI and Display settings
set number          " Show absolute line number for current line
set relativenumber  " Show relative line numbers for all other lines (great for jumping)
set signcolumn=yes  " Always show the sign column to prevent code from shifting left/right
set cursorline      " Slightly highlight the current line to know exactly where you are

" Markdown and LaTex support
set conceallevel=2
set concealcursor=nc "

" ==============================================================================
" Stage 1: Plugin Installation
" ==============================================================================
call plug#begin('~/.vim/plugged')
  " General Utilities
  Plug 'mbbill/undotree'
  Plug 'farmergreg/vim-lastplace'
  Plug 'stevearc/oil.nvim'
  Plug 'stevearc/aerial.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'tomasiser/vim-code-dark'
  
  " Formatting
  Plug 'stevearc/conform.nvim'
  
  " Core autocomplete and completion sources
  " Cmp 
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lsp'
  
  " Snippet plugins
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'rafamadriz/friendly-snippets' 
       " Preconfigured snippets for various languages
  
  " LSP and Syntax
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter'
  
  " Beautiful Markdown Rendering (Math, Tables, Code Blocks)
  Plug 'MeanderingProgrammer/render-markdown.nvim'
  
  " AI code completion
  Plug 'milanglacier/minuet-ai.nvim'

  " Multi-file programming core plugins
  Plug 'ibhagwan/fzf-lua'
  Plug 'nvim-lua/plenary.nvim' 
        " Harpoon dependency
  Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'folke/flash.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'RRethy/vim-illuminate'
call plug#end()

" ==============================================================================
" Stage 2: Plugin Configurations
" ==============================================================================

" --- Theme & Syntax ---
syntax on           " Enable syntax highlighting
filetype plugin on  " Enable filetype plugins
filetype indent on  " Enable filetype indentation
set background=dark
colorscheme vscode_theme

" --- Oil.nvim ---
lua << EOF
require("oil").setup({       
   default_file_explorer = true,                          
})                           
EOF
" Avoid keys conflict
lua << EOF
require("oil").setup({       
    default_file_explorer = true,
    keymaps = {
        ["<C-h>"] = false,
        ["<C-x>"] = "actions.select_split",
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",      
    }
})
EOF

" --- Aerial (Heading Outline) ---
lua << EOF
pcall(function()
    require('aerial').setup({
        layout = {
            default_direction = "left",
            width = 30,
            min_width = 30,
            max_width = 30, -- Fixed width for clean wrapping
        },
        show_guides = false, -- Disable guides to enable perfect wrap alignment
        on_attach = function(bufnr)
            vim.keymap.set('n', '<CR>', '<cmd>AerialNext<CR>', {buffer = bufnr}) -- Jump to heading
        end
    })
end)
EOF

" Clean wrap and perfect alignment in Aerial
augroup AerialWrap
    autocmd!
    autocmd FileType aerial setlocal wrap breakindent
augroup END

" \o: Toggle sidebar
nnoremap <leader>o <cmd>AerialToggle!<CR>

" --- Conform ---
lua << EOF
local status_conform, conform = pcall(require, "conform")
if status_conform then
    conform.setup({
        formatters_by_ft = {
            python = { "isort", "black" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            verilog = { "verible" },
            systemverilog = { "verible" },
        },
        format_on_save = {
            timeout_ms = 5000,
            lsp_format = "fallback"
        },
    })
end
EOF

" --- Cmp & LuaSnip ---
lua << EOF
  local cmp_status, cmp = pcall(require, 'cmp')
  local luasnip_status, luasnip = pcall(require, 'luasnip')

  if cmp_status and luasnip_status then
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then cmp.select_next_item() else fallback() end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
        { name = 'path' },
      })
    })
  end
EOF

" --- Treesitter ---
lua << EOF
  vim.treesitter.language.register('verilog', 'systemverilog')

  -- In Neovim 0.12+, Treesitter highlighting must be handled natively via vim.treesitter.start()
  pcall(function()
    require("nvim-treesitter").setup()
    require("nvim-treesitter").install({ "python", "lua", "vim", "c", "cpp", "systemverilog", "markdown", "markdown_inline", "latex", "sql" })
  end)

  -- Intercept FileType event globally to start native TS parsing if available
  vim.api.nvim_create_autocmd('FileType', {
    pattern = "*",
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
      if lang then
          local ok, err = pcall(vim.treesitter.start, args.buf)
          if not ok then
             -- print("TS Error: " .. tostring(err))
          end
      end
    end,
  })
EOF

" --- Render Markdown (Beautiful Math & Tables) ---
lua << EOF
pcall(function()
    require('render-markdown').setup({
        latex = { enabled = false },   -- Disable complex latex rendering to avoid altering fractions
        code = {
            sign = false,              -- Clean code blocks
            width = 'block',           -- Fill background fully
            right_pad = 1,
        },
        heading = { enabled = false }, -- Keep headings native (to retain syntax colors)
        bullet = {
            icons = { '● ', '○ ', '□ ', '□ ', '□ ', '□ ', '□ ', '□ ', '□ ', '□ ' }, -- 1st: solid circle, 2nd: hollow circle, 3rd-10th: hollow square
            ordered_icons = function(ctx)
                local value = vim.trim(ctx.value)
                local index = tonumber(value:sub(1, #value - 1))
                return string.format(' %d.', index > 1 and index or ctx.index)
            end,
            left_pad = 0,
            right_pad = 0,
        },
        quote = {
            icon = '│', -- Thin line for quotes
            repeat_linebreak = true, -- Keep quote lines connected across empty lines
        },
        pipe_table = {
            preset = 'none',   -- Clean borderless design
            style = 'full',    -- Full background block
            cell = 'overlay',  -- Overlay cells entirely to fill the table background like code blocks
            padding = 1,
        },
    })
end)
EOF

" --- Harpoon v2 (Core workspace file navigation) ---
lua << EOF
local harpoon = require("harpoon")
harpoon:setup()
-- Add current file to Harpoon list
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- Toggle Harpoon UI quick menu
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
-- Seamlessly switch to file 1, 2, 3, 4, 5, 6
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
EOF

" --- Flash.nvim (On-screen fast jump) ---
lua << EOF
require("flash").setup({})
vim.keymap.set({"n", "x", "o"}, "s", function() require("flash").jump() end, { desc = "Flash" })
EOF

" --- Gitsigns (Git line modifications) ---
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
}
EOF

" Set explicit colors for Gitsigns signs
highlight GitSignsAdd    guifg=#458588 ctermfg=40
highlight GitSignsChange guifg=#d79921 ctermfg=208
highlight GitSignsDelete guifg=#fb4934 ctermfg=196
highlight GitSignsChangeDelete guifg=#b16286 ctermfg=132

" --- Mason & LSPConfig (Auto-install environments & go-to mappings) ---
lua << EOF
-- Initialize Mason auto-installer
require("mason").setup()
require("mason-lspconfig").setup({
    -- Auto-install LSP servers for C++ (clangd) and Python (pyright, ruff)
    ensure_installed = { "clangd", "pyright", "ruff" }
})

-- Deprecate on_attach, use native LspAttach autocommands for keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { noremap=true, silent=true, buffer=ev.buf }
        -- Core fix: Get current LSP client and disable semantic tokens to prevent color flickering
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
        -- Neovim 0.12+: Intercept pending semantic token requests to prevent render override
        if vim.lsp.semantic_tokens and vim.lsp.semantic_tokens.enable then
            pcall(vim.lsp.semantic_tokens.enable, false, { bufnr = ev.buf, client_id = ev.data.client_id })
        end

        -- Core jumps: Definition, references, hover
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- Header/Source switch (clangd/C++/C only)
        vim.keymap.set('n', '<leader>gh', function()
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client and client.name == 'clangd' then
                client:request('textDocument/switchSourceHeader', { uri = vim.uri_from_bufnr(ev.buf) }, function(err, result)
                    if err then error(tostring(err)) end
                    if not result then print("Corresponding file not found") return end
                    vim.api.nvim_command('edit ' .. vim.uri_to_fname(result))
                end, ev.buf)
            end
        end, opts)
        -- Batch rename variables
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        -- Code actions (e.g., auto-import)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    end,
})

-- Start C++ and Python LSP natively (Neovim 0.11+)
-- This avoids the deprecated require('lspconfig') warnings while preserving full functionality.
pcall(vim.lsp.enable, "clangd")
pcall(vim.lsp.enable, "pyright")
pcall(vim.lsp.enable, "ruff")
EOF

" --- vim-illuminate (Auto-highlight identical variables) ---
lua << EOF
require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    delay = 100,
})
EOF

" Override vim-illuminate highlight colors to be very subtle (faint background)
highlight IlluminatedWordText guibg=#3a3a3a ctermbg=237 gui=none cterm=none
highlight IlluminatedWordRead guibg=#3a3a3a ctermbg=237 gui=none cterm=none
highlight IlluminatedWordWrite guibg=#3a3a3a ctermbg=237 gui=none cterm=none

"" --- milanglacier/minuet-ai.nvim (Ollama ghost text code completion) ---
lua << EOF
require('minuet').setup({
    provider = 'openai_fim_compatible',
    n_completions = 1,
    -- Prevent high CPU usage/overheating: increase delay to 400ms
    debounce = 400,
    throttle = 400,
    provider_options = {
        openai_fim_compatible = {
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:3b',
            optional = {
                max_tokens = 256,
                top_p = 0.9,
            },
        },
    },
    virtualtext = {
        auto_trigger_ft = { '*' },
        keymap = {
            -- Keymaps tailored for macOS (No Alt/Option keys)
            accept = '<Tab>',         -- Accept entire suggestion
            accept_line = '<C-l>',    -- Accept only the current line (Ctrl+L for right/forward)
            accept_n_lines = '<C-q>', -- Accept multiple lines (Ctrl+Q for quantity)
            prev = '<C-b>',           -- Previous suggestion (Ctrl+B for backward)
            next = '<C-f>',           -- Next suggestion (Ctrl+F for forward)
            dismiss = '<C-e>',        -- Dismiss suggestion (Ctrl+E for exit)
        },
    },
})
EOF
"
"" Override minuet-ai.nvim suggestion color to be very pale gray (lighter than comments)
"highlight MinuetVirtualText guifg=#4a4a4a ctermfg=239

" --- fzf-lua ---
lua << EOF
require('fzf-lua').setup({
  winopts = {
    preview = {
      layout = 'horizontal',     
      horizontal = 'right:70%',  
    }
  }
})
EOF

" ==============================================================================
" Stage 3: Custom Functions & Autocommands
" ==============================================================================

" SystemVerilog filetype detection
augroup SystemVerilogDetect
  autocmd!
  autocmd BufNewFile,BufRead *.sv,*.vh setfiletype systemverilog
augroup END

" DynamicCursorLine for visualization
augroup DynamicCursorLine
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Compile and run keymaps
augroup CompileRun
    autocmd!
    " C 
    autocmd FileType c nnoremap <buffer> <leader>rr :w<CR>:10sp <bar> term cd %:p:h && gcc %:t -o %:t:r && ./%:t:r<CR>i
    " C++ 
    autocmd FileType cpp nnoremap <buffer> <leader>rr <cmd>w<CR><cmd>10sp <bar> term cd %:p:h && g++ %:t -o %:t:r -std=c++20 && ./%:t:r<CR>i
    " Python
    autocmd FileType python nnoremap <buffer> <leader>rr :w<CR>:10sp <bar> term cd %:p:h && python3 %:t<CR>i
augroup END

" Function to retrieve and display Python nested context
function! ShowPythonContext()
    let l:current_line = line('.')
    
    " Skip empty lines at cursor to find actual code indentation
    while l:current_line > 0 && match(getline(l:current_line), '^\s*$') != -1
        let l:current_line -= 1
    endwhile

    " Set initial indent threshold
    let l:current_indent = indent(l:current_line) + 1
    let l:context = []

    " Traverse upwards to the beginning of the file
    for l:i in range(l:current_line, 1, -1)
        let l:line_text = getline(l:i)
        
        " Match lines containing 'def' or 'class'
        if match(l:line_text, '^\s*def\s\+') != -1 || match(l:line_text, '^\s*class\s\+') != -1
            let l:indent = indent(l:i)
            
            " Outer scope detected if the line indent is strictly less than the current threshold
            if l:indent < l:current_indent
                " Extract function or class name using \v (very magic)
                let l:name = matchstr(l:line_text, '\v(def|class)\s+\w+')
                if l:name != ''
                    " Insert at the beginning of the list to maintain order (outer left, inner right)
                    call insert(l:context, l:name)
                    let l:current_indent = l:indent
                endif
            endif
        endif
        
        " Stop traversal when reaching global scope (indent 0)
        if l:current_indent == 0
            break
        endif
    endfor

    " Output the result
    if empty(l:context)
        echo "Located at: Global Scope"
    else
        echo "Path: " . join(l:context, " -> ")
    endif
endfunction

" Function to safely translate the current line avoiding Vim's special character expansion
function! TranslateLine()
    let l:line = getline('.')
    let l:safe_cmd = escape(shellescape(l:line), '#%!')
    execute '10sp | term trans ' . l:safe_cmd
    startinsert
endfunction





" ==============================================================================
" Stage 4: Keymaps
" ==============================================================================

" Cancel search highlighting with double ESC
nnoremap <Esc><Esc> :nohlsearch<CR>

" Toggle the undo tree display
nnoremap <F4> :UndotreeToggle<CR>

" Open current directory with Oil
nnoremap - <CMD>Oil<CR>

" Exit insert mode and save
inoremap jj <Esc>:w<CR>

" Add a blank line below without entering insert mode
" nnoremap <CR> o<Esc>

" Window navigation with Ctrl + h/j/k/l
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Translate current word or sentence
nnoremap <leader>tr :10sp <bar> term trans <C-r><C-w><CR>i
nnoremap <leader>tl <cmd>call TranslateLine()<CR>

" Bind shortcut for Python context
nnoremap <silent> <leader>pc :call ShowPythonContext()<CR>

" fzf-lua (Global fast search, replacing rg/Telescope)
nnoremap <leader>ff <cmd>lua require('fzf-lua').files()<CR>
nnoremap <leader>fg <cmd>lua require('fzf-lua').live_grep()<CR>
nnoremap <leader>gw <cmd>lua require('fzf-lua').grep_cword()<CR>
nnoremap <leader>fb <cmd>lua require('fzf-lua').buffers()<CR>

" Key mapping for Markdown
vnoremap <leader>b c**<C-r>"**<ESC>

" Quickly adjust window size (step by 5 columns/rows each time)
nnoremap <Up> <cmd>resize +5<CR>
nnoremap <Down> <cmd>resize -5<CR>
nnoremap <Left> <cmd>vertical resize -5<CR>
nnoremap <Right> <cmd>vertical resize +5<CR>

" ==============================================================================
" Stage 5: Late Initialization
" ==============================================================================

" Core fix: Force re-trigger FileType event.
" Since init.vim is the startup file, the FileType event might trigger before treesitter loads,
" causing no highlights on open. Re-triggering ensures lazy-loaded plugins (like treesitter) attach!
silent! doautocmd FileType
