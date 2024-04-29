{ config, pkgs, inputs, ... }:

{
  home.username = "goyo";
  home.homeDirectory = "/home/goyo";

  # You should not change this value.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # langs
    #kotlin
    #nodejs_21
    #python312
    #rustc
    #rustfmt
    #swiPrologWithGui
    #temurin-bin-21 # java
    #typescript

    #devel
    awscli
    direnv
    google-cloud-sdk-gce
    k3d
    kind
    krew
    nix-direnv
    
    # cli
    ack
    bat
    encfs
    fzf
    jq
    just
    yq

    # apps
    dropbox
    jetbrains.idea-community
    jetbrains.pycharm-community-bin
    mpv
    #steam
    typora
    vscode


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # dotfile management
  home.file = {
    ".config/fish/functions" = {
      source = dotfiles/fish;
      recursive = true;
    };

    ".ssh" = {
      source = dotfiles/ssh;
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "/run/current-system/sw/bin/fish";
  };

  # programs configuration
  programs.fish = {
    enable = true;
    functions = {
      dir = "grc ls -alh --indicator-style=classify --group-directories-first --color $argv";
      ps = "grc ps $argv";
    };
    shellAliases = {
      # something was overwriting function defined in ./dotfiles/fish/ls.fish,
      # so we define it here, since shellAliases has priority.
      ls = "ls --indicator-style=classify --group-directories-first --color";
    };
  };

  programs.git = {
    enable = true;
    userName = "jose";
    userEmail = "jose.dinuncio@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
    };
    
    aliases = {
      br = "branch";
      co = "checkout";
      lg = "log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --decorate=full";
      st = "status";
    };
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

  programs.vscode = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
