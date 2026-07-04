[
  { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; }
  { mode = "n"; key = "<leader>e";  action = "<cmd>Oil<CR>"; } # file explorer

# move lines
{ mode = "n"; key = "<A-j>"; action = "<CMD>m .+1<CR>=="; options = { silent = true; desc = "Move line down"; }; }
{ mode = "n"; key = "<A-k>"; action = "<CMD>m .-2<CR>=="; options = { silent = true; desc = "Move line up"; }; }
{ mode = "v"; key = "<A-j>"; action = ":m '>+1<CR>gv=gv"; options = { silent = true; desc = "Move selection down"; }; }
{ mode = "v"; key = "<A-k>"; action = ":m '<-2<CR>gv=gv"; options = { silent = true; desc = "Move selection up"; }; }

# duplicate lines
  { mode = "n"; key = "<A-C-j>";  action = "yyp"; }
  { mode = "n"; key = "<A-C-k>";  action = "yyP"; }

# replace current word
  { mode = "n"; key = "<leader>s"; action = ":%s/\<<C-r><C-w>\>//gI<Left><Left><Left>"; }

# quick save
  { mode = "n"; key = "<leader><leader>";  action = ":w<CR>"; }

  {
    mode = "n";
    key = "<leader>fg";
    action.__raw = '' 
      function()
      local path
      local ok, oil = pcall(require, "oil")

      -- Try to get path from Oil
      if ok and vim.bo.filetype == "oil" then
	path = oil.get_current_dir()
      else
	-- Try to get directory of current file
	  path = vim.fn.expand("%:p:h")
	  end

	  -- Fallback to CWD if path is empty or invalid (e.g. empty buffer)
	  if path == "" or path == "." then
	    path = vim.fn.getcwd()
	      end

	      require("telescope.builtin").live_grep({
		  cwd = path,
		  })
    end
      '';
    options = { desc = "Grep in current directory, oil or file directory"; };
  }
]
