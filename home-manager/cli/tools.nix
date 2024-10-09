{ pkgs, inputs, ... }:
let
  mypkg = inputs.self.outputs.packages.${pkgs.system};
in
{
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
    procs # ps alternative

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

    # fonts
    mypkg.udev-gothic
    mypkg.udev-gothic-nf
    mypkg.moralerspace-nf

    dropbox
  ];
}
