local opt = vim.opt -- global
local g = vim.g -- global for let options
local fn = vim.fn -- access vim functions
local cmd = vim.cmd -- vim commands

local ensure_packer = function()
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        cmd "packadd packer.nvim"
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(
    function(use)
        use "wbthomason/packer.nvim"

        -- Intelligence
        use "neovim/nvim-lspconfig"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-path"
        use "hrsh7th/nvim-cmp"
        use 'simrat39/rust-tools.nvim'

        -- General
        use "editorconfig/editorconfig-vim"
        use "mhinz/vim-startify"
        use "numToStr/Comment.nvim"
        use "tpope/vim-surround"
        use "tpope/vim-sleuth"
        use "nvim-lua/popup.nvim"
        use "nvim-lua/plenary.nvim"
        use "hrsh7th/vim-vsnip"

        -- Debugging
        use 'mfussenegger/nvim-dap'

        -- Navigation and search
        use "airblade/vim-rooter"
        use "christoomey/vim-tmux-navigator"
        use "christoomey/vim-tmux-runner"
        use "nvim-telescope/telescope.nvim"
        use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}

        -- Appearance
        use "dracula/vim"
		use { -- Highlight, edit, and navigate code
			'nvim-treesitter/nvim-treesitter',
			run = function()
			  pcall(require('nvim-treesitter.install').update { with_sync = true })
			end,
		}
		use "hoob3rt/lualine.nvim"
        use "akinsho/nvim-bufferline.lua"
        use "lukas-reineke/indent-blankline.nvim"

        -- HTML/CSS/JS
        use "norcalli/nvim-colorizer.lua"
        use "prettier/vim-prettier"

        -- Git
        use "tpope/vim-fugitive"
        use "tpope/vim-rhubarb"
        use "lewis6991/gitsigns.nvim"

        -- Testing
        use "vim-test/vim-test"
        use "ankush/frappe_test.vim"
        use "ankush/frappe_sql.nvim"

        -- Notetaking
        use "vimwiki/vimwiki"

        if packer_bootstrap then
            require("packer").sync()
        end
    end
)

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

cmd "colorscheme dracula"

-- all global settings

g.mapleader = " "
g.nojoinspaces = true

opt.backspace = [[indent,eol,start]]
opt.completeopt = [[menuone,noinsert,noselect]]
opt.autoindent = true
opt.termguicolors = true
opt.history = 1000
opt.hidden = true
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = "utf-8"
opt.ignorecase = true
opt.lazyredraw = true
opt.list = true
opt.wrap = true
opt.mouse = "a"
opt.incsearch = true
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.scrolloff = 5
opt.shiftwidth = 4
opt.shortmess:append("I")
opt.shortmess:append("W")
opt.shortmess:append("c")
opt.showtabline = 2
opt.smartcase = true
opt.spellfile = "$HOME/.config/nvim/spell/en.utf-8.add"
opt.spelllang = "en_gb"
opt.splitbelow = true
opt.swapfile = false -- #yolo
opt.showmode = false
opt.splitright = true
opt.fixendofline = false -- doctype.json
opt.listchars = "tab:│ ,extends:>,trail:·,precedes:<,nbsp:⦸"
opt.timeoutlen = 500
opt.updatetime = 150
opt.wildmenu = true
opt.undofile = true
opt.undodir = "/tmp" -- #yolo
opt.signcolumn = "number"
opt.clipboard = "unnamedplus"
opt.number = true
opt.tabstop = 4

-- Accept defeat and just use vim.cmd
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- trim whitespace on end
cmd("autocmd BufWritePre * :%s/\\s\\+$//e")
cmd("autocmd BufNewFile,BufRead * setlocal formatoptions-=cro")

-- keybindings --
function map(mode, binding, action, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, binding, action, options)
end

-- buffer manipulation
map("n", "<M-j>", ":resize -2<CR>")
map("n", "<M-k>", ":resize +2<CR>")
map("n", "<M-h>", ":vertical resize -2<CR>")
map("n", "<M-l>", ":vertical resize +2<CR>")
map("n", "<leader>h", "<C-W>s")
map("n", "<leader>v", "<C-W>v")
map("n", "<leader>q", ":bdelete<CR>")

-- searching
map("n", "\\", ":Telescope live_grep<cr>")
map("n", "#", ":Telescope grep_string<cr>")
map("n", "<leader>f", ":Telescope find_files<cr>")
map("n", "<leader>m", ":Telescope oldfiles<cr>")

-- Run tests
map("n", "<leader>tf", ":TestFile<CR>")
map("n", "<leader>tn", ":TestNearest<CR>")

-- quickfix
map("n", "<leader>ll", ":copen<CR>")
map("n", "<leader>ln", ":cnext<CR>")
map("n", "<leader>lp", ":cprev<CR>")

-- only git thing I need bind for
map("n", "<leader>gb", ":Git blame<CR>")

-- the right way to save things
map("n", "<C-s>", ":w<CR>")

-- black + isort
map("n", "<leader>b", ":!black %<CR>:!isort %<CR>")

