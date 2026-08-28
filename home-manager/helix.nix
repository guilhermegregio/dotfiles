{ pkgs, ... }: {
  programs = {
    helix = {
      enable = true;
      package = pkgs.helix;

      settings = {
        theme = "catppuccin_mocha";

        editor = {
          line-number = "relative";
          lsp.display-messages = true;
          indent-guides.render = true;
          file-picker.hidden = false;
          # Configurações adicionais para o tema Catppuccin
          color-modes = true;

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
      };

      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
          }
          {
            name = "typescript";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettier}/bin/prettier";
              args = [ "--parser" "typescript" ];
            };
            language-servers = [ "typescript-language-server" ];
          }
          {
            name = "tsx";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettier}/bin/prettier";
              args = [ "--parser" "typescript" ];
            };
            language-servers = [ "typescript-language-server" ];
          }
          {
            name = "javascript";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettier}/bin/prettier";
              args = [ "--parser" "javascript" ];
            };
            language-servers = [ "typescript-language-server" ];
          }
          {
            name = "jsx";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettier}/bin/prettier";
              args = [ "--parser" "javascript" ];
            };
            language-servers = [ "typescript-language-server" ];
          }
          # Python
          {
            name = "python";
            auto-format = true;
            formatter = {
              command = "${pkgs.black}/bin/black";
              args = [ "-" ];
            };
            language-servers = [ "pyright" ];
          }
        ];

        language-server = {
          typescript-language-server = {
            command =
              "${pkgs.typescript-language-server}/bin/typescript-language-server";
            args = [ "--stdio" ];
          };
          pyright = {
            command = "${pkgs.pyright}/bin/pyright-langserver";
            args = [ "--stdio" ];
          };

        };
      };
    };
  };
}
