vim.opt.shell = 'bash'

vim.opt.shellcmdflag = '-lc'





-- ~/.config/nvim/init.lua
-- Do not set any colorscheme or custom highlights
-- This ensures Neovim uses the terminal's colors
vim.cmd("set relativenumber")
vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', '<C-x><C-f>', ':tcd ', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>pv", function()
vim.opt.splitbelow = true
    vim.cmd("split");
	vim.cmd("Oil")
	vim.cmd("set relativenumber")
end)

vim.api.nvim_set_keymap('n', '<C-F5>', ':! ./r.sh<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>d', ':!pwd > /tmp/nvim_cwd<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gf", function()
vim.fn.jobstart({"/home/shabbeer/apps/gf/gf2" })

end)

vim.o.autoread = true
vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "FocusGained"}, {
    command = "checktime",
})


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



-- Define a variable to track the state of the recenter cycle
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

local function execute_file()
    local cursor_line = vim.fn.line('.')
    local file = vim.fn.getline(cursor_line)
    print("Raw File Path: " .. file)  -- Debug print statement
    file = vim.fn.fnamemodify(file, ':p')  -- Convert to absolute path
    print("Absolute File Path: " .. file)  -- Debug print statement

    -- Remove wildcards and ensure the file path is correct
    file = vim.fn.expand(file)

    -- Ensure the file exists before running the command
    if vim.fn.filereadable(file) == 1 then
        local cmd = '! ./' .. vim.fn.shellescape(file)
        print("Command: " .. cmd)  -- Debug print statement
        vim.cmd(cmd)  -- Execute the command
    else
        print("File not found: " .. file)
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

-- Define the execute_selected_file function
local function execute_selected_file()
    local oil = require("oil") -- Ensure oil is loaded
    local entry = oil.get_cursor_entry() -- Get the entry currently under the cursor

    if entry then  -- Check if entry exists and has a path
        -- Execute the file using its path
        vim.cmd("!" .. entry.path) -- Use entry.path to execute the file
    else
        print("No file selected or invalid entry")
    end
end


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

   -- ["gr"] = execute_selected_file,
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
  builtin.find_files({ cwd = '~',
  hidden = true
  })
end, { desc = 'Telescope find files from home directory' })

vim.keymap.set('n', '<leader>fr', function()
  builtin.find_files({ cwd = '/',
  hidden = true
  })
end, { desc = 'Telescope find files from root directory' })




--TREESITTER _------------------------------------------------------------------------------
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,


  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