-- navigating long wrapped lines
map("n", "<Down>", "gj")
map("n", "<Up>", "gk")

-- Indenting
map("v", "<Left>", "<gv")
map("v", "<Right>", ">gv")

-- remove search
map("n", "<CR><CR>", ":noh<CR>")

map("n", "<tab>", ":BufferLineCycleNext<CR>", {silent = true})
map("n", "<S-tab>", ":BufferLineCyclePrev<CR>", {silent = true})

-- Replace word with yanked word
map("n", "<C-p>", "ciw<C-r>0<ESC>")

-- improve default bindings
map("n", "Y", "y$")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ":", ":<c-g>u")
map("i", ")", ")<c-g>u")
map("i", "(", "(<c-g>u")

map("n", "<leader>k", ":m .-2<CR>==")
map("n", "<leader>j", ":m .+1<CR>==")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

local nvim_lsp = require "lspconfig"
local cmp = require "cmp"
local telescope = require "telescope"

local lsp_sig_config = {
    hint_enable = false,
    handler_opts = {
        border = "none"
    }
}

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<space>lk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>lw", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#44475a
      hi LspReferenceText cterm=bold ctermbg=red guibg=#44475a
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#44475a
      augroup lsp_document_highlight
	autocmd! * <buffer>
	autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end
end

cmp.setup(
    {
        snippet = {
            -- REQUIRED by cmp
            expand = function(args)
                fn["vsnip#anonymous"](args.body)
            end
        },
        mapping = {
            ["<Tab>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
            ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
            ["<C-j>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
            ["<C-k>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
            ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
        },
        sources = {
            {name = "nvim_lsp", max_item_count = 3},
            {name = "buffer", max_item_count = 2},
            {name = "path", max_item_count = 2}
        }
    }
)

nvim_lsp.pyright.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",
                diagnosticMode = "openFilesOnly"
            }
        }
    }
}

nvim_lsp.tsserver.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach
}

-- nvim_lsp.rust_analyzer.setup {
--     capabilities = require("cmp_nvim_lsp").default_capabilities(),
--     on_attach = on_attach,
-- 	cmd = {"rustup", "run", "stable", "rust-analyzer"}
-- }
--

local rt = require("rust-tools")


local rt_attach = function(client, bufnr)
  on_attach(client, bufnr) -- call my original lspconfig function first
  vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
  vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
end



rt.setup({
  server = {
    on_attach = rt_attach,
  },
})

require("nvim-treesitter.configs").setup {
    highlight = {enable = true},
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?"
        }
    }
}

require("lualine").setup {
    options = {
        icons_enabled = false,
        theme = "dracula",
        section_separators = "",
        component_separators = "|",
        globalstatus = true
    },
    sections = {
        lualine_a = {{"mode", upper = true}},
        lualine_b = {{"branch"}},
        lualine_c = {{"filename", file_status = true}, {"diagnostics", sources = {"nvim_diagnostic"}}},
        lualine_x = {"diff", "fileformat", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
    }
}

require("bufferline").setup {
    options = {
        diagnostics = "nvim_diagnostic",
        show_close_icon = false,
        always_show_bufferline = false
    }
}

require("gitsigns").setup {
    signs = {
        add = {hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
        change = {hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"},
        delete = {hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        topdelete = {hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        changedelete = {hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}
    },
    numhl = false,
    linehl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,
        ["n ]c"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns.actions".next_hunk()<CR>\''},
        ["n [c"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns.actions".prev_hunk()<CR>\''},
        ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
        -- Text objects
        ["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        ["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
    },
    watch_gitdir = {
        interval = 5000,
        follow_files = true
    },
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    word_diff = false
}

require("indent_blankline").setup {
    show_current_context = true,
    char = "┊"
}

require("colorizer").setup()

telescope.load_extension("fzf")
telescope.setup {
    defaults = {
        layout_strategy = "vertical",
        layout_config = {height = 0.95, width = 0.95}
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
}

-- Jump to last known position in file.
-- TODO: ignore gitcommit filetype.
local group = vim.api.nvim_create_augroup("jump_last_position", {clear = true})
vim.api.nvim_create_autocmd(
    "BufReadPost",
    {
        callback = function()
            local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
            if {row, col} ~= {0, 0} then
                vim.api.nvim_win_set_cursor(0, {row, 0})
            end
        end,
        group = group
    }
)

-- configure vimscript plugins
g["rooter_patterns"] = {".git", "Makefile", "compile_commands.json", "package.json", "Cargo.toml"}

cmd"let test#strategy = 'vtr'"
cmd"let g:test#custom_runners = {'python': ['Frappe']}"
cmd"let g:test#enabled_runners = ['python#frappe']"
cmd"let g:test#python#frappe#testsite = $CUR_SITE"
cmd"let g:vimwiki_list = [{'path': '~/wiki/', 'syntax': 'markdown', 'ext': '.md'}]"
cmd"let g:vimwiki_ext2syntax = {'.md': 'markdown'}"
cmd"let g:vimwiki_listsym_rejected = '✗'"

cmd"hi Normal guibg=NONE ctermbg=NONE"
