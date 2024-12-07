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

    environment.systemPackages = with pkgs; [
        autotiling
        cifs-utils
        dunst
        easyeffects
        eza
        gcc
        git
        glib
        grim
        imv
        keepassxc
        kitty
        krita
        libnotify
        nautilus
        neovim
        oh-my-zsh
        pcmanfm
        playerctl
        rofi-wayland
        slurp
        swaybg
        udiskie
        vesktop
        vimix-cursor-theme
        waybar
        wl-clipboard
        xsettingsd
        zoxide
    ];

    environment.sessionVariables = {
        ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
    };
}
