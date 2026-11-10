return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      { name = "personal", path = "~/vaults/personal" },
    },
  },
}
