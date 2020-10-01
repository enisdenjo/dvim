local nvim_lsp = require('nvim_lsp')
local lsp_status = require('lsp-status')
local diagnostic = require('diagnostic')
local completion = require('completion')

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  diagnostic.on_attach(client, bufnr)
  completion.on_attach(client, bufnr)

  -- Keybindings
  vim.fn.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap = true, silent = true})

  -- Bind omnifunc
  vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc');
end

nvim_lsp.vimls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}
nvim_lsp.tsserver.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}
nvim_lsp.html.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}
nvim_lsp.cssls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}
nvim_lsp.gopls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}
nvim_lsp.sumneko_lua.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}
