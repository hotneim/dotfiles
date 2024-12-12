--
-- Various functions are collected here
--
-- Custom function to search specifically in the notes folder
local search_notes = function()
  require('telescope.builtin').find_files({
    prompt_title = "Search Notes",
    cwd = "/Users/hakon/work/notes/zk/",
  })
end

local live_grep_notes = function()
  require('telescope.builtin').live_grep({
    prompt_title = "Grep Notes",
    cwd = "/Users/hakon/work/notes/zk/",
  })
end

-- Define a global function to strip a single wikilink under the cursor
_G.strip_wikilink = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local s_start, s_end = line:find("%[%[.-%]%]")
  
  if s_start and s_end then
    local link_content = line:sub(s_start + 2, s_end - 2)
    local link, text = link_content:match("(.-)|(.*)")
    if not text then
      text = link_content
    end
    local new_line = line:sub(1, s_start - 1) .. text .. line:sub(s_end + 1)
    vim.api.nvim_set_current_line(new_line)
  else
    print("No wikilink found under cursor")
  end
end

-- Define a global function to strip wikilinks in visual selection
_G.strip_wikilinks_in_selection = function()
  local _, start_row, _, _ = unpack(vim.fn.getpos("'<"))
  local _, end_row, _, _ = unpack(vim.fn.getpos("'>"))
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  
  for i, line in ipairs(lines) do
    local s_start, s_end = line:find("%[%[.-%]%]")
    while s_start and s_end do
      local link_content = line:sub(s_start + 2, s_end - 2)
      local link, text = link_content:match("(.-)|(.*)")
      if not text then
        text = link_content
      end
      line = line:sub(1, s_start - 1) .. text .. line:sub(s_end + 1)
      s_start, s_end = line:find("%[%[.-%]%]")
    end
    lines[i] = line
  end
  
  vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, lines)
end

-- Map the keybinding to the function for normal mode
-- vim.api.nvim_set_keymap('n', '<leader>ms', ':lua _G.strip_wikilink()<CR>', { noremap = true, silent = true })

-- Map the keybinding to the function for visual mode
vim.api.nvim_set_keymap('v', '<leader>ma', ":<C-u>lua _G.strip_wikilinks_in_selection()<CR>", { noremap = true, silent = true })

