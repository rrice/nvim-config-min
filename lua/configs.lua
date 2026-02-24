
vim.wo.number = true
vim.g.have_nerd_font = true


local opt = vim.opt

-- Mouse mode
opt.mouse = "a"

-- Tab stops
opt.autoindent = true -- Enabled auto indentation.
opt.expandtab = false -- Use tabs instead of spaces by default, use autocmds for lang-specific
opt.tabstop = 2	-- Number of spaces for a tab.
opt.softtabstop = 4 -- Number of spaces for a tab when editing.
opt.shiftwidth = 2 -- Number of spaces for autoindent.
opt.shiftround = true -- Round indent to multiples of shiftwidth.

-- Character displays
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Characters to show for tabs, spaces, and end of line
opt.list = true -- Show whitespace chars

-- Line behaviors
opt.wrap = false -- Disable line wrapping
opt.cursorline = true -- Highlight the current line
opt.scrolloff = 4 -- Number of lines of context
opt.sidescrolloff = 10 -- Number of columns of context
opt.breakindent = true -- Wrapped lines will continue to be indented

-- Line number column
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.numberwidth = 2 -- Width of the line number column

-- Terminal behaviors

opt.termguicolors = true -- Enable true colors
opt.guicursor = "i:block" -- Use the block cursor in insert mode
opt.updatetime = 250 -- Swap file update time in ms
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Time to wait for mapped sequence to complete in ms
opt.signcolumn = "auto:4" -- Sign column display
opt.showmode = false -- Don't show mode because we have a status line.
opt.virtualedit = "block" -- Allow the cursor to move where there is no text.
opt.winminwidth = 5 -- Minimum window width

-- Popup behaviors 
opt.pumblend = 10 -- Popup blend default.
opt.pumheight = 10 -- Popup height default.

-- Folding
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldtext = ""

-- Paren matching
opt.showmatch = true -- Enable matching paren
opt.matchtime = 5 -- Show matching parens in 10ths of second.

-- Casing behaviors
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Smart casing enabled

-- Undo behaviors
opt.undodir = os.getenv('HOME') .. '/.vim/undodir' -- Directory for undo files
opt.undofile = true -- Enable persistent undo.
opt.undolevels = 10000

-- Completion behaviors
opt.completeopt = { "menu", "menuone", "popup", "noinsert", "noselect" } -- Options for completion menu
opt.winborder = "rounded" -- Use rounded borders for windows
opt.hlsearch = false -- Disable highlighting of search results

-- System behaviors
opt.autowrite = true -- Enable autowrite
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus" -- Sync with system clipboard

-- Window split behaviors
opt.splitright = true -- split to right first on horizontal split
opt.splitbelow = true -- split below first on vertical split
opt.splitkeep = "screen"
opt.inccommand = "nosplit" -- Shows the effects of a command incrementally in the buffer

-- Plugin behaviors
vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation


