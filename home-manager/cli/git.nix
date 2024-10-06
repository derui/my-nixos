{ pkgs, pkgs-stable, ... }:
{
  programs.git = {
    enable = true;
    userName = "derui";
    userEmail = "derutakayu@gmail.com";

    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "main";

      credential.helper = "cache --timeout 300000";

      alias = {
        co = "checkout";
        br = "branch";
        rb = "rebase";
        rbi = "rebase -i";
        rbh = "rebase HEAD";
        nb = "switch -c";
        s = "switch";
        sq = "!point=\${1:-HEAD} sh -c 'files=`git diff --name-only \${point}`; git reset \${point};git add $files; git commit -a'; git rept";
        rept = "!sh -c 'git tag -d pt; git tag pt'";
        l = "log --pretty=format:\"%ci %C(yellow)%H%Creset [%cn] %Cgreen%s %C(cyan)%d%Creset\" -10";
        lg = "log --graph --all --color --pretty='%x09%h %cn%x09%s %Cred%d%Creset'";
        fp = "fetch --prune";
        delete-merged-branch = "!fish -c git_alias_remove_merged_branch";
      };

      core = {
        autocrlf = "input";
      };

      delta = {
        # use n and N to move between diff sections
        navigate = true;
        side-by-side = true;

        # delta detects terminal colors automatically; set one of these to disable auto-detection
        dark = true;
      };

      push.default = "simple";
      color.ui = "auto";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
  };
}
