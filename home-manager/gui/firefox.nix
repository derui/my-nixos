{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    # pipewireを有効にする
    wrapperConfig = {
      pipewireSupport = true;
    };

    languagePacks = [ "ja" ];

    profiles."derui" = {
      id = 0;
      isDefault = true;

      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        "Nix Options" = {
          definedAliases = [ "@no" ];
          urls = [{
            template = "https://search.nixos.org/options";
            params = [
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
        };
      };
    };
  };
}
