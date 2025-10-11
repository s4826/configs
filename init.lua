vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<F1>', ':bp<CR>')
vim.keymap.set('n', '<F2>', ':bn<CR>')
vim.keymap.set('n', 'do', ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'gd', ':lua require("goto-preview").goto_preview_definition()<CR>')
vim.keymap.set('n', 'gr', ':lua require("goto-preview").goto_preview_references()<CR>')
vim.keymap.set('n', 'gP', ':lua require("goto-preview").close_all_win()<CR>')
--vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
vim.g.loaded_matchparen = false
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.ts = 4
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.statusline = '%{getcwd()}%=%l:%c'

vim.cmd([[
    set nohlsearch
    set noswapfile
    colorscheme slate
]])

vim.diagnostic.config({
    float = {
        source = 'always',
        border = border
    }
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({timeout=250})
    end,
})

require('config.lazy')

require('goto-preview').setup({
  width = 120, -- Width of the floating window
  height = 15, -- Height of the floating window
  border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}, -- Border characters of the floating window
  default_mappings = false, -- Bind default mappings
  debug = false, -- Print debug information
  opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
  resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
  post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
  post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
  references = { -- Configure the telescope UI for slowing the references cycling window.
    provider = "telescope", -- telescope|fzf_lua|snacks|mini_pick|default
    telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
  },
  -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
  focus_on_open = true, -- Focus the floating window when opening it.
  dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
  force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
  bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
  stack_floating_preview_windows = true, -- Whether to nest floating windows
  same_file_float_preview = true, -- Whether to open a new floating window for a reference within the current file
  preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
  zindex = 1, -- Starting zindex for the stack of floating windows
  vim_ui_input = true, -- Whether to override vim.ui.input with a goto-preview floating window
})

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
    }, {
        { name = 'buffer' },
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('basedpyright', {
    capabilities = capabilities,
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = 'basic',
                inlayHints = {
                    callArgumentNames = 'true'
                }
            }
        }
    }
})
vim.lsp.enable('basedpyright')

vim.lsp.config('lua_ls', {
    capabilities = capabilities
})
vim.lsp.enable('lua_ls')

vim.lsp.config('gopls', {
    capabilities = capabilities
})
vim.lsp.enable('gopls')
