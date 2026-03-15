{
  pkgs,
  inputs,
  ...
}:
let
  mypkg = inputs.self.outputs.packages.${pkgs.stdenv.hostPlatform.system};
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
    bat # A modern replacement for `cat/less`
    fzf # command-line fuzzy
    fd # find alternative
    procs # ps alternative
    pv # for monitor
    starship
    go-task

    # misc
    which
    gnused
    gnutar
    gawk
    zstd
    direnv
    zoxide # move directory
    just # task runner
    mountpoint-s3

    # latex
    texliveBasic
    texlivePackages.dvipng
    # multimedia
    mpv

    # nix related
    nix-output-monitor
    nh # for daily nix development
    nix-direnv

    btop # replacement of htop

    # fonts
    mypkg.udev-gothic
    mypkg.udev-gothic-nf
    mypkg.moralerspace
    mypkg.moralerspace-hw
    mypkg.explex
  ];
}
