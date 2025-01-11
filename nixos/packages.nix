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
      glib
      godot_4
      gpt4all
      grim
      halloy
      haskell.compiler.ghc910
      haskellPackages.hoogle
      hlint
      imv
      keepassxc
      kitty
      klipper-estimator
      krita
      libnotify
      moar
      mpv
      nautilus
      neovim
      oh-my-zsh
      pcmanfm
      playerctl
      prusa-slicer
      python3
      qmk
      qutebrowser
      ripgrep
      rofi-wayland
      slurp
      swaybg
      tree
      udiskie
      vesktop
      vimix-cursor-theme
      waybar
      wl-clipboard
      xsettingsd
      yt-dlp
      zathura
      zoxide
    ];

    environment.sessionVariables = {
        ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
    };
}
