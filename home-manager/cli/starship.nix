{
  # customizable prompt for any shell
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;

      format = ''
        $username\
        $directory\
        $git_branch\
        $git_state\
        $nodejs\
        $ocaml\
        $time\
        $cmd_duration\
        $line_break\
        $jobs\
        $character
      '';

      package.disabled = true;
      username.show_always = true;
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold green)";
      };

      time = {
        disabled = false;
        time_format = "%T";
        utc_time_offset = "+9";
        style = "bold fg:blue";
      };
    };
  };

}
