{ config, pkgs, inputs, ... }:
let
  mypkg = inputs.self.outputs.packages.${pkgs.system};
in
{
  home.username = "derui";
  home.homeDirectory = "/home/derui";

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    zip
    xz
    unzip
    p7zip

    ripgrep # fast grep altrenative
    jq # JSON processor
    eza # A modern replacement for `ls`
    fzf # command-line fuzzy
    fd # find alternative

    # misc
    which
    gnused
    gnutar
    gawk
    zstd
    direnv

    # nix related
    nix-output-monitor
    nh # for daily nix development
    nix-direnv

    btop # replacement of htop

    wofi # program launcher
    waybar # bar display
    mako

    # fonts
    mypkg.udev-gothic
    mypkg.udev-gothic-nf
  ];

  # imports software
  imports =
    [
      ./home-manager/gui
      ./home-manager/cli
    ];

  # home manager version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  # fontをインストールできるように
  fonts.fontconfig.enable = true;
}
