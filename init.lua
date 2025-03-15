vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<F1>', ':split<CR><C-w>5+<C-w><C-w>:terminal<CR>:Neotree<CR>')
vim.keymap.set('n', 'do', ':lua vim.diagnostic.open_float()<CR>')
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

require('config.lazy')
require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = { 'lua_ls', 'basedpyright' },
    automatic_installation = true
}

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

require('lspconfig').basedpyright.setup({
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
require('lspconfig').lua_ls.setup({
    capabilities = capabilities
})
