{ pkgs, ... }:
{
  programs.steam = {
    enable = true;

    extraPackages = with pkgs; [
      mangohud
    ];
  };

  environment.systemPackages = [
    pkgs.protontricks
  ];
}
