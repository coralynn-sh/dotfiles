{ config, libs, pkgs, ... }:

{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
        ];
    };

    networking.nameservers = [ "10.20.30.4" ];

    services.resolved = {
        enable = true;
        dnssec = "true";
        domains = [ "~." ];
        fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
        dnsovertls = "false";
    };

    services.udisks2.enable = true;

    services.logind.extraConfig = ''
        HandlePowerKey=ignore
    '';

    services.tailscale.enable = true;
}
