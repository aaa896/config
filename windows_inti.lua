vim.api.nvim_set_hl(0, 'Comment', { fg = '#808080', bg = 'NONE', italic = false, bold = false,
	undercurl = false, reverse = true      	})
    



-- ~/.config/nvim/init.lua
-- Do not set any colorscheme or custom highlights
-- This ensures Neovim uses the terminal's colors
vim.cmd("set relativenumber")
vim.g.mapleader = " "
vim.opt.backup = false       -- Disable backup files
vim.opt.writebackup = false  -- Disable backup before overwriting
vim.opt.swapfile = false     -- Disable swap files
vim.opt.shada = ''

vim.keymap.set("n", "<leader>pv", function()
vim.opt.splitbelow = true
    vim.cmd("split");
	vim.cmd("Oil")
	vim.cmd("set relativenumber")
end)

vim.opt.shell = "powershell.exe"
vim.opt.shellxquote = ""
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellpipe = "| Out-File -Encoding UTF8 %s"
vim.opt.shellredir = "| Out-File -Encoding UTF8 %s"


local home = os.getenv("USERPROFILE") -- Get the home directory on Windows
local file = home .. "\\nvim_cwd" -- Path to the output file

-- Function to write the current working directory to the file
local function write_cwd_to_file()
    local home = os.getenv("USERPROFILE") -- Get the home directory on Windows
    local file = home .. "\\nvim_cwd" -- Path to the output file
    local cwd = vim.fn.getcwd() -- Get the current working directory
    local command = string.format('echo "%s" > "%s"', cwd, file)
    os.execute(command)
    print("Current working directory written to nvim_cwd")
end

-- Map <leader>d to the function in normal mode
vim.api.nvim_set_keymap('n', '<leader>d', ':lua write_cwd_to_file()<CR>', { noremap = true, silent = true })



vim.api.nvim_set_keymap('n', '<C-x><C-f>', ':tcd ', { noremap = true, silent = true })

-- Close the current split
vim.api.nvim_set_keymap('n', '<leader>qc', ':q<CR>', { noremap = true, silent = true })
-- Move to the next split
vim.api.nvim_set_keymap('n', '<leader>sn', ':wincmd w<CR>', { noremap = true, silent = true })

-- Move to the previous split
vim.api.nvim_set_keymap('n', '<leader>sp', ':wincmd p<CR>', { noremap = true, silent = true })

-- Function to center the screen around the cursor
function _G.center_cursor()
	vim.cmd('normal! zz')
end

--For ctrl a/e end and start
-- Normal mode mappings
vim.keymap.set('n', '<C-e>', '$', { noremap = true, silent = true })
vim.keymap.set('n', '<C-a>', '^', { noremap = true, silent = true })

vim.keymap.set('v', '<C-e>', '$', { noremap = true, silent = true })
vim.keymap.set('v', '<C-a>', '^', { noremap = true, silent = true })

-- Insert mode mappings
vim.keymap.set('i', '<C-e>', '<C-o>$', { noremap = true, silent = true })
vim.keymap.set('i', '<C-a>', '<C-o>^', { noremap = true, silent = true })


-- Move selected lines down with Ctrl+j
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move selected lines up with Ctrl+k
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })



vim.keymap.set('n', '<C-l>', 'zz', { noremap = true, silent = true })








vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
   
    -- Mapping for running file under cursor after changing directory
    vim.api.nvim_buf_set_keymap(0, 'n', 'J', ':lua vim.cmd("cd " .. vim.fn.expand("%:p:h"))<CR>:lua RunFileUnderCursorInNetrw()<CR>', { noremap = true, silent = true })
  end
})


-- Function to run file under the cursor
function RunFileUnderCursorInNetrw()
  -- Get the file under the cursor in netrw
  local file = vim.fn.expand('<cfile>') 
  if file ~= "" then
    vim.cmd('!./' .. vim.fn.fnameescape(file))
  else
    print("No file selected or invalid file")
  end
end


--function _G.MyTabLine()
--  local s = ''
--  for i = 1, vim.fn.tabpagenr('$') do
--    local current = vim.fn.tabpagenr() == i and '%#TabLineSel#' or '%#TabLine#'
--    local tab_name = (vim.fn.tabpagebuflist(i)[1] ~= -1 and vim.fn.expand('%:p:h') or '')
--    s = s .. current .. ' ' .. tab_name .. ' '
--  end
--  return s
--end


vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0


vim.opt.nu = true
vim.opt.relativenumber = true
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
vim.opt.wrap = false


vim.opt.termguicolors =true

