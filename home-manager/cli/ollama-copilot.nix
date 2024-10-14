{ lib, inputs, useLLM, pkgs, ... }:
let
  mypkgs = inputs.self.outputs.packages.${pkgs.system};
in
lib.mkIf useLLM {
  home.packages = [ mypkgs.ollama-copilot ];

  systemd.user.services.ollama-copilot = {
    Unit = {
      Description = "Ollama-copilot service";
    };
    Install = {
      WantedBy = [ "default.target" "ollama.service" ];
    };
    Service = {
      ExecStart = "${mypkgs.ollama-copilot}/bin/ollama-copilot";
      Restart = "on-failure";
    };
  };
}
