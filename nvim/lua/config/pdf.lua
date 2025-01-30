
local M = {}

-- Utility function to extract YAML front matter from current buffer.
local function get_front_matter()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local yaml_lines = {}
  local in_yaml = false

  for _, line in ipairs(lines) do
    if line:match("^%-%-%-$") and not in_yaml then
      in_yaml = true
    elseif line:match("^%-%-%-$") and in_yaml then
      break
    elseif in_yaml then
      table.insert(yaml_lines, line)
    end
  end

  local fm = {}
  for _, l in ipairs(yaml_lines) do
    -- Match "key: value"
    local key, value = l:match("^(%w+):%s*(.*)")
    if key and value then
      -- Strip surrounding quotes if present
      value = value:gsub("^['\"](.-)['\"]$", "%1")
      -- Just store the raw string in fm[key]
      fm[key] = value
    end
  end

  return fm
end

-- Main function to produce the PDF
local function export_to_pdf()
  local fm = get_front_matter()

  -- Read relevant fields from YAML
  local alias = fm.alias or ""     -- PDF title (if not empty)
  local date  = fm.date  or ""     -- PDF date  (if not empty)
  local author = fm.author or ""   -- PDF author (if not empty)

  -- "true" / "false" strings for toggles
  local number_sections = fm.number_sections or ""
  local keep_tex = fm.keep_tex or ""

  -- Get the current buffer name and directory
  local buf_name = vim.api.nvim_buf_get_name(0)
  local dir      = vim.fn.fnamemodify(buf_name, ":p:h")
  local base     = vim.fn.fnamemodify(buf_name, ":t:r")
  local pdf_out  = dir .. "/" .. base .. ".pdf"

  -- Strip YAML front matter from the buffer lines
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local yaml_end_idx = nil
  do
    local inside_yaml = false
    for i, line in ipairs(lines) do
      if line:match("^%-%-%-$") and not inside_yaml then
        inside_yaml = true
      elseif line:match("^%-%-%-$") and inside_yaml then
        yaml_end_idx = i
        break
      end
    end
  end

  local out_lines = {}
  local start_idx = (yaml_end_idx and yaml_end_idx + 1) or 1
  for i = start_idx, #lines do
    table.insert(out_lines, lines[i])
  end

  -- Write stripped content to a temp markdown file
  local temp_file = vim.fn.tempname() .. ".md"
  vim.fn.writefile(out_lines, temp_file)
  print("Temp Markdown file:", temp_file)

  -- Build Pandoc command
  local template_path = vim.fn.expand("/Users/hakon/work/config/bin/note_template.tex")
  local pandoc_cmd = {
    "pandoc",
    temp_file,
    "--pdf-engine=xelatex",
    "--template=" .. template_path,
    "-o", pdf_out,
  }

  -- Add metadata fields only if they are non-empty
  if alias ~= "" then
    table.insert(pandoc_cmd, "--metadata")
    table.insert(pandoc_cmd, "title=" .. alias)
  end
  if date ~= "" then
    table.insert(pandoc_cmd, "--metadata")
    table.insert(pandoc_cmd, "date=" .. date)
  end
  if author ~= "" then
    table.insert(pandoc_cmd, "--metadata")
    table.insert(pandoc_cmd, "author=" .. author)
  end

  -- Toggle section numbering if number_sections == "true"
  if number_sections == "true" then
    table.insert(pandoc_cmd, "--number-sections")
  end

  -- If keep_tex == "true", let Pandoc keep the intermediate .tex
  -- The .tex file will be named similarly to the PDF.
  if keep_tex == "true" then
    table.insert(pandoc_cmd, "--keep-tex")
  end

  -- Run pandoc with error capture
  local job_id = vim.fn.jobstart(pandoc_cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stderr = function(_, data, _)
      for _, line in ipairs(data) do
        if line and #line > 0 then
          print("Pandoc error:", line)
        end
      end
    end,
    on_exit = function(_, exit_code, _)
      -- Comment this out if you want to keep the .md temp file
      -- vim.fn.delete(temp_file)

      if exit_code == 0 then
        print("PDF generated at:", pdf_out)
        if keep_tex == "true" then
          print("Kept intermediate .tex file next to the PDF.")
        end
      else
        print("Error generating PDF. Check pandoc error messages or .tex file.")
      end
    end
  })
end

-- Create a user command "ExportNotePDF" that just calls export_to_pdf()
vim.api.nvim_create_user_command('ExportNotePDF', function(opts)
  export_to_pdf()
end, { nargs='*' })

