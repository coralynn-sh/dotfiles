{ config, libs, pkgs, ... }:

{
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-emoji
        font-awesome
        fira-mono
    ];
}
