_G.OctoEditCurrentPR = function()
  local prNumber = vim.fn.system("echo $(gh pr view --json number -t '{{.number}}')")
  vim.cmd(":execute 'Octo pr edit ' .. " .. prNumber)
end

return {
  -- Add Octo.nvim
  -- https://github.com/tpope/vim-rails
  {
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup()
    end,
    keys = {
      { "<leader>op", [[:lua OctoEditCurrentPR()<CR>]], desc = "Edit current PR" },
      { "<leader>oc", ":Octo pr checks<CR>", desc = "View checks of current PR" },
    },
  },
}
