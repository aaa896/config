
-- ~/.config/nvim/init.lua


-- Do not set any colorscheme or custom highlights
-- This ensures Neovim uses the terminal's colors
vim.cmd("set relativenumber")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", function()
	vim.cmd("Ex")
	vim.cmd("set relativenumber")
end)

-- Function to center the screen around the cursor
function _G.center_cursor()
	vim.cmd('normal! zz')
end


-- Map Ctrl + l to center the screen around the cursor
vim.api.nvim_set_keymap('n', '<C-l>', ':lua center_cursor()<CR>', { noremap = true, silent = true })

vim.opt.nu = true
vim.opt.relativenumber = true
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
vim.opt.termguicolors = false
vim.api.nvim_set_hl(0, 'Comment', { fg = '#808080', bg = 'NONE', italic = false, bold = false,
	undercurl = false, reverse = true      	})

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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})





local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', function()
    require('telescope.builtin').find_files()
end)
