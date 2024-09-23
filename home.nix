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
    python312Full
    python312Packages.pip
    temurin-jre-bin-21
    # go
    bazel
    bazelisk
    go
    mage
    protobuf
    protoc-gen-go
    grpcui

    # devel
    # awscli2
    devenv
    # google-cloud-sdk-gce
    gnumake42
    httpie
    k3d
    kind
    krew
    ruff

    # cli
    ack
    bat
    encfs
    fzf
    jq
    just
    lm_sensors
    yq
    xsensors

    # apps
    dropbox
    firefox
    gnomeExtensions.system-monitor
    jetbrains.idea-community
    #jetbrains.goland
    jetbrains.pycharm-community-bin
    maestral  # dropbox replacement
    maestral-gui
    mpv
    #steam
    typora
    vdhcoapp

    # libs
    zlib
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
