-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume last Telescope window" }
)

_G.copyFilePath = function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  local line_number = vim.fn.line(".")
  vim.fn.setreg("*", file_path .. ":" .. line_number)
end

-- copy current filepath with line number to clipboard
vim.api.nvim_set_keymap("n", "<leader>p", [[:lua copyFilePath()<CR>]], { noremap = true, silent = true })

_G.appendSuffix = function(suffix)
  removeTODOSuffix()
  local line = vim.fn.getline(".")
  vim.fn.setline(".", line .. " => " .. suffix)
end

vim.api.nvim_set_keymap("n", "<leader>D", [[:lua appendSuffix('DONE')<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>W", [[:lua appendSuffix('WIP')<CR>]], { noremap = true, silent = true })

_G.removeTODOSuffix = function()
  local line = vim.fn.getline(".")
  local new_line = vim.fn.substitute(line, "\\s*=>\\s.*$", "", "")
  vim.fn.setline(".", new_line)
end

vim.api.nvim_set_keymap("n", "<leader>U", [[:lua removeTODOSuffix()<CR>]], { noremap = true, silent = true })
