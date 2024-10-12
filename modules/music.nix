{ lib, ... }:
{
  environment.variables =
    let
      makePluginPath =
        format:
        lib.strings.makeSearchPath format [
          "$HOME/.nix-profile/lib"
          "/run/current-system/sw/lib"
          "/etc/profiles/per-user/$USER/lib"
        ];
    in
    {
      # LV2のプラグインを読み込むためにはこれを指定しておく必要があるが、そのままだと固有のものしか見えないので、
      # HOMEとかも対象にいれるようにしている
      LV2_PATH = lib.mkDefault (makePluginPath "lv2");
    };
}
