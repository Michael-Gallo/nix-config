{ config, pkgs, ... }:
let
  # Detect if running on a laptop
  isLaptop = builtins.pathExists "/sys/class/power_supply/BAT0";
in
{

    services.xserver.xkb.options = "caps:swapescape";
}
