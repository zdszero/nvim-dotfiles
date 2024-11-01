local template = {
  -- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
  sources = {
    ultisnips = {
      vim.fn.stdpath("config") .. "/UltiSnips",
    },
  },
  output = {
    -- Specify the output formats and paths
    snipmate = {
      vim.fn.stdpath("config") .. "/snippets",
    },
  },
}

require("snippet_converter").setup {
  templates = { template },
  -- To change the default settings (see configuration section in the documentation)
  -- settings = {},
}