--crtrl in insert to move
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- Remap arrow keys for scrolling
vim.api.nvim_set_keymap('n', '<Up>', '<C-y>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '<C-e>', { noremap = true, silent = true })






vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8






-- LAZY.NVIM-----------------------------------------------------------------------------------------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup mapleader and maplocalleader before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
     {
        'nvim-treesitter/nvim-treesitter',

    },



    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },



  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
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
  skip_confirm_for_simple_edits = true,
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
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
    ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = false,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
    -- Sort file names in a more intuitive order for humans. Is less performant,
    -- so you may want to set to false if you work with large directories.
    natural_order = true,
    -- Sort file and directory names case insensitive
    case_insensitive = false,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  -- Extra arguments to pass to SCP when moving/copying files over SSH
  extra_scp_args = {},
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
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
    preview_split = "auto",
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the actions floating preview window
  preview = {
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
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- Whether the preview window is automatically updated when the cursor is moved
    update_on_cursor_moved = true,
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating SSH window
  ssh = {
    border = "rounded",
  },
  -- Configuration for the floating keymaps help window
  keymaps_help = {
    border = "rounded",
  },
})






local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fh', function()
  require('telescope.builtin').find_files({ cwd = os.getenv('USERPROFILE') }) -- Home directory on Windows
end, { desc = 'Telescope find files in home dir' })
vim.keymap.set('n', '<leader>fr', function()
  require('telescope.builtin').find_files({ cwd = 'C:\\' }) -- Root of C: drive
end, { desc = 'Telescope find files from C:\\' })






