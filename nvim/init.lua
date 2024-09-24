
vim.api.nvim_set_hl(0, 'Comment', { fg = '#808080', bg = 'NONE', italic = false, bold = false,
	undercurl = false, reverse = true      	})

-- ~/.config/nvim/init.lua
-- Do not set any colorscheme or custom highlights
-- This ensures Neovim uses the terminal's colors
vim.cmd("set relativenumber")
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", function()
vim.opt.splitbelow = true
    vim.cmd("split");
	vim.cmd("Ex")
	vim.cmd("set relativenumber")
end)

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
local recenter_state = 0




-- Function to mimic Emacs C-l behavior
local function recenter_cycle()
  if recenter_state == 0 then
    -- Center the cursor in the screen
    vim.cmd('normal! zz')
    recenter_state = 1
  elseif recenter_state == 1 then
    -- Move the cursor line to the top of the screen
    vim.cmd('normal! zt')
    recenter_state = 2
  elseif recenter_state == 2 then
    -- Move the cursor line to the bottom of the screen
    vim.cmd('normal! zb')
    recenter_state = 0
  end
end

-- Map C-l in normal mode to the custom recenter function
vim.keymap.set('n', '<C-l>', recenter_cycle, { noremap = true, silent = true })









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
    },



  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})





local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })



-- Set the background and text color for normal text
vim.api.nvim_set_hl(0, 'Normal', { fg = '#ebdbb2', bg = '#282828' })  -- Dark background, light text
vim.api.nvim_set_hl(0, 'Comment', { fg = '#282828', bg = '#ebdbb2' })  -- Dark background, light text

--void, int
vim.api.nvim_set_hl(0, 'Type', { fg = '#8ec07c', bold = true, bg = '#282828' })    

vim.api.nvim_set_hl(0, 'Format', { fg = '#000bb2', italic = true, bg = '#282828' })
-- Change the highlight color for conditional statements like 'if', 'else', 'switch', etc.
vim.api.nvim_set_hl(0, 'Conditional', { fg = '#83a598', bg = '#282828', bold = true })  -- Example: pinkish color for conditionals

-- Change the highlight color for 'case', 'return', and other keywords in the 'Statement' group.
vim.api.nvim_set_hl(0, 'Statement', { fg = '#83a598', bg = '#282828', bold = true })    -- Example: cyan color for statements

-- Highlight for string literals
vim.api.nvim_set_hl(0, 'String', { fg = '#d3869b', bg = '#282828' })  
-- Highlight for numbers
vim.api.nvim_set_hl(0, 'Number', { fg = '#ebdbb2', bg = '#282828' })  

-- Status line highlights
vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#282828', bg = '#ebdbb2' })  -- Dark text on light background
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#282828', bg = '#ebdbb2' }) -- For non-current windows




-- Preprocessor directives like #include, #define, #ifdef, etc.
vim.api.nvim_set_hl(0, 'PreProc', { fg = '#8ec07c', bg = '#282828', bold = true })  -- Pinkish for preprocessor directives
--
-- constansts (false/true...
vim.api.nvim_set_hl(0, 'Constant', { fg = '#ebdbb2', bg = '#282828', bold = false })  -- Pinkish for preprocessor directives

-- Keywords like sizeof, typedef, etc.
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#50fa7b', bg = '#282828', bold = true })  -- Green for keywords


-- Example for `Operator` group (if used)
vim.api.nvim_set_hl(0, 'Operator', { fg = '#ebdbb2', bg = '#282828', bold = false })

-- %d
vim.api.nvim_set_hl(0, 'Special', { fg = '#8ec07c', bg = '#282828', bold = true })
--
--unmatched brackets..
vim.api.nvim_set_hl(0, 'Error', { fg = '#ebdbb2', bg = '#9d0006', bold = true })



-- Set the color of normal line numbers
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#525050', bg = '#282828' })
vim.o.number = true
--vim.o.cursorline = true

