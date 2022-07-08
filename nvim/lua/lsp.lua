require('cmp').setup {
  sources = {
    { name = 'cmp_tabnine' },
    { name = 'nvim_lsp' }
  },
}

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]

vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.diagnostic.config({
  virtual_text = {
    source = "always", -- Or "if_many"
  },
  float = {
    source = "always", -- Or "if_many"
    border = "rounded",
    style = "minimal",
    prefix = "",
    header = "",
    format = function(d)
      local t = vim.deepcopy(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
      end
      return t.message
    end,
  },
  peek = {
    max_height = 15,
    max_width = 30,
    context = 10,
  },
})

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local on_attach = function(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_lines = 1000;
  max_num_results = 20;
  sort = true;
  run_on_every_keystroke = true;
  snippet_placeholder = '..';
})

local lspkind = require('lspkind')
-- lspkind.init({
--  mode = 'symbol_text',
--  preset = 'codicons',
-- })

local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    --    ["<Tab>"] = cmp.mapping(function(fallback)
    --      if cmp.visible() then
    --        cmp.select_next_item()
    --  elseif luasnip.expand_or_jumpable() then
    --    luasnip.expand_or_jump()
    -- elseif has_words_before() then
    --   cmp.complete()
    --   fallback()
    -- else
    -- end
    -- end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        -- elseif luasnip.jumpable(-1) then
        -- luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

  }),

  formatting = { -- lspkind
    format = lspkind.cmp_format({
      mode = 'symbol', -- show symbol and text annotations
      maxwidth = 100, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      border = "rounded",

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          cmp_tabnine = "[TN]",
          luasnip = "[LUS]",
        })[entry.source.name]
        return vim_item
      end
    })
  },

  sources = cmp.config.sources({
    { name = 'cmp_tabnine' },
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['tsserver'].setup { on_attach = on_attach, capabilities = capabilities, flags = lsp_flags }

-- lua

local sumneko_root_path = "/home/dytan/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
require('lspconfig')['sumneko_lua'].setup({
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  capabilities = capabilities,
  flags = lsp_flags,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      completion = { enable = true, callSnippet = "Both" },
      diagnostics = {
        enable = true,
        globals = { 'vim', 'describe' },
        disable = { "lowercase-global" }
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          [vim.fn.expand('/usr/share/awesome/lib')] = true
        },
        -- adjust these two values if your performance is not optimal
        maxPreload = 2000,
        preloadFileSize = 1000
      }
    }
  },
  on_attach = on_attach
})

-- jsonls
local jsoncapabilities = vim.lsp.protocol.make_client_capabilities()
jsoncapabilities.textDocument.completion.completionItem.snippetSupported = true

require('lspconfig')['jsonls'].setup {
  jsoncapabilities = jsoncapabilities,
  capabilities = capabilities,
  flags = lsp_flags,
  -- capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true
  },
  single_file_support = true
}

-- html
local htmlcapabilities = vim.lsp.protocol.make_client_capabilities()
htmlcapabilities.textDocument.completion.completionItem.snippetSupported = true

require('lspconfig')['html'].setup {
  htmlcapabilities = htmlcapabilities,
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  },
  settings = {},
  single_file_support = true
}
