{ config, libs, pkgs, ... }:
let
  unstable = import <unstable> {};
in
{
    nixpkgs.config.allowUnfree = true;

    networking.wireless.iwd = {
        enable = true;
        settings.General.EnableNetworkConfiguration = true;
    };

    programs.zsh.enable = true;
    programs.firefox.enable = true;

    programs.light.enable = true;
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };

    programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
    };

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    environment.systemPackages = with pkgs; [
      aerc
      aseprite
      autotiling
      blender
      cabal-install
      cifs-utils
      distrobox
      dunst
      easyeffects
      eza
      gcc
      git
      git-lfs
      glib
      godot_4
      grim
      halloy
      haskell.compiler.ghc910
      haskellPackages.hoogle
      hlint
      imv
      inkscape
      keepassxc
      kicad
      kitty
      klipper-estimator
      krita
      legcord
      libnotify
      linux-wifi-hotspot
      moar
      mpv
      nautilus
      neovim
      oh-my-zsh
      pavucontrol
      pcmanfm
      playerctl
      python3
      qmk
      qutebrowser
      ripgrep
      rofi-wayland
      slurp
      swaybg
      tree
      udiskie
      unzip
      vimix-cursor-theme
      waybar
      wl-clipboard
      xsettingsd
      yt-dlp
      zathura
      zip
      zoxide
      unstable.flowblade
      unstable.freecad
      unstable.openscad-unstable
      unstable.prusa-slicer
    ];

    environment.sessionVariables = {
        ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
    };
}
