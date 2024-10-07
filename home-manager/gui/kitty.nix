{ pkgs, inputs, ... }:
let
  mypkg = inputs.self.outputs.packages.${pkgs.system};
in
{
  programs.kitty = {
    enable = true;

    settings = {
      cursor = "#ffffff";
      cursor_text_color = "#000000";
      # no blink cursor
      cursor_blink_interval = 0;
      enable_audio_bell = "no";
      bell_on_tab = "🔔 ";

      # window layout
      enabled_layout = "tall,grid,splits";
      visual_window_select_characters = "ASDFGHJKL";

      # tab bar
      tab_bar_edge = "top";
      tab_bar_margin_width = "6.0";
      tab_bar_style = "powerline";
      tab_bar_min_tabs = "1";

      # color schema
      foreground = "#ffffff";
      background = "#0d0e1c";
      background_opacity = "0.7";

      selection_foreground = "#bfefff";
      selection_background = "#005e8b";

      ## black
      color0 = "#000000";
      color8 = "#595959";

      ## red
      color1 = "#ff5f59";
      color9 = "#ff5f5f";

      ## green
      color2 = "#44bc44";
      color10 = "#44df44";

      ## yellow
      color3 = "#d0bc00";
      color11 = "#efef00";

      ## blue
      color4 = "#2fafff";
      color12 = "#338fff";

      ## magenta
      color5 = "#feacd0";
      color13 = "#ff66ff";

      ## cyan
      color6 = "#00d3d0";
      color14 = "#00eff0";

      ## white
      color7 = "#ffffff";
      color15 = "#989898";

      # advanced

      ## shell
      shell = "fish --login --interactive";
      ## do not check update
      update_check_interval = 0;

      macos_quit_when_last_window_closed = "yes";

      # mod
      kitty_mod = "alt+shift";
      clear_all_shortcuts = "yes";
    };

    font = {
      name = "UDEV Gothic NFLG";
      size = 16.0;
    };

    keybindings = {
      # reload configuration
      "kitty_mod+," = "load_config_file";
      "opt+cmd+," = "load_config_file";

      # clipboard
      "kitty_mod+c" = "copy_to_clipboard";
      "cmd+c" = "copy_to_clipboard";
      "kitty_mod+v" = "paste_from_clipboard";

      # browse scrollback in pager
      "kitty_mod+h" = "launch --stdin-source=@screen_scrollback --stdin-add-formatting --type=overlay less +G -R";

      # new window
      "kitty_mod+enter" = "new_window";
      "ctrl+alt+enter" = "launch --cwd=current";
      "cmd+enter" = "new_window";

      # focus window
      "ctrl+," = "focus_visible_window";

      # next tab
      "ctrl+tab" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";

      # move between window
      "kitty_mod+w>h" = "neighboring_window left";
      "kitty_mod+w>j" = "neighboring_window bottom";
      "kitty_mod+w>k" = "neighboring_window top";
      "kitty_mod+w>l" = "neighboring_window right";

      # new OS window
      "kitty_mod+w>n" = "new_os_window";

      # close window
      "kitty_mod+w>d" = "close_window";
      # move window to top
      "kitty_mod+w>t" = "move_window_to_top";
      "kitty_mod+w>r" = "start_resizing_window";

      # tab management
      "kitty_mod+f>n" = "new_tab";
      "kitty_mod+f>q" = "close_tab";
      "kitty_mod+f>t" = "set_tab_title";

      "kitty_mod+l>enter" = "next_layout";
      "kitty_mod+l>t" = "goto_layout tall";
      "kitty_mod+l>g" = "goto_layout grid";

      # change font size
      "kitty_mod+l>u" = "change_font_size all +2.0";
      "kitty_mod+l>d" = "change_font_size all -2.0";
      "kitty_mod+l>r" = "change_font_size all 0";

      "kitty_mod+p>f" = "kitten hints --type path --program -";
      "kitty_mod+p>h" = "kitten hints --type hash --program -";
      "kitty_mod+p>y" = "kitten hints --type hyperlink";

    } //
    # 1-10のtabに移動するためのattributesのセットに変換する
    (
      builtins.listToAttrs (builtins.genList
        (i:
          let window = i + 1; in
          {
            name = "kitty_mod+t>${toString window}";

            value = "goto_tab ${toString window}";
          }) 9));

  };
}
