local ls = require('luasnip')

require("luasnip.loaders.from_vscode").load({ include =
{
  "html", "javascript", "typescript", "java", "typescriptreact",
  "javascriptreact", "json", "rust", "go"
}
}) -- Load snippets from vscode

ls.config.set_config({
  history = true,
  updateevents = 'TextChanged, TextChangedI',
  enable_autosnippets = true,
  ext_opts = {
    [require('luasnip.util.types').choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } },
      },
    },
  },
})

-- Key Maps
vim.keymap.set({ "i", "s" }, "<a-p>", function()
  if ls.expand_or_jumpable() then
    ls.expand()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
