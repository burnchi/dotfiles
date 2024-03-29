local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Javascript Snippets", { clear = true })
local file_pattern = "*.js"

local function cs(trigger, nodes, opts) --{{{
  local snippet = s(trigger, nodes)
  local target_table = snippets

  local pattern = file_pattern
  local keymaps = {}

  if opts ~= nil then
    -- check for custom pattern
    if opts.pattern then
      pattern = opts.pattern
    end

    -- if opts is a string
    if type(opts) == "string" then
      if opts == "auto" then
        target_table = autosnippets
      else
        table.insert(keymaps, { "i", opts })
      end
    end

    -- if opts is a table
    if opts ~= nil and type(opts) == "table" then
      for _, keymap in ipairs(opts) do
        if type(keymap) == "string" then
          table.insert(keymaps, { "i", keymap })
        else
          table.insert(keymaps, keymap)
        end
      end
    end

    -- set autocmd for each keymap
    if opts ~= "auto" then
      for _, keymap in ipairs(keymaps) do
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = pattern,
          group = group,
          callback = function()
            vim.keymap.set(keymap[1], keymap[2], function()
              ls.snip_expand(snippet)
            end, { noremap = true, silent = true, buffer = true })
          end,
        })
      end
    end
  end

  table.insert(target_table, snippet) -- insert snippet into appropriate table
end
-- 箭头函数1  可以修改分割符号
cs(
  "cafe",
  fmt(
    [[
      const [] = ([]) => {
         [] 
      }
  ]],
    {
      -- i(1) is at nodes[1], i(2) at nodes[2].
      i(1, ""),
      i(2, ""),
      i(3, ""),
    },
    {
      delimiters = "[]",
    }
  )
)
-- 箭头函数2
cs(
  "af",
  fmt(
    [[
    ({}) => {}
  ]],
    {
      i(1, ""),
      i(2, ""),
    }
  )
)
-- 组件类型定义
cs(
  "interComp",
  fmt(
    [[
interface {}{{
  children: React.ReactNode;
  className?: string;
}}
  ]],
    {
      i(1, ""),
    }
  )
)
-- twmerge样式合并
cs(
  "twmerge",
  fmt(
    [[
    twMerge("{}", className)
  ]],
    {
      i(1, ""),
    }
  )
)

return snippets, autosnippets
