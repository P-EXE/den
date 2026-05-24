{ den, inputs, lib, ... }: {
  flake-file = {
    inputs = {
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      hyprland-plugins = {
        url = "github:hyprwm/hyprland-plugins";
        inputs.hyprland.follows = "hyprland";
      };
    };
  };
  den.aspects.alice._.desktop = {
    #includes = lib.attrValues den.aspects.alice._.desktops._.hyprland._;
    nixos = { pkgs, ... } : {
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        withUWSM = true;
        xwayland.enable = true;
      };
      nix.settings = {
        #substituters = ["https://hyprland.cachix.org"];
        #trusted-substituters = ["https://hyprland.cachix.org"];
        #trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      };
    };
    homeManager = { config, pkgs, ...}: {
      home.packages = with pkgs; [
        hyprshot
        jetbrains-mono
      ];
      
      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        systemd.enable = false;
        configType = "hyprlang"; # "lua" is now default
        plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
          #hyprexpo
          hyprbars
        ];
        settings = {
          # Keybinds
          "$mod" = "Super";
          "$mod_l" = "Super_L";
          input = {
            kb_layout = "us, de";
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
            #"$mod, Tab, hyprexpo:expo, toggle"
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

          # Startup
          exec-once = [
            "systemctl --user start hyprpolkitagent"
            "udiskie"
            "waybar"
            "systemctl --user enable --now hyprpaper.service"
            #"awww-daemon"
          ];

          # Workspaces
          workspace = [
            "1, default:true"
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

          # Hardware
          monitor  = [ ", preferred, auto, 1" ];

          # Theme
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
              #ignore_window = true;
              color = "0xff252525";
              color_inactive = "0xff1b1b1b";
              scale = 1.0;
            };
          };
          windowrule = [
            "no_dim on, match:class firefox"
            "no_dim on, match:class vesktop"
            "move 100% 16, opacity 0.9, match:initial_title = Hyprland Polkit Agent"
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
          #"plugin:hyprexpo" = {
          #  columns = 3;
          #  gap_size = 0;
          #  bg_col = "0x000000";
          #  workspace_method = "center current";
          #};
        };
      };

      programs.kitty = {
        enable = true;
        settings = {
          font_size = 9;
          confirm_os_window_close = 0;

          # Theme
          font_family = "JetBrains Mono";
          cursor_shape = "beam";
          cursor_shape_unfocused = "unchanged";
          window_padding_width = 0;
          background = "#000000";
          foreground = "#E6E6E6";
          cursor = "#ffffff";
          selection_background = "#E6E6E6";
          selection_foreground = "#000000";
          color0 = "";
          color1 = "#FF6188";
          color2 = "#A9DC76";
          color3 = "#FFD866";
          color4 = "#2386D1";
          color5 = "#AB9DF2";
          color6 = "#78DCE8";
          color7 = "";
          color8 = "";
          color9 = "#CC768C";
          color10 = "#92A87D";
          color11 = "#CCB87A";
          color12 = "#3A739E";
          color13 = "#A7A3BF";
          color14 = "#82B0B5";
          color15 = "";
        };
      };

      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "bottom";
            position = "top";
            modules-left = [ "hyprland/workspaces" "wlr/taskbar" ];
            modules-center = [ "custom/waybar-mpris" ];
            modules-right = [ "tray" "hyprland/language" "network" "cpu" "memory" "wireplumber" "battery" "clock" ];
            #output = [];
            "hyprland/workspaces" = {};
            "wlr/taskbar" = {
              format = "{icon}";
              icon-size = 10;
              tooltip-format = "{title}";
              on-click = "activate";
              on-click-middle = "close";
              rotate = 0;
            };
            "tray" = {
              icon-size = 10;
              spacing = 8;
              rotate = 0;
            };
            "hyprland/language" = {
              format = "{}";
              format-de = "DE";
              format-en = "US";
              rotate = 0;
            };
            "network" = {
              format-ethernet = "ETH: {ipaddr}/{cidr}";
              format-wifi = "WLAN: {essid}-↑{bandwidthUpBits}↓{bandwidthDownBits}";
              format-disconnected = "";
              format-icons = ["░" "▂" "▄" "▆" "█"];
              tooltip-format = "if: {ifname}\nip: {ipaddr}/{cidr}/{cidr6}\ngw: {gwaddr}";
              tooltip-format-wifi = "if: {ifname}\nip: {ipaddr}/{cidr}/{cidr6}\ngw: {gwaddr}\nstr: {signalStrength}\nstr dB: {signaldBm}\nfreq: {frequency} GHz\nup: {bandwidthUpBits}\ndown: {bandwidthDownBits}";
              rotate = 0;
            };
            "cpu" = {
              format = "CPU: {usage}%";
              rotate = 0;
            };
            "memory" = {
              format = "RAM: {}%";
              rotate = 0;
            };
            "wireplumber" = {
              format = "Vol: {volume}%-{node_name}";
              format-muted = "Mute";
              on-click = "helvum";
              format-icons = ["◂" "◄" "◀"];
              rotate = 0;
            };
            "pulseaudio" = {
              scroll-step = 1;
              format = "Vol: {volume}%";
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = " {icon} {format_source}";
              format-muted = " {format_source}";
              format-source = "{volume}% ";
              format-source-muted = " ";
              format-icons = {
                "headphone" = " ";
                "hands-free" = " ";
                "headset" = " ";
                "phone" = " ";
                "portable" = " ";
                "car" = " ";
                "default" = ["" " " " "];
              };
              on-click = "pavucontrol";
              rotate = 0;
            };
            "battery" = {
              "states" = {
                "good" = 95;
                "warning" = 30;
                "critical" = 15;
              };
              format = "BAT: {capacity}%";
              format-charging = "CRG-{capacity}%";
              format-plugged = "PLG-{capacity}%";
              format-alt = "{icon} {time}";
              format-full = "";
              format-icons = ["░" "▂" "▄" "▆" "█"];
              rotate = 0;
            };
            "clock" = {
              format = "{:L%A %d.%m.%Y(W%V) %H:%M:%S (%z)}";
              rotate = 0;
            };
            "custom/waybar-mpris" = {
              "return-type"= "json";
              "exec" = "waybar-mpris --position --autofocus";
              "on-click" = "waybar-mpris --send toggle";
              # This option will switch between players on right click.
              "on-click-right" = "waybar-mpris --send player-next";
              # The options below will switch the selected player on scroll
              # "on-scroll-up" = "waybar-mpris --send player-next";
              # "on-scroll-down" = "waybar-mpris --send player-prev";
              # The options below will go to next/previous track on scroll
              #"on-scroll-up" = "waybar-mpris --send next";
              #"on-scroll-down" = "waybar-mpris --send prev";
              "escape" = true;
              rotate = 0;
            };
          };
        };
        style = ''
          * {
            all: unset;
            font-family: 'JetBrains Mono';
          }

          window#waybar>box {
            background: #000000;
            font-size: 10px;
            padding: 0px;
          }

          tooltip {
            background: transparent;
            /* border: 1px solid rgba(100, 114, 125, 0.5); */
          }
          tooltip label {
            background: #000000;
            margin: 4px;
          }

          #workspaces {
          }
          #workspaces button {
            padding: 0px;
            color: rgba(255, 255, 255, 0.5);
          }
          #workspaces button.active {
            color: #ffffff;
          }
          #taskbar {
            padding: 0px;
          }
          #taskbar * {
            padding: 1px;
          }

          #tray {
            padding: 0px;
          }
          #language {
            padding: 0px;
          }
          #network {
            padding: 0px;
            color: #ff6188;
          }
          #cpu {
            padding: 0px;
            color: #fc9867;
          }
          #memory {
            padding: 0px;
            color: #ffd866;
          }
          #wireplumber {
            padding: 0px;
            color: #a9dc76;
          }
          #battery {
            padding: 0px;
            color: #78dce8;
          }
          #clock {
            padding: 0px;
            color: #ab9df2;
          }
        '';
      };

      programs.tofi = {
        enable = true;
        settings = {
          # Theme
          width = "100%";
          height = "100%";
          border-width = 0;
          outline-width = 0;
          padding-left = 32;
          padding-top = 16;
          result-spacing = -16;
          num-results = 0;
          font = "JetBrains Mono";
          font-variations = "wght 900";
          font-features = "ss08 on";
          font-size = "96px";
          text-color = "#FFFFFF33";
          background-color = "#000000FF";
          selection-color = "#FFFFFFE6";
          selection-match-color = "#FF4F00";
          selection-background-padding = "16px 0 16px 16px";
          prompt-text = "↘";
        };
      };

      # Theme
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
}