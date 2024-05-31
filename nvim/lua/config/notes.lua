--
-- Functions for creating notes via the note scripts
--

-- Function to run the 'nd' shell script with a flag and open the daily note
local function open_daily_note()
  -- Run the shell script with the --no-open flag
  vim.fn.system('nd --no-open')

  -- Construct the filename based on today's date
  local date = os.date("%Y-%m-%d")
  local filename = '/Users/hakon/work/notes/inbox/' .. date .. '.md'

  -- Open the file in a new buffer
  vim.cmd('edit ' .. filename)
end

-- Set up the key mapping
vim.api.nvim_set_keymap('n', '<leader>nd', '', {
  noremap = true,
  silent = true,
  callback = open_daily_note,
  desc = "[d]aily note"
})


local function run_general_note()
  -- Prompt for the title
  local title = vim.fn.input('Enter note title: ')
  if title == "" then
    print("No title provided. Command cancelled.")
    return
  end

  -- Optional: Prompt for a custom date
  local custom_date = vim.fn.input('Enter custom date (YYYY-MM-DD) or leave empty: ')
  if custom_date ~= "" and not custom_date:match("^%d%d%d%d%-%d%d%-%d%d$") then
    print("Invalid date format. Command cancelled.")
    return
  end

  -- Prepare the command
  local cmd = 'nn '
  if custom_date ~= "" then
    cmd = cmd .. custom_date .. ' '                  -- Remove shellescape if causing issues with extra quotes
  end
  cmd = cmd .. ' "' .. title .. '" ' .. ' --no-open' -- Append the title and the flag at the end

  print("Running command: " .. cmd)                  -- Debug: print the command

  -- Run the shell script
  local result = vim.fn.system(cmd)
  print("Command output: " .. result) -- Print output for debugging

  -- Construct the filename based on the input and today's date
  local date = custom_date ~= "" and custom_date or os.date("%Y-%m-%d")
  local formatted_title = title:gsub("%s+", "-"):lower() -- Replace spaces with hyphens and convert to lower case
  local filename = '/Users/hakon/work/notes/inbox/' .. date .. '_' .. formatted_title .. '.md'

  -- Open the file in a new buffer
  if vim.fn.filereadable(filename) == 1 then
    vim.cmd('edit ' .. filename)
  else
    print("File does not exist: " .. filename)
  end
end

-- Set up the key mapping
vim.api.nvim_set_keymap('n', '<leader>nn', '', {
  noremap = true,
  silent = true,
  callback = run_general_note,
  desc = "[n]ew note"
})

local function run_reading_note()
  -- Prompt for the document type
  local doc_type = vim.fn.input('Enter document type (B, P, A for Book, Paper, Article): ')
  if doc_type == "" or not string.match(doc_type, "^[BbPpAa]$") then
    print("Invalid or no document type provided. Command cancelled.")
    return
  end

  -- Prompt for the author
  local author = vim.fn.input('Enter author name: ')
  if author == "" then
    print("No author provided. Command cancelled.")
    return
  end

  -- Prompt for the title
  local title = vim.fn.input('Enter note title: ')
  if title == "" then
    print("No title provided. Command cancelled.")
    return
  end

  -- Prepare the command
  local cmd = 'nr ' .. doc_type .. ' "' .. author .. '" ' .. '"' .. title .. '"' .. ' --no-open'

  print("Running command: " .. cmd) -- Debug: print the command

  -- Run the shell script
  local result = vim.fn.system(cmd)
  print("Shell command output: " .. result) -- Print output for debugging

  -- Normalize inputs for filename construction
  local normalized_doc_type = string.lower(doc_type)
  local formatted_author = string.gsub(string.lower(author), "%s+", "-")
  local formatted_title = string.gsub(string.lower(title), "%s+", "-")

  -- Construct the filename
  local filename = '/Users/hakon/work/notes/inbox/' ..
      normalized_doc_type .. '_' .. formatted_author .. '_' .. formatted_title .. '.md'

  -- Open the file in a new buffer
  if vim.fn.filereadable(filename) == 1 then
    vim.cmd('edit ' .. filename)
  else
    print("File does not exist: " .. filename)
  end
end

-- Set up the key mapping
vim.api.nvim_set_keymap('n', '<leader>nr', '', {
  noremap = true,
  silent = true,
  callback = run_reading_note,
  desc = "[r]eading note"
})

-- move file in current buffer to accepted folder
vim.keymap.set("n", "<leader>nk", ":!mv '%:p' /Users/hakon/work/notes/inbox/accepted/<cr>:bd<cr>",
  { desc = "accept note" })

-- delete file in current buffer
vim.keymap.set("n", "<leader>nx", ":!rm '%:p'<cr>:bd<cr>", { desc = "delete note" })