--ts colors
--
--
--
--
---- Set the background and text color for normal text
---purple
vim.api.nvim_set_hl(0, 'TSString', { fg = '#d4adcf', bg = NONE })
vim.api.nvim_set_hl(0, 'TSNumber', { fg = '#d4adcf', bg = NONE })
vim.api.nvim_set_hl(0, '@number', { fg = '#d4adcf', bg = NONE })
---white
vim.api.nvim_set_hl(0, '@lsp.type.variable', { fg = '#f9d4bb', bg = none })
vim.api.nvim_set_hl(0, '@lsp.type.parameter', { fg = '#f9d4bb', bg = none })
vim.api.nvim_set_hl(0, '@variable', { fg = '#f9d4bb', bg = NONE })
vim.api.nvim_set_hl(0, '@constant', { fg = '#f9d4bb', bg = NONE })
vim.api.nvim_set_hl(0, '@operator', { fg = '#f9d4bb', bg = NONE })
vim.api.nvim_set_hl(0, '@property', { fg = '#f9d4bb', bg = NONE })
vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = '#f9d4bb', bg = NONE })
vim.api.nvim_set_hl(0, '@Delimiter', { fg = '#f9d4bb', bg = NONE })
vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = '#f9d4bb', bg = NONE })
vim.api.nvim_set_hl(0, 'TSComment', { fg = '#463f3a', bg = '#f9d4bb' })
vim.api.nvim_set_hl(0, 'TSError', { fg = '#f9d4bb', bg = '#9d0006', bold = false })
vim.api.nvim_set_hl(0, 'TSFunction', { fg = '#f9d4bb', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSVariable', { fg = '#f9d4bb', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSSpecial', { fg = '#f9d4bb', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@function.call', { fg = '#f9d4bb', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@keyword.function.rust', { fg = '#f9d4bb', bg = NONE, bold = false })
--green
vim.api.nvim_set_hl(0, 'TSType', { fg = '#8ec07c', bold = false, bg = '#463f3a' })
vim.api.nvim_set_hl(0, 'TSConstant', { fg = '#8ec07c', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@type.builtin', { fg = '#8ec07c', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@type', { fg = '#8ec07c', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@keyword.modifier', { fg = '#8ec07c', bg = NONE, bold = false })

vim.api.nvim_set_hl(0, 'TSFormat', { fg = '#000bb2', italic = true, bg = '#463f3a' })
--orange
vim.api.nvim_set_hl(0, '@keyword.conditional', { fg = '#c18c5d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@keyword.repeat', { fg = '#c18c5d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSStatement', { fg = '#c18c5d', bg = NONE, bold = false })
--green
vim.api.nvim_set_hl(0, 'TSPreProc', { fg = '#c18c5d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSKeyword', { fg = '#c18c5d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSOperator', { fg = '#c18c5d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSIdentifier', { fg = '#c18c5d', bg = NONE, bold = false })


vim.api.nvim_set_hl(0, 'TSOperator', { fg = '#c18c5d', bg = NONE, bold = false })


-- Preprocessor directives like #include, #define, #ifdef, etc.
vim.api.nvim_set_hl(0, 'TSPreProc', { fg = '#c18c5d', bg = NONE, bold = false })  -- Pinkish for preprocessor directives
--
-- constansts (false/true...
vim.api.nvim_set_hl(0, 'TSConstant', { fg = '#d4adcf', bg = NONE, bold = false })  -- Pinkish for preprocessor directives

-- Keywords like sizeof, typedef, etc.
vim.api.nvim_set_hl(0, 'TSKeyword', { fg = '#c18c5d', bg = NONE, bold = false })  -- Green for keywords


-- Example for `Operator` group (if used)

-- %d
--
--unmatched brackets..
vim.api.nvim_set_hl(0, 'TSError', { fg = '#f9d4bb', bg = '#9d0006', bold = false })
vim.api.nvim_set_hl(0, 'TSIdentifier', { fg = '#c18c5d', bg = NONE, bold = false })










--normal colors

---- Set the background and text color for normal text
vim.api.nvim_set_hl(0, 'Normal', { fg = '#f9d4bb', bg = NONE })  -- Dark background, light text
vim.api.nvim_set_hl(0, 'Comment', { fg = '#463f3a', bg = '#f9d4bb' })  -- Dark background, light text

--void, int
vim.api.nvim_set_hl(0, 'Type', { fg = '#8ec07c', bold = false, bg = '#463f3a' })    

vim.api.nvim_set_hl(0, 'Format', { fg = '#000bb2', italic = true, bg = '#463f3a' })
-- Change the highlight color for conditional statements like 'if', 'else', 'switch', etc.
vim.api.nvim_set_hl(0, 'Conditional', { fg = '#c18c5d', bg = NONE, bold = false })  -- Example: pinkish color for conditionals

-- Change the highlight color for 'case', 'return', and other keywords in the 'Statement' group.
vim.api.nvim_set_hl(0, 'Statement', { fg = '#c18c5d', bg = NONE, bold = false })    -- Example: cyan color for statements

-- Highlight for string literals
vim.api.nvim_set_hl(0, 'String', { fg = '#d4adcf', bg = NONE })  
-- Highlight for numbers
vim.api.nvim_set_hl(0, 'Number', { fg = '#c18c5d', bg =  NONE})  

-- Status line highlights
vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#463f3a', bg = '#f9d4bb' })  -- Dark text on light background
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#463f3a', bg = '#f9d4bb' }) -- For non-current windows




-- Preprocessor directives like #include, #define, #ifdef, etc.
vim.api.nvim_set_hl(0, 'PreProc', { fg = '#c18c5d', bg = NONE, bold = false })  -- Pinkish for preprocessor directives
--
-- constansts (false/true...
vim.api.nvim_set_hl(0, 'Constant', { fg = '#d4adcf', bg = NONE, bold = false })  -- Pinkish for preprocessor directives

-- Keywords like sizeof, typedef, etc.
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#c18c5d', bg = NONE, bold = false })  -- Green for keywords


-- Example for `Operator` group (if used)
vim.api.nvim_set_hl(0, 'Operator', { fg = '#c18c5d', bg = NONE, bold = false })

-- %d
vim.api.nvim_set_hl(0, 'Special', { fg = '#f9d4bb', bg = NONE, bold = false })
--
--unmatched brackets..
vim.api.nvim_set_hl(0, 'Error', { fg = '#f9d4bb', bg = '#9d0006', bold = false })
vim.api.nvim_set_hl(0, 'Identifier', { fg = '#c18c5d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'Function', { fg = '#f9d4bb', bg = NONE, bold = false })

vim.api.nvim_set_hl(0, 'Comment', { fg = '#719b92', bg = 'NONE', italic = false, bold = false})


-- Set the color of normal line numbers

vim.api.nvim_set_hl(0, 'LineNr', { fg = '#5B584D', bg = '#2e282a' })
vim.cmd[[highlight CursorLineNr ctermfg=Yellow guifg=#f9d4bb]]
vim.o.number = true
--vim.cmd[[highlight CursorLine  cterm=underline ctermbg=10 guibg=#463f3a]]
vim.cmd[[highlight CursorLine cterm=underline ctermbg=NONE guibg=#3c3437]]
vim.o.cursorline = true

vim.cmd[[highlight MatchParen ctermfg=NONE guibg=#40594f]]

-- Adjust syntax highlighting to respect the cursor line background
--vim.cmd[[highlight Comment guibg=NONE ctermbg=NONE]]
vim.cmd("syntax on")

vim.cmd[[highlight String guibg=NONE ctermbg=NONE]]
vim.cmd[[highlight Number guibg=NONE ctermbg=NONE]]
vim.cmd[[highlight Operator guibg=NONE ctermbg=NONE]]
--vim.cmd[[highlight Identifier guibg=NONE ctermbg=NONE]]
vim.cmd[[highlight Keyword guibg=NONE ctermbg=NONE]]
vim.cmd[[highlight Type guibg=NONE ctermbg=NONE]]
vim.cmd[[highlight Statement guibg=NONE ctermbg=NONE]]






vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8

