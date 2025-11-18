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
        # note: this shouldn't be necessary, since it should be automatically set by
        # helix.nix.
        set -g EDITOR "hx"
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