return M
--
-- local M = {}
--
-- -- Utility function to extract YAML front matter from current buffer
-- -- and return it as a Lua table.
-- local function get_front_matter()
--   local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--   local yaml_lines = {}
--
--   local in_yaml = false
--   for _, line in ipairs(lines) do
--     if line:match("^%-%-%-$") and not in_yaml then
--       in_yaml = true
--     elseif line:match("^%-%-%-$") and in_yaml then
--       break
--     elseif in_yaml then
--       table.insert(yaml_lines, line)
--     end
--   end
--
--   -- Simple YAML parse: for more complex parsing consider a dedicated Lua YAML library.
--   -- We assume straightforward key: value structure here.
--   local front_matter = {}
--   for _, l in ipairs(yaml_lines) do
--     -- Match keys and values
--     local key, value = l:match("^(%w+):%s*(.*)")
--     if key and value then
--       -- Remove surrounding quotes if present
--       value = value:gsub("^['\"](.-)['\"]$", "%1")
--       -- For lists (like tags or folder), parse them as arrays
--       if value:match("^%[") or value:match("^- ") then
--         -- This is simplistic; for complex structures, consider a YAML parser
--         local list_values = {}
--         if value:match("^- ") then
--           -- multiple lines format
--           -- You might need to handle multi-line arrays from the original lines block
--           -- For simplicity, assume arrays are on the same line or handle them above
--         else
--           -- single-line array [car, something]
--           value = value:gsub("^%[", ""):gsub("%]$", "")
--           for item in value:gmatch("[^,]+") do
--             item = item:gsub("^%s+", ""):gsub("%s+$", "")
--             table.insert(list_values, item)
--           end
--         end
--         front_matter[key] = list_values
--       else
--         front_matter[key] = value
--       end
--     end
--   end
--   return front_matter
-- end
--
-- -- Function to produce the PDF
-- -- Optional arguments:
-- --   args.date: custom date (omit if "")
-- --   args.author: custom author (omit if "")
--
--
-- local function export_to_pdf(args)
--   local fm = get_front_matter()
--
--   -- Figure out the date:
--   -- If user explicitly typed "date=", skip date entirely
--   -- If user typed "date=xyz", use that
--   -- If user didn't type anything for date, use fm.date if it exists
--   local date
--   if args.date == nil then
--     -- user didn't specify date in the :ExportNotePDF command
--     date = fm.date  -- from front matter
--   elseif args.date == "" then
--     -- user explicitly typed date=, so omit date entirely
--     date = nil
--   else
--     -- user specified some date (e.g. date=2024-11-01)
--     date = args.date
--   end
--
--   -- Similarly for author
--   local author
--   if args.author == nil then
--     author = "Håkon Otneim"  -- default if not specified
--   elseif args.author == "" then
--     author = nil  -- omit author entirely
--   else
--     author = args.author
--   end
--
--   local alias = fm.alias or "Untitled"
--
--   -- Current buffer info
--   local buf_name = vim.api.nvim_buf_get_name(0)
--   local dir = vim.fn.fnamemodify(buf_name, ":p:h")
--   local base = vim.fn.fnamemodify(buf_name, ":t:r")
--   local pdf_out = dir .. "/" .. base .. ".pdf"
--
--   -- Strip YAML from the buffer lines (but do NOT remove any headings)
--   local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--   local out_lines = {}
--   local yaml_end_idx = nil
--
--   do
--     local inside_yaml = false
--     for i, line in ipairs(lines) do
--       if line:match("^%-%-%-$") and not inside_yaml then
--         inside_yaml = true
--       elseif line:match("^%-%-%-$") and inside_yaml then
--         yaml_end_idx = i
--         break
--       end
--     end
--   end
--
--   local start_idx = (yaml_end_idx and yaml_end_idx + 1) or 1
--   for i = start_idx, #lines do
--     table.insert(out_lines, lines[i])
--   end
--
--   local temp_file = vim.fn.tempname() .. ".md"
--   print("Temp Markdown file saved at: " .. temp_file)
--   vim.fn.writefile(out_lines, temp_file)
--
--   -- Pandoc metadata
--   local meta_args = {
--     '--metadata', 'title=' .. alias
--   }
--   if date and date ~= "" then
--     table.insert(meta_args, '--metadata')
--     table.insert(meta_args, 'date=' .. date)
--   end
--   if author and author ~= "" then
--     table.insert(meta_args, '--metadata')
--     table.insert(meta_args, 'author=' .. author)
--   end
--
--   local template_path = vim.fn.expand("/Users/hakon/work/config/bin/note_template.tex")
--   local pandoc_cmd = {
--     'pandoc', temp_file,
--     '--pdf-engine=xelatex',
--     '--template=' .. template_path,
--     '-o', pdf_out,
--   }
--   --
--   -- Add numbering if user requested it
--   if numbering == "true" then
--     table.insert(pandoc_cmd, '--number-sections')
--   end
--
--   for _, ma in ipairs(meta_args) do
--     table.insert(pandoc_cmd, ma)
--   end
--
-- local job_id = vim.fn.jobstart(pandoc_cmd, {
--   on_stderr = function(_, data, _)
--     for _, line in ipairs(data) do
--       if line and #line > 0 then
--         print("Pandoc error: " .. line)
--       end
--     end
--   end,
--   on_exit = function(_, exit_code, _)
--     -- vim.fn.delete(temp_file)
--     if exit_code == 0 then
--       print("PDF generated at: " .. pdf_out)
--     else
--       print("Error generating PDF. Check pandoc command and template.")
--     end
--   end
-- })
-- end
--
-- -- Create a user command that can be used in Neovim
-- -- Usage:
-- --   :ExportNotePDF
-- --   :ExportNotePDF date=2024-11-01 author="John Doe"
-- --   :ExportNotePDF date= author=  (to omit these fields)
--
-- vim.api.nvim_create_user_command('ExportNotePDF', function(opts)
--   local args = {date="", author="", numbering=""}
--   for _, v in ipairs(opts.fargs) do
--     local k, val = v:match("^(%a+)=(.*)")
--     if k and val then
--       if k == "date" then
--         args.date = val
--       elseif k == "author" then
--         args.author = val
--       elseif k == "numbering" then
--         args.numbering = val
--       end
--     end
--   end
--   export_to_pdf(args)
-- end, {
--     nargs='*'
-- })
-- return M
