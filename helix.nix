{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    ignores = [
      ".devenv/"
      ".git/"
      ".venv/"
    ];

    settings = {
        theme = "onedark";

        editor = {
            shell = ["fish" "-c"];
            bufferline = "always";
            rulers = [120];
            true-color = true;
            cursor-shape = {
                insert = "bar";
                normal = "block";
                select = "underline";
            };
        };

        keys.normal = {
            "C-]" = ":buffer-next";
            "C-[" = ":buffer-previous";
        }; 
    };

    languages = {  
      language = [
        {
          name = "toml";
          scope = "source.toml";
          injection-regex = "toml";
          file-types = ["toml" "Cargo.lock"];
          roots = [];
          auto-format = true;
          comment-token = "#";
        }
        {
          name = "ini";
          scope = "source.ini";
          file-types = ["conf" "ini"];
          auto-format = true;
          comment-token = "#";
        }
      ];

      grammar = {
        name = "toml";
        source = { git = "https://github.com/ikatyang/tree-sitter-toml"; rev = "main"; };
      };

      language-server.taplo = {
        command = "taplo";
        args = ["lsp" "stdio"];
      };
    };
    
    extraPackages = [];
  };
}
