{...}: {
  globals.mapleader = " ";

  keymaps = [
    # {
    #   key = "<leader>b";
    #   action = "<cmd>:Ex<CR>";
    # }
    {
      key = "<leader>b";
      action = "<C-O>";
    }
  ];

  plugins = {
    telescope.keymaps = {
      "<leader>ff" = {
        action = "find_files";
      };
      "<leader>fw" = {
        action = "live_grep";
      };
      "<leader>fb" = {
        action = "buffers";
      };
    };

    lsp.keymaps = {
      silent = true;
      lspBuf = {
        gd = {
          action = "definition";
          desc = "Goto Definition";
        };
        gr = {
          action = "references";
          desc = "Goto References";
        };
        gD = {
          action = "declaration";
          desc = "Goto Declaration";
        };
        gI = {
          action = "implementation";
          desc = "Goto Implementation";
        };
        gT = {
          action = "type_definition";
          desc = "Type Definition";
        };
        K = {
          action = "hover";
          desc = "Hover";
        };
        "<leader>cw" = {
          action = "workspace_symbol";
          desc = "Workspace Symbol";
        };
        "<leader>rr" = {
          action = "rename";
          desc = "Rename";
        };
      };
      diagnostic = {
        "<leader>cd" = {
          action = "open_float";
          desc = "Line Diagnostics";
        };
        "[d" = {
          action = "goto_next";
          desc = "Next Diagnostic";
        };
        "]d" = {
          action = "goto_prev";
          desc = "Previous Diagnostic";
        };
      };
    };

    cmp.settings.mapping = {
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<Esc>" = "cmp.mapping.abort()";
      "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
      "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
    };

    harpoon.keymaps = {
      addFile = "<leader>ha";
      toggleQuickMenu = "<leader>hm";
      navFile = {
        "1" = "<C-1>";
        "2" = "<C-2>";
        "3" = "<C-3>";
        "4" = "<C-4>";
      };
    };
  };
}
