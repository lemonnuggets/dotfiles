local set = vim.opt
set.mouse = 'a'             	--Enable mouse mode
set.breakindent = true      	--Enable break indent
set.undofile = true       	    --Save undo history
set.number = true               --Show current line number
set.relativenumber = true       --Relative line numbers
set.cursorline = true           --Highlight line with cursor
set.termguicolors = true    	--Set colorscheme
set.scrolloff = 8		        --Offset from last line which screen starts scrolling at
set.sidescrolloff = 8           --Offset from right of screen where horizontal scrolling starts
set.wrap = false           	    --Do not wrap long lines
set.splitbelow = true           --Open hsplit below current one
set.splitright = true           --Open vsplit to the right of current one
set.hlsearch = true         	--Set highlight on search
set.incsearch = true            --Search as query is being typed out
set.ignorecase = true       	--Case insensitive
set.smartcase = true        	--Case insensitive searching UNLESS /C or capital in search
set.expandtab = true            --Replace tab with appropriate number of spaces
set.smarttab = true             --Detect and add tab of appropriate size on new line
set.shiftwidth = 4              --Number of spaces in beginning of newline
set.tabstop = 4                 --Size of tab
set.clipboard='unnamedplus'     --Use system clipboard
set.updatetime = 250            --Decrease update time, faster completion
set.signcolumn = 'yes'          --Always draws signcolumn, else text is shifted each time
set.conceallevel = 0            -- so that `` is visible in markdown files
set.pumheight = 10              -- pop up menu height
set.hidden = true
set.fileencoding = 'utf-8'


vim.cmd "set whichwrap+=<,>,[,],h,l"        --Wrap to next/prev line automatically at beginning or end of line
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]          -- TODO: this doesn't seem to work

