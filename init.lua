vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}


-- Define a function for circular navigation
local function circular_window_nav(direction)
    local cur_win = vim.fn.winnr()
    local max_win = vim.fn.winnr('$') -- Get the total number of windows

    if direction == "right" then
        if cur_win == max_win then
            vim.cmd("wincmd t") -- Go to the first window if at the last
        else
            vim.cmd("wincmd w") -- Go to the next window
        end
    elseif direction == "left" then
        if cur_win == 1 then
            vim.cmd("wincmd W") -- Go to the last window if at the first
        else
            vim.cmd("wincmd W") -- Go to the previous window
        end
    end
end

-- Map keys for circular navigation
vim.keymap.set("n", "<Space>l", function() circular_window_nav("right") end, { desc = "Go to the next window (circular)" })
vim.keymap.set("n", "<Space>h", function() circular_window_nav("left") end, { desc = "Go to the previous window (circular)" })

require("lazy").setup("plugins")
