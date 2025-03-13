{ config, libs, pkgs, ... }:
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

    services.espanso = {
      package = pkgs.espanso-wayland;
      enable = true;
    };

    services.syncthing = {
      user = "coralynn";
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      aerc
      autotiling
      blender
      cabal-install
      cifs-utils
      distrobox
      dunst
      easyeffects
      eza
      ffmpeg
      freecad
      git
      git-lfs
      glib
      godot_4
      grim
      halloy
      haskell.compiler.ghc96
      haskellPackages.hoogle
      hlint
      imv
      inkscape
      keepassxc
      kitty
      klipper-estimator
      krita
      legcord
      libnotify
      linux-wifi-hotspot
      mpv
      nautilus
      neovim
      oh-my-zsh
      openscad-unstable
      pavucontrol
      pcmanfm
      playerctl
      prusa-slicer
      python3
      qmk
      qutebrowser
      ripgrep
      rofi-wayland
      signal-desktop
      slurp
      swaybg
      tree
      udiskie
      unzip
      catppuccin-cursors.mochaDark
      waybar
      wl-clipboard
      xsettingsd
      yt-dlp
      zathura
      zip
      zoxide
    ];

    environment.sessionVariables = {
        ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
    };
}
