{ inputs
, lib
, pkgs
, ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    clipboard.register = "unnamedplus";
    clipboard.providers.wl-copy.enable = true;

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 4;
    };

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      web-devicons.enable = true;
      autoclose.enable = true;

      #Muss ich mir noch anschauen
      nvim-surround.enable = true;

      lsp = {
        enable = true;

        servers = {
          lua-ls.enable = true;
          nil-ls.enable = true;
          pyright.enable = true;
          cmake.enable = true;
          clangd.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
      };

      cmp = {
        enable = true;

        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };

      conform-nvim = {
        enable = true;

        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            nix = [ "alejandra" "nixpkgs_fmt" ];
            python = [ "black" "isort" ];
            c = [ "clang-format" ];
            rust = [ "rustfmt" ];
          };

          formatters = {
            alejandra = {
              command = "${lib.getExe pkgs.alejandra}";
            };
            nixpkgs_fmt = {
              command = "${lib.getExe pkgs.nixpkgs-fmt}";
            };
            stylua = {
              command = "${lib.getExe pkgs.stylua}";
            };
            black = {
              command = "${lib.getExe pkgs.black}";
            };
            isort = {
              command = "${lib.getExe pkgs.isort}";
            };
            clang-format = {
              command = "${lib.getExe pkgs.clang}";
            };
            rustfmt = {
              command = "${lib.getExe pkgs.rustfmt}";
            };
          };

          format_on_save = ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end

              local function on_format(err)
                if err and err:match("timeout$") then
                  slow_format_filetypes[vim.bo[bufnr].filetype] = true
                end
              end

              return { timeout_ms = 200, lsp_fallback = true }, on_format
             end
          '';
        };
      };

      codesnap = {
        enable = true;

        settings = {
          code_font_family = "Noto";
          has_line_number = true;
          mac_window_bar = true;
          save_path = "~/Pictures";
        };
      };

      harpoon = {
        enable = true;
      };

      cursorline = {
        enable = true;

        cursorline = {
          number = true;
          timeout = 0;
        };
      };

      floaterm = {
        enable = true;

        keymaps = {
          toggle = "<Alt-I>";
        };
      };
    };

    imports = [
      ./mappings.nix
    ];
  };
}
