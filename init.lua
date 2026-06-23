vim.g.mapleader = " "
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4     
vim.opt.softtabstop = 4  
vim.opt.shiftwidth = 4  
vim.opt.expandtab = true
vim.opt.softtabstop = 0  
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "❯"
vim.opt.makeprg="./b.sh"
vim.opt.background  = "light"

vim.opt.title = true



vim.keymap.set("n", "<A-\'>", function()
    local dir =  vim.fn.getcwd() --require("oil").get_current_dir()
    local cmd = string.format("wezterm cli split-pane --cwd %s", vim.fn.shellescape(dir))
    vim.fn.system(cmd)
end)

vim.keymap.set("n", "<A-t>", function()
    local dir =  vim.fn.getcwd() --require("oil").get_current_dir()
    local cmd = string.format("wezterm cli spawn --cwd %s", vim.fn.shellescape(dir))
    vim.fn.system(cmd)
end)

vim.keymap.set("n", "<A-5>", function()
    local dir =  vim.fn.getcwd() --require("oil").get_current_dir()
    local cmd = string.format("wezterm cli split-pane --right --cwd %s", vim.fn.shellescape(dir))
    vim.fn.system(cmd)
end)

--:% ! column -t -s= -o=
vim.keymap.set("v", "<Space>=", ":% ! column -t -s= -o=" )
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set("n", "<Space>e", function()
    local user_input = vim.fn.input(" ")
    vim.cmd("cgetexpr system(\"" .. user_input .. "\")")
    vim.cmd("copen 25")
end)
--vim.keymap.set("n", "<Space>e", ":cgetexpr system(\" " )
vim.keymap.set("n", "<Space>c", ":copen 20<CR>" )
vim.keymap.set("n", "<Space>C", ":cclose<CR>" )
vim.keymap.set("n", "<Space>n", ":noh<CR>" )
vim.keymap.set({'n', 'i', 'v'}, '<Down>', '<C-e>', { noremap = true, silent = true })
vim.keymap.set({'n', 'i', 'v'}, '<Up>', '<C-y>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "-", ":Oil<CR>")
vim.keymap.set("n", "<C-l>", "zz")
vim.keymap.set("n", "<C-a>", "^")
vim.keymap.set("n", "<C-e>", "$")
vim.keymap.set("v", "<Space>y", "\"+y" )
vim.keymap.set("n", "<Space>h", "<C-w>h" )
vim.keymap.set("n", "<Space>l", "<C-w>l" )
vim.keymap.set("n", "<Space>k", "<C-w>k" )
vim.keymap.set("n", "<Space>j", "<C-w>j" )
vim.keymap.set("n", "<M-d>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-D>", "<cmd>cprevious<CR>")
vim.keymap.set("n", "<Space>m", function()
    vim.cmd("make")
    vim.cmd("copen 20")
end)
vim.keymap.set('n', '<Space>r', function()
    vim.cmd('tabnew')
    vim.cmd('terminal ./r.sh')
    vim.cmd('startinsert')
end )

vim.keymap.set("n", "<leader>s", function()
  vim.cmd("wa")
  vim.cmd("silent! !cd " .. vim.fn.getcwd() .. " && ctags ./*")
end )
vim.keymap.set("n", "<leader>w", function()
  vim.cmd("wa")
  vim.cmd("silent! !cd " .. vim.fn.getcwd() .. " && ctags -R .")
end )

vim.api.nvim_set_hl(0, 'Normal', {fg='#333333', bg= '#f2f2f2'})
vim.api.nvim_set_hl(0, 'MatchParen', {fg='#333333', bg= '#f2f2f2', reverse = true})
vim.api.nvim_set_hl(0, 'Comment', {fg='#339900', })
vim.api.nvim_set_hl(0, 'Delimiter', {fg='#333333', })
vim.api.nvim_set_hl(0, 'LineNr', {fg='#aaaaaa'})
vim.api.nvim_set_hl(0, 'CursorLineNr', {fg='#cb7d7b', bold = true})
vim.api.nvim_set_hl(0, 'CursorLine', {bg = "#c5d8dc",})

	
vim.api.nvim_set_hl(0, "Function", { fg = "#333333", })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#333333", })
vim.api.nvim_set_hl(0, "Type", { fg = "#333333", })
vim.api.nvim_set_hl(0, "Number", { fg = "#333333", })
vim.api.nvim_set_hl(0, "Statement", { fg = "#333333", bold = true })
vim.api.nvim_set_hl(0, "Preproc", { fg = "#333333", bold = true })
vim.api.nvim_set_hl(0, "Special", { fg = "#333333", })
vim.api.nvim_set_hl(0, "Structure", { fg = "#333333", })
vim.api.nvim_set_hl(0, "String", { fg = "#333333", })
vim.api.nvim_set_hl(0, "Operator", { fg = "#333333", })
vim.api.nvim_set_hl(0, 'MsgArea', { fg = '#333333' })
vim.api.nvim_set_hl(0, "@variable", { fg = "#333333", })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = "#333333", })
vim.api.nvim_set_hl(0, "Constant", { fg = "#333333", })
vim.api.nvim_set_hl(0, 'StatusLine', {bg = "#a1c4d0", fg = '#333333' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = "#333333",bg = '#b8b8b8' })
vim.o.showcmd=false

