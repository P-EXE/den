{ den, inputs, lib, ... }: {
  flake-file = {
    inputs = {
      yazi.url = "github:sxyazi/yazi";
      bunny-yazi = {
        url = "github:stelcodes/bunny.yazi";
        flake = false;
      };
    };
  };
  den.aspects.alice._.apps._.yazi = {
    homeManager = { pkgs, ...}: {
      home.packages = with pkgs;[
        yaziPlugins.ouch
      ];
      programs.yazi = {
        enable = true;
        package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
        settings = {
          yazi = {
            sort_by = "natural";
            sort_sensitive = true;
            sort_reverse = false;
            sort_dir_first = true;
            sort_translit = true;
            linemode = "none";
            show_hidden = true;
            show_symlink = true;
          };
        };
        keymap.mgr.prepend_keymap = [
          { on = "<C-t>"; run = "tab_create --current"; desc = "Create a new tab with CWD"; }
          { on = "<C-w>"; run = "close"; desc = "Close the current tab, or quit if it's last"; }
          { on = "<C-b>"; run = "plugin bunny"; desc = "Start bunny.yazi"; }
        ];
        plugins = { 
          bunny = "${inputs.bunny-yazi}";
          ouch = "${pkgs.yaziPlugins.ouch}";
        };
        initLua = ''
          require("bunny"):setup({
            hops = {
              { key = "/",          path = "/",                                    },
              { key = "t",          path = "/tmp",                                 },
              { key = "n",          path = "/nix/store",     desc = "Nix store"    },
              { key = "~",          path = "~",              desc = "Home"         },
              { key = "c",          path = "~/.config",      desc = "Config files" },
              { key = { "l", "s" }, path = "~/.local/share", desc = "Local share"  },
              { key = { "l", "b" }, path = "~/.local/bin",   desc = "Local bin"    },
              { key = { "l", "t" }, path = "~/.local/state", desc = "Local state"  },
              -- key and path attributes are required, desc is optional
            },
            desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
            ephemeral = true, -- Enable ephemeral hops, default is true
            tabs = true, -- Enable tab hops, default is true
            notify = false, -- Notify after hopping, default is false
            fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
          })
        '';
      };
    };
  };
}