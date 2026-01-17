-- Add to your init.lua or in a separate file in ~/.config/nvim/lua/
vim.api.nvim_create_user_command('On', function(opts)
  local filename = opts.args
  if filename == "" then
    print("Error: A file name must be set")
    return
  end
  
  -- Replace spaces with underscores
  filename = filename:gsub(" ", "_")
  
  -- Add date prefix
  local dated_name = os.date("%Y-%m-%d") .. "-" .. filename .. ".md"
  
  local vault_inbox = "/home/suvar/ObsidianZotero/mark_obsidian/notes"
  local full_path = vault_inbox .. "/" .. dated_name
  
  -- Create the file
  vim.fn.system("touch " .. vim.fn.shellescape(full_path))
  
  -- Open it in current buffer
  vim.cmd("edit " .. vim.fn.fnameescape(full_path))
end, {
  nargs = 1,
  desc = "Create and open a new dated note"
})
