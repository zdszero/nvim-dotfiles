local backend = "deepseek"

-- 1. Define your data first
local providers = {
  deepseek = {
    model = "deepseek-chat",
    host = "https://api.deepseek.com/chat/completions",
    api_key = "sk-2cb961dfa05145faa5c577d04cd6d66d",
  },
  qwen = {
    model = "qwen-max",
    host = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
    api_key = "sk-ec50424a8f4c4774b487d87a651d0baa",
  },
}

local p = providers[backend]

-- 2. Create a generic command generator to avoid repetition
local function make_command(config)
  return function(options)
    -- gen.nvim automatically replaces $body with the JSON payload
    -- Use the host from our config table directly to be safe
    return "curl --silent --no-buffer -X POST " ..
           "-H 'Content-Type: application/json' " ..
           "-H 'Authorization: Bearer " .. (config.api_key or "") .. "' " ..
           config.host .. " -d $body"
  end
end

-- 3. Setup the plugin
require("gen").setup({
  model = p.model,
  host = p.host,
  quit_map = "q",
  retry_map = "<c-r>",
  accept_map = "<cr>",
  display_mode = "horizontal-split",
  show_prompt = false,
  show_model = false,
  no_auto_close = false,
  file = false,
  hidden = false,
  
  -- Pass the generated command function
  command = make_command(p),

  result_filetype = "markdown",
  debug = false
})
