{ den, inputs, lib, ... }: {
  # user aspect
  den.aspects.alice = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "fish")
      #den.aspects.alice._.themes._.archive
      #den.aspects.alice._.desktops._.hyprland
      #den.aspects.alice._.desktops._.niri
      den.aspects.alice._.apps
      den.aspects.alice._.coding
    ];
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ 
        htop
      ];
    };
    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts.nixos = { pkgs, ... }: { 

    };
    # Aspects
    _.themes._.archive = {
      homeManager = { pkgs,  ... }: {
        home.packages = with pkgs; [
          jetbrains-mono
        ];

        wayland.windowManager.hyprland.settings = {
          general = {
            layout = "dwindle";
            border_size = 0;
            gaps_in = 0;
            gaps_out = 0;
          };
          decoration = {
            rounding = 0;
            active_opacity = 1;
            inactive_opacity = 1;
            dim_inactive = true;
            dim_strength = 0.6;
            blur = {
              enabled = false;
              size = 128;
              passes = 3;
              noise = 0.1;
              contrast = 1.0;
              brightness = 1.0;
              vibrancy = 1.0;
              vibrancy_darkness = 1.0;
              popups = true;
              popups_ignorealpha = 0.2;
              input_methods = true;
              input_methods_ignorealpha = 0.2;
              new_optimizations = true;
            };
            shadow = {
              enabled = false;
              range = 16;
              render_power = 3;
              sharp = false;
              ignore_window = true;
              color = "0xff252525";
              color_inactive = "0xff1b1b1b";
              scale = 1.0;
            };
          };
          windowrule = [
            "no_dim on, match:class firefox"
            "no_dim on, match:class vesktop"
            "move 100%-w-16, opacity 0.9, match:initial_title = Hyprland Polkit Agent"
          ];
          layerrule = [
          ];
          animations = {
            enabled = true;
          };
          animation = [
            "fade, 1, 0.1, default"
            "workspaces, 1, 1, default, slide"
            "layersIn, 1, 1, default, slide"
            "layersOut, 1, 1, default, slide"
            "windows, 1, 1, default, slide"
          ];
          env = [
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          ];
          "plugin:hyprbars" = {
            enabled = true;
            bar_height = 18;
            bar_title_enabled = true;
            bar_text_size = 8;
            bar_text_font = "JetBrains Mono";
            bar_text_align = "left";
            bar_padding = 4;
            bar_color = "rgb(0, 0, 0)";
          };
          "plugin:hyprexpo" = {
            columns = 3;
            gap_size = 0;
            bg_col = "0x000000";
            workspace_method = "center current";
          };
        };    

        home.pointerCursor = {
          gtk.enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Original-Classic";
          size = 4;
        };    

        gtk = with pkgs; {
          enable = true;
          theme = {
            package = adw-gtk3;
            name = "adw-gtk3-dark";
          };
          iconTheme = {
            package = papirus-icon-theme;
            name = "Papirus-Dark";
          };
          gtk3.extraConfig = {
            Settings = ''
              gtk-application-prefer-dark-theme=1
            '';
          };
          gtk4.extraConfig = {
            Settings = ''
              gtk-application-prefer-dark-theme=1
            '';
          };
        };
      };
    };
  };
}
