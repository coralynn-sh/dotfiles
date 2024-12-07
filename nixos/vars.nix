{ config, libs, pkgs, ... }:

{
    environment.sessionVariables = {
        ZSH_DIR = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
    };
}
