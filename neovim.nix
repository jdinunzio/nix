{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      #rnix-lsp

      # xclip
      # wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-bash
          p.tree-sitter-fish
          p.tree-sitter-json
          p.tree-sitter-lua
          p.tree-sitter-nix
          p.tree-sitter-python
          p.tree-sitter-vim
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      nvim-cmp
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      cmp_luasnip
      cmp-nvim-lsp
      luasnip

      neodev-nvim
      nvim-web-devicons
      vim-nix
    ];

    extraLuaConfig = ''
    ${builtins.readFile ./nvim/options.lua}
    '';
  };
}