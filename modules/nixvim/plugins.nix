{
  web-devicons.enable = true; 	# File icons
  lightline.enable = true; 	    # Status bar
  telescope.enable = true; 	    # Search
  treesitter.enable = true;    	# Highlighting
  oil.enable = true;       	    # File management

  # Auto-completion
  cmp = {
    enable = true;
    settings = {
      sources = [
      { name = "nvim_lsp"; }
      { name = "path"; }
      { name = "buffer"; }
      ];
      mapping = {
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-x><C-x>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-y>" = "cmp.mapping.confirm({ select = true })";
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
      };
    };
  };


  # LSP (Language Servers)
  lsp = {
    enable = true;
    servers = {
      nil_ls = {
        enable = true;
        settings = {
          nix = {
            flake = {
              autoArchive = true;
            };
          };
        };
      };
      lua_ls.enable = true;     # Lua
        pyright.enable = true;  # Python
        bashls.enable = true;   # Bash
    };
  };
}
