# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  lib,
  pkgs,
  inputs,
  user,
  ...
}:
{
  imports = [

    ../modules/nix.nix
  ];

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "ja_JP.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "video"
      "audio"
      "game"
      "networkmanager"
      "ollama"
      "wheel" # Enable ‘sudo’ for the user.
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl

    # shells
    fish

    # for emacs
    enchant2
    nuspell
    hunspellDicts.en_US-large
  ];
  # Set the default editor to vim
  environment.variables = {
    EDITOR = "vim";
  };

  # enable zram
  zramSwap = {
    enable = true;
    memoryPercent = 200;
  };

  system.activationScripts = {
    binbash = ''
      mkdir -m 0755 -p /bin
      ln -sfn ${pkgs.bash}/bin/bash /bin/.bash.tmp
      mv /bin/.bash.tmp /bin/bash
    '';
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
