{ pkgs, ... }:
{
  imports = [
    ./keymap.nix
    ./plugins.nix
  ];

  environment.systemPackages = with pkgs; [ 
    ripgrep # required for Telescope live_grep
  ];
  
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
      };
    };

    opts = {
      number = true;         # Line numbers
      relativenumber = true; # Relative numbers for jumping
      shiftwidth = 2;        # Tab width
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      ignorecase = true;
      breakindent = true;
      cursorline = true;     # Highlight current line
      scrolloff = 8;         # Keep 8 lines above/below cursor
      clipboard = "unnamedplus";
    };

    globals.mapleader = " ";

    extraConfigLua = ''
      if vim.env.SSH_TTY then
        vim.g.clipboard = {
          name = 'OSC 52',
          copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
          },
          paste = {
            ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
            ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
          },
        }
      end

      -- Make line numbers brighter
      vim.cmd('highlight LineNr guifg=#9399b2 guibg=NONE')
      vim.cmd('highlight CursorLineNr guifg=#f5c2e7 guibg=NONE')
    '';
  };
}
