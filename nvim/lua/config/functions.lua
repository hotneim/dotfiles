--
-- Various functions are collected here
--

-- Search functions for the notes
vim.api.nvim_create_user_command('TelescopeLiveGrepMeetings', function()
  require('telescope.builtin').live_grep({
    search_dirs = { "/Users/hakon/work/notes/zk/meetings/" }
  })
end, {})

vim.api.nvim_create_user_command('TelescopeLiveGrepDaily', function()
  require('telescope.builtin').live_grep({
    search_dirs = { "/Users/hakon/work/notes/zk/daily/" }
  })
end, {})

vim.api.nvim_create_user_command('TelescopeLiveGrepReading', function()
  require('telescope.builtin').live_grep({
    search_dirs = { "/Users/hakon/work/notes/zk/reading/" }
  })
end, {})

vim.api.nvim_create_user_command('TelescopeLiveGrepNotes', function()
  require('telescope.builtin').live_grep({
    search_dirs = { "/Users/hakon/work/notes/zk/" }
  })
end, {})