vim.api.nvim_create_autocmd("FileType", {
  pattern = "odin",
  callback = function()
    vim.opt_local.errorformat = "%f(%l:%c)%m"
  end,
})


vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*.h", "*.hpp" },
  callback = function()
    if vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == "" then
      local filename = vim.fn.expand("%:t:r")
      local guard_name = "_" .. string.upper(filename) .. "_H_"
      local lines = {
        "#ifndef " .. guard_name,
        "#define " .. guard_name,
        "",
        "",
        "#endif // " .. guard_name
      }
      vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
      vim.api.nvim_win_set_cursor(0, { 3, 0 })
    end
  end,
})
vim.pack.add({
    'https://github.com/stevearc/oil.nvim',

    'https://github.com/nvim-telescope/telescope.nvim', 
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim', 

    'https://github.com/NeogitOrg/neogit',
    'https://github.com/sindrets/diffview.nvim',
})



require("oil").setup({
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
  default_file_explorer = true,
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    "icon",
     "permissions",
     "size",
     "mtime",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  delete_to_trash = false,
  -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = false,
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  -- (:help prompt_save_on_select_new_entry)
  prompt_save_on_select_new_entry = true,
  -- Oil will automatically delete hidden buffers after this delay
  -- You can set the delay to false to disable cleanup entirely
  -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    -- Enable or disable LSP file operations
    enabled = true,
    -- Time to wait for LSP file operations to complete before skipping
    timeout_ms = 1000,
    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
    -- Set to "unmodified" to only save unmodified buffers
    autosave_changes = false,
  },
  -- Constrain the cursor to the editable parts of the oil buffer
  -- Set to `false` to disable, or "name" to keep it on the file names
  constrain_cursor = "editable",
  -- Set to true to watch the filesystem for changes and reload oil
  watch_for_changes = false,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["<C-l>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = false,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      local m = name:match("^%.")
      return m ~= nil
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
    -- Sort file names with numbers in a more intuitive order for humans.
    -- Can be "fast", true, or false. "fast" will turn it off for large directories.
    natural_order = "fast",
    -- Sort file and directory names case insensitive
    case_insensitive = false,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
    -- Customize the highlight group for the file name
    highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
      return nil
    end,
  },
  -- Extra arguments to pass to SCP when moving/copying files over SSH
  extra_scp_args = {},
  -- Extra arguments to pass to aws s3 when creating/deleting/moving/copying files using aws s3
  extra_s3_args = {},
  -- EXPERIMENTAL support for performing file operations with git
  git = {
    -- Return true to automatically git add/mv/rm files
    add = function(path)
      return false
    end,
    mv = function(src_path, dest_path)
      return false
    end,
    rm = function(path)
      return false
    end,
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    max_width = 0,
    max_height = 0,
    border = nil,
    win_options = {
      winblend = 0,
    },
    -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
    get_win_title = nil,
    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
    preview_split = "auto",
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the file preview window
  preview_win = {
    -- Whether the preview window is automatically updated when the cursor is moved
    update_on_cursor_moved = true,
    -- How to open the preview window "load"|"scratch"|"fast_scratch"
    preview_method = "fast_scratch",
    -- A function that returns true to disable preview on a file e.g. to avoid lag
    disable_preview = function(filename)
      return false
    end,
    -- Window-local options to use for preview window buffers
    win_options = {},
  },
  -- Configuration for the floating action confirmation window
  confirmation = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = nil,
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = nil,
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating SSH window
  ssh = {
    border = nil,
  },
  -- Configuration for the floating keymaps help window
  keymaps_help = {
    border = nil,
  },
})

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local neogit = require('neogit')
vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Open Neogit UI" })


