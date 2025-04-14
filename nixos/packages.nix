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

    environment.systemPackages = with pkgs; [
      (chromium.override { enableWideVine = true; })
      aaxtomp3
      aerc
      audible-cli
      autotiling
      blender
      cabal-install
      catppuccin-cursors.mochaDark
      cifs-utils
      cryptsetup
      distrobox
      dunst
      easyeffects
      emacs-pgtk
      eza
      ffmpeg
      file
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
      mpv
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
      syncthing
      tree
      udiskie
      unzip
      waybar
      wl-clipboard
      xsettingsd
      yt-dlp
      zathura
      zip
      zlib
      zoxide
    ];

    environment.sessionVariables = {
        ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
    };
}
