require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    -- adaptive_size = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
