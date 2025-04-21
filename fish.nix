{
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
      df = "grc df -h -x tmpfs $argv";
    };

    interactiveShellInit =
      ''
        set -g LESSOPEN "|bat --paging=never --color=always %s"
        # todo: remove this once neovim>=0.11 is in stable,
        # and it has been configured with programs.neovim
        set -g EDITOR "vim"
      '';
  };

  home.file = {
    ".config/fish" = {
      source = dotfiles/fish;
      recursive = true;
    };
  };

  home.sessionVariables = {
    SHELL = "/run/current-system/sw/bin/fish";
  };
}
