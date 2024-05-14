{ config, pkgs, inputs, ... }:

{
  home.username = "goyo";
  home.homeDirectory = "/home/goyo";

  imports = [
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./neovim.nix
    ./ssh.nix
    ./vscode.nix
  ];

  # You should not change this value.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # langs
    python312

    #devel
    awscli
    devenv
    google-cloud-sdk-gce
    httpie
    k3d
    kind
    krew

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
  ];

  home.language = {
    collate = "C";
  };

  home.sessionVariables = {
    LC_COLLATE = "C";
  };

  # Let Home Manager install and manage itself.
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}