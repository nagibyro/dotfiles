local tel = require("telescope")

tel.setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  }
})

pcall(tel.load_extension, 'fzf')
pcall(tel.load_extension, 'projects')

