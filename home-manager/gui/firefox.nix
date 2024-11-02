{ pkgs, ... }:
{
  # only configurations for user-profile
  programs.firefox = {
    enable = true;

    policies = {
      ExtensionSettings =
        with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
        # uuidは about:debugging#/runtime/this-firefox から取得できる。
        listToAttrs [
          (extension "tree-style-tab" "treestyletab@piro.sakura.ne.jp")
          (extension "vimium" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
        ];

      HardwareAcceleration = true;
    };

    profiles."derui" = {
      id = 0;
      isDefault = true;

      search.force = true;
      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        "Nix Options" = {
          definedAliases = [ "@no" ];
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
        };
        "Bing".metaData.hidden = true;
      };
    };
  };
}
