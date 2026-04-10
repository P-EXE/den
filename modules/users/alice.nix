{ den, inputs, lib, ... }: {
  # user aspect
  den.aspects.alice = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "fish")
      #den.aspects.alice._.themes._.archive
      den.aspects.alice._.desktops._.hyprland
      den.aspects.alice._.apps
      den.aspects.alice._.coding
    ];
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ 
        pkgs.htop
      ];
    };
    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts.nixos = { pkgs, ... }: { };
    # Aspects
    _.desktops._.hyprland = {
      flake-file = {
        inputs.hyprland.url = "github:hyprwm/Hyprland";
      };
      nixos = {pkgs, ...}: {
        programs.hyprland = {
          enable = false;
          # set the flake package
          #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          # make sure to also set the portal package, so that they are in sync
          #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };
        nix.settings = {
          substituters = ["https://hyprland.cachix.org"];
          trusted-substituters = ["https://hyprland.cachix.org"];
          trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
        };
      };
      homeManager = {
        wayland.windowManager.hyprland = {
          enable = true;
          # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
          #package = null;
          #portalPackage = null;
          settings = {
            # Keybinds
            "$mod" = "Super";
            "$mod_l" = "Super_L";
            input = {
              kb_layout = "us";
              kb_options = "grp:alt_space_toggle";
              repeat_rate = 25;
              repeat_delay = 300;
            };
            bind = [
              "$mod, L, exec, hyprlock"
              "$mod, Delete, exit"
              "$mod+Shift, Delete, exec, shutdown 0"
              "$mod, Q, killactive"
              #"$mod, Space, exec, pkill anyrun || anyrun"
              #"$mod, Space, exec, pkill walker || walker"
              #"$mod, Space, exec, nc -U /run/user/1000/walker/walker.sock"
              "$mod, Space, exec, pkill tofi-drun || tofi-drun | xargs hyprctl dispatch exec --"
              "$mod+Shift, Space, exec, pkill tofi-run || tofi-run | xargs hyprctl dispatch exec --"
              "$mod, K, exec, kitty"
              "$mod, E, exec, kitty yazi"
              "$mod, Tab, hyprexpo:expo, toggle"
              "Control_L&Shift_L, Escape, exec, kitty htop"
              "$mod, Print, exec, hyprshot -m region --clipboard-only"
              "$mod+Shift, Print, exec, hyprshot -m output --clipboard-only"
              "$mod+Shift+Control, Print, exec, hyprshot -m window --clipboard-only"
              "$mod, Equal, exec, hyprctl keyword monitor \"eDP-1, preferred, auto, 1.5\""
              "$mod, Minus, exec, hyprctl keyword monitor \"eDP-1, preferred, auto, 1\""
              "$mod, Return, fullscreen"
              "$mod, W, togglefloating"
              "$mod, Left, movefocus, l"
              "$mod, Right, movefocus, r"
              "$mod, Up, movefocus, u"
              "$mod, Down, movefocus, d"
              "$mod Shift, Left, swapwindow, l"
              "$mod Shift, Right, swapwindow, r"
              "$mod Shift, Up, swapwindow, u"
              "$mod Shift, Down, swapwindow, d"
              "$mod, 1, workspace, 1"
              "$mod, 2, workspace, 2"
              "$mod, 3, workspace, 3"
              "$mod, 4, workspace, 4"
              "$mod, 5, workspace, 5"
              "$mod, 6, workspace, 6"
              "$mod, 7, workspace, 7"
              "$mod, 8, workspace, 8"
              "$mod, 9, workspace, 9"
              "$mod, 0, workspace, 10"
              "$mod+Shift, 1, movetoworkspace, 1"
              "$mod+Shift, 2, movetoworkspace, 2"
              "$mod+Shift, 3, movetoworkspace, 3"
              "$mod+Shift, 4, movetoworkspace, 4"
              "$mod+Shift, 5, movetoworkspace, 5"
              "$mod+Shift, 6, movetoworkspace, 6"
              "$mod+Shift, 7, movetoworkspace, 7"
              "$mod+Shift, 8, movetoworkspace, 8"
              "$mod+Shift, 9, movetoworkspace, 9"
              "$mod+Shift, 0, movetoworkspace, 10"
            ];
            binde = [
              "$mod Control, Left, resizeactive, -10 0"
              "$mod Control, Right, resizeactive, 10 0"
              "$mod Control, Up, resizeactive, 0 -10"
              "$mod Control, Down, resizeactive, 0 10"
              ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
              ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
              ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
              ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
              ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
             #", XF86KbdBrightnessUp, exec, brightnessctl -d chromeos::kbd_backlight s 10%+"
             #", XF86KbdBrightnessDown, exec, brightnessctl -d chromeos::kbd_backlight s 10%-"
            ];
            bindm = [
              "$mod, mouse:272, movewindow"
              "$mod, mouse:273, resizewindow"
            ];
            gesture = [
              "3, horizontal, workspace" 
              #workspace_swipe = true;
              #workspace_swipe_fingers = 3;
              #workspace_swipe_distance = 400;
              #workspace_swipe_create_new = true;
              #workspace_swipe_forever = true;
            ];
            monitor  = [ ", preferred, auto, 1" ];
            exec-once = [
              "systemctl --user start hyprpolkitagent"
              "udiskie"
              "waybar"
              "systemctl --user enable --now hyprpaper.service"
              #"awww-daemon"
            ];
            workspace = [
              "1 default:true"
              "2"
              "3"
              "4"
              "5"
              "6"
              "7"
              "8"
              "9"
              "10"
            ];
          };
        };
      };
    };
    _.apps = {
      includes = lib.attrValues den.aspects.alice._.apps._;
      _.browsers = {
        homeManager = {
          programs.firefox.enable = true;
        };
      };
      _.media = {
        homeManager = {pkgs, ...}: {
          home.packages = with pkgs; [
            spotify
          ];
        };
      };
    };
    _.coding = {
      includes = lib.attrValues den.aspects.alice._.coding._;
      _.editors = {
        homeManager = {
          programs.vscode.enable = true;
        };
      };
      _.tools = {
        homeManager = {
          programs.git.enable = true;
        };
      };
    };
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
