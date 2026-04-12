{ lib, ... }: {
  den.aspects.alice._.desktops._.hyprland._.keybinds.homeManager = {
    wayland.windowManager.hyprland.settings = {
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
    };
  };
}