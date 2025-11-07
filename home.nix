{ config, pkgs, pkgs-unstable, inputs, ... }:

{
  home.username = "goyo";
  home.homeDirectory = "/home/goyo";

  imports = [
    ./direnv.nix
    ./dotfiles.nix
    ./fish.nix
    ./git.nix
    ./nvim.nix
    ./shell.nix
    ./ssh.nix
    ./vscode.nix
  ];

  # You should not change this value.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = 
    (with pkgs; [
      # langs
      cargo
      gcc
      ghc
      #python313Full
      python312Full
      python313Packages.jedi-language-server
      python312Packages.pip
      python312Packages.python-lsp-server
      temurin-jre-bin-21
      # go
      bazel
      bazelisk
      go
      mage
      #nodejs_23
      protobuf
      protoc-gen-go
      grpcui

      # devel
      # awscli2
      # devenv
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
      ffmpeg
      fzf
      fishPlugins.grc
      gh
      gifsicle
      grc
      imagemagick
      jq
      lm_sensors
      mmv-go
      nixVersions.nix_2_28
      rar
      yq
      yt-dlp
      wmctrl
      xsensors

      # apps
      brave
      comical
      dropbox
      firefox
      gnomeExtensions.system-monitor
      helix
      jetbrains.idea-community
      #jetbrains.goland
      jetbrains.pycharm-community-bin
      kitty
      libreoffice-fresh
      maestral  # dropbox replacement
      maestral-gui
      media-downloader
      mpv
      #steam
      speechd
      typora

      # libs
      libwebp
      zlib

    ]) 
    ++ 
    (with pkgs-unstable; [
      devbox
      devenv
      just
      vdhcoapp
      video-downloader
    ]);

  home.language = {
    collate = "C";
  };

  home.sessionVariables = {
    LC_COLLATE = "C";
  };

  # Let Home Manager install and manage itself.
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };
  programs.home-manager.enable = true;
}