--ts colors
--
--
--
--
---- Set the background and text color for normal text
---purple
vim.api.nvim_set_hl(0, 'TSString', { fg = '#bd8cc0', bg = NONE })
vim.api.nvim_set_hl(0, 'TSNumber', { fg = '#bd8cc0', bg = NONE })
vim.api.nvim_set_hl(0, '@number', { fg = '#bd8cc0', bg = NONE })
---white
vim.api.nvim_set_hl(0, '@lsp.type.variable', { fg = '#e0ac9d', bg = none })
vim.api.nvim_set_hl(0, '@type.c', { fg = '#e0ac9d', bg = none })
vim.api.nvim_set_hl(0, '@lsp.type.parameter', { fg = '#e0ac9d', bg = none })
vim.api.nvim_set_hl(0, '@variable', { fg = '#e0ac9d', bg = NONE })
vim.api.nvim_set_hl(0, '@constant', { fg = '#e0ac9d', bg = NONE })
vim.api.nvim_set_hl(0, '@operator', { fg = '#e0ac9d', bg = NONE })
vim.api.nvim_set_hl(0, '@property', { fg = '#e0ac9d', bg = NONE })
vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = '#e0ac9d', bg = NONE })
vim.api.nvim_set_hl(0, '@Delimiter', { fg = '#e0ac9d', bg = NONE })
vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = '#e0ac9d', bg = NONE })
vim.api.nvim_set_hl(0, 'TSComment', { fg = '#463f3a', bg = '#e0ac9d' })
vim.api.nvim_set_hl(0, 'TSError', { fg = '#e0ac9d', bg = '#9d0006', bold = false })
vim.api.nvim_set_hl(0, 'TSFunction', { fg = '#e0ac9d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSVariable', { fg = '#e0ac9d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSSpecial', { fg = '#e0ac9d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@function.call', { fg = '#e0ac9d', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@keyword.function.rust', { fg = '#e0ac9d', bg = NONE, bold = false })
--green
vim.api.nvim_set_hl(0, 'TSType', { fg = '#a7c080', bold = false, bg = '#463f3a' })
vim.api.nvim_set_hl(0, 'TSConstant', { fg = '#a7c080', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@type.builtin', { fg = '#a7c080', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@type', { fg = '#a7c080', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@keyword.modifier', { fg = '#a7c080', bg = NONE, bold = false })

vim.api.nvim_set_hl(0, 'TSFormat', { fg = '#000bb2', italic = true, bg = '#463f3a' })
--orange
vim.api.nvim_set_hl(0, '@keyword.conditional', { fg = '#e88873', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, '@keyword.repeat', { fg = '#e88873', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSStatement', { fg = '#e88873', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSPreProc', { fg = '#e88873', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSKeyword', { fg = '#e88873', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSOperator', { fg = '#e88873', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'TSIdentifier', { fg = '#e88873', bg = NONE, bold = false })


vim.api.nvim_set_hl(0, 'TSOperator', { fg = '#e88873', bg = NONE, bold = false })


-- Preprocessor directives like #include, #define, #ifdef, etc.
vim.api.nvim_set_hl(0, 'TSPreProc', { fg = '#e88873', bg = NONE, bold = false })  -- Pinkish for preprocessor directives
--
-- constansts (false/true...
vim.api.nvim_set_hl(0, 'TSConstant', { fg = '#bd8cc0', bg = NONE, bold = false })  -- Pinkish for preprocessor directives

-- Keywords like sizeof, typedef, etc.
vim.api.nvim_set_hl(0, 'TSKeyword', { fg = '#e88873', bg = NONE, bold = false })  -- Green for keywords


-- Example for `Operator` group (if used)

-- %d
--
--unmatched brackets..
vim.api.nvim_set_hl(0, 'TSError', { fg = '#e0ac9d', bg = '#9d0006', bold = false })
vim.api.nvim_set_hl(0, 'TSIdentifier', { fg = '#e88873', bg = NONE, bold = false })



vim.api.nvim_set_hl(0, 'Todo', { fg = '#e67e80', reverse = true, bg = 'NONE', italic = false, bold = false})
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#83c092', reverse = true, bg = 'NONE', italic = false, bold = false})






--normal colors

---- Set the background and text color for normal text
vim.api.nvim_set_hl(0, 'Normal', { fg = '#e0ac9d', bg = NONE })  -- Dark background, light text
vim.api.nvim_set_hl(0, 'Comment', { fg = '#463f3a', bg = '#e0ac9d' })  -- Dark background, light text

vim.api.nvim_set_hl(0, '@module.cpp', { fg = '#e0ac9d', bg = NONE })  -- Dark background, light text
vim.api.nvim_set_hl(0, '@type.cpp', { fg = '#e0ac9d', bg = NONE })  -- Dark background, light text
--void, int
vim.api.nvim_set_hl(0, 'Type', { fg = '#a7c080', bold = false, bg = '#463f3a' })    

vim.api.nvim_set_hl(0, 'Format', { fg = '#000bb2', italic = true, bg = '#463f3a' })
-- Change the highlight color for conditional statements like 'if', 'else', 'switch', etc.
vim.api.nvim_set_hl(0, 'Conditional', { fg = '#e88873', bg = NONE, bold = false })  -- Example: pinkish color for conditionals

-- Change the highlight color for 'case', 'return', and other keywords in the 'Statement' group.
vim.api.nvim_set_hl(0, 'Statement', { fg = '#e88873', bg = NONE, bold = false })    -- Example: cyan color for statements

-- Highlight for string literals
vim.api.nvim_set_hl(0, 'String', { fg = '#bd8cc0', bg = NONE })  
-- Highlight for numbers
vim.api.nvim_set_hl(0, 'Number', { fg = '#e88873', bg =  NONE})  

-- Status line highlights
vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#463f3a', bg = '#e0ac9d' })  -- Dark text on light background
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#463f3a', bg = '#e0ac9d' }) -- For non-current windows




-- Preprocessor directives like #include, #define, #ifdef, etc.
vim.api.nvim_set_hl(0, 'PreProc', { fg = '#e88873', bg = NONE, bold = false })  -- Pinkish for preprocessor directives
--
-- constansts (false/true...
vim.api.nvim_set_hl(0, 'Constant', { fg = '#bd8cc0', bg = NONE, bold = false })  -- Pinkish for preprocessor directives

-- Keywords like sizeof, typedef, etc.
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#e88873', bg = NONE, bold = false })  -- Green for keywords


-- Example for `Operator` group (if used)
vim.api.nvim_set_hl(0, 'Operator', { fg = '#e88873', bg = NONE, bold = false })

-- %d
vim.api.nvim_set_hl(0, 'Special', { fg = '#e0ac9d', bg = NONE, bold = false })
--
--unmatched brackets..
vim.api.nvim_set_hl(0, 'Error', { fg = '#e0ac9d', bg = '#9d0006', bold = false })
vim.api.nvim_set_hl(0, 'Identifier', { fg = '#e88873', bg = NONE, bold = false })
vim.api.nvim_set_hl(0, 'Function', { fg = '#e0ac9d', bg = NONE, bold = false })

vim.api.nvim_set_hl(0, 'Comment', { fg = '#e0ac9d', reverse = true,  bg = 'NONE', italic = false, bold = false})



-- Set the color of normal line numbers

vim.api.nvim_set_hl(0, 'LineNr', { fg = '#765b56', bg = '#6d4c4a' })
vim.cmd[[highlight CursorLineNr ctermfg=Yellow guifg=#e0ac9d]]
vim.o.number = true
--vim.cmd[[highlight CursorLine  cterm=underline ctermbg=10 guibg=#463f3a]]
vim.cmd[[highlight CursorLine cterm=underline ctermbg=NONE guibg=#795753]]
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






vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.scrolloff   = 8
-- Normal mode: Yank the current line with Space + y
vim.keymap.set('n', '<Space>y', '"+y', { noremap = true })

-- Visual mode: Yank the selected text with Space + y
vim.keymap.set('v', '<Space>y', '"+y', { noremap = true })

-- Move to the left split using Space + h
vim.api.nvim_set_keymap('n', '<Space>h', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>k', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>j', '<C-w>j', { noremap = true, silent = true })

-- Move to the right split using Space + l
vim.api.nvim_set_keymap('n', '<Space>l', '<C-w>l', { noremap = true, silent = true })


--auto header guard

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.h",
  callback = function()
    local filename = vim.fn.expand("%:t"):upper():gsub("%W", "_")
    local guard = string.format("#ifndef %s\n#define %s\n\n\n\n#endif // %s\n", filename .. "_", filename .. "_", filename .. "_")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(guard, "\n"))
    vim.api.nvim_win_set_cursor(0, {4, 0}) -- move cursor between the #define and #endif
  end,
})


--TODO:for oil
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.h",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    if #lines == 1 and lines[1] == "" then
      local filename = vim.fn.expand("%:t"):upper():gsub("%W", "_") .. "_"
      local guard = {
        "#ifndef " .. filename,
        "#define " .. filename,
        "",
        "",
        "#endif // " .. filename,
      }
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, guard)
      vim.api.nvim_win_set_cursor(0, {4, 0})
    end
  end,
})


vim.api.nvim_set_hl(0, "Search", { bg = "#e67c80", fg = "#000000" })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#dbbc7f", fg = "#000000" })


--Good equal
function AlignEqualsPreserveIndent()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  local maxlen = 0
  local parsed = {}

  for _, line in ipairs(lines) do
    local indent, lhs, rhs = line:match("^(%s*)(.-)=(.*)")
    if lhs and rhs then
      lhs = vim.trim(lhs)
      rhs = vim.trim(rhs)
      maxlen = math.max(maxlen, #lhs)
      table.insert(parsed, { indent = indent, lhs = lhs, rhs = rhs })
    else
      table.insert(parsed, { raw = line }) -- preserve unmatchable lines
    end
  end

  local aligned = {}
  for _, item in ipairs(parsed) do
    if item.raw then
      table.insert(aligned, item.raw)
    else
      table.insert(aligned, string.format("%s%-" .. maxlen .. "s = %s", item.indent, item.lhs, item.rhs))
    end
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, aligned)
end

vim.api.nvim_set_keymap("v", "<leader>a=", [[:lua AlignEqualsPreserveIndent()<CR>]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>s", function()
  local name = vim.fn.input("Struct name: ")
  if name == "" then return end
  local lines = {
    string.format("typedef struct %s %s;", name, name),
    string.format("struct %s {", name),
    "};"
  }
  vim.api.nvim_put(lines, "l", true, true)
end, { desc = "Insert typedef struct" })



vim.keymap.set("n", "<leader>e", function()
  local name = vim.fn.input("Enum name: ")
  if name == "" then return end
  local lines = {
    string.format("typedef enum %s %s;", name, name),
    string.format("enum %s {", name),
    "};"
  }
  vim.api.nvim_put(lines, "l", true, true)
end, { desc = "Insert typedef enum" })

-- Scroll screen horizontally with arrow keys
vim.keymap.set('n', '<Left>', 'zh', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', 'zl', { noremap = true, silent = true })



