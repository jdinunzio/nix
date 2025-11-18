{ pkgs, pkgs-unstable, ... }:

{
  # Configuration to install neovim and use lazyvim with it.
  # * Install neovim from unstable, until neovim>=0.11 is available.
  # * Does not configure neovim using home-manager module, until it's 
  #   in stable, and only to create symlinks.
  # * Install packages used by lazyvim and the chosen plugins.
  # * Neovim's `nvim` config folder moved to this repo, to keep
  #   configuration in the same place.
  #
  home.packages = (with pkgs; [
      # vim
      lua51Packages.lua
      luarocks-nix
      fd
      lazygit
      ripgrep
  ])
  ++ 
  (with pkgs-unstable; [
      neovim
  ]);
}
