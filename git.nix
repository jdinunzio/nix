{
  programs.git = {
    enable = true;
    userName = "jose";
    userEmail = "jose.dinuncio@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };

    aliases = {
      br = "branch";
      co = "checkout";
      lg = "log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --decorate=full";
      st = "status";
      comain = "!git co main && git pull origin main && git pull origin --tags &&  git remote prune origin";
      co2main = "!f() { git co $1 && git rebase main; }; f";
    };
  };
}